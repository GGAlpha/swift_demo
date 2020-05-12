//
//  runtimeVC.swift
//  AZB_swift
//
//  Created by limbo on 2020/5/8.
//  Copyright © 2020 limbo. All rights reserved.
//

import Foundation

/*
 纯swift类没有动态性，但在方法、属性前添加dynamic修饰，可获得动态性。
 继承自NSObject的swift类，其继承自父类的方法具有动态性，其它自定义方法、属性想要获得动态性，需要添加dynamic修饰。
 若方法的参数、属性类型为swift特有、无法映射到objective－c的类型(如Character、Tuple)，则此方法、属性无法添加dynamic修饰(编译器报错)
*/
class runtimeVC: BaseVC {
    var aBool:Bool = true
        var aInt:UInt = 0
        var aFloat:Float = 123.45
        var aDouble:Double = 1234.567
        var aString:String = "abc"
        var aObject:AnyObject! = nil
        
        override func viewDidLoad() {
            
    //        let aSwiftClass:TestASwiftClass = TestASwiftClass.init()
    //        showClsRuntime(cls: object_getClass(aSwiftClass)!)
    //        print("\n");
    //        showClsRuntime(cls:object_getClass(self)!);
            methodSwizze(cls: object_getClass(ViewController.self)!, originalSelector: #selector(UIViewController.viewDidAppear(_:)), swizzedSelector: #selector(ViewController.sz_viewDidAppear(animated:)))
          
            methodSwizze(cls: object_getClass(ViewController.self)!, originalSelector: #selector(ViewController.testReturnVoidWithaId(aId:)), swizzedSelector: #selector(ViewController.sz_testReturnVoidWithaId(aId:)))
    //        testReturnVoidWithaId(aId: self.view)
        }
        
    //    func showClsRuntime(cls:AnyClass){
    //        print("start methodList")
    //        var methodNum:UInt32 = 0
    //        let methodList = class_copyMethodList(cls, &methodNum)
    //        for index in 0..<numericCast(methodNum){
    //            let method:Method = methodList![index]
    //            print(String(utf8String: method_getTypeEncoding(method)!))
    //            print(String(utf8String: method_copyReturnType(method)))
    //            print(String(_sel:method_getName(method)))
    //        }
    //        print("end methodList")
    //
    //        print("start propertyList")
    //        var propertyNum:UInt32 = 0
    //        let propertyList = class_copyPropertyList(cls, &propertyNum)
    //        for index in 0..<numericCast(propertyNum){
    //            let property:objc_property_t = propertyList![index]
    //            print(String(utf8String:property_getName(property)))
    //            print(String(utf8String:property_getAttributes(property)!))
    //        }
    //        print("end propertyList")
    //    }
    //
    //
    //    override func viewDidAppear(_ animated: Bool) {
    //        super.viewDidAppear(animated)
    //    }
    //
    //    func testReturnVoidWithaId(aId:UIView){
    //
    //    }
    //
    //    func testReturnVoidWithaBool(aBool:Bool,aInteger:UInt,aFloat:Float,aDouble:Double,aString:String,aObject:AnyObject){
    //
    //    }
    //
    //    func testReturnTuple(aBool:Bool,aInteger:UInt,aFloat:Float,aDouble:Double,aString:String,aObject:AnyObject)->(UInt,Bool,Float){
    //         return (aInteger,aBool,aFloat)
    //    }
    //
    //    func testReturnVoidWithaCharacter(aCharacter:Character){
    //
    //    }
        
        func methodSwizze(cls:AnyClass,originalSelector:Selector,swizzedSelector:Selector){
            let originalMethod = class_getInstanceMethod(cls, originalSelector)
            let swizzledMethod = class_getInstanceMethod(cls, swizzedSelector)
            
            let didAddMethod = class_addMethod(cls, originalSelector, method_getImplementation(swizzledMethod!), method_getTypeEncoding(swizzledMethod!))
            if didAddMethod{
                class_replaceMethod(cls, swizzedSelector, method_getImplementation(originalMethod!), method_getTypeEncoding(originalMethod!))
            }else{
                method_exchangeImplementations(originalMethod!, swizzledMethod!)
            }
        }
        
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            print("F:\(#function) L:\(#line)")
        }
        @objc func sz_viewDidAppear(animated:Bool){
            super.viewDidAppear(animated)
            print("\(#function) L:\(#line)")
        }
        
        //纯swift类没有动态性，但在方法、属性前添加dynamic修饰，可获得动态性
        @objc dynamic func testReturnVoidWithaId(aId:UIView){
            print("F:\(#function) L:\(#line)")
        }
        
        @objc dynamic func sz_testReturnVoidWithaId(aId:UIView){
            print("F:\(#function) L:\(#line)")
        }
        
    }

    class TestASwiftClass {
        var aBool:Bool = true
        var aInt:UInt = 0
        var aFloat:Float = 123.45
        var aDouble:Double = 1234.567
        var aString:String = "abc"
        var aObject:AnyObject! = nil
    }

    extension ViewController{
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            print("F:\(#function) L:\(#line)")
        }
        @objc func sz_viewDidAppear(animated:Bool){
            super.viewDidAppear(animated)
            print("\(#function) L:\(#line)")
        }
        @objc func testReturnVoidWithaId(aId:UIView){
            print("F:\(#function) L:\(#line)")
        }
        
        @objc func sz_testReturnVoidWithaId(aId:UIView){
            print("F:\(#function) L:\(#line)")
        }
}
