package com.sensynehealth.hospitals.di

import android.content.Context
import androidx.viewbinding.BuildConfig
import okhttp3.OkHttpClient
import okhttp3.logging.HttpLoggingInterceptor
import org.koin.android.ext.koin.androidContext
import org.koin.dsl.module
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory
import com.sensynehealth.hospitals.data.api.API
import com.sensynehealth.hospitals.data.api.ApiService
import com.sensynehealth.hospitals.utils.BASE_URL
import com.sensynehealth.hospitals.utils.Network

val appModule = module {
    single { provideOkHttpClient() }
    single { provideRetrofit(get(), BASE_URL) }
    single { provideApiService(get()) }
    single { provideNetworkHelper(androidContext()) }
    single {
        return@single ApiService(get())
    }
}

private fun provideNetworkHelper(context: Context) = Network(context)

private fun provideOkHttpClient() = if (BuildConfig.DEBUG) {
    val loggingInterceptor = HttpLoggingInterceptor()
    loggingInterceptor.setLevel(HttpLoggingInterceptor.Level.BODY)
    OkHttpClient.Builder()
        .addInterceptor(loggingInterceptor)
        .build()
} else OkHttpClient
    .Builder()
    .build()

private fun provideRetrofit(
    okHttpClient: OkHttpClient,
    BASE_URL: String
): Retrofit =
    Retrofit.Builder()
        .addConverterFactory(GsonConverterFactory.create())
        .baseUrl(BASE_URL)
        .client(okHttpClient)
        .build()

private fun provideApiService(retrofit: Retrofit): API = retrofit.create(API::class.java)

private fun provideApiHelper(api: ApiService): ApiService = api