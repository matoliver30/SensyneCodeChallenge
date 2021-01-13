package com.sensynehealth.hospitals.ui.list

import android.os.Bundle
import android.view.View
import androidx.appcompat.app.AppCompatActivity
import androidx.appcompat.widget.SearchView
import androidx.navigation.fragment.findNavController
import org.koin.android.viewmodel.ext.android.viewModel
import com.sensynehealth.hospitals.R
import com.sensynehealth.hospitals.data.model.Hospital
import com.sensynehealth.hospitals.databinding.FragmentListBinding
import com.sensynehealth.hospitals.ui.base.BaseFragment
import com.sensynehealth.hospitals.utils.ApiStatus

class ListFragment : BaseFragment<FragmentListBinding, ListVM>(), HospitalSelectionListener {

    override val layoutId = R.layout.fragment_list

    override val viewModel: ListVM by viewModel()

    private val adapter: HospitalAdapter = HospitalAdapter(this)

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        (requireActivity() as AppCompatActivity).setSupportActionBar(binding.toolbar.toolbar)

        binding.adapter = adapter

        setUI()
        setObservables()
    }

    private fun setUI() {
        binding.search.setOnQueryTextListener(object : SearchView.OnQueryTextListener {
            override fun onQueryTextSubmit(query: String?): Boolean {
                query?.let { viewModel.filterByName(it) }
                return query.isNullOrEmpty().not()
            }

            override fun onQueryTextChange(newText: String?): Boolean {
                newText?.let { viewModel.filterByName(it) }
                return newText.isNullOrEmpty().not()
            }
        })

        binding.search.findViewById<View>(androidx.appcompat.R.id.search_close_btn)
            .setOnClickListener {
                binding.search.setQuery("", false)
                binding.search.isIconified = true
                binding.search.clearFocus()
                viewModel.getHospitals()
            }
    }

    private fun setObservables() {
        viewModel.getHospitals().observe(viewLifecycleOwner, {
            when (it.status) {
                ApiStatus.SUCCESS -> {
                    it.data?.let { items -> adapter.addItems(items) }
                    adapter.notifyDataSetChanged()
                    binding.progressBar.visibility = View.GONE
                }
                ApiStatus.ERROR -> {
                    binding.progressBar.visibility = View.GONE
                    // TODO: 12/6/20 show error
                }
                ApiStatus.LOADING -> {
                    binding.progressBar.visibility = View.VISIBLE
                }
            }
        })

        viewModel.filteredResults.observe(viewLifecycleOwner, {
            adapter.addItems(it)
            adapter.notifyDataSetChanged()
        })
    }

    override fun onHospitalSelected(hospital: Hospital) {
        findNavController().navigate(ListFragmentDirections.actionListToDetails(hospital))
    }
}