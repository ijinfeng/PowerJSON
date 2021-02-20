//
//  HiJson.swift
//  HiJson
//
//  Created by JinFeng on 2021/1/13.
//  Copyright © 2021 jinfeng. All rights reserved.
//

import Foundation

/// https://github.com/alibaba/HandyJSON
/// 通过指针操作来实现swift中的model赋值

protocol PowerJSON: TransferMix, WappedUserConfiguration {
    
    mutating func wapped(from json: JSON) -> Self
    
    func toJSON() -> JSON?
    
    func toJSONData() -> Data?
    
    func toJSONString() -> String?
}

