//
//  My_CSLoginViewController.swift
//  MyCodeShare
//
//  Created by AnChar on 16/10/11.
//  Copyright © 2016年 AnChar. All rights reserved.
//

import UIKit
import Alamofire
class My_CSLoginViewController: ViewController {

    private var userName:UITextField?
    private var passWord:UITextField?
    
    private var loginButton:UIButton?
    private var button:UIButton?
    var comBolk:((name: String, pass: String)->Void)?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title="登录"
        self.view.backgroundColor=UIColor.whiteColor()
        self.configTextField()
        self.configButton()
        self.configNavButton()
        self.userName?.text = "13519182823"
        self.passWord?.text = "475869"
    }
    override func viewDidAppear(animated: Bool) {
        self.viewWillAppear(animated)
    }
    func configNavButton(){
        let regButton = UIButton.configButton("注册", colorNormal: nil, colorHighlighted: nil, colorDisabled: nil, UIControlJKActionBlock: { (button) in
            self.navigationController?.pushViewController(My_CSResgerViewController(), animated: true)
        })
        regButton.frame = CGRectMake(0, 0, 50, 40)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: regButton)
//        let back = UIButton(type: .Custom)
//        back.frame=CGRectMake(0, 0, 22, 44)
//        back.setImage(UIImage(named: "返回按钮"), forState: .Normal)
//        back.jk_handleControlEvents(.TouchUpInside) { (back) in
//            self.navigationController?.popViewControllerAnimated(true)
//        }
//        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: back)
    }

    func configTextField(){
        self.userName = UITextField.configTextFiled(self, placeholderString: "请输入手机号或邮箱", isSecure: false, supView: nil, height: 100, leftImage: "用户图标")
        self.passWord = UITextField.configTextFiled(self, placeholderString: "请输入密码", isSecure: true, supView: userName, height: 10, leftImage: "密码图标")
    }
    
    func configButton(){
        self.button = UIButton.configButton("忘记密码？", colorNormal: UIColor.whiteColor(), colorHighlighted: UIColor.whiteColor(), colorDisabled: UIColor.greenColor(), UIControlJKActionBlock: { (button) in
            print("忘记密码")
        })
        self.button?.setTitleColor(UIColor.darkGrayColor(), forState: .Disabled)
        self.view.addSubview(self.button!)
        self.button?.snp_makeConstraints(closure: { (make) in
            make.top.equalTo(passWord!.snp_bottom).offset(50)
            make.right.equalTo(-10)
            make.height.equalTo(40)
            make.width.equalTo(100)
        })
        
        self.loginButton = UIButton.configButton("登录", colorNormal: UIColor.randomColor(), colorHighlighted: UIColor.darkGrayColor(), colorDisabled: UIColor.whiteColor(), target: self, supView: nil, height: 0, UIControlJKActionBlock: {
                [weak self]
                (button) in
            My_CSNetHelp.request(parameters: [
                "service":"User.Login",
                "phone":self!.userName!.text!,
                "password":(self!.passWord!.text! as NSString).jk_md5String,
                ]).responseJSON({
                    [weak self]
                    (data, success) in
                    if self != nil{
                        if success {
                            /**
                             *  配置 用户数据
                             */
                            My_CSUsersModel.login(With: data as! [String: AnyObject])
                            self?.dismissViewControllerAnimated(true, completion: nil)
                        }else{
                            MyUtil.showAlertMsg(data as! String, onViewController: self!)
                        }
                    }
                })
        })
        NSNotificationCenter.defaultCenter().rac_addObserverForName(UIKeyboardWillChangeFrameNotification, object: nil)
            .subscribeNext { (ntoi) in
                let userInfo = (ntoi as! NSNotification).userInfo![UIKeyboardFrameEndUserInfoKey]
                let rect = userInfo as! NSValue
                
                self.loginButton!.snp_updateConstraints(closure: { (make) in
                    make.height.equalTo(48)
                    let y = UIScreen.mainScreen().bounds.height - rect.CGRectValue().origin.y
                    make.bottom.equalTo(-y)
                })
                UIView.animateWithDuration(0.25, animations: {
                    self.loginButton!.layoutIfNeeded()
                })
        }
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}



