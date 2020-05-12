//
//  workSectionMeunModel.swift
//  AZB_swift
//
//  Created by limbo on 2020/4/5.
//  Copyright © 2020 limbo. All rights reserved.
//

import Foundation

class workSectionMeunModel: BaseModel {
    var id:String?
    var name:String?
    var code:String?
    var children:Array<workMenuModel>?
    
    override func setValue(_ value: Any?, forKey key: String) {
        
        if key == "children" {
            var childArray:Array<workMenuModel> = Array.init()
            let array:Array = value as! Array<Dictionary<String, Any>>
            for item in array {
                let model = workMenuModel.init()
                model.setValuesForKeys(item)
                model.state = MenuState.MenuState_canAdd
                childArray.append(model)
            }
            self.children = childArray
            return
        }
        
        super.setValue(value, forKey: key)
    }
}


