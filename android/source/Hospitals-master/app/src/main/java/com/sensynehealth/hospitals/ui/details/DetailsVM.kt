package com.sensynehealth.hospitals.ui.details

import androidx.lifecycle.MutableLiveData
import com.sensynehealth.hospitals.data.model.Hospital
import com.sensynehealth.hospitals.ui.base.BaseVM

class DetailsVM : BaseVM() {

    lateinit var hospital: Hospital

    val website = MutableLiveData<String>()
    val phone = MutableLiveData<String>()

    fun loadWebsite() {
        website.postValue(hospital.website)
    }

    fun callPhone() {
        phone.postValue("tel:" + hospital.phone)
    }

}