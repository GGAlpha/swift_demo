//
//  CommonTool.swift
//  AZB_swift
//
//  Created by limbo on 2020/3/30.
//  Copyright © 2020 limbo. All rights reserved.
//

import Foundation
import CommonCrypto



class CommonTool: NSObject {
     class func base64Encoding(plainString:String)->String{
        let plainData = plainString.data(using:String.Encoding.utf8)
        let base64String = plainData?.base64EncodedString(options:NSData.Base64EncodingOptions.init(rawValue:0))
        return base64String!
     }

     class func base64Decoding(encodedString:String)->String{
        let decodedData=NSData(base64Encoded:encodedString,options:NSData.Base64DecodingOptions.init(rawValue:0))

        let decodedString=NSString(data:decodedData!as Data,encoding:String.Encoding.utf8.rawValue)!as String
        return decodedString
    }
    
    
    class func getJSONStringFromArray(array:Array<Dictionary<String, Any>>) -> String {
         
        if (!JSONSerialization.isValidJSONObject(array)) {
            print("无法解析出JSONString")
            return ""
        }
         
        let data : NSData! = try? JSONSerialization.data(withJSONObject: array, options: []) as NSData?
        let JSONString = NSString(data:data as Data,encoding: String.Encoding.utf8.rawValue)
        return JSONString! as String
    }
    
    class func getJSONStringFromDictionary(dictionary:Dictionary<String, Any>) -> String {
       if (!JSONSerialization.isValidJSONObject(dictionary)) {
           print("无法解析出JSONString")
           return ""
       }
        let data : NSData! = try? JSONSerialization.data(withJSONObject: dictionary, options: []) as NSData?
       let JSONString = NSString(data:data as Data,encoding: String.Encoding.utf8.rawValue)
       return JSONString! as String
    }
}
