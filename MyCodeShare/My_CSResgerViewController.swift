//
//  My_CSResgerViewController.swift
//  MyCodeShare
//
//  Created by AnChar on 16/10/11.
//  Copyright © 2016年 AnChar. All rights reserved.
//

import UIKit
import Alamofire
import ReactiveCocoa
import JKCategories
class My_CSResgerViewController: UIViewController {

    private var userName:UITextField?
    private var passWord:UITextField?
    private var codeText:UITextField?
    private var regButton:UIButton?
    private var button:UIButton?
    private lazy var int = 60
    private var time : NSTimer?
    private dynamic var isSele = -1
    private var timer : NSTimer!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.title="注册"
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.configTextField()
        self.configButton()
        self.configAction()
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /**
     设置信号监听方法
     */
    func configAction(){
        self.button?.jk_handleControlEvents(.TouchUpInside, withBlock: {(sender) in
            /**
             发短信
             - parameter phoneNumber:      手机号
             - parameter zone:             中国区号
             - parameter customIdentifier: nil
             */
            self.isSele = 60
            self.timer = NSTimer.jk_scheduledTimerWithTimeInterval(1, block: { 
                self.isSele -=  1
                }, repeats: true)as! NSTimer
            SMSSDK.getVerificationCodeByMethod(SMSGetCodeMethod.init(0), phoneNumber: self.userName!.text, zone: "86", customIdentifier: nil) { (error) in
                if error != nil {
                    MyUtil.showAlertMsg("\(error.userInfo["getVerificationCode"]!)", onViewController: self)
                    self.isSele = -1
                }else{
                    MyUtil.showAlertMsg("短信已发送", onViewController: self)
                }
            }
        })
        self.rac_valuesForKeyPath("isSele", observer: self)
        .subscribeNext { (sender) in
            if self.isSele > -1{
                self.button?.setTitle("\(self.isSele)s后重新发送", forState: .Normal)
                self.button?.enabled = false
            }else{
                self.button?.setTitle("获取验证码", forState: .Normal)
                self.button?.enabled = true
            }
        }
        self.userName?.rac_textSignal().subscribeNext({ (sender) in
            self.button?.enabled = ((self.userName?.text)! as NSString).length == 11 && self.isSele == -1
        })
        /**
         *  登录键的ractise方法
         */
        self.userName?.rac_textSignal()
        .combineLatestWith(self.passWord?.rac_textSignal())
        .combineLatestWith(self.codeText!.rac_textSignal())
        .subscribeNext({ (sender) in
            self.regButton?.enabled = ((self.userName?.text)! as NSString).length == 11 && ((self.passWord?.text)! as NSString).length >= 6 && ((self.codeText?.text)! as NSString).length == 4
        })
        
        NSNotificationCenter.defaultCenter().rac_addObserverForName(UIKeyboardWillChangeFrameNotification, object: nil)
            .subscribeNext { (ntoi) in
                let userInfo = (ntoi as! NSNotification).userInfo![UIKeyboardFrameEndUserInfoKey]
                let rect = userInfo as! NSValue
                
                self.regButton!.snp_updateConstraints(closure: { (make) in
                    make.height.equalTo(48)
                    let y = UIScreen.mainScreen().bounds.height - rect.CGRectValue().origin.y
                    make.bottom.equalTo(-y)
                })
                UIView.animateWithDuration(0.25, animations: {
                    self.regButton!.layoutIfNeeded()
                })
        }

    }
    func configTextField(){
        self.userName = UITextField.configTextFiled(self, placeholderString: "请输入手机号或邮箱", isSecure: false, supView: nil, height: 100, leftImage: "用户图标")
        self.passWord = UITextField.configTextFiled(self, placeholderString: "请输入密码", isSecure: true, supView: userName, height: 10, leftImage: "密码图标")
        self.codeText = UITextField.configTextFiled(self, placeholderString: "输入验证码", isSecure: false, supView: passWord, height: 10, leftImage: "验证信息图标")
    }
    
    
    func configButton(){
        self.button = UIButton.configButton("获取验证码", colorNormal: UIColor.whiteColor(), colorHighlighted: UIColor.greenColor(), colorDisabled: UIColor.darkGrayColor(), UIControlJKActionBlock: {
            [weak self]
            (button) in
            if self != nil {
                self!.button!.enabled = false
                self!.button?.setTitle("\(self!.int)s后重新发送", forState: .Normal)
                
            }
        })
        button?.setTitleColor(UIColor.blackColor(), forState: .Disabled)
        button?.layer.borderWidth=1
        button?.layer.borderColor=UIColor.lightGrayColor().CGColor
        button?.layer.masksToBounds = true
        button?.layer.cornerRadius = 3.0
        let subView = UIView()
        subView.frame.size = CGSizeMake(130, 30)
        subView.addSubview(self.button!)
        self.button?.frame = CGRectMake(5, 0, 120, 30)
        self.button?.enabled = false
        self.codeText?.rightView = subView
        self.codeText?.rightViewMode = .Always
        self.regButton = UIButton.configButton("注册", colorNormal: UIColor.greenColor(), colorHighlighted: UIColor.whiteColor(), colorDisabled: UIColor.darkGrayColor(), target: self, supView: nil, height: 0, UIControlJKActionBlock: {
            [weak self]
            (button) in
            if self != nil {
                Alamofire.request(.POST, "https://www.1000phone.tk", parameters: [
                    "service":"User.Register",
                    "phone":self!.userName!.text!,
                    "password":self!.passWord!.text!,
                    "verificationCode":self!.codeText!.text!,
                    ], encoding: ParameterEncoding.URLEncodedInURL, headers: nil).responseJSON(completionHandler: {
                        (response) in
                        if response.result.isSuccess{
                            dispatch_async(dispatch_get_main_queue(), { 
                                MyUtil.showAlertMsg1("注册成功!是否返回登录界面?", onViewController: self!, bb: { 
                                    self!.navigationController?.popViewControllerAnimated(true)
                                    }, aa: {
                                })
                            })
                        }else{
                            dispatch_async(dispatch_get_main_queue(), { 
                                MyUtil.showAlertMsg("网络不给力", onViewController: self!)
                            })
                        }
                    })
            }
        })
        self.regButton?.enabled = false
    }
}
