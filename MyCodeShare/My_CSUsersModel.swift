//
//  My_CSUsersModel.swift
//  MyCodeShare
//
//  Created by AnChar on 16/10/13.
//  Copyright © 2016年 AnChar. All rights reserved.
//

import UIKit
import YYModel
class My_CSUsersModel: NSObject {
    /**
     *  用户为单例
     */
    static var ShareUser = My_CSUsersModel()
    
    var address     : String?
    var avatar      : String?
    var birthday    : String?
    var email       : String?
    var gender      : String?
    var id          : String?
    var name        : String?
    var nickname    : String?
    var phone       : String?
    
    class func isLogin()->Bool {
        return ShareUser.id != nil
    }
    
    class func login(With UserInfo: [String: AnyObject]) {
//        ShareUser.setValuesForKeysWithDictionary(UserInfo)
        ShareUser.yy_modelSetWithDictionary(UserInfo)
        NSUserDefaults.standardUserDefaults().setObject(ShareUser.yy_modelToJSONObject(), forKey: "id")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
    private override init() {
        super.init()
        if let userInfo = NSUserDefaults.standardUserDefaults().objectForKey("id"){
            self.yy_modelSetWithJSON(userInfo)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}