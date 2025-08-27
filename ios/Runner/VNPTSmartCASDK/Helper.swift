//
//  Helper.swift
//  SmartCASDK
//
//  Created by AlwaysSmile on 04/12/2023.
//  Copyright © 2023 quannm. All rights reserved.
//

import Foundation

class Helper {
    
    // Convert from String to JSONString.
    public static func getJSONStringfromString(jsonObject: [String: Any]) -> String? {
        var convertedString: String? = nil
        do {
            let billData =  try JSONSerialization.data(withJSONObject: jsonObject, options: JSONSerialization.WritingOptions.prettyPrinted)
            convertedString = String(data: billData, encoding: String.Encoding.utf8)
        } catch let myJSONError {
            print(myJSONError)
        }
        return convertedString
    }
    
    // Make configure object
    public static func makeConfigure(env: Int, clientId: String, lang: String, isFlutter: Bool) -> [String: Any] {
        let jsonObject: [String : Any] = [ENV_KEY: env, CLIENT_ID_KEY: clientId, LANG_KEY: lang, IS_FLUTTER: isFlutter]
        return jsonObject
    }
}
