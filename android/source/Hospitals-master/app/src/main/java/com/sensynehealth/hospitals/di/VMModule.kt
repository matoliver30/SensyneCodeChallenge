package com.sensynehealth.hospitals.di

import org.koin.android.viewmodel.dsl.viewModel
import org.koin.dsl.module
import com.sensynehealth.hospitals.ui.details.DetailsVM
import com.sensynehealth.hospitals.ui.list.ListVM

val vmModule = module {
    viewModel { ListVM(get(), get()) }
    viewModel { DetailsVM() }
}