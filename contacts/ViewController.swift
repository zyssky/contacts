//
//  ViewController.swift
//  contacts
//
//  Created by zyssky on 2016/11/18.
//  Copyright © 2016年 zyssky. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate {
    
    @IBOutlet weak var mail_btn: UIButton!
    @IBOutlet weak var sms_btn: UIButton!
    @IBOutlet weak var phone_btn: UIButton!
    @IBOutlet weak var phone_text: UITextField!
    @IBOutlet weak var email_text: UITextField!
    @IBOutlet weak var name_text: UITextField!
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var photoimage: UIImageView!
    
    
    @IBAction func onTouchEmail(_ sender: AnyObject) {
        NSLog("ontouchemail")
        guard let url = NSURL(string: "mailto://\(email.text)") else {
            return
           
        }
        
        if UIApplication.shared.canOpenURL(url as URL) {
            UIApplication.shared.openURL(url as URL)
        }
    }
    
   
    
    func pickImage(){
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func onTouchMessage(_ sender: AnyObject) {
        NSLog("ontouchmessage")
        guard let url = NSURL(string: "mailto://\(phone.text)") else {
            return
        }
        
        if UIApplication.shared.canOpenURL(url as URL) {
            UIApplication.shared.openURL(url as URL)
        }
    }
    
    func phonecalltest(){
        
        
    }
    
    @IBAction func onTouchPhone(_ sender: AnyObject) {
        NSLog("ontouchphone")
        guard let url = NSURL(string: "prefs:root=Phone") else {
            return
        }
        
        self.extensionContext?.open(url as URL)
    }
    
    
    @IBAction func tapOnPhotoimage(_ sender: AnyObject) {
        pickImage()
    }
    
    var contact:Contact?
    
    override func viewDidAppear(_ animated: Bool){
        
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.5, delay: 0.1, usingSpringWithDamping: 0, initialSpringVelocity: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.phone_btn.alpha = 1
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0.1, usingSpringWithDamping: 0, initialSpringVelocity: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.sms_btn.alpha = 1
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0.1, usingSpringWithDamping: 0, initialSpringVelocity: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.mail_btn.alpha = 1
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0, initialSpringVelocity: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.photoimage.alpha = 1
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0.15, usingSpringWithDamping: 0, initialSpringVelocity: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.name_text.alpha = 1
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0.3, usingSpringWithDamping: 0, initialSpringVelocity: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.name.alpha = 1
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0.35, usingSpringWithDamping: 0, initialSpringVelocity: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.phone_text.alpha = 1
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0.4, usingSpringWithDamping: 0, initialSpringVelocity: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.phone.alpha = 1
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0.5, usingSpringWithDamping: 0, initialSpringVelocity: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.email_text.alpha = 1
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0.6, usingSpringWithDamping: 0, initialSpringVelocity: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.email.alpha = 1
        }, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        maskLayer.position = CGPoint(x: view.layer.bounds.size.width/2,y: view.layer.bounds.size.height/2)
//        view.layer.mask = maskLayer
        
        self.email.alpha = 0
        self.phone.alpha = 0
        self.name.alpha  = 0
        self.photoimage.alpha = 0
        self.name_text.alpha  = 0
        self.phone_text.alpha = 0
        self.email_text.alpha = 0
        self.phone_btn.alpha  = 0
        self.sms_btn.alpha    = 0
        self.mail_btn.alpha   = 0
        
        // Do any additional setup after loading the view, typically from a nib.
        if let person = self.contact{
//            self.navigationItem.title = person.name
            name.text = person.name
            phone.text = person.phone
            email.text = person.email
            photoimage.image = person.photo
        }
        else{
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "cancleToList"{
            
        }
        
        if segue.identifier == "saveToList"{
            contact = Contact(name: name.text!, phone: phone.text!, email: email.text!, photo: photoimage.image!)
        }
    }
    

    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        contact?.photo = selectedImage
        photoimage.image = selectedImage
        dismiss(animated: true, completion: nil)
    }

}

