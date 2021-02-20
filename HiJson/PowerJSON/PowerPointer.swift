//
//  PowerPointer.swift
//  HiJson
//
//  Created by jinfeng on 2021/1/28.
//  Copyright © 2021 jinfeng. All rights reserved.
//

import Foundation
import SwiftOverlayShims

typealias Byte = UInt8

protocol PowerPointer {}

extension PowerPointer {
    /// 获取class或结构体的首属性地址偏移
    func metaDataSize() -> Int {
        if Self.self is AnyClass {
            return MemoryLayout<HeapObject>.size
        } else {
            return 0
        }
    }
    
    mutating func headerPointer() -> UnsafeMutablePointer<Byte> {
        if Self.self is AnyClass {
            return getClassObjHeaderPointer()
        } else {
            return getStructObjHeaderPointer()
        }
    }
    
    func getClassObjHeaderPointer() -> UnsafeMutablePointer<Byte> {
        let opaquePointer = Unmanaged.passUnretained(self as AnyObject).toOpaque()
        return opaquePointer.bindMemory(to: Byte.self, capacity: MemoryLayout<Self>.stride)
    }
    
    mutating func getStructObjHeaderPointer() -> UnsafeMutablePointer<Byte> {
        return withUnsafePointer(to: &self) { (pointer) in
            return UnsafeMutableRawPointer(mutating: pointer).bindMemory(to: Byte.self, capacity: MemoryLayout<Self>.stride)
        }
    }
}
