package com.sensynehealth.hospitals.utils

import androidx.databinding.BindingAdapter
import androidx.recyclerview.widget.DividerItemDecoration
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView

@BindingAdapter(value = ["setAdapter"])
fun RecyclerView.bindRecyclerViewAdapter(adapter: RecyclerView.Adapter<*>) {
    this.run {
        this.setHasFixedSize(true)
        this.adapter = adapter
        this.addItemDecoration(
            DividerItemDecoration(
                context, ((this.layoutManager) as LinearLayoutManager).orientation

            )
        )
    }
}