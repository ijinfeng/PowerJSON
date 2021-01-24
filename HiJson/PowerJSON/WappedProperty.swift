//
//  WappedProperty.swift
//  HiJson
//
//  Created by JinFeng on 2021/1/15.
//  Copyright © 2021 jinfeng. All rights reserved.
//

import Foundation

struct WappedProperty {
    var name: String
    var value: Any
    var displayStyle: WappedMirror.DisplayStyle
    var objectType: Any.Type
    var stride: Int
    var offset: Int
    
    init(child: Mirror.Child) {
        name = child.label ?? ""
        value = child.value
        let mirror = Mirror(reflecting: value)
        displayStyle = WappedMirror.transferDisplayStyle(from: mirror.displayStyle)
        objectType = mirror.subjectType
        stride = MemoryLayout.stride(ofValue: value)
        offset = stride
        print("property style=\(displayStyle), type=\(mirror.subjectType), value=\(value)")
    }
}
