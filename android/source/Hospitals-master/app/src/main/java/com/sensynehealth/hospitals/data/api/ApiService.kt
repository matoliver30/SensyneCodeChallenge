package com.sensynehealth.hospitals.data.api

import retrofit2.Response
import com.sensynehealth.hospitals.data.model.Hospital

class ApiService(private val api: API) {

    suspend fun getHospitals(): Response<List<Hospital>> = api.getHospitals()

}