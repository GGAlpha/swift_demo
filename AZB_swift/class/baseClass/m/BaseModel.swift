//
//  BaseModel.swift
//  AZB_swift
//
//  Created by limbo on 2020/4/1.
//  Copyright © 2020 limbo. All rights reserved.
//

import Foundation

@objcMembers
class BaseModel: NSObject {
    
    var ID:String?
    
    override func setValue(_ value: Any?, forKey key: String) {
        super.setValue(value, forKey: key)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        return
    }
}
