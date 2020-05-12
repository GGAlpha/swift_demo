//
//  BaseVC.swift
//  AZB_swift
//
//  Created by limbo on 2020/3/26.
//  Copyright © 2020 limbo. All rights reserved.
//

import Foundation
import UIKit

class BaseVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func setRightBarButtonItemTitle(title:String){
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title:title, style: UIBarButtonItem.Style.done, target: self, action: #selector(rightClick))
    self.navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.white,NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18)], for: .normal)
    }
    
    
    @objc func rightClick(){
        
    }
}
