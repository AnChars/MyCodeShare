//
//  My_CSColorHelp.swift
//  MyCodeShare
//
//  Created by AnChar on 16/10/13.
//  Copyright © 2016年 AnChar. All rights reserved.
//

import UIKit

extension UIColor{
    class func randomColor()-> UIColor {
        let r = CGFloat(Float(arc4random_uniform(128))/250.0 + 0.5)
        let g = CGFloat(Float(arc4random_uniform(128))/250.0 + 0.5)
        let b = CGFloat(Float(arc4random_uniform(128))/250.0 + 0.5)
        
        return UIColor(red: r, green: g, blue: b, alpha: 1.0)
    }
}
