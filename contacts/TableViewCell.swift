//
//  tableViewCell.swift
//  contacts
//
//  Created by zyssky on 2016/11/18.
//  Copyright © 2016年 zyssky. All rights reserved.
//

import Foundation
import UIKit

class TableViewCell:UITableViewCell{
    
    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var phone: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
