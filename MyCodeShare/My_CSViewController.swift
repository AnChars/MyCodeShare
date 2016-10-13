//
//  My_CSViewController.swift
//  MyCodeShare
//
//  Created by AnChar on 16/10/11.
//  Copyright © 2016年 AnChar. All rights reserved.
//

import UIKit

class My_CSViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.configTabBar()
        self.tabBar.tintColor=UIColor ( red: 0.7131, green: 0.9034, blue: 0.2, alpha: 1.0 )
    }
    
    func configTabBar(){
        let tabbarSubViews = [
            ["title":"主页",
            "image":"按钮主页",
            "class":"Home"
            ],
            ["title":"消息",
            "image":"按钮消息",
            "class":"Message"
            ],
            ["title":"分享",
            "image":"按钮分享",
            "class":"Message"
            ],
            ["title":"我的",
            "image":"按钮我的",
            "class":"MyVideo",
            ]
        ]
        var navs = [UINavigationController]()
        for subview in tabbarSubViews{
            let vc = (NSClassFromString("MyCodeShare.My_CS"+subview["class"]!+"ViewController")as!UIViewController.Type).init()
            let nvc = UINavigationController(rootViewController: vc)
            vc.title = subview["title"]
            vc.view.backgroundColor=UIColor.whiteColor()
            navs.append(nvc)
        }
        self.viewControllers = navs
        
        for item in self.tabBar.items!{
            let index = self.tabBar.items?.indexOf(item)
            item.image = UIImage(named: tabbarSubViews[index!]["image"]!)
            item.selectedImage = UIImage(named: tabbarSubViews[index!]["image"]!+"-点击")
        }
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
