//
//  SmartCAResultListener.swift
//  SmartCASDK
//
//  Created by AlwaysSmile on 04/12/2023.
//  Copyright © 2023 quannm. All rights reserved.
//

import Foundation
import Flutter

class SmartCAResultListener {
    
    init(vnptSmartCASDK: VNPTSmartCASDK) {
        vnptSmartCASDK.methodChannel?.setMethodCallHandler {
            (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            if let arguments = call.arguments as? [String: Any] {
                switch call.method {
                case SmartCAMethods.getWaitingTransactionResult:
                    let result = SmartCAResult(map: arguments)
                    if let callback = vnptSmartCASDK.listeners[SmartCAMethods.getWaitingTransactionResult] {
                        callback(result)
                    }
                case SmartCAMethods.getAuthenticationResult:
                    let result = SmartCAResult(map: arguments)
                    let callback = vnptSmartCASDK.listeners[SmartCAMethods.getAuthenticationResult]
                    let status = result.status
                    // Không lấy được token, credential thì show giao diện
//                    if status != SmartCAResultCode.SUCCESS_CODE && status != SmartCAResultCode.USER_CANCEL_CODE {
                    if status == SmartCAResultCode.REQUIRED_OPEN_SDK {
                        vnptSmartCASDK.showSDK()
                    } else {
                        vnptSmartCASDK.closeSDK()
                    }
                    if status != SmartCAResultCode.REQUIRED_OPEN_SDK, let callback = callback {
                        callback(result)
                    }
                case SmartCAMethods.getMainInfoResult:
                    let result = SmartCAResult(map: arguments)
                    if let callback = vnptSmartCASDK.listeners[SmartCAMethods.getMainInfoResult] {
                        callback(result)
                    }
                case SmartCAMethods.activeEKYC:
                    if vnptSmartCASDK.eKYCService == nil, vnptSmartCASDK.viewController != nil {
                        vnptSmartCASDK.eKYCService = EKYCService(viewController: vnptSmartCASDK.viewController!, flutterEngine: vnptSmartCASDK.flutterEngine)
                    }
                case SmartCAMethods.activeEContract:
                    if vnptSmartCASDK.eContractService == nil, vnptSmartCASDK.viewController != nil {
                        vnptSmartCASDK.eContractService = EContractService(viewController: vnptSmartCASDK.viewController!, flutterEngine: vnptSmartCASDK.flutterEngine)
                    }
                case SmartCAMethods.userCancel:
                    vnptSmartCASDK.closeSDK()
                case SmartCAMethods.isReady:
                    vnptSmartCASDK.configSDK()
                default:
                    break
                }
            } else {
                result(FlutterError.init(code: "bad args", message: nil, details: nil))
            }
        }
    }
}
