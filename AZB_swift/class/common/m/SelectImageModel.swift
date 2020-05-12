//
//  SelectImageModel.swift
//  AZB_swift
//
//  Created by limbo on 2020/4/9.
//  Copyright © 2020 limbo. All rights reserved.
//

import Foundation
import RealmSwift

class SelectImageModel: Object,NSMutableCopying{
    @objc dynamic var urlStr:String?
    @objc dynamic var imageData:NSData?
//    let owners = LinkingObjects(fromType: SelectImageModel.self, property: "imageArray")
    
    func mutableCopy(with zone: NSZone? = nil) -> Any {
        let theCopyObj = type(of: self).init()
        theCopyObj.urlStr = self.urlStr
        theCopyObj.imageData = self.imageData
        return theCopyObj
    }
}
