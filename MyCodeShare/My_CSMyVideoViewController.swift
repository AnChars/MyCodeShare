//
//  My_CSMyVideoViewController.swift
//  MyCodeShare
//
//  Created by AnChar on 16/10/13.
//  Copyright © 2016年 AnChar. All rights reserved.
//

import UIKit
/// 我的视频列表
class My_CSMyVideoViewController: My_CSTableViewController {

    private var cellInfos:  [[String:AnyObject]] = []
    private var cellModels: [AnyObject]  = []
    override func viewDidLoad() {
        super.viewDidLoad()

        self.getData()
        self.tableView.registerNib(UINib(nibName: String(My_CSMyVideoTableViewCell),bundle: nil), forCellReuseIdentifier: "cellId")
        let myTitleView = My_CSMyTitleView()
        let headerView = UIView()
        headerView.frame=CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, 200)
        headerView.backgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)
        self.tableView.tableHeaderView = headerView
        headerView.addSubview(myTitleView)
        myTitleView.snp_makeConstraints { (make) in
            make.top.equalTo(20)
            make.left.right.equalTo(0)
            make.height.equalTo(180)
        }
        myTitleView.name="大熊猫"
        myTitleView.email="jklha@qq.com"
        myTitleView.configSubView(self,
            myShareButtonActionBlock: { (sender) in
                /**
                 我的分享的执行方法
                 */
            let vc = My_CSMessageViewController()
            vc.title = "我的分享"
            self.navigationController?.pushViewController(vc, animated: true)
            },
            myDownButtonActionBlock: { (down) in
                /**
                 *  我的下载
                 */
                self.navigationController?.pushViewController(My_CSMessageViewController(), animated: true)
            },
            myFrimeButtonActionBlock: { (frime) in
                /**
                 *  我的朋友
                 */
                self.navigationController?.pushViewController(My_CSMessageViewController(), animated: true)
            }) { (set) in
                /**
                 设置方法
                 */
                self.navigationController?.pushViewController(My_CSMessageViewController(), animated: true)
        }
    }
    /**
     请求数据
     */
    func getData(){
        self.cellInfos = [
            [
                "title":"杭州。。。。。。。你妹！什么",
                "image"   : "视频",
                "videoURL": "www.baidu.com"
            ],
            [
                "title":"你大爷。。。。。。你妹！什么",
                "image"   : "视频",
                "videoURL": "www.baidu.com"
            ],
            [
                "title":"卧槽。。。。。。。你妹！什么",
                "image"   : "视频",
                "videoURL": "www.baidu.com"
            ],
            [
                "title":"我的天哪。。。。。你妹！什么",
                "image"   : "视频",
                "videoURL": "www.baidu.com"
            ]
        ]
        
        cellModels = NSArray.yy_modelArrayWithClass(My_CSMyVideoModel.self, json: cellInfos)!
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

extension My_CSMyVideoViewController{
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cellModels.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("cellId", forIndexPath: indexPath)as! My_CSMyVideoTableViewCell
        cell.config(self.cellModels[indexPath.row] as! My_CSMyVideoModel)
        return cell
    }
}












