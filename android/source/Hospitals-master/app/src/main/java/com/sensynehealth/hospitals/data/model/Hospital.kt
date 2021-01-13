package com.sensynehealth.hospitals.data.model

import android.os.Parcelable
import com.google.gson.annotations.SerializedName
import kotlinx.parcelize.Parcelize

@Parcelize
data class Hospital(
    @SerializedName("OrganisationID") val organizationId: Int,
    @SerializedName("OrganisationCode") val organizationCode: String,
    @SerializedName("OrganisationType") val organizationType: String,
    @SerializedName("SubType") val subtype: String,
    @SerializedName("Sector") val sector: String,
    @SerializedName("OrganisationStatus") val organizationStatus: String,
    @SerializedName("IsPimsManaged") val isPimsManaged: Boolean,
    @SerializedName("OrganisationName") val organizationName: String,
    @SerializedName("Address1") val address1: String,
    @SerializedName("Address2") val address2: String,
    @SerializedName("Address3") val address3: String,
    @SerializedName("City") val city: String,
    @SerializedName("County") val county: String,
    @SerializedName("Postcode") val postcode: String,
    @SerializedName("Latitude") val latitude: String,
    @SerializedName("Longitude") val longitude: String,
    @SerializedName("ParentODSCode") val parentODSCode: String,
    @SerializedName("ParentName") val parentName: String,
    @SerializedName("Phone") val phone: String,
    @SerializedName("Email") val email: String,
    @SerializedName("Website") val website: String,
    @SerializedName("Fax") val fax: String,
) : Parcelable