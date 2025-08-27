//
//  Constants.swift
//  SmartCASDK
//
//  Created by AlwaysSmile on 04/12/2023.
//  Copyright © 2023 quannm. All rights reserved.
//

import Foundation

class EKYCMethods {
    static let configeKYC = "configeKYC"
    static let eKYCFull = "eKYCFull"
    static let ocrFront = "ocrFront"
    static let ocrBack = "ocrBack"
    static let ocrFrontAndBack = "ocrFrontAndBack"
    static let compareFace = "compareFace"
    static let verifyFace = "verifyFace"   
}

class EContractMethods {
    static let configContract = "configContract"
    static let showContract = "showContract"
}

class SmartCAMethods {
    static let getAuthentication = "getAuthentication"
    static let getAuthenticationResult = "getAuthenticationResult"
    
    static let getWaitingTransaction = "getWaitingTransaction"
    static let getWaitingTransactionResult = "getWaitingTransactionResult"
    
    static let getMainInfo = "getMainInfo"
    static let getMainInfoResult = "getMainInfoResult"
 
    static let activeEKYC = "activeEKYC"
    static let activeEContract = "activeEContract"
        
    static let userCancel = "userCancel"
    static let isReady = "VNPTSmartCASDK#isReady"
    static let configure = "VNPTSmartCASDK#start"
    
    static let configContract = "configContract"
    static let showContract = "showContract"
}
