//
//  WappedObject.swift
//  HiJson
//
//  Created by JinFeng on 2021/1/15.
//  Copyright © 2021 jinfeng. All rights reserved.
//

import Foundation

struct WappedObject {
    var propertys = [WappedProperty]()
    var displayStyle: WappedMirror.DisplayStyle
    var objectType: Any.Type
    var headPointer: UnsafeMutablePointer<Byte>
    var propertyOffset: Int
}

