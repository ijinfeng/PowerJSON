//
//  TypeTransfer.swift
//  HiJson
//
//  Created by jinfeng on 2021/2/3.
//  Copyright © 2021 jinfeng. All rights reserved.
//

import Foundation


/// 这里分两层，一个是模型定义的时候属性的类型，一个是json返回的类型

protocol TypeTransfer {
    static func _set(value: Any, for rawPointer: UnsafeMutableRawPointer) -> Int
}

extension TypeTransfer {
    static func transfer(from type: TypeTransfer.Type, anyValue: Any, headerRawPointer: UnsafeMutableRawPointer) -> Int {
        var _offset = 0
        switch type {
        case let transferType as SwiftTypeTransfer.Type:
            _offset = transferType._set(value: anyValue, for: headerRawPointer)
        case let transferType as ObjectiveCTypeTransfer.Type:
            _offset = transferType._set(value: anyValue, for: headerRawPointer)
        case let transferType as CustomTypeTransfer.Type:
            _offset = transferType._set(value: anyValue, for: headerRawPointer)
        case let transferType as UnknowTypeTransfer.Type:
            _offset = transferType._set(value: anyValue, for: headerRawPointer)
        default:
            break
        }
        return _offset
    }
}


/// Swift type transfer from Any.Type
protocol SwiftTypeTransfer: TypeTransfer {
    
}

extension SwiftTypeTransfer {
    
}

extension Optional: SwiftTypeTransfer {
    static func _set(value: Any, for rawPointer: UnsafeMutableRawPointer) -> Int {
        if let transferType = Wrapped.self as? TypeTransfer.Type {
            return transferType.transfer(from: transferType, anyValue: value, headerRawPointer: rawPointer)
        }
        return 0
    }
}

extension String: SwiftTypeTransfer {
    static func _set(value: Any, for rawPointer: UnsafeMutableRawPointer) -> Int {
        if let realValue = value as? String {
            rawPointer.assumingMemoryBound(to: String.self).pointee = realValue
        }
        return MemoryLayout<String>.stride
    }
}

protocol SwiftIntegerTypeTransfer: SwiftTypeTransfer {
}

extension SwiftIntegerTypeTransfer {
    static func _set(value: Any, for rawPointer: UnsafeMutableRawPointer) -> Int {
        if let realValue = value as? Self {
            rawPointer.assumingMemoryBound(to: Self.self).pointee = realValue
        }
        // 这儿很奇怪，不管是Int16还是其他，偏移必须是Int的步长
        let stride = MemoryLayout<Int>.stride
        print("-----stride:\(stride)")
        return stride
    }
}

extension Int: SwiftIntegerTypeTransfer {}
extension Int8: SwiftIntegerTypeTransfer {}
extension Int16: SwiftIntegerTypeTransfer {}
extension Int32: SwiftIntegerTypeTransfer {}
extension Int64: SwiftIntegerTypeTransfer {}

extension UInt: SwiftIntegerTypeTransfer {}
extension UInt8: SwiftIntegerTypeTransfer {}
extension UInt16: SwiftIntegerTypeTransfer {}
extension UInt32: SwiftIntegerTypeTransfer {}
extension UInt64: SwiftIntegerTypeTransfer {}

protocol SwiftFloatTypeTransfer: SwiftTypeTransfer {
}

extension SwiftFloatTypeTransfer {
    static func _set(value: Any, for rawPointer: UnsafeMutableRawPointer) -> Int {
        if let realValue = value as? Self {
            rawPointer.assumingMemoryBound(to: Self.self).pointee = realValue
        }
        let stride = MemoryLayout<Self>.stride
        print("-----stride:\(stride)")
        return stride
    }
}

extension Float: SwiftFloatTypeTransfer {}
extension Double: SwiftFloatTypeTransfer {}
@available(iOS 14.0, *)
extension Float16: SwiftFloatTypeTransfer {}

/// Objective-C type transfer from Any.Type
protocol ObjectiveCTypeTransfer: TypeTransfer {
    
}

extension ObjectiveCTypeTransfer {
    
}


/// User custom type transfer from Any.Type
protocol CustomTypeTransfer: TypeTransfer {
    
}

extension CustomTypeTransfer {
    
}


/// Unknow type transfer from Any.Type
protocol UnknowTypeTransfer: TypeTransfer {
    
}

extension UnknowTypeTransfer {
    
}
