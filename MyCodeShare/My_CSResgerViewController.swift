//
//  My_CSResgerViewController.swift
//  MyCodeShare
//
//  Created by AnChar on 16/10/11.
//  Copyright © 2016年 AnChar. All rights reserved.
//

import UIKit
import Alamofire
class My_CSResgerViewController: UIViewController {

    private var userName:UITextField?
    private var passWord:UITextField?
    private var codeText:UITextField?
    private var regButton:UIButton?
    private var button:UIButton?
    private lazy var int = 60
    private var time : NSTimer?
    private var isSele = false
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.title="注册"
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.configTextField()
        self.configButton()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configTextField(){
        self.userName = UITextField.configTextFiled(self, placeholderString: "请输入手机号或邮箱", isSecure: false, supView: nil, height: 100, leftImage: "用户图标")
        self.passWord = UITextField.configTextFiled(self, placeholderString: "请输入密码", isSecure: true, supView: userName, height: 10, leftImage: "密码图标")
        self.codeText = UITextField.configTextFiled(self, placeholderString: "输入验证码", isSecure: false, supView: passWord, height: 10, leftImage: "验证信息图标")
    }
    
    func loop(){
        if self.isSele == true{
            self.int -= 1
            self.button!.setTitle("\(self.int)s后重新发送", forState: .Normal)
            if self.int <= 0{
                self.isSele = false
                self.button?.enabled = true
                self.int = 60
                self.button!.setTitle("获取验证码", forState: .Normal)
            }
        }
    }
    
    func configButton(){
        self.time = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(self.loop), userInfo: nil, repeats: true)
        self.button = UIButton.configButton("获取验证码", colorNormal: UIColor.whiteColor(), colorHighlighted: UIColor.greenColor(), colorDisabled: UIColor.greenColor(), UIControlJKActionBlock: {
            [weak self]
            (button) in
            if self != nil {
                self!.isSele = true
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
        self.codeText?.rightView = subView
        self.codeText?.rightViewMode = .Always
        self.regButton = UIButton.configButton("注册", colorNormal: UIColor.greenColor(), colorHighlighted: UIColor.darkGrayColor(), colorDisabled: UIColor.whiteColor(), target: self, supView: self.codeText, height: 50, UIControlJKActionBlock: {
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
                            print(response.result.value!)
                            self!.navigationController?.popViewControllerAnimated(true)
                        }else{
                            print("网络不通畅")
                        }
                    })
            }
        })
        
    }
}
