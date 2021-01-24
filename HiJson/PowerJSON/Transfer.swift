//
//  Transfer.swift
//  HiJson
//
//  Created by JinFeng on 2021/1/15.
//  Copyright © 2021 jinfeng. All rights reserved.
//

import Foundation

protocol TransferConfiguration {}

extension TransferConfiguration {
    
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
