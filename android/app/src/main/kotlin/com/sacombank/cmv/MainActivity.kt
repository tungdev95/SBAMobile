package com.sacombank.cmv

import com.vnpt.smartca.*
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterFragmentActivity() {
    private val CHANNEL = "com.sacombank.cmv/digitalSign"
    var vnptSmartCA = VNPTSmartCASDK()

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL
        ).setMethodCallHandler { call, result ->
            when (call.method) {
                "initSmartCa" -> {
                    initSmartCa()
                    result.success(true)
                }
                "getMainInfo" -> {
                    getMainInfo(result)
                }
                "getAuthentication" -> {
                    getAuthentication(result)
                }
                "startSign" -> {
                    startSign(call.arguments, result)
                }
                "destroySDK" -> {
                    destroySDK()
                    result.success(true)
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }

    private fun initSmartCa() {
        val config = ConfigSDK()
        config.context = this
        config.partnerId = "VNPTSmartCAPartner-79a7413b-c5cf-4c61-93d-9eccefef7b6c"
        config.environment = SmartCAEnvironment.PROD_ENV
        config.lang = SmartCALanguage.VI
        config.isFlutter = true
        vnptSmartCA.initSDK(config)
    }

    private fun getMainInfo(callback: MethodChannel.Result) {
        try {
            vnptSmartCA.getMainInfo { result ->
                // callback.success(getMap(result))
                when (result.status) {
                    SmartCAResultCode.SUCCESS_CODE -> {
                        callback.success(getMap(result))
                    }
                    else -> {
                        // Xử lý lỗi
                        callback.success(getMap(result))
                    }
                }
            }
        } catch (ex: Exception) {
//            throw ex;
            callback.error("100", ex.message, ex)
        }
    }

    private fun getAuthentication(callback: MethodChannel.Result) {
        try {
            // SDK tự động xử lý các trường hợp về: chưa kích hoạt, hết hạn token...
            vnptSmartCA.getAuthentication { result ->
                // Nếu ko lấy được token, credentialId sẽ hiển thị giao diện thông báo
                when (result.status) {
                    SmartCAResultCode.SUCCESS_CODE -> {
                        callback.success(getMap(result))
                    }
                    else -> {
                        // Xử lý lỗi
                        callback.success(getMap(result))
                    }
                }
            }
        } catch (ex: Exception) {
            callback.success("")
        }
    }

    private fun startSign(arguments: Any, callBack: MethodChannel.Result) {
        val transId: String = ((arguments as Map<*, *>)["transId"] ?: return) as String
        vnptSmartCA.getWaitingTransaction(transId) {
            callBack.success(getMap(it))
        }
    }

    private fun destroySDK() {
        vnptSmartCA.destroySDK()
    }

    private fun getMap(result: SmartCAResult): HashMap<String, Any> {
        val hashMap = HashMap<String, Any>()
        hashMap["status"] = result.status
        result.statusDesc?.let { hashMap.put("statusDesc", it) }
        result.data?.let { hashMap.put("data", it) }
        return hashMap
    }
}
