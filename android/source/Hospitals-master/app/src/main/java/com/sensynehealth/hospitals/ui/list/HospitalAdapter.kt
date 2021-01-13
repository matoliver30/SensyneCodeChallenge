package com.sensynehealth.hospitals.ui.list

import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import com.sensynehealth.hospitals.data.model.Hospital
import com.sensynehealth.hospitals.databinding.ItemListBinding

class HospitalAdapter(private val listener: HospitalSelectionListener) :
    RecyclerView.Adapter<HospitalAdapter.HospitalHolder>() {

    private var items: ArrayList<Hospital> = arrayListOf()

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): HospitalHolder {
        val inflater = LayoutInflater.from(parent.context)
        val binding = ItemListBinding.inflate(inflater)
        return HospitalHolder(binding)
    }

    override fun onBindViewHolder(holder: HospitalHolder, position: Int) =
        holder.bind(items[position], listener)

    override fun getItemCount(): Int {
        return items.size
    }

    fun addItems(newItems: List<Hospital>) {
        items.clear()
        items.addAll(newItems)
    }

    inner class HospitalHolder(
        private val binding: ItemListBinding
    ) :
        RecyclerView.ViewHolder(binding.root) {
        fun bind(hospital: Hospital, listener: HospitalSelectionListener) {
            binding.item = hospital
            binding.listener = listener
        }
    }
}