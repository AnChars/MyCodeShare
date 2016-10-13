//
//  ViewController.swift
//  MyCodeShare
//
//  Created by AnChar on 16/10/11.
//  Copyright © 2016年 AnChar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets = false
        self.configBackItem()
        self.view.backgroundColor = UIColor.randomColor()
    }
    
    /**
     返回按钮的方法
     */
    func configBackItem(){
        
       if (self.navigationController?.presentingViewController == nil && self.navigationController?.viewControllers.first != self)
        || self.navigationController?.presentingViewController != nil {
            let backButton = UIButton(type: .Custom)
            backButton.setImage(UIImage(named: "返回按钮"), forState: .Normal)
            backButton.jk_handleControlEvents(.TouchUpInside, withBlock: { (sender) in
                if self.navigationController?.popViewControllerAnimated(true) == nil {
                    self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
                }
            })
            backButton.setTitleColor(UIColor.randomColor(), forState: .Normal)
            backButton.frame = CGRectMake(0, 0, 22, 42)
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        }else{
//            self.hidesBottomBarWhenPushed = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        self.view.endEditing(true)
    }
}


