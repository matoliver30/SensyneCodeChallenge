package com.sensynehealth.hospitals.di

import org.koin.dsl.module
import com.sensynehealth.hospitals.data.repository.HospitalRepo

val repoModule = module {
    single { HospitalRepo(get()) }
}