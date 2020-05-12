//
//  myVC.swift
//  AZB_swift
//
//  Created by limbo on 2020/4/1.
//  Copyright © 2020 limbo. All rights reserved.
//

import Foundation
import UIKit

class myVC: BaseVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        let logOutBtn = UIButton.init()
        logOutBtn.setTitle("退出登录", for: .normal)
        logOutBtn.setTitleColor(.white, for: .normal)
        logOutBtn.backgroundColor = kCommonBlue
        logOutBtn.addTarget(self, action: #selector(pressLogout), for: .touchUpInside)
        self.view.addSubview(logOutBtn)
        logOutBtn.snp.makeConstraints { (make) in
            make.bottom.equalTo(-100)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(50)
        }
    }
    
    @objc func pressLogout() {
        let userName = Defaults[\.app_userName]
        Defaults.removeAll()
        Defaults[\.app_userName] = userName
        kCommonWindow.rootViewController = LoginVC.init()
    }
}
