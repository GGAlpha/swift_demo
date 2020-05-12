//
//  NetworkTool.swift
//  AZB_swift
//
//  Created by limbo on 2020/3/27.
//  Copyright © 2020 limbo. All rights reserved.
//

import Foundation
import Alamofire
typealias networkSuccessBlock = (_ responseObject:Parameters?)->()
typealias networkFailBlock = (_ error:NSError?)->()

class NetworkTool: NSObject {
    
    enum NetworkEnvironment {
        case Network_Dev
        case Network_Test
        case Network_Dis
    }
    enum NetworkMethod {
        case GET
        case POST
    }
    var alamofire:SessionManager?
    let currentNetwork:NetworkEnvironment = .Network_Test
    private var base_url:String? = BASE_TEST_IP
    
    static let shareNetwork:NetworkTool = {
        let share = NetworkTool()
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10
        share.alamofire = Alamofire.SessionManager(configuration: configuration)
        return share
    }()
    
    func configHeaders() -> HTTPHeaders {
            
        var headers:HTTPHeaders = ["Content-type":"application/json;charset=utf-8",
                                   "Accept":"application/json","source":"app"]
        let token = Defaults[\.app_token]
        let userOrgToken = Defaults[\.app_userOrgToken]
        if token != nil && userOrgToken != nil{
            headers["token"] = token
            headers["userOrgToken"] = userOrgToken
        }
        return headers
    }
//    func requestBy(type:NetworkMethod,urlStr:String,parameDict:Any,success:@escaping networkSuccessBlock,fali:@escaping networkFailBlock) {
//        let url = base_url! + urlStr
//        switch type {
//        case .GET:
//            break
//        case .POST:
//            break
//
//    }
    
    func POST(urlStr:String,parameDict:Any,success:@escaping networkSuccessBlock,fail:@escaping networkFailBlock){
        let header = self.configHeaders()
        let url = base_url!+urlStr

        self.alamofire?.request(url, method: .post, parameters: parameDict as? Parameters, encoding: JSONEncoding.default, headers: header).validate().responseJSON(completionHandler: { (response) in

            self.Dealwith(responObj: response as? DataResponse, success: { (responObj) in
                success(responObj)
            }) { (error) in
                fail(error)
            }

        })
    }
        
    func GET(urlStr:String,parameDict:Any,success:@escaping networkSuccessBlock,fail:@escaping networkFailBlock){
        let header = self.configHeaders()
        let url = base_url!+urlStr
        self.alamofire?.request(url, method: .get, parameters: parameDict as? Parameters, encoding: URLEncoding.default, headers: header).responseJSON(completionHandler: { (response) in
           
            self.Dealwith(responObj: response as? DataResponse, success: { (responObj) in
                success(responObj)
            }) { (error) in
                fail(error)
            }

        })
    }

    func Dealwith(responObj:DataResponse<Any>?,success:@escaping networkSuccessBlock,fail:@escaping networkFailBlock){

        if ((responObj?.result.isSuccess)!){
            let responDic:Parameters = responObj!.result.value as! Parameters
            if(responDic["code"] as! NSNumber == 200){//普通
                success(responDic as Parameters)
            }else if(responDic["statusCode"] as? NSNumber == 200){//图片
                success(responDic as Parameters)
            }else if(responDic["code"] as! NSNumber == 401){//退出登录
//                kCommonWindow.rootViewController = LoginVC.init()
            }else{//报错
                
                SVProgressHUD.showError(withStatus: responDic["data"] as? String)
                SVProgressHUD.dismiss(withDelay: 2)
                
                let error:NSError = NSError.init(domain: NSURLErrorDomain, code: responDic["code"] as! Int, userInfo: responDic)
                fail(error)
                
                
            }
        }else{
            SVProgressHUD.showError(withStatus: "请检查网络")
            SVProgressHUD.dismiss(withDelay: 2)
            
            let error:NSError = NSError.init(domain: NSURLErrorDomain, code: 404, userInfo:[:])
            fail(error)
        }
  
    }
}
