//
//  My_CSMyVideoTableViewCell.swift
//  MyCodeShare
//
//  Created by AnChar on 16/10/13.
//  Copyright © 2016年 AnChar. All rights reserved.
//

import UIKit

class My_CSMyVideoTableViewCell: UITableViewCell {

    @IBOutlet var imageview: UIImageView!
    @IBOutlet var sizeLable: UILabel!
    @IBOutlet var title: UILabel!
    
    func config(model:My_CSMyVideoModel){
        self.title.text = model.title
        self.sizeLable.text = model.videoSize
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
