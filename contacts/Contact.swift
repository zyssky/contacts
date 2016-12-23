//
//  Contact.swift
//  contacts
//
//  Created by zyssky on 2016/11/18.
//  Copyright © 2016年 zyssky. All rights reserved.
//

import Foundation
import UIKit

class Contact:NSObject,NSCoding {
    static var DocumentDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchieveURL = DocumentDirectory.appendingPathComponent("mycontacts2")
    static var defaultSet  = false
    
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
    
    required init(coder aDecoder: NSCoder) {
        self.name = (aDecoder.decodeObject(forKey: "name") as? String)!
        self.phone = (aDecoder.decodeObject(forKey: "phone") as? String)!
        
        if let p = (aDecoder.decodeObject(forKey: "photo")as? UIImage){
            self.photo = p
        }else{
//            self.name  = "KungFuPanda"
//            self.phone = "666666"
//            self.email = "panda@12306.com"
            self.photo = UIImage(named: "KungFuPanda.png")!
        }
        self.email = (aDecoder.decodeObject(forKey: "email") as? String)!
        super.init()
    }
    
    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(self.name,forKey: "name")
        aCoder.encode(self.phone,forKey: "phone")
        aCoder.encode(self.photo,forKey: "photo")
        aCoder.encode(self.email,forKey: "email")
    }
    
}
