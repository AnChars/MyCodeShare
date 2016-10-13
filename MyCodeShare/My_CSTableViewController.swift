//
//  My_CSViewController.swift
//  MyCodeShare
//
//  Created by AnChar on 16/10/13.
//  Copyright © 2016年 AnChar. All rights reserved.
//

import UIKit

class My_CSTableViewController: ViewController {
    
    var style: UITableViewStyle = UITableViewStyle.Grouped
    
    init(WithStyle style:UITableViewStyle){
        self.style = style
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
    }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    private(set) lazy var tableView : UITableView = {
        let tableView = UITableView(frame: CGRectZero, style: self.style)
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor=UIColor(red: 0.8699, green: 0.8699, blue: 0.8699, alpha: 1)
        tableView.rowHeight = 90
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    var contenInset = UIEdgeInsetsZero {
        didSet{
            tableView.contentInset = contenInset
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.addSubview(tableView)
        tableView.snp_makeConstraints { (make) in
            make.edges.equalTo(0)
        }
        contenInset = UIEdgeInsetsMake(topBarheight, 0, tabBarHeight, 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

extension My_CSTableViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}



