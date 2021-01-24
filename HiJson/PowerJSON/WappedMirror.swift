//
//  WappedMirror.swift
//  HiJson
//
//  Created by JinFeng on 2021/1/17.
//  Copyright © 2021 jinfeng. All rights reserved.
//

import Foundation

struct WappedMirror {
    enum DisplayStyle {
        case basic
        
        case `struct`

        case `class`

        case `enum`

        case tuple

        case optional

        case collection

        case dictionary

        case set
    }
    
    static func transferDisplayStyle(from displayStyle: Mirror.DisplayStyle?) -> DisplayStyle {
        if let displayStyle = displayStyle {
            switch displayStyle {
            case .struct:
                return .struct
            case .class:
                return .class
            case .enum:
                return .enum
            case .tuple:
                return .tuple
            case .optional:
                return .optional
            case .collection:
                return .collection
            case .dictionary:
                return .dictionary
            case .set:
                return .set
            default:
                return .basic
            }
        }
        return .basic
    }

}
