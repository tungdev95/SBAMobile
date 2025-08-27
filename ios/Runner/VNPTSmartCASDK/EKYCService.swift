//
//  EKYCService.swift
//  SmartCASDK
//
//  Created by AlwaysSmile on 04/12/2023.
//  Copyright © 2023 quannm. All rights reserved.
//

import Foundation
import Flutter
@_implementationOnly import ICSdkEKYC

class EKYCService: NSObject {
    
    var ekycResult: FlutterResult?
    var rootView: UIViewController?
    
    init(viewController: UIViewController, flutterEngine: FlutterEngine) {
        super.init()
        self.rootView = viewController
        
        let methodChannel = FlutterMethodChannel(name: "com.vnpt.smartca/ekyc", binaryMessenger: flutterEngine.binaryMessenger)
        methodChannel.setMethodCallHandler(setMethodCallHandler)
    }
    
    func setMethodCallHandler(call: FlutterMethodCall, result: @escaping FlutterResult) {
        self.ekycResult = result
        let arguments = call.arguments as? [String : Any?]
        
        switch call.method {
        case EKYCMethods.configeKYC:
            break
        case EKYCMethods.eKYCFull:
            eKYCFullFlow(arguments: arguments)
        default:
            result("Not Implemented")
        }
    }
    
    func _configFlowBase(arguments: [String : Any?]?) -> ICEkycCameraViewController {
        let objCamera = ICEkycCameraRouter.createModule() as! ICEkycCameraViewController
        objCamera.cameraDelegate = self
        
        objCamera.versionSdk = ProOval
        objCamera.isShowTutorial = true
        objCamera.documentType = IdentityCard
        objCamera.isShowTrademark = false
        objCamera.isValidatePostcode = false
        objCamera.languageSdk = arguments?["languageApplication"] as? String ?? "vi"
        objCamera.isEnableGotIt = arguments?["isSkipVoiceVideo"] as? Bool ?? true
        objCamera.isCheckLivenessCard = arguments?["isCheckLivenessCard"] as? Bool ??  true
        objCamera.isCheckMaskedFace = arguments?["isCheckMaskFace"] as? Bool ?? true
        objCamera.isTurnOffCallService = true
        objCamera.modalPresentationStyle = .fullScreen
        
        return objCamera
    }
    
    func eKYCFullFlow(arguments: [String : Any?]?) {
        let objCamera = _configFlowBase(arguments: arguments)
        objCamera.flowType = full
        objCamera.isRecordVideoFace = true
        objCamera.isRecordVideoDocument = true
        objCamera.modelHelpCard = HelpV2
        self.rootView?.showDetailViewController(objCamera, sender: nil)
    }
    
    func getResulteKYC() {
        let result: [String: Any?] = [
            "IdFront": ICEKYCSavedData.shared().imageCropedFront.jpegData(compressionQuality: 0.95),
            "IdFrontFull": ICEKYCSavedData.shared().imageFront.jpegData(compressionQuality: 0.95),
            
            "IdBack": ICEKYCSavedData.shared().imageCropedBack.jpegData(compressionQuality: 0.95),
            "IdBackFull": ICEKYCSavedData.shared().imageBack.jpegData(compressionQuality: 0.95),
            
            "NearPortrait": ICEKYCSavedData.shared().imageFaceNear.jpegData(compressionQuality: 0.95),
            "FarPortrait": ICEKYCSavedData.shared().imageFaceFar.jpegData(compressionQuality: 0.95),
            "imageCropedFaceFar": ICEKYCSavedData.shared().imageCropedFaceFar.jpegData(compressionQuality: 0.95),
            "imageCropedFaceNear": ICEKYCSavedData.shared().imageCropedFaceNear.jpegData(compressionQuality: 0.95),
            "FaceVideo": ICEKYCSavedData.shared().pathVideoRecordFace.path,
            "OcrIdVideo": ICEKYCSavedData.shared().pathVideoRecordDocument.path,
        ]
        
        self.ekycResult?(result)
    }
}

extension EKYCService: ICEkycCameraDelegate {
    func icEkycGetResult() {
        getResulteKYC()
    }
}
