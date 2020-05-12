//
//  LoginVC.swift
//  AZB_swift
//
//  Created by limbo on 2020/3/26.
//  Copyright © 2020 limbo. All rights reserved.
//

import Foundation
import UIKit

class LoginVC: BaseVC {
   
    var usernameField:UITextField?
    var pwdField:UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addSubviews()
    }
    
    func addSubviews() {
        let ImageBG = UIImageView.init(frame: self.view.frame)
        ImageBG.image = UIImage.init(named: "login_BG")
        self.view.addSubview(ImageBG)
        
        let titleBG = UIImageView.init(image: UIImage.init(named: "login_title"))
        titleBG.center = CGPoint.init(x: kCommonScreenWidth/2, y: 120)
        self.view.addSubview(titleBG)
        titleBG.snp.makeConstraints { (make) in
            make.top.equalTo(60)
            make.centerX.equalTo(kCommonScreenWidth/2)
        }
        
        let imageArray = ["login_username","login_pwd","login_code"]
        let placeholderArray = ["请输入用户名","请输入密码","请输入客户编码(非必填)"]
        
        var codeLine:UIView?
        for i in 0...2 {
            let field = UITextField.init()
            field.keyboardType = .emailAddress
            if(i==0){
                usernameField = field
                let username = Defaults[\.app_userName]
                if(username != nil){
                    field.text = username
                }
            }else if(i==1){
                pwdField = field
            }
            field.leftViewMode = .always
            field.textColor = .white
            field.attributedPlaceholder = NSAttributedString.init(string: placeholderArray[i], attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize:15),NSAttributedString.Key.foregroundColor:UIColor.white])
            let leftView = UIImageView.init(image: UIImage.init(named: imageArray[i]))
            leftView.contentMode = .center
            field.leftView = leftView
            self.view.addSubview(field)
            field.snp.makeConstraints { (make) in
                make.top.equalTo(titleBG.snp_bottom).offset(40+i*60)
                make.left.equalTo(40)
                make.right.equalTo(-40)
            }
            
            let line = UIView.init()
            if(i == 2){
                codeLine = line
            }
            line.backgroundColor = .white
            self.view.addSubview(line)
            line.snp.makeConstraints { (make) in
                make.top.equalTo(field.snp_bottom).offset(15)
                make.height.equalTo(0.5)
                make.left.equalTo(40)
                make.right.equalTo(-40)
            }
        }
        
        let loginBtn = UIButton.init(type: .custom)
        loginBtn.addTarget(self, action: #selector(pressLogin), for: .touchUpInside)
        loginBtn.backgroundColor = .white
        loginBtn.setTitle("登录", for: .normal)
        loginBtn.setTitleColor(kCommonBlue, for: .normal)
        loginBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        loginBtn.layer.cornerRadius = 3
        loginBtn.layer.masksToBounds = true
        self.view.addSubview(loginBtn)
        loginBtn.snp.makeConstraints { (make) in
            make.top.equalTo(codeLine!.snp_bottom).offset(30)
            make.left.equalTo(40)
            make.right.equalTo(-40)
            make.height.equalTo(40)
        }
    }
    
    @objc func pressLogin() {
        if(usernameField?.text?.count==0){
            SVProgressHUD.showError(withStatus: "请输入用户名")
            SVProgressHUD.dismiss(withDelay: 2)
            return;
        }
        if(pwdField?.text?.count == 0){
            SVProgressHUD.showError(withStatus: "请输入密码")
            SVProgressHUD.dismiss(withDelay: 2)
            return;
        }
        
        let dic:[String:String] = ["userName":usernameField!.text!,"password":"LrNXTlXRUj+B0SrK7esOHg==","code":"LOGIN_AZB_APP","dataSource":"IOS"]

        SVProgressHUD.show(withStatus: "登录中")
        //登录
        NetworkTool.shareNetwork.POST(urlStr: "api/business/v1/login/appAes201907", parameDict: dic, success: { (respon) in
            
            let resDict = respon?["data"] as! Dictionary<String,Any>

            Defaults[\.app_userName] = resDict["userName"] as? String
            Defaults[\.app_password] = "LrNXTlXRUj+B0SrK7esOHg=="
            Defaults[\.app_token] = resDict["token"] as? String
            Defaults[\.app_userOrgToken] = resDict["userOrgToken"] as? String
            Defaults[\.app_userUuid] = resDict["uuid"] as? String
            Defaults[\.app_userId] = resDict["userId"] as? String
            Defaults[\.app_userOrgId] = resDict["userOrgId"] as? String
            Defaults[\.app_userOrgUuid] = resDict["userOrgUuid"] as? String

            self.getProjectInfo()
        }) { (error) in}
    }
    
    //获取项目信息
    func getProjectInfo() {
        
        NetworkTool.shareNetwork.GET(urlStr: "api/business/v1/tree/getStandardProject", parameDict: [:], success: { (respon) in
            let json = JSON(respon)
            Defaults[\.app_projectId] = json["data"][0]["id"].string
            Defaults[\.app_projectUuid] = json["data"][0]["uuid"].string
                        
            self.getMenu()
        }) { (error) in}
    }
    
    //获取主菜单
    func getMenu(){
        NetworkTool.shareNetwork.GET(urlStr: "api/business/v1/roles/getMenuForApp", parameDict: [:], success: { (respon) in
            let menuDict = [menuDictKey:respon?["data"]]
            Defaults[\.app_menuDict] = menuDict as [String : Any]
            self.getHomeMenu()
        }) { (error) in}
    }
    
    //获取首页自定义菜单
    func getHomeMenu() {
      NetworkTool.shareNetwork.GET(urlStr:"api/business/v1/roles/getMenuAppForRecord", parameDict: [:], success: { (respon) in
            let homeMenuDict = [homeMenuDictKey:respon?["data"]]
            Defaults[\.app_homeCustomMenuDict] = homeMenuDict as [String : Any]
            
            SVProgressHUD.dismiss()
            kCommonWindow.rootViewController = BaseTabVC.init()
            
        }) { (error) in}
    }
}
