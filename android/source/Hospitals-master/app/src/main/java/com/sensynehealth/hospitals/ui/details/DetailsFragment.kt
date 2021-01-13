package com.sensynehealth.hospitals.ui.details

import android.Manifest
import android.content.Intent
import android.content.pm.PackageManager
import android.net.Uri
import android.os.Bundle
import android.view.MenuItem
import android.view.View
import androidx.appcompat.app.AppCompatActivity
import androidx.core.content.ContextCompat
import androidx.navigation.fragment.navArgs
import com.sensynehealth.hospitals.R
import com.sensynehealth.hospitals.databinding.FragmentDetailsBinding
import com.sensynehealth.hospitals.ui.base.BaseFragment
import com.sensynehealth.hospitals.utils.PERMISSION_REQUEST_CODE
import org.koin.android.viewmodel.ext.android.viewModel


class DetailsFragment : BaseFragment<FragmentDetailsBinding, DetailsVM>() {

    private val args: DetailsFragmentArgs by navArgs()

    lateinit var phoneNumber: String

    override val layoutId = R.layout.fragment_details
    override val viewModel: DetailsVM by viewModel()

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        (requireActivity() as AppCompatActivity).setSupportActionBar(binding.toolbar.toolbar)
        (requireActivity() as AppCompatActivity).supportActionBar!!.setDisplayHomeAsUpEnabled(true)

        viewModel.hospital = args.hospital

        setObservers()
    }

    override fun onActivityCreated(savedInstanceState: Bundle?) {
        super.onActivityCreated(savedInstanceState)
        setHasOptionsMenu(true)
    }

    override fun onOptionsItemSelected(item: MenuItem): Boolean {
        if (item.itemId == android.R.id.home) {
            requireActivity().onBackPressed()
        }
        return super.onOptionsItemSelected(item)
    }

    private fun setObservers() {
        viewModel.website.observe(viewLifecycleOwner, {
            startActivity(Intent(Intent.ACTION_VIEW, Uri.parse(it)))
        })

        viewModel.phone.observe(viewLifecycleOwner, {
            phoneNumber = it
            checkPermission()
        })
    }

    private fun checkPermission() {
        when (PackageManager.PERMISSION_GRANTED) {
            ContextCompat.checkSelfPermission(
                requireContext(),
                Manifest.permission.CALL_PHONE
            ) -> {
                startActivity(Intent(Intent.ACTION_CALL, Uri.parse(phoneNumber)))
            }
            else -> {
                requestPermissions(arrayOf(Manifest.permission.CALL_PHONE), PERMISSION_REQUEST_CODE)
            }
        }
    }

    override fun onRequestPermissionsResult(requestCode: Int,
                                            permissions: Array<String>, grantResults: IntArray) {
        when (requestCode) {
            PERMISSION_REQUEST_CODE -> {
                if ((grantResults.isNotEmpty() &&
                            grantResults[0] == PackageManager.PERMISSION_GRANTED)) {
                    checkPermission()
                }
                return
            }
        }
    }
}