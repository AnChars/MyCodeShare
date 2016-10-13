//
//  My_CSNetHelp.swift
//  MyCodeShare
//
//  Created by AnChar on 16/10/13.
//  Copyright © 2016年 AnChar. All rights reserved.
//

import UIKit
import Alamofire
class My_CSNetHelp: NSObject {
    /**
     在Alamofire基础上封装、一个函数
     
     - parameter method:     默认
     - parameter URLString:  默认
     - parameter parameters: 字典
     - parameter headers:    nil
     
     - returns: 返回值
     */
    class func request(
        method: Alamofire.Method = .POST,
        URLString: String = QFAppBaseURL,
        parameters: [String: AnyObject],
        headers: [String: String]? = nil
        ) -> Alamofire.Request {
        return Alamofire.request(method, URLString, parameters: parameters, encoding: ParameterEncoding.URLEncodedInURL, headers: headers)
    }
    
}
extension Request{
    func responseJSON(
        comletionHandler: ((data: AnyObject, success: Bool)->Void)
        )->Self{
        return responseJSON(completionHandler: { (response) in
            let result = response.result
            /// 两个返回值
            var success = false
            var data: AnyObject = "网络不给力，请重试"
            /**
             *  判断Http请求有无成功
             */
            if result.isSuccess == true{
                let serverData = result.value as! NSDictionary
                /**
                 *  取出服务器的返回码
                 */
                let serverRet = serverData["ret"] as! NSNumber
                if serverRet != 200{//请求出现问题
                    data = serverData["msg"] as! String
                }else{
                    let retValue = serverData["data"]as! NSDictionary
                    /**
                     *  取出操作返回码
                     */
                    let retCode = retValue["code"]as! NSNumber
                    if retCode == 0{//操作成功
                        success = true
                        data = retValue["data"]!
                    }else{
                        data = retValue["msg"]as! NSString
                    }
                }
            }else{
                data = (result.error?.localizedDescription)!
            }
            /**
             *  回调传入的闭包
             *  如果成功就返回数据
             *  如果失败就返回失败的原因
             */
            comletionHandler(data: data,success: success)
        })
    }
}


