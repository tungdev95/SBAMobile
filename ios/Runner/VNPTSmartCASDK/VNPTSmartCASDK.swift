//
//  VNPTSmartCASDK.swift
//  SmartCASDK
//
//  Created by AlwaysSmile on 04/12/2023.
//  Copyright © 2023 quannm. All rights reserved.
//

import Foundation
import Flutter
//import FlutterPluginRegistrant
import UIKit

public class VNPTSmartCASDK {
    
    lazy var flutterEngine = FlutterEngine(name: "vnpt_smartca")
    private var smartCAResultListener: SmartCAResultListener?
    var methodChannel: FlutterMethodChannel?
    var flutterViewController: FlutterViewController?
    var listeners = [String: (SmartCAResult) -> Void]()
    public enum ENVIRONMENT: Int { case DEMO = 1, PRODUCTION = 2 }
    public enum LANG: String {case VI = "vi", EN = "en"}
    
    var enviroment: Int
    var partnerId: String
    var lang: String
    var isFlutterApp: Bool
    var viewController: UIViewController?
    var eKYCService: EKYCService?
    var eContractService: EContractService?
    
    var isShowingSDK = false
    
    // Khởi tạo SDK
    public init(viewController: UIViewController, partnerId: String, environment: ENVIRONMENT, lang: LANG, isFlutterApp: Bool = false) {
        
        self.viewController = viewController
        self.enviroment = environment.rawValue
        self.partnerId = partnerId
        self.lang = lang.rawValue
        self.isFlutterApp = isFlutterApp
        
        self.flutterEngine.run(withEntrypoint: isFlutterApp ? "VNPTSmartCAEntryponit" : "")
//        GeneratedPluginRegistrant.register(with: self.flutterEngine)
        
        self.methodChannel = FlutterMethodChannel(name: METHOD_CHANNEL, binaryMessenger: flutterEngine.binaryMessenger)
        self.flutterViewController = FlutterViewController(engine: self.flutterEngine, nibName: nil, bundle: nil)
        
        let _ = SmartCAResultListener(vnptSmartCASDK: self)
    }
    
    // Cấu hình SDK
    public func configSDK() -> Void {
        let argsObj = Helper.makeConfigure(env: self.enviroment, clientId: self.partnerId, lang: self.lang, isFlutter: isFlutterApp)
        let args = Helper.getJSONStringfromString(jsonObject: argsObj)
        self.methodChannel?.invokeMethod(SmartCAMethods.configure, arguments: args)
    }
    
    // Lấy thông tin về accessToken, credentialId
    public func getAuthentication(callback: @escaping (SmartCAResult) -> Void) -> Void {
        self.listeners[SmartCAMethods.getAuthenticationResult] = callback
        self.methodChannel?.invokeMethod(SmartCAMethods.getAuthentication, arguments: nil)
    }
    
    // Lấy thông tin giao dịch chờ
    public func getWaitingTransaction(tranId: String, callback: @escaping (SmartCAResult) -> Void) -> Void {
        self.listeners[SmartCAMethods.getWaitingTransactionResult] = callback
        self.methodChannel?.invokeMethod(SmartCAMethods.getWaitingTransaction, arguments: tranId)
        self.showSDK()
    }
    
    // Mở màn hình Main
    public func getMainInfo(callback: @escaping (SmartCAResult) -> Void) -> Void {
        self.listeners[SmartCAMethods.getMainInfoResult] = callback
        self.methodChannel?.invokeMethod(SmartCAMethods.getMainInfo, arguments: nil)
        self.showSDK()
    }
    
    // Hiển thị màn hình SDK
    func showSDK() {
        if isShowingSDK { return }
        isShowingSDK = true
        self.flutterViewController?.modalPresentationStyle = .overFullScreen
        if let flutterVC = flutterViewController {
            self.viewController?.present(flutterVC, animated: true, completion: nil)
        }
    }
    
    // Đóng SDK
    func closeSDK() {
        isShowingSDK = false
        self.flutterViewController?.dismiss(animated: true, completion: nil)
    }
    
    // Hủy engine Flutter đang chạy
    public func destroySDK() -> Void {
        self.flutterEngine.destroyContext()
    }
   
}
