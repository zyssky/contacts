//
//  TableViewController.swift
//  contacts
//
//  Created by zyssky on 2016/11/18.
//  Copyright © 2016年 zyssky. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchbar: UISearchBar!
    
    
    var searchOpen:Bool = false
    @IBOutlet weak var table: UITableView!
    var canSelectRow:Bool = true
    var searchRes: NSMutableArray = NSMutableArray()
    var contacts:[Contact] = []
    var isDir: ObjCBool = false
//    let transition = pushAnim()
    
    func loadContacts() -> [Contact]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Contact.ArchieveURL.path) as? [Contact]
    }
    
    func saveContact() {
        let success = NSKeyedArchiver.archiveRootObject(contacts, toFile: Contact.ArchieveURL.path)
        if !success {
            print("fail")
        }
    }
    
    func checkFileExist() -> Int {
        
        let fileManager = FileManager.default
        var isDir: ObjCBool = false
        if fileManager.fileExists(atPath: Contact.ArchieveURL.path, isDirectory:&isDir){
            if isDir.boolValue{
                //Exist and is a dir.
                return 0
            }else{
                //Exist and is a file
                return 1
            }
        }else{
            //Non Exist.
            return 2
        }
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.searchbar.delegate = self
        self.tableView.delegate = self
        self.tableView.dataSource = self
        searchbar.autocorrectionType = .yes
        
        if let cont = self.loadContacts(){
            self.contacts = cont
        }
        if (contacts.count == 0){
            initiater()
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if(searchOpen){
            return searchRes.count
        }else{
            return contacts.count
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(searchOpen){
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! TableViewCell
        
        let contact = searchRes[indexPath.row] as! Contact
        cell.photoImage.image = contact.photo
        cell.name.text = contact.name
//        cell.phone.text = contact.phone

        return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! TableViewCell
            let contact = contacts[indexPath.row]
            cell.photoImage.image = contact.photo
            cell.name.text = contact.name
            return cell
        }
    }
    
    @IBAction func saveToList(segue:UIStoryboardSegue){	
        if let detailView = segue.source as? ViewController{
            if let contact = detailView.contact{
                if let selectedIndexPath = tableView.indexPathForSelectedRow{
                    contacts[(selectedIndexPath as IndexPath).row] = contact
                    tableView.reloadRows(at: [selectedIndexPath], with: .automatic)
                    
                }
                else{
                    contacts.append(contact)
                    let indexPath = IndexPath(row: contacts.count-1, section: 0)
                    tableView.insertRows(at: [indexPath], with: .automatic)
                }
            }
        }
        saveContact()
    }
    
    @IBAction func cancleToList(segue:UIStoryboardSegue){
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "modifyContact"{
            if let detailView = segue.destination as? ViewController{
                detailView.contact = contacts[(tableView.indexPathForSelectedRow?.row)!]
            }
        }
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            contacts.remove(at: indexPath.row)
            saveContact()
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if (searchText.characters.count == 0){
            
            searchOpen = false
            self.searchInTable()
        }
        
        if (searchText.characters.count > 0){
            //Input Activated.
//            print("Invoke me")
            searchOpen = true
            canSelectRow = true
            self.table.isScrollEnabled = true
            self.searchInTable()
        }else{
            searchOpen = false
            canSelectRow = false
            
        }
    }
    
    func searchInTable(){
        
        searchRes.removeAllObjects()
        for contact in contacts{
            if(contact.name.range(of: searchbar.text!) != nil){
                
                searchRes.add(contact)
            }
        }
        self.table.reloadData()
    }
    
    
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        animateTable()
    }
    
    func animateTable(){
        
        self.table.reloadData()
        let cells = self.table.visibleCells
        let tableHeight: CGFloat = self.table.bounds.size.height
        
        for i in cells{
            
            let cell: UITableViewCell = i as UITableViewCell
            cell.transform = CGAffineTransform(translationX: 0,y: tableHeight)
        }
        
        var index = 0
        
        for X in cells {
            
            let cell: UITableViewCell = X as UITableViewCell
            UIView.animate(withDuration: 1.0, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: UIViewAnimationOptions.curveEaseIn, animations: {
            cell.transform = CGAffineTransform(translationX: 0,y: 0)
            }, completion: nil)
            
            index += 1
            
        }
    }
    
    func initiater(){
        
        let x11 = UIImage(named: "Panda2.png")
        let x1  = Contact(name: "Fake_KungFuPanda",phone: "999999",email: "XWarrior@12306.com",photo: x11!)
        let x21 = UIImage(named: "Panda3.png")
        let x2  = Contact(name: "Richman",phone: "888888",email: "Bfat@12306.com",photo: x21!)
        let x31 = UIImage(named: "Panda4.png")
        let x3  = Contact(name: "KungfuMaster",phone: "00000",email: "Qute@12306.com",photo: x31!)
        let x41 = UIImage(named: "Panda5.png")
        let x4  = Contact(name: "Foolishfish",phone: "110",email: "Hitman@12306.com",photo: x41!)
        self.contacts.append(x1)
        self.contacts.append(x2)
        self.contacts.append(x3)
        self.contacts.append(x4)
        self.saveContact()
        self.table.reloadData()
    }
    
    
    
    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
