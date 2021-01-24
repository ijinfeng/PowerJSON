//
//  JSONSerialize.swift
//  HiJson
//
//  Created by JinFeng on 2021/1/15.
//  Copyright © 2021 jinfeng. All rights reserved.
//

import Foundation

typealias JSON = Any
typealias JSONObject = Any

protocol JSONSerialize {}

extension JSONSerialize {
    static func data(from jsonObject: JSONObject) -> Data? {
        if jsonObject is Data {
            return jsonObject as? Data
        }
        if let jsonString = jsonObject as? String {
            return jsonString.data(using: .utf8)
        }
        let vaildJSONObject = JSONSerialization.isValidJSONObject(jsonObject)
        guard vaildJSONObject else {
            return nil
        }
        return try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)
    }
    
    static func jsonObject(from json: JSON) -> Any? {
        guard let data = self.data(from: json) else {
            return nil
        }
        return try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
    }
    
    
}
