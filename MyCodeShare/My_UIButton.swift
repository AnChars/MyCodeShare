//
//  My_UIButton.swift
//  MyCodeShare
//
//  Created by AnChar on 16/10/11.
//  Copyright © 2016年 AnChar. All rights reserved.
//

import UIKit
import SnapKit
import JKCategories
extension UIButton{
    class func configButton(title:String,colorNormal:UIColor?,colorHighlighted:UIColor?,colorDisabled:UIColor?,target:UIViewController,supView:UIView?,height:CGFloat,UIControlJKActionBlock:((AnyObject!)->Void)?)->UIButton{
        let button = UIButton.configButton(title, colorNormal: colorNormal, colorHighlighted: colorHighlighted, colorDisabled: colorDisabled, UIControlJKActionBlock: UIControlJKActionBlock)
        target.view.addSubview(button)
        button.snp_makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.height.equalTo(48)
            if supView == nil {
                make.bottom.equalTo(height)
            }else{
                make.top.equalTo(supView!.snp_bottom).offset(height)
            }
        }
        return button
    }
    class func configButton(title:String,colorNormal:UIColor?,colorHighlighted:UIColor?,colorDisabled:UIColor?,UIControlJKActionBlock:((AnyObject!)->Void)?)->UIButton{
        let button = UIButton(type: .Custom)
        button.setTitle(title, forState: .Normal)
        button.setTitleColor(UIColor.blueColor(), forState: .Normal)
        button.titleLabel?.font=UIFont.systemFontOfSize(15)
        if colorNormal != nil {
            button.jk_setBackgroundColor(colorNormal, forState: .Normal)
        }
        if colorHighlighted != nil {
            button.jk_setBackgroundColor(colorHighlighted, forState: .Highlighted)
        }
        if colorDisabled != nil {
            button.jk_setBackgroundColor(colorDisabled, forState: .Disabled)
        }
        if UIControlJKActionBlock != nil{
            button.jk_handleControlEvents(.TouchUpInside, withBlock: UIControlJKActionBlock!)
        }
        return button
    }
    
}
