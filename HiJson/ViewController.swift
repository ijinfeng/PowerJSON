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
    var age = 10
    var version: Int?
    var array: [String] = ["1"]
    var dic: Dictionary<String, Any>?
    
    func customLog() {
        print(">---------->")
        print("name=\(name)\ntitle=\(title ?? "nil")\nage=\(age)\nversion=\(version)\narray=\(array)\ndic=\(dic)")
        print("<----------<")
    }
    
}

enum JsonEnum {
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

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let jsonValue = """
{
"name": "jinfeng",
"title": "我是标题",
"age": 101,
"version": "11",
"dic": {"key": "-.-"},
}
"""
        print(jsonValue)
        
//////////////////////// 当前的问题 ///////////////
/// 1. property获取到的并不是对象本身的属性（指针），因此不能直接赋值
        
/// 2. OC 中不能被直接绑定的类型 //////////////////////
// NSString , NSArray, NSDictory
        
//////////////////////////////////////////////////////////////////////////////
        
        
        var s1: Any.Type = String.Type.self
        s1 = String.Type.self

        
        var model = JsonModel()
        model.wapped(from: jsonValue)
        
        model.customLog()
        
        
        print("======================== test =======================")
        
        print("size=\(MemoryLayout.size(ofValue: model))")
        print("alignment=\(MemoryLayout.alignment(ofValue: model))")
        print("stride=\(MemoryLayout.stride(ofValue: model))")
        
        
        var mpointer = PowerPointerHelp.headPointer(object: &model)
        mpointer = mpointer.setOffset(16)
        PowerPointerHelp.bindMemory(headPointer: mpointer, type: type(of: model.name)).pointee = "wo shi name"
        mpointer = mpointer.setOffset(MemoryLayout.stride(ofValue: model.name))
        PowerPointerHelp.bindMemory(headPointer: mpointer, type: type(of: model.title)).pointee = "wo shi title?"
        
        var s_model = JsonStruct()
        var pointer = PowerPointerHelp.headPointer(object: &s_model)
        PowerPointerHelp.bindMemory(headPointer: pointer, type: type(of: s_model.a)).pointee = 10000
        pointer = pointer.setOffset(MemoryLayout.stride(ofValue: s_model.a))
        PowerPointerHelp.bindMemory(headPointer: pointer, type: type(of: s_model.b)).pointee = "adasdadasdadasdadsasdad"
        pointer = pointer.setOffset(MemoryLayout.stride(ofValue: s_model.a) + MemoryLayout.stride(ofValue: s_model.b))
//        PowerPointerHelp.bindMemory(headPointer: pointer, type: type(of: s_model.c)).pointee = "wo shi ccccccccccc"
        
//        PowerPointerHelp.bindValue(object: &model.name, value: "jjj")
//        PowerPointerHelp.bindValue(object: &model.title, value: "-=-")
//        PowerPointerHelp.bindValue(object: &s_model.f, value: (10, "000"))
//        PowerPointerHelp.bindValue(object: &s_model.g, value: 100)
//        PowerPointerHelp.bindValue(object: &s_model.i, value: ["11":22])
//        PowerPointerHelp.bindValue(object: &s_model.j, value: CGSize(width: 100, height: 400))
//        PowerPointerHelp.bindValue(object: &s_model.c, value: "oc_s")
        
//        let pointer = PowerPointerHelp.headPointer(object: &model.a)
//        let a_p = UnsafeMutableRawPointer(pointer).bindMemory(to: Int.self, capacity: 1)
//                    a_p.pointee = 101
        
//        withUnsafeMutablePointer(to: &model) { (pointer: UnsafeMutablePointer<JsonStruct>) in
//            let a_p = UnsafeMutableRawPointer(pointer).bindMemory(to: Int.self, capacity: 1)
//            a_p.pointee = 101
//
//            UnsafeMutableRawPointer(a_p.advanced(by: MemoryLayout.stride(ofValue: a_p.pointee))).bindMemory(to: String.self, capacity: 1).pointee = "xyz"
//        }
        print("name=\(model.name)")
        print("title=\(model.title)")
        print("a=\(s_model.a)")
        print("f=\(s_model.f)")
        print("g=\(s_model.g)")
        print("h=\(s_model.h)")
        print("i=\(s_model.i)")
        print("j=\(s_model.j)")
        print("c=\(s_model.c)")
        print("b=\(s_model.b)")
        
        print(PowerPointerHelp.isOCObject(object: s_model.c))
        print(PowerPointerHelp.isOCObject(object: s_model.a))
        print(PowerPointerHelp.isOCObject(object: model.dic))
        print(PowerPointerHelp.isOCObject(object: s_model.g))
        print(PowerPointerHelp.isOCObject(object: s_model.h))
        print(PowerPointerHelp.isOCObject(object: s_model.j))
    
        
        
//        let oc_str: NSString = "oc_str"
//        let type_oc_str = type(of: String(oc_str))
//        print(type_oc_str)
    }


}

