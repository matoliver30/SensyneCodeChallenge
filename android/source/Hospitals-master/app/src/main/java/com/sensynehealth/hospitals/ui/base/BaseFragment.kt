package com.sensynehealth.hospitals.ui.base

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.annotation.LayoutRes
import androidx.databinding.DataBindingUtil
import androidx.databinding.ViewDataBinding
import androidx.fragment.app.Fragment
import com.sensynehealth.hospitals.BR

abstract class BaseFragment<B : ViewDataBinding, VM : BaseVM> : Fragment() {
    @get:LayoutRes
    protected abstract val layoutId: Int

    protected lateinit var binding: B
    protected abstract val viewModel: VM

    protected open fun initBinding(binding: B) = binding.setVariable(BR.viewmodel, viewModel)

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        binding = DataBindingUtil.inflate(inflater, layoutId, container, false)
        binding.lifecycleOwner = viewLifecycleOwner
        initBinding(binding)
        return binding.root
    }
}