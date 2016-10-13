//
//  My_UIViewController.swift
//  MyCodeShare
//
//  Created by AnChar on 16/10/13.
//  Copyright © 2016年 AnChar. All rights reserved.
//

import UIKit

extension UIViewController{
    var statusBarHeight: CGFloat{
        return UIApplication.sharedApplication().statusBarFrame.size.height
    }
    
    var naviBarHeight: CGFloat{
        return (self.navigationController?.navigationBar.frame.size.height)!
    }
    
    var tabBarHeight: CGFloat{
        if self.hidesBottomBarWhenPushed == true{
            return (self.tabBarController?.tabBar.frame.size.height)!
        }else{
            return 0
        }
    }
    
    var topBarheight: CGFloat{
        return statusBarHeight + naviBarHeight
    }
}




