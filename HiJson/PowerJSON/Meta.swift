//
//  Meta.swift
//  HiJson
//
//  Created by JinFeng on 2021/1/22.
//  Copyright © 2021 jinfeng. All rights reserved.
//

import Foundation
import SwiftOverlayShims

protocol MetaData {
    func metaDataSize(displayStyle: WappedMirror.DisplayStyle) -> Int
}

extension MetaData {
    func metaDataSize(displayStyle: WappedMirror.DisplayStyle) -> Int {
        if displayStyle == .class {
            return MemoryLayout<HeapObject>.size
        } else {
            return 0
        }
    }
}
