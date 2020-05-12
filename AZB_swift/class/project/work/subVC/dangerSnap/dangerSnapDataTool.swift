//
//  dangerSnapDataTool.swift
//  AZB_swift
//
//  Created by limbo on 2020/4/9.
//  Copyright © 2020 limbo. All rights reserved.
//

import Foundation
//查询的model重新使用时可能会直接引用数据库中对应的model，因此获取以后采用了深拷贝
class dangerSnapDataTool: Object {
    private class func getDB() -> Realm {
        let docPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0] as String
        let dbPath = docPath.appending("/defaultDB.realm")
        /// 传入路径会自动创建数据库
        let defaultRealm = try! Realm(fileURL: URL.init(string: dbPath)!)
        return defaultRealm
    }
}

extension dangerSnapDataTool {
   
    public class func insertDanger(by model : dangerSnapModel) -> Void {
        let defaultRealm = self.getDB()
        try! defaultRealm.write {
            defaultRealm.add(model)
        }
        print(defaultRealm.configuration.fileURL ?? "")
    }
    
    public class func getDanger() -> Results<dangerSnapModel> {
        let defaultRealm = self.getDB()
        return defaultRealm.objects(dangerSnapModel.self)
    }
    
    /// 删除单个
    public class func deleteDanger(model : dangerSnapModel) {
        let defaultRealm = self.getDB()
        try! defaultRealm.write {
            defaultRealm.delete(model)
        }
    }
    
    /// 删除多个
    public class func deleteDanger(models : Results<dangerSnapModel>) {
        let defaultRealm = self.getDB()
        try! defaultRealm.write {
            defaultRealm.delete(models)
        }
    }
    
    /// 改
    public class func updateDanger(models : [dangerSnapModel]) {
        let defaultRealm = self.getDB()
        try! defaultRealm.write {
            defaultRealm.add(models)
        }
    }
}
