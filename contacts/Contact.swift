//
//  Contact.swift
//  contacts
//
//  Created by zyssky on 2016/11/18.
//  Copyright © 2016年 zyssky. All rights reserved.
//

import Foundation
import UIKit

class Contact{
    var name:String
    var phone:String
    var email:String
    var photo:UIImage
    
    init(name:String,phone:String,email:String,photo:UIImage) {
        self.email = email
        self.name = name
        self.phone = phone
        self.photo = photo
    }
}
