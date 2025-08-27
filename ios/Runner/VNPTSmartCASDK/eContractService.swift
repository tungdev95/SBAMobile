//
//  eContractService.swift
//  SmartCASDK
//
//  Created by AlwaysSmile on 04/12/2023.
//  Copyright © 2023 quannm. All rights reserved.
//

import Foundation
@_implementationOnly import eContractSDK
import UIKit
import Flutter

class EContractService {
    
    var rootView: UIViewController!
    var eContractResult: FlutterResult?
    var econtract = eContract()
    
    init(viewController: UIViewController, flutterEngine: FlutterEngine) {
        self.rootView = viewController
        econtract.delegate = self
        
        let methodChannel = FlutterMethodChannel(name: "com.vnpt.smartca/econtract", binaryMessenger: flutterEngine.binaryMessenger)
        methodChannel.setMethodCallHandler(setMethodCallHandler)
    }
    
    func setMethodCallHandler(call: FlutterMethodCall, result: @escaping FlutterResult) {
        self.eContractResult = result
        
        let arguments = call.arguments as? [String : Any?]
        
        switch call.method {
        case SmartCAMethods.configContract:
            configEContract(arguments: arguments)
        case SmartCAMethods.showContract:
            showContract(arguments: arguments)
        default:
            result("Not Implemented")
        }
    }
    
    func configEContract(arguments: [String: Any?]?) {
        let tokenId = arguments?["tokenId"] as? String
        let tokenKey = arguments?["tokenKey"] as? String
        let domain = arguments?["domain"] as? String
        
        econtract.data.tokenId = tokenId ?? ""
        econtract.data.tokenKey = tokenKey ?? ""
        econtract.data.domain = domain ?? ""
    }
    
    func showContract(arguments: [String: Any?]?) {
        let accessToken = arguments?["access_token"] as? String
        let orderId = arguments?["orderId"] as? String
        econtract.data.orderId = orderId ?? ""
        econtract.data.accessToken = accessToken ?? ""
        
        if let topVC = topViewController() {
            econtract.start(fromController: topVC)
        }
    }
    
    func getResult(isSuccess: Bool) {
        self.eContractResult?(["isSuccess": isSuccess])
    }
    
    func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}

extension EContractService: eContractDelegate {
    func onSuccess(contractId: String, signId: String, signerId: String, validDate: String?) {
        getResult(isSuccess: true)
    }
    
    func onError(msg: String) {
        getResult(isSuccess: false)
    }
}
