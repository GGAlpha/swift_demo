//
//  workMenuModel.swift
//  AZB_swift
//
//  Created by limbo on 2020/4/1.
//  Copyright © 2020 limbo. All rights reserved.
//

import Foundation

enum MenuState:NSInteger{
    case MenuState_canAdd = 0
    case MenuState_canReduce
    case MenuState_repeat
}

class workMenuModel: BaseModel {
    var id:String?
    var name:String?
    var code:String?
    var editState:Bool = false
    var state:MenuState?
    var unreadCount:String?
}
