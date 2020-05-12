//
//  dangerSnapModel.swift
//  AZB_swift
//
//  Created by limbo on 2020/4/9.
//  Copyright © 2020 limbo. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class dangerSnapModel: Object,NSMutableCopying {
    
    var imageArray = List<SelectImageModel>()
    @objc dynamic var id:Int = 0
    @objc dynamic var postion:String = ""
    @objc dynamic var content:String = ""
    @objc dynamic var typ:String = ""
//    /// 0通过 1整改
    @objc dynamic var index:Int = 0
    @objc dynamic var people:String = ""
    @objc dynamic var time:String = ""

    func mutableCopy(with zone: NSZone? = nil) -> Any {
        let theCopyObj = type(of: self).init()
        theCopyObj.id = self.id
        theCopyObj.postion = self.postion
        theCopyObj.content = self.content
        theCopyObj.typ = self.typ
        theCopyObj.index = self.index
        theCopyObj.people = self.people
        theCopyObj.time = self.time
        let array = List<SelectImageModel>()
        for item in self.imageArray {
            let copyItem = item.mutableCopy()
            array.append(copyItem as! SelectImageModel)
        }
        
        theCopyObj.imageArray = array
        return theCopyObj
    }
    
    
    //重写 Object.primaryKey() 可以设置模型的主键。
    //声明主键之后，对象将被允许查询，更新速度更加高效，并且要求每个对象保持唯一性。
    //一旦带有主键的对象被添加到 Realm 之后，该对象的主键将不可修改。
    override static func primaryKey() -> String? {
        return "id"
    }
    
    //重写 Object.ignoredProperties() 存储时可以忽略某个属性,数组内用字符串表示属性
    override static func ignoredProperties() -> [String] {
        return []
    }
    
    //重写 Object.indexedProperties() 方法可以为数据模型中需要添加索引的属性建立索引，Realm 支持为字符串、整型、布尔值以及 Date 属性建立索引。,数组内用字符串表示属性
    override static func indexedProperties() -> [String] {
        return []
    }
}
