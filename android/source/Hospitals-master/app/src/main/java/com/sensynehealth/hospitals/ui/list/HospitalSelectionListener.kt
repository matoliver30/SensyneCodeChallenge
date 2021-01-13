package com.sensynehealth.hospitals.ui.list

import com.sensynehealth.hospitals.data.model.Hospital

interface HospitalSelectionListener {
    fun onHospitalSelected(hospital: Hospital)
}