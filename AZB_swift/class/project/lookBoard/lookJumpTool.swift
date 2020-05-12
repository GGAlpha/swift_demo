//
//  lookJumpTool.swift
//  AZB_swift
//
//  Created by limbo on 2020/5/8.
//  Copyright © 2020 limbo. All rights reserved.
//

import Foundation

struct lookJumpTool {
    
    static func getArray()->Array<String> {
        return ["泛型","ReactiveSwift","runtime","MDCSwipeToChoose卡片","KolodaCards卡片","collectionview","collectStandLayout","WaterfallLayout","DBSphereTagCloudBall"]
    }
    
    static func jumpWith(text:String,navigationController:BaseNavigationVC) {
        var vc:BaseVC?
        switch text {
        case "泛型":
            vc = genericVC.init()
            break
        case "ReactiveSwift":
            vc = ReactiveSwiftVC.init()
            break
        case "runtime":
            vc = runtimeVC.init()
            break
        case "MDCSwipeToChoose卡片":
            vc = MDCSwipeToChoose.init()
            break
        case "KolodaCards卡片":
            vc = KolodaCards.init()
            break
        case "collectionview":
            vc = collectionCardTable.init()
            break
            
        case "collectStandLayout":
            vc = collectStandLayout.init()
            break
        case "WaterfallLayout":
            vc = WaterfallLayoutVC.init()
            break
        case "DBSphereTagCloudBall":
            vc = DBSphereTagCloudVC.init()
            break
        default:
            return
        }
        if vc != nil {
            navigationController.pushViewController(vc!, animated: true)
        }
        
    }
}
