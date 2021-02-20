//
//  ViewController.swift
//  HiJson
//
//  Created by JinFeng on 2021/1/13.
//  Copyright © 2021 jinfeng. All rights reserved.
//

import UIKit
import HandyJSON

class JsonModel: PowerJSON  {
    
    var name: String = "default"
    var title: String?
    var age: UInt16 = 10
    var version: Int?
    var array: [String] = ["1"]
    var dic: Dictionary<String, Any>?
    
//    func willWapped(key: String, value: Any?) {
//        print("wapped key=\(key),value=\(value)")
//    }
}

class SingleModel: PowerJSON {
        var age: Int16 = 0
    var name: String = "default"
    var title: String?
    var age1: UInt32 = 0
    var version: String?
    var f1: Float32 = 1.0
    var sub: String = "defalut"
    var dic: String? = "default"
}

enum JsonEnum: PowerJSON {
    case dong
    case xi
}

struct JsonStruct: HandyJSON {
    var a = 1
    var b = "123"
    var c: NSString = "s"
    var d = 11.11
    var e = JsonEnum.xi
    var f = (1, "2")
    var g: NSInteger = 10
    var h: NSArray = [1, 2]
    var i: [String: Any] = ["l": "12"]
    var j = CGSize(width: 10, height: 20)
}

class OCObjectClass: NSObject, PowerJSON {
    
}

class ViewController: UIViewController {

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        let jsonValue = """
{
"name": "jinfeng",
"title": "我是标题",
"age": 111,
"version": "11",
"dic": {"key": "-.-"},
"sub": "sub_string",
"age1": 189,
"f1": 19.99
}
"""
        
//        let jsonDic: [String : Any] = ["a": 123, "b":"123", "c":3, "g":999]
        
//        print(jsonValue)
        
//////////////////////// 当前的问题 ///////////////
/// 1. property获取到的并不是对象本身的属性（指针），因此不能直接赋值
        
/// 2. OC 中不能被直接绑定的类型： NSString , NSArray, NSDictory
        
/// 3. Any 类型获取到的Stride为32，与实际类型不匹配

        
//////////////////////////////////////////////////////////////////////////////
        
        var model = SingleModel()
        model.wapped(from: jsonValue)
        
        model.objectDescription()
        

//        print(MemoryLayout.stride(ofValue: model.name))
//        print(MemoryLayout.stride(ofValue: model.title))
//        print(MemoryLayout<String?>.stride)
//        print(MemoryLayout<String>.stride)
//        print(MemoryLayout.stride(ofValue: anyString))
        
        
//        let jsonStruct = JsonStruct.deserialize(from: jsonDic)
//        print(jsonStruct)
        
        
//        var my_i: FixedWidthInteger?
//        var my_j: SignedInteger?
        
//        var my_int: Int = 10
//        var my_int8: Int8 = 8
//        var my_int16: Int16 = 16
//        var my_int64: Int64 = 64
//
//
//
//        print(my_int.bitWidth)
//        print(my_int8.bitWidth)
//        print(my_int16.bitWidth)
//        print(my_int64.bitWidth)
//
//        print(MemoryLayout<Int>.stride)
//        print(MemoryLayout<Int8>.stride)
//        print(MemoryLayout<Int16>.stride)
//        print(MemoryLayout<Int64>.stride)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let left = UIBarButtonItem.init(title: "test", style: .done, target: self, action: #selector(actionForTest))
        navigationItem.rightBarButtonItem = left
        
    }

    @objc func actionForTest() {
        let vc = PointerTestViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

}

