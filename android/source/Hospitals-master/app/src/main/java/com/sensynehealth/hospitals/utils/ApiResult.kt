package com.sensynehealth.hospitals.utils

data class ApiResult<out T>(val status: ApiStatus, val data: T?, val message: String?) {

    companion object {

        fun <T> success(data: T?): ApiResult<T> {
            return ApiResult(ApiStatus.SUCCESS, data, null)
        }

        fun <T> error(msg: String, data: T?): ApiResult<T> {
            return ApiResult(ApiStatus.ERROR, data, msg)
        }

        fun <T> loading(data: T?): ApiResult<T> {
            return ApiResult(ApiStatus.LOADING, data, null)
        }
    }
}