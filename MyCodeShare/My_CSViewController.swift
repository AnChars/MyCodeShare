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
    }
    
    func configTabBar(){
        let tabbarSubViews = [
            ["title":"主页",
            "image":"tabbar_1",
            "class":"Home"
            ],
            ["title":"消息",
            "image":"tabbar_1",
            "class":"Message"
            ],
            ["title":"分享",
            "image":"tabbar_1",
            "class":"Message"
            ],
            ["title":"我的",
            "image":"tabbar_1",
            "class":"Message",
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
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
