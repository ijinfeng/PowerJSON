//
//  UserConfiguration.swift
//  HiJson
//
//  Created by jinfeng on 2021/1/28.
//  Copyright © 2021 jinfeng. All rights reserved.
//

import Foundation

protocol WappedUserConfiguration {
    func customWappedKeys() -> [String: String]?
    func ignoreWappedKeys() -> [String]?
    func willWapped(key: String, value: Any?)
}

extension WappedUserConfiguration {
    
    /// 自定义key映射 ["targetKey": "oldKey"]
    /// like: ["identifier": "id"]
    func customWappedKeys() -> [String: String]? {
        return [:]
    }
    
    /// 要忽略映射的keys
    func ignoreWappedKeys() -> [String]? {
        return []
    }
    
    /// 将要映射的key-value
    /// - Parameters:
    ///   - key: key
    ///   - value: value
    func willWapped(key: String, value: Any?) {
        
    }
}
