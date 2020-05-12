//
//  BaseNavigationVC.swift
//  AZB_swift
//
//  Created by limbo on 2020/3/26.
//  Copyright © 2020 limbo. All rights reserved.
//

import Foundation
import UIKit

class BaseNavigationVC: UINavigationController,UINavigationControllerDelegate{
    
//    init(){
//        super.init(rootViewController: BaseTabVC.init())
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.setBackgroundImage(UIImage.init(named: "home_topBG"), for: .default)
        self.navigationBar.titleTextAttributes =  [NSAttributedString.Key.foregroundColor:UIColor.white,NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18)]
    self.navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.white,NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18)], for: .normal)

    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if(self.viewControllers.count>0){
            viewController.hidesBottomBarWhenPushed = true
            let leftBtn = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 40, height: 40))
            leftBtn.contentHorizontalAlignment = .left
            leftBtn.setImage(UIImage.init(named: "return_white"), for: .normal)
            leftBtn.addTarget(self, action: #selector(leftClick), for: .touchUpInside)
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: leftBtn)

        }
        super.pushViewController(viewController, animated: animated)
    }
    
    @objc func leftClick() {
        popViewController(animated: true)
    }
    
    func setRightTitle(title:String) {
        
    }
    
}
