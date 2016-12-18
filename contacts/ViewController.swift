//
//  ViewController.swift
//  contacts
//
//  Created by zyssky on 2016/11/18.
//  Copyright © 2016年 zyssky. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate {

    @IBAction func onTouchEmail(_ sender: AnyObject) {
        NSLog("ontouchemail")
        guard let url = NSURL(string: "mailto://\(email.text)") else {
            return
        }
        
        if UIApplication.shared.canOpenURL(url as URL) {
            UIApplication.shared.openURL(url as URL)
        }
    }
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var photoimage: UIImageView!
    
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
    
    
    
    @IBAction func onTouchPhone(_ sender: AnyObject) {
        NSLog("ontouchphone")
        guard let url = NSURL(string: "tel://\(phone.text)") else {
            return
        }
        
        if UIApplication.shared.canOpenURL(url as URL) {
            UIApplication.shared.openURL(url as URL)
        }
    }
    
    
    @IBAction func tapOnPhotoimage(_ sender: AnyObject) {
        pickImage()
    }
    
    var contact:Contact?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let person = self.contact{
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

