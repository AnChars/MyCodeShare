//
//  My_CSMyTitleView.swift
//  MyCodeShare
//
//  Created by AnChar on 16/10/13.
//  Copyright © 2016年 AnChar. All rights reserved.
//

import UIKit
import SnapKit
class My_CSMyTitleView: UIView {

    
    var name:           String?
    var email:          String?
    var shareIndex:     String = "12"
    var downIndex:      String = "5"
    var fiameIndex:     String = "0"
    var myShareButton:  UIControl?
    var myDownButton:   UIControl?
    var myFiameButton:  UIControl?
    var setButton:      UIControl?
    var nameLable:      UILabel?
    var emailLable:      UILabel?
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func configSubView(
            target: UIViewController,
            myShareButtonActionBlock: ((AnyObject!) -> Void)?,
            myDownButtonActionBlock: ((AnyObject!) -> Void)?,
            myFrimeButtonActionBlock: ((AnyObject!) -> Void)?,
            setButtonActionBlock: ((AnyObject!) -> Void)?
        ){
        ///背景图片
        let bjImageView = UIImageView()
        bjImageView.image = UIImage(named: "背景图片")
        self.addSubview(bjImageView)
        bjImageView.snp_makeConstraints { (make) in
            make.top.left.right.bottom.equalTo(0)
        }
        /// 头像
        let nameImageView = UIImageView()
        nameImageView.image = UIImage(named: "头像")
        self.addSubview(nameImageView)
        nameImageView.snp_makeConstraints { (make) in
            make.top.equalTo(15)
            make.left.equalTo(10)
            make.width.height.equalTo(100)
        }
        self.myShareButton = self.setController(self.shareIndex, nameString: "我的分享", bolk: myShareButtonActionBlock, bottom: 0, left: 0)
        self.myDownButton = self.setController(self.downIndex, nameString: "我的下载", bolk: myDownButtonActionBlock, bottom: 0, left: UIScreen.mainScreen().bounds.width/3.0)
        self.myFiameButton = self.setController(self.fiameIndex, nameString: "我的朋友", bolk: myFrimeButtonActionBlock, bottom: 0, left: 2.0 * UIScreen.mainScreen().bounds.width/3.0)
        self.setButton = self.setController(nil, nameString: "设置", bolk: setButtonActionBlock, bottom: -100, left: UIScreen.mainScreen().bounds.width - 60.0)
        
        self.nameLable = UILabel()
        self.nameLable?.text = self.name
        self.nameLable?.numberOfLines = 2
        self.nameLable?.textColor = UIColor.whiteColor()
        self.addSubview(self.nameLable!)
        self.nameLable?.snp_makeConstraints(closure: { (make) in
            make.top.equalTo(40)
            make.left.equalTo(130)
            make.height.equalTo(20)
            make.width.equalTo(100)
        })
        self.emailLable = UILabel()
        self.emailLable?.text = self.email
        self.emailLable?.numberOfLines = 2
        self.emailLable?.textColor = UIColor.whiteColor()
        self.addSubview(self.emailLable!)
        self.emailLable?.snp_makeConstraints(closure: { (make) in
            make.top.equalTo(65)
            make.left.equalTo(130)
            make.height.equalTo(20)
            make.width.equalTo(200)
        })
    }
    /**
     设置头视图按钮
     
     - parameter index:      文件个数
     - parameter nameString: 分类
     - parameter bolk:       点击执行方法
     */
    func setController(
            index: String?,
            nameString: String,
            bolk: ((AnyObject!) -> Void)?,
            bottom: CGFloat,
            left: CGFloat
        )->UIControl {
        
        var width: CGFloat = 60
        var height: CGFloat = 20
        let supView = UIControl()
        self.addSubview(supView)
        if index != nil {
            height = 40
            width = UIScreen.mainScreen().bounds.width/CGFloat(3)
            let indexLable = UILabel()
            indexLable.text = index
            indexLable.textColor = UIColor.whiteColor()
            indexLable.textAlignment = .Center
            supView.addSubview(indexLable)
            indexLable.snp_makeConstraints(closure: { (make) in
                make.top.equalTo(0)
                make.left.equalTo(0)
                make.height.equalTo(20)
                make.width.equalTo(width)
            })
            supView.backgroundColor = UIColor ( red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 0.1 )
        }
        let classLable = UILabel()
        classLable.text = nameString
        classLable.textColor = UIColor.whiteColor()
        classLable.textAlignment = .Center
        supView.addSubview(classLable)
        classLable.snp_makeConstraints(closure: { (make) in
            make.bottom.equalTo(0)
            make.left.equalTo(0)
            make.height.equalTo(20)
            make.width.equalTo(width)
            
        })
        supView.snp_makeConstraints { (make) in
            make.bottom.equalTo(bottom)
            make.left.equalTo(left)
            make.width.equalTo(width)
            make.height.equalTo(height)
        }
        supView.jk_handleControlEvents(.TouchUpInside, withBlock: bolk)
        
        return supView
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
