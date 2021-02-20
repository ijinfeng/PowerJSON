//
//  PowerWapped.swift
//  HiJson
//
//  Created by JinFeng on 2021/1/23.
//  Copyright © 2021 jinfeng. All rights reserved.
//

import Foundation

protocol PowerWapped: PowerPointer {}

extension PowerWapped {
    mutating func toWappedObject() -> WappedObject {
        let mirror = Mirror(reflecting: self)
        let displayStyle = WappedMirror.transferDisplayStyle(from: mirror.displayStyle)
        let objectType = mirror.subjectType
        let headPointer = self.headerPointer()
        let offset = self.metaDataSize()
        var propertys = [WappedProperty]()
        for child in mirror.children {
            let property = WappedProperty(child: child)
//            property.offset = offset
            propertys.append(property)
        }
        return WappedObject(propertys: propertys, displayStyle: displayStyle, objectType: objectType, headPointer: headPointer, propertyOffset: offset)
    }
    
    func write(value: Any, object: inout WappedObject, to property: WappedProperty) {
        print("-----will transfer type=\(property.objectType)-----")
        if let transferType = property.objectType as? TypeTransfer.Type {
            print("-----transfer success with type=\(transferType)-----")
            let headerPointer = object.headPointer.advanced(by: object.propertyOffset)
            let rawPointer = UnsafeMutableRawPointer(headerPointer)
            let offset = transferType.transfer(from: transferType, anyValue: value, headerRawPointer: rawPointer)
            print("-----end transfer type return offset=\(offset)")
            object.propertyOffset += offset
        }
    }
    
    mutating func objectDescription() {
        let object = self.toWappedObject()
        print("\n----->object<class:\(Self.self)>")
        for property in object.propertys {
            print("\t\(property.name) - \(property.value)")
        }
        print("----->print end\n")
    }
}
