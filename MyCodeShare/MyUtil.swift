//
//  MyUtil.swift
//  1604_LimitFree
//
//  Created by gaokunpeng on 16/9/26.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

class MyUtil: NSObject {
    
    /**
     弹出视图 无闭包
     */
    class func showAlertMsg(msg: String, onViewController vc: UIViewController) {
        
        let alertCtrl = UIAlertController(title: "温馨提示", message: msg, preferredStyle: .Alert)
        
        let action = UIAlertAction(title: "确定", style: .Default, handler: nil)
        alertCtrl.addAction(action)
        dispatch_async(dispatch_get_main_queue()) {
            vc.presentViewController(alertCtrl, animated: true, completion: nil)
        }
        
    }
    /**
     弹出视图
     
     - parameter msg: self
     - parameter vc:  父视图
     - parameter bb:  确定的闭包
     - parameter aa:  取消的闭包
     */
    class func showAlertMsg1(msg: String, onViewController vc: UIViewController,bb:(()->Void),aa:(()->Void)) {
        
        let alertCtrl = UIAlertController(title: "温馨提示", message: msg, preferredStyle: .Alert)
        
        let action = UIAlertAction(title: "确定", style: .Default) {
            (action) in
            bb()
        }
        alertCtrl.addAction(action)
        
        let action1 = UIAlertAction(title: "取消", style: .Default){
            (action) in
            aa()
        }
        alertCtrl.addAction(action1)
        dispatch_async(dispatch_get_main_queue()) {
            vc.presentViewController(alertCtrl, animated: true, completion: nil)
        }
        
    }
}
