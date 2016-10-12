//
//  My_UITextField.swift
//  MyCodeShare
//
//  Created by AnChar on 16/10/11.
//  Copyright © 2016年 AnChar. All rights reserved.
//

import UIKit
import SnapKit


extension UITextField{
    class func configTextFiled(target:UIViewController,placeholderString:String,isSecure:Bool,supView:UIView?,height:CGFloat,leftImage:String)->UITextField {
        let textField = UITextField()
        textField.placeholder = placeholderString
        textField.autocapitalizationType = .None
        textField.autocorrectionType = .No
        textField.clearButtonMode = .Always
        textField.borderStyle = .RoundedRect
        textField.font=UIFont.systemFontOfSize(15)
        textField.secureTextEntry = isSecure
        textField.layer.borderColor = UIColor.darkGrayColor().CGColor
        textField.layer.borderWidth = 1.0
        target.view.addSubview(textField)
        textField.snp_makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.height.equalTo(48)
            if supView == nil {
                make.top.equalTo(height)
            }else{
                make.top.equalTo(supView!.snp_bottom).offset(height)
            }
        }
        let leftView = UIView()
        let leftImageView = UIImageView()
        leftImageView.image = UIImage(named: leftImage)
        leftView.addSubview(leftImageView)
        leftView.frame = CGRectMake(0, 0, 64, 48)
        leftImageView.frame.size=CGSizeMake(24, 28)
        leftImageView.center = leftView.center
        textField.leftView = leftView
        textField.leftViewMode = .Always
        return textField
    }
}

