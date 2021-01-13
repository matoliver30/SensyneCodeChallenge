package com.sensynehealth.hospitals.utils

import com.sensynehealth.hospitals.R

class TestData {
    companion object {
        const val DEFAULT_TIMEOUT: Long = 10000L
        const val FIRST_HOSPITAL_NAME_NO_SEARCH: String = "East Riding Community Hospital"
        const val FIRST_HOSPITAL_TYPE_NO_SEARCH: String = "Mental Health Hospital"
        const val DEFAULT_SEARCH_STRING: String = "BMI"
        const val DEFAULT_SEARCH_COUNT: Int = 47
        const val DEFAULT_CELL_POS_TO_CHECK: Int = 0
        const val FIRST_HOSPITAL_NAME_SEARCH_B = "Bridgewater Hospital"
        const val FIRST_HOSPITAL_NAME_FROM_SEARCH: String = "BMI The Alexandra Hospital"
        const val FIRST_HOSPITAL_SUBTYPE_FROM_SEARCH: String = "Hospital"
        const val FIRST_HOSPITAL_SECTOR_FROM_SEARCH: String = "Independent Sector"
        const val FIRST_HOSPITAL_ADDRESS1_FROM_SEARCH: String = "The Alexandra Hospital"
        const val FIRST_HOSPITAL_ADDRESS2_FROM_SEARCH: String = "Mill Lane"
        const val FIRST_HOSPITAL_ADDRESS4_FROM_SEARCH: String = "SK8 2PX Cheadle, Cheshire"
        const val FIRST_HOSPITAL_WEBSITE_FROM_SEARCH: String = "http://www.bmihealthcare.co.uk/alexandra"
        const val FIRST_HOSPITAL_PHONE_FROM_SEARCH: String = "0161 428 3656"

        const val MAIN_SCREEN_SEARCH_BUTTON: Int = R.id.search_button
        const val MAIN_SCREEN_SEARCH_CLOSE_BUTTON: Int = R.id.search_close_btn
        const val MAIN_SCREEN_SEARCH_TEXT: Int = R.id.search_src_text
        const val MAIN_SCREEN_LIST: Int = R.id.list
        const val MAIN_SCREEN_HOSPITAL_NAME: Int = R.id.hospitalName
        const val MAIN_SCREEN_HOSPITAL_TYPE: Int = R.id.hospitalType

        const val DETAIL_SCREEN_HOSPITAL_NAME: Int = R.id.organisationName
        const val DETAIL_SCREEN_HOSPITAL_SUBTYPE: Int = R.id.organisationSubType
        const val DETAIL_SCREEN_HOSPITAL_SECTOR: Int = R.id.organisationSector
        const val DETAIL_SCREEN_ADDRESS_LABEL: Int = R.id.organisationAddressLabel
        const val DETAIL_SCREEN_HOSPITAL_ADDRESS1: Int = R.id.organisationAddress1
        const val DETAIL_SCREEN_HOSPITAL_ADDRESS2: Int = R.id.organisationAddress2
        const val DETAIL_SCREEN_HOSPITAL_ADDRESS3: Int = R.id.organisationAddress3
        const val DETAIL_SCREEN_HOSPITAL_ADDRESS4: Int = R.id.organisationAddress4
        const val DETAIL_SCREEN_HOSPITAL_WEBSITE: Int = R.id.organisationWebsite
        const val DETAIL_SCREEN_HOSPITAL_PHONE: Int = R.id.organisationPhone
    }
}