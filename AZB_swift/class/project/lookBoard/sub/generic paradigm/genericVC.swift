//
//  genericVC.swift
//  AZB_swift
//
//  Created by limbo on 2020/5/7.
//  Copyright © 2020 limbo. All rights reserved.
//

import Foundation

class genericVC: BaseVC {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //泛型 inout关键字练习
        //在Swift类型中，只有class是指针传递，其余的如Int,Float,Bool,Character,Array,Set,enum,struct全都是值传递.使用inout关键字可以传递其指针
            var arr = [2,5]
            appendIntToArray(src: [12,9], dest: &arr)
            print(arr)
            
            var strArr = ["OC","Swift"]
            appendStringToArray(src: ["PHP", "C#"], dest: &strArr)
            print(strArr)
            
            var anyArr: [Any] = [1,2]
            appendToArray(src: ["a", "b"], dest: &anyArr)
            print(anyArr)
            
            var stringStack = stack<String>.init()
            stringStack.push(item: "a")
            stringStack.push(item: "b")
            stringStack.push(item: "c")
            print(stringStack.array)
            stringStack.pop()
            print(stringStack.array)
    }
    
    
    func appendIntToArray(src:[Int], dest:inout [Int]) {
        for element in src {
            dest.append(element)
        }
    }
    
    func appendStringToArray(src:[String], dest:inout [String]) {
        for element in src {
            dest.append(element)
        }
    }

    func appendToArray(src:[Any],dest: inout [Any]){
        for element in src {
            dest.append(element)
        }
    }
    
    func appendAnyToArray<T>(src:[T],dest:inout [T]){
        for element in src {
            dest.append(element)
        }
    }
}

//用结构体模拟一个泛型的栈
struct stack<T> {
    var array = Array<T>.init()
    
    mutating func push(item:T){
        array.append(item)
    }
    
    mutating func pop()->T{
        return array.removeLast()
    }
}
