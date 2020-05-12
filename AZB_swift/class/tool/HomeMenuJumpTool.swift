//
//  HomeMenuJumpTool.swift
//  AZB_swift
//
//  Created by limbo on 2020/4/7.
//  Copyright © 2020 limbo. All rights reserved.
//

import Foundation

class HomeMenuJumpTool: NSObject {
    class func jumpWithModel(model:workMenuModel) {
        switch model.code {
        case "menu_m_3_221":
            let vc = dangerSnapVC.init()
            let tab:BaseTabVC = kCommonWindow.rootViewController as! BaseTabVC
            let nav = tab.viewControllers![tab.selectedIndex] as! BaseNavigationVC
            nav.pushViewController(vc, animated: true)
        default:
            break
        }
    }
}
