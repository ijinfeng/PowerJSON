//
//  PowerWapped.swift
//  HiJson
//
//  Created by JinFeng on 2021/1/23.
//  Copyright © 2021 jinfeng. All rights reserved.
//

import Foundation

protocol PowerWapped: MetaData {}

extension PowerWapped {
    mutating func toWappedObject() -> WappedObject {
        let mirror = Mirror(reflecting: self)
        let displayStyle = WappedMirror.transferDisplayStyle(from: mirror.displayStyle)
        let objectType = mirror.subjectType
        print("style=\(displayStyle),type=\(objectType)")
        let headPointer = PowerPointerHelp.headPointer(object: &self)
        var offset = self.metaDataSize(displayStyle: displayStyle)
        var propertys = [WappedProperty]()
        for child in mirror.children {
            var property = WappedProperty(child: child)
            propertys.append(property)
            property.offset = offset
            offset += property.stride
        }
        return WappedObject(propertys: propertys, displayStyle: displayStyle, objectType: objectType, headPointer: headPointer)
    }
}
