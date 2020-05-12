//
//  BaseTabVC.swift
//  AZB_swift
//
//  Created by limbo on 2020/3/26.
//  Copyright © 2020 limbo. All rights reserved.
//

import Foundation
import ESTabBarController_swift

class BaseTabVC: ESTabBarController,UITabBarControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setChildVC()
        if #available(iOS 13.0, *) {
            self.tabBar.standardAppearance.selectionIndicatorTintColor = kCommonBlue
        } else {
            // Fallback on earlier versions
//            self.tabBar.standardAppearance.color
        }
        self.delegate = self as UITabBarControllerDelegate
    }
    
    func setChildVC() {
        let menuArray:Array = Defaults[\.app_menuDict]?[menuDictKey] as! Array<Any>
        var i = 0
        var childVCArray:Array = Array<Any>.init()
        for item in menuArray{
            let dict = item as! Dictionary<String, Any>
            let code:String = dict["code"] as! String
            let name:String = dict["name"] as! String
            let isShow:Bool = dict["show"] as! Bool
            if isShow == true{
                if code == "menu_m_1_8" ||
                   code == "menu_m_1_1" ||
                   code == "menu_m_1_2" ||
                   code == "menu_m_1_3" ||
                   code == "menu_m_1_4" ||
                   code == "menu_m_1_5"{
                    
                    var vc:UIViewController
                    switch code {
                    case "menu_m_1_8":
                        vc = cockpitVC.init()
                        break
                    case "menu_m_1_1":
                        vc = workHomeVC.init()
                        break
                    case "menu_m_1_2":
                        vc = educationVC.init()
                        break
                    case "menu_m_1_3":
                        vc = monitorVC.init()
                        break
                    case "menu_m_1_4":
                        vc = lookBoardVC.init()
                        break
                    case "menu_m_1_5":
                        vc = myVC.init()
                        break
                    default:
                        vc = UIViewController.init()
                        break
                    }
                    let nav = BaseNavigationVC.init(rootViewController: vc)
                    let image = UIImage.init(named: "tabbar_normal_"+code )?.withRenderingMode(.alwaysOriginal)
                    let selectImage = UIImage.init(named: "tabbar_highlight_"+code)?.withRenderingMode(.alwaysOriginal)
                    vc.tabBarItem = ESTabBarItem.init(ExampleBouncesContentView(), title: name, image: image, selectedImage: selectImage, tag: i)
                    
                    childVCArray.append(nav)
                    i+=1
                }
            }
        }
        self.viewControllers = childVCArray as? [UIViewController]
    }
}
