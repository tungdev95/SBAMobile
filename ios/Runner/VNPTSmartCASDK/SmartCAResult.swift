//
//  SmartCAResult.swift
//  SmartCASDK
//
//  Created by AlwaysSmile on 04/12/2023.
//  Copyright © 2023 quannm. All rights reserved.
//

import Foundation

public struct SmartCAResult {
    public var status: Int
    public var statusDesc: String
    public var data: String
    
    public init(map: [String: Any?]) {
        status = map["status"] as? Int ?? 0
        statusDesc = map["statusDesc"] as? String ?? ""
        data = map["data"] as? String ?? ""
    }
    
    public func toJson() -> [String: Any] {
        return ["status": status, "statusDesc": statusDesc, "data": data]
    }
}

//public class SmartCAResultCodeDesc {
//    public static var UNKNOWN_ERROR = "UNKNOWN_ERROR"
//    public static var USER_CANCEL = "USER_CANCEL"
//    public static var REJECTED_SUCCESS = "REJECTED_SUCCESS"
//    public static var CONFIRMED_SUCCESS = "CONFIRMED_SUCCESS"
//    public static var ENROLL_SUCCESS = "ENROLL_SUCCESS"
//    public static var SUCCESS = "SUCCESS"
//}

public class SmartCAResultCode {
    public static var REQUIRED_OPEN_SDK = 4
    public static var UNKNOWN_ERROR_CODE = 2
    public static var USER_CANCEL_CODE = 1
    public static var SUCCESS_CODE = 0
}
