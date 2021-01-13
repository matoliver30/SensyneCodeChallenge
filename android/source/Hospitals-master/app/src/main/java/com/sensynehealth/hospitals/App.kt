package com.sensynehealth.hospitals

import android.app.Application
import org.koin.android.ext.koin.androidContext
import org.koin.core.context.startKoin
import com.sensynehealth.hospitals.di.appModule
import com.sensynehealth.hospitals.di.repoModule
import com.sensynehealth.hospitals.di.vmModule

class App : Application() {

    override fun onCreate() {
        super.onCreate()
        startKoin {
            androidContext(this@App)
            modules(listOf(appModule, repoModule, vmModule))
        }
    }
}