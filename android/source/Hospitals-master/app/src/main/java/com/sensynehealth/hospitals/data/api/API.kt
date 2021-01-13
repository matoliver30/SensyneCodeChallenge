package com.sensynehealth.hospitals.data.api

import retrofit2.Response
import retrofit2.http.GET
import com.sensynehealth.hospitals.data.model.Hospital
import com.sensynehealth.hospitals.utils.ENDPOINT_HOSPITALS

interface API {

    @GET(ENDPOINT_HOSPITALS)
    suspend fun getHospitals(): Response<List<Hospital>>
}