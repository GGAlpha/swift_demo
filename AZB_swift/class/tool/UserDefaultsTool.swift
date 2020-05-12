//
//  UserDefaultsTool.swift
//  AZB_swift
//
//  Created by limbo on 2020/3/30.
//  Copyright © 2020 limbo. All rights reserved.
//

import Foundation

let menuDictKey = "menuDictKey"
let homeMenuDictKey = "homeMenuDictKey"

extension DefaultsKeys {
    var app_userName: DefaultsKey<String?> { .init("app_userName") }
    var app_password: DefaultsKey<String?> { .init("app_password") }
    var app_token: DefaultsKey<String?> { .init("app_token") }
    var app_userUuid: DefaultsKey<String?> { .init("app_userUuid") }
    var app_userOrgToken: DefaultsKey<String?> { .init("app_userOrgToken") }
    var app_userOrgId: DefaultsKey<String?> { .init("app_userOrgId") }
    var app_userOrgUuid: DefaultsKey<String?> { .init("app_userOrgUuid") }
    var app_userId: DefaultsKey<String?> { .init("app_userId") }
    var app_projectId: DefaultsKey<String?> { .init("app_projectId") }
    var app_projectUuid: DefaultsKey<String?> { .init("app_projectId") }
    //由于该三方不支持存储装有dictionary的数组，因此该字段添加一个key值直接存[key:array]
    //tab菜单
    var app_menuDict: DefaultsKey<Dictionary<String, Any>?> { .init("app_menuDict") }
    //顶部自定义菜单
    var app_homeCustomMenuDict: DefaultsKey<Dictionary<String, Any>?> { .init("app_homeCustomMenuDict") }
}



