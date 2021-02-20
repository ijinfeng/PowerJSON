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
    
    init(child: Mirror.Child) {
        name = child.label ?? ""
        value = child.value
        let mirror = Mirror(reflecting: value)
        objectType = mirror.subjectType
        displayStyle = WappedMirror.transferDisplayStyle(from: mirror.displayStyle)
    }
}
