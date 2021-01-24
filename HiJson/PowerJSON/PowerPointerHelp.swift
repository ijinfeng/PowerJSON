//
//  PowerPointerHelp.swift
//  HiJson
//
//  Created by JinFeng on 2021/1/17.
//  Copyright © 2021 jinfeng. All rights reserved.
//

import Foundation

typealias Byte = UInt8

struct PowerPointerHelp<T> {
    
    /// 获取某个对象的指针
    /// - Parameter object: 对象实例
    static func headPointer(object: inout T) -> UnsafeMutablePointer<Byte> {
        if T.self is AnyClass {
            return headPointerOfClass(object: &object)
        } else {
            return headPointerOfStruct(object: &object)
        }
    }
    
    /// 给某个指针绑定一个类型
    /// - Parameters:
    ///   - headPointer: 对象指针
    ///   - type: 类型
    static func bindMemory(headPointer: UnsafeMutablePointer<Byte>, type: T.Type) -> UnsafeMutablePointer<T> {
        let pointer = UnsafeMutableRawPointer(headPointer).bindMemory(to: type, capacity: MemoryLayout<T>.stride)
        return pointer
    }
    
    /// 将首地址偏移指定位置后设值
    /// - Parameters:
    ///   - headPointer: 首地址
    ///   - type: 类型
    ///   - offset: 偏移量
    ///   - value: 值
    static func bindMemory(headPointer: UnsafeMutablePointer<Byte>, type: T.Type, offset: Int, value: T) {
        var pointer = bindMemory(headPointer: headPointer, type: type)
        pointer = pointer.setOffset(offset)
        pointer.pointee = value
    }
    
    /// 给某个对象绑定一个值
    /// - Parameters:
    ///   - object: 对象实例
    ///   - value: 值
    static func bindValue(object: inout T, value: T) {
        let pointer = headPointer(object: &object)
        let typePointer = bindMemory(headPointer: pointer, type: type(of: object))
        typePointer.pointee = value
    }
    
    /// 是否是OC对象
    /// - Parameter object: true：是，false：不是
    static func isOCObject(object: T) -> Bool {
        return type(of: object) is NSObject.Type
    }
}

extension PowerPointerHelp {
    static func headPointerOfStruct(object: inout T) -> UnsafeMutablePointer<Byte> {
        return withUnsafePointer(to: &object) { (pointer) in
            return UnsafeMutableRawPointer(mutating: pointer).bindMemory(to: Byte.self, capacity: MemoryLayout<T>.stride)
        }
    }
    
    static func headPointerOfClass(object: inout T) -> UnsafeMutablePointer<Byte> {
        guard T.self is AnyClass else {
            return headPointerOfStruct(object: &object)
        }
        let opaquePointer = Unmanaged.passUnretained(object as AnyObject).toOpaque()
        return opaquePointer.bindMemory(to: Byte.self, capacity: MemoryLayout<T>.stride)
    }
}

extension UnsafeMutablePointer {
    func setOffset(_ offset: Int) -> UnsafeMutablePointer {
        return self.advanced(by: offset)
    }
}
