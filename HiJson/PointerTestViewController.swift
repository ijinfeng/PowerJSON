//
//  PointerTestViewController.swift
//  HiJson
//
//  Created by jinfeng on 2021/2/1.
//  Copyright © 2021 jinfeng. All rights reserved.
//

import Foundation
import UIKit


class OCClass: NSObject {
    var name: String?
    var age: Int = 10
}

class SwiftClass: PowerJSON {
    var name: String? = "jack"
    var age: UInt16 = 1
    var home: String?
    var add: UInt16 = 10
}

struct StructClass: PowerJSON {
    var name: String = "jack"
    var age: Int = 1
    var home: String?
}

class PointerTestViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
//       let oc = OCClass()
//       let ocPointer = Unmanaged.passUnretained(oc as AnyObject).toOpaque()
//        print(ocPointer)
//
//        let ocp2 = Unmanaged.passUnretained(oc as AnyObject).toOpaque()
//        print(ocp2)
        
        
        var cls = SwiftClass()
        let headerPointer = cls.headerPointer()
        let pointer = UnsafeMutableRawPointer(headerPointer)
        var offset = cls.metaDataSize()
        let namePtr = pointer.advanced(by: offset).assumingMemoryBound(to: String.self)
        offset += MemoryLayout<String?>.stride
        let agePtr = pointer.advanced(by: offset).assumingMemoryBound(to: UInt16.self)
//        let agePtr = pointer.advanced(by: offset).bindMemory(to: UInt16.self, capacity: MemoryLayout<UInt16>.stride)
        offset += MemoryLayout<Int>.stride
        let homePtr = pointer.advanced(by: offset).assumingMemoryBound(to: String?.self)
        offset += MemoryLayout<String?>.stride
        let addPtr = pointer.advanced(by: offset).assumingMemoryBound(to: UInt16.self)
        namePtr.pointee = "jinfeng"
        agePtr.pointee = 100
        homePtr.pointee = "地球村。。"
        addPtr.pointee = 1
//        cls.objectDescription()
        print(cls)
    }
}
