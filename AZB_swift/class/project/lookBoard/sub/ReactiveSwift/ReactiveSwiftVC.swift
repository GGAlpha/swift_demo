//
//  ReactiveSwiftVC.swift
//  AZB_swift
//
//  Created by limbo on 2020/5/8.
//  Copyright © 2020 limbo. All rights reserved.
//

import Foundation

class ReactiveSwiftVC: BaseVC {
    override func viewDidLoad() {
            let btn:UIButton = UIButton.init()
            btn.setTitle("0", for: .normal)
            btn.backgroundColor = kCommonBlue
            self.view.addSubview(btn)
            btn.snp.makeConstraints { (make) in
                make.bottom.equalTo(-100)
                make.left.equalTo(15)
                make.right.equalTo(-15)
                make.height.equalTo(50)
            }
            btn.reactive.controlEvents(.touchUpInside).observeValues { (selected) in
                let title = selected.titleLabel?.text
                let i = NSInteger(title!)!+1
                let newTitle = String(i)
                selected.setTitle(newTitle, for: .normal)
            }
            
            NotificationCenter.default.reactive.notifications(forName: Notification.Name(rawValue: "UIKeyboardWillShowNotification"),object: nil).observeValues { (notification) in

                print("键盘弹起")
            }
            
            
    //        let label = UILabel.init()
    //        self.view.addSubview(label)
    //        label.snp.makeConstraints { (make) in
    //            make.top.equalTo(20)
    //            make.left.equalTo(20)
    //            make.right.equalTo(-20)
    //            make.height.equalTo(50)
    //        }
    //
    //        let tf = UITextField.init()
    //        tf.backgroundColor = .gray
    //        self.view.addSubview(tf)
    //        tf.snp.makeConstraints { (make) in
    //            make.top.equalTo(100)
    //            make.left.equalTo(20)
    //            make.right.equalTo(-20)
    //            make.height.equalTo(50)
    //        }
    //        //filter这个函数只允许当它的返回值为true的事件发生
    //        //下边的信号可依次拆开使用，动态获取返回值来实现对textfield内容变化的监听，替代delegate
    //        tf.reactive.continuousTextValues.filter({ (count) -> Bool in
    //            return count.count<=5
    //        }).observeValues { (count) in
    //            label.text = String(count)
    //        }.map({ (text) in
    //            //此处将text映射为text.count，若return text，则下边闭包中的’count‘都应变为text
    //            return text
    //        })
            
            let tfU = UITextField.init()
            tfU.placeholder = "用户名"
            tfU.backgroundColor = .lightGray
            self.view.addSubview(tfU)
            tfU.snp.makeConstraints { (make) in
                make.top.equalTo(100)
                make.left.equalTo(20)
                make.right.equalTo(-20)
                make.height.equalTo(50)
            }
            tfU.reactive.continuousTextValues.observeValues { (text) in
                self.isU = text.count<=5
            }
            let uSign = tfU.reactive.continuousTextValues.map {text in
                return self.isU
            }
            uSign.map { (isU) in
                //用map把bool映射成color
                return isU ? UIColor.lightGray : UIColor.red
            }.observeValues { (color) in
                tfU.backgroundColor = color
            }
            
            let tfP = UITextField.init()
            tfP.placeholder = "密码"
            tfP.backgroundColor = .lightGray
            self.view.addSubview(tfP)
            tfP.snp.makeConstraints { (make) in
                make.top.equalTo(160)
                make.left.equalTo(20)
                make.right.equalTo(-20)
                make.height.equalTo(50)
            }
            tfP.reactive.continuousTextValues.observeValues { (text) in
                self.isP = text.count<=5
            }
            let pSign = tfP.reactive.continuousTextValues.map {text in
                return self.isP
            }
            pSign.map { (isP) in
                return isP ? UIColor.lightGray : UIColor.red
            }.observeValues { (color) in
                tfP.backgroundColor = color
            }
            
            //信号结合
            let clickSign = Signal.combineLatest(uSign, pSign)
            clickSign.map { (isU,isP) in
                print(isU,isP)
                return isU && isP
            }.observeValues { (canCilck) in
                btn.isEnabled = canCilck
            }
        }
        
        var isU:Bool = false
        var isP:Bool = false
}
