//
//  PowerJSONImpl.swift
//  HiJson
//
//  Created by JinFeng on 2021/1/22.
//  Copyright © 2021 jinfeng. All rights reserved.
//

import Foundation

extension PowerJSON {
    @discardableResult mutating func wapped(from json: JSON) -> Self {
        let jsonObject = Self.jsonObject(from: json)
        if jsonObject is [String: Any] {
            let jsonDic = jsonObject as! [String: Any]
            var wappedObject = self.toWappedObject()
            let customWappedKeys = self.customWappedKeys() ?? [:]
            for property in wappedObject.propertys {
                var propertyName = property.name
                if let wappedKey = customWappedKeys[property.name] {
                    propertyName = wappedKey
                }
                if let jsonValue = jsonDic[propertyName] {
                    print("will wapped name=\(propertyName), value=\(jsonValue)")
                    self.willWapped(key: propertyName, value: jsonValue)
                    self.write(value: jsonValue, object: &wappedObject, to: property)
                }
            }
        } else if jsonObject is [Any] {
            
            
        }
        return self
    }
    
    func toJSON() -> JSON? {
        return nil
    }
    func toJSONData() -> Data? {
        return nil
    }
    func toJSONString() -> String? {
        return nil
    }
}
