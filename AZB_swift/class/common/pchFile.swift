//
//  pchFile.swift
//  AZB_swift
//
//  Created by limbo on 2020/3/25.
//  Copyright © 2020 limbo. All rights reserved.
//

import Foundation
import UIKit

@_exported import SnapKit
@_exported import SwiftyJSON
@_exported import SwiftyUserDefaults
@_exported import Kingfisher
@_exported import OpalImagePicker
@_exported import RealmSwift
@_exported import ReactiveCocoa
@_exported import ReactiveSwift
@_exported import Koloda
@_exported import AnimatedCollectionViewLayout
@_exported import CollectionViewSlantedLayout

//MARK: - 尺寸相关
let kCommonScreenWidth:CGFloat    = UIScreen.main.bounds.width
let kCommonScreenHeight:CGFloat   = UIScreen.main.bounds.height
let kCommonWindow:UIWindow = (UIApplication.shared.delegate?.window!)!
func kCommonIsFringe()-> Bool {
    if #available(iOS 11.0, *) {
        if kCommonWindow.safeAreaInsets.top>20{
            return true
        }
    } else {
        // Fallback on earlier versions
    }
    return false
}
func kCommonNavAndStatus()->CGFloat{
    return kCommonIsFringe()==true ? 88 : 64
}
func kCommonTabAndStatus()->CGFloat{
    return kCommonIsFringe()==true ? 83 : 49
}
func kcommonGetXaddW(view:UIView)->CGFloat{
    return CGFloat(view.frame.origin.x + view.frame.size.width)
}

func kcommonGetYaddH(view:UIView)->CGFloat{
    return CGFloat(view.frame.origin.y + view.frame.size.height)
}


//MARK: - 颜色相关
func kCommonRGB(redFlot:Float,greenFloat:Float,blueFloat:Float) -> UIColor {
    return UIColor.init(_colorLiteralRed: redFlot/255.0, green: greenFloat/255.0, blue: blueFloat/255.0, alpha: 1.0)
}
func kCommonRandomRGB() -> UIColor {
    return UIColor.init(red: CGFloat(arc4random()%256)/255.0, green: CGFloat(arc4random()%256)/255.0, blue: CGFloat(arc4random()%256)/255.0, alpha: 1)
}
let kCommonBlue = kCommonRGB(redFlot: 15, greenFloat: 139, blueFloat: 235)
let kCommonLigthGray = kCommonRGB(redFlot: 237, greenFloat: 237, blueFloat: 237)

func dPrint(item: () -> Any) {
    #if DEBUG
    print(item())
    #endif
}
