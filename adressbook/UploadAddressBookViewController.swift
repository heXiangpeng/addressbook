//
//  UploadAddressBookViewController.swift
//  adressbook
//
//  Created by hexiangpeng on 15/11/5.
//  Copyright © 2015年 huayuan. All rights reserved.
//

import UIKit
import Contacts

class UploadAddressBookViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    var main:AddressBookTabBarControllerViewController!
    var uploadBtn:UIButton!
    var addressTable:UITableView!
    

    var contacts = [CNContact]()
    let store = CNContactStore()
    let keysToFetch = [CNContactFormatter.descriptorForRequiredKeysForStyle(.FullName),CNContactImageDataKey,CNContactPhoneNumbersKey]
    
    
    var adrressbook:[UploadAddressStruct]=[]
    
    let db = SqliteOpertion()
    
    
    
   

    override func viewDidLoad() {
        super.viewDidLoad()
      
        self.view.backgroundColor = UIColor.whiteColor()
        let lable = UILabel(frame: CGRectZero)
        lable.backgroundColor = UIColor.clearColor()
        lable.textColor = UIColor.whiteColor()
        lable.text = "上传联系人"
        self.navigationItem.titleView = lable
        lable.sizeToFit()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "navback"), forBarMetrics: UIBarMetrics.Default)
      
        self.navigationController!.navigationBar.translucent = false
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "跳过", style: UIBarButtonItemStyle.Done, target: self, action: "upStep:")
        navigationItem.rightBarButtonItem?.tintColor = UIColor.whiteColor()
        
        
        db.createDataBase()
        
        
//      初始化上传按钮
        initView()
         main = AddressBookTabBarControllerViewController()
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            
            self.contacts = self.getAddressBook()
            
            dispatch_async(dispatch_get_main_queue()) {
                
                self.addressTable.reloadData()
                
            } 
            
            
            
        }
        

        
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.adrressbook.count
    }
    
//    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        return 60
//    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        var cell = tableView.dequeueReusableCellWithIdentifier("cell")
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "cell")
//            cell?.accessoryType =  UITableViewCellAccessoryType.DetailDisclosureButton
        }
        
        
        
        let contact = self.adrressbook[indexPath.row].addressbook
        var phones:[String] = []
        for number in contact.phoneNumbers {
            
            let phoneNumber = number.value as! CNPhoneNumber
            
//           phoneNumber.stringValue
               let num =   phoneNumber.stringValue.stringByReplacingOccurrencesOfString("-", withString: "").getPhone()
             phones.append(num)
//            phoneNumber.stringValue.stringByReplacingOccurrencesOfString(<#T##target: String##String#>, withString: <#T##String#>, options: .CaseInsensitiveSearch | NSStringCompareOptions.LiteralSearch, range: nil)
            
       
            
    
            
        }
        cell?.accessoryView = checkbox()

        cell?.detailTextLabel?.text = phones[0]
        cell!.textLabel!.text = "\(contact.familyName)\(contact.givenName)"
       
        
        return cell!
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        
        let checkview = cell!.accessoryView as! UIImageView
        print(checkview.image)
        
        if(self.adrressbook[indexPath.row].isNeedUpload == false){
            checkview.image = UIImage(named: "checked")
            self.adrressbook[indexPath.row].isNeedUpload = true
        }else{
            checkview.image = UIImage(named: "uncheck")
             self.adrressbook[indexPath.row].isNeedUpload = false
        }
        
        
        
        
        
    }
    
    func checkbox() -> UIImageView{
        let frame = CGRectMake(0, 0, 10, 10)
        let checkview = UIImageView(frame: frame)
        
        checkview.image = UIImage(named: "uncheck")
        
        return checkview
    }
    
  

    
   
    
    func getAddressBook() ->[CNContact]{
        let fetchRequest = CNContactFetchRequest(keysToFetch: keysToFetch)
        
        do {
            try store.enumerateContactsWithFetchRequest(fetchRequest, usingBlock: { (let contact, let stop) -> Void in
                self.contacts.append(contact)
                let add = UploadAddressStruct()
                
                
            
            
                add.addressbook=contact
                add.isNeedUpload = false
                if(add.addressbook.phoneNumbers.count>0){
                   self.adrressbook.append(add)
                }
            })
        }catch let error as NSError{
            print(error.localizedDescription)
        }
        
        
        return contacts

    }
    
    func initView(){
        
        
        addressTable = UITableView(frame: CGRectMake(0, 0, self.view.bounds.width,  self.view.bounds.height-120),style:UITableViewStyle.Plain)
        
        addressTable.dataSource = self
        addressTable.delegate = self
        addressTable.tableFooterView = UIView()
        
        self.view.addSubview(addressTable)
        
        
        uploadBtn = UIButton(frame: CGRectMake(0,self.view.frame.height-120,self.view.bounds.width,60))
         uploadBtn.setBackgroundImage(colorToImage(RGB(223, g: 222, b: 222), size:  uploadBtn.frame.size), forState: UIControlState.Normal)
         uploadBtn.setBackgroundImage(colorToImage(RGB(197, g: 197, b: 197), size:  uploadBtn.frame.size), forState: UIControlState.Selected)
        uploadBtn.setTitle("上传", forState: UIControlState.Normal)
        
        uploadBtn.addTarget(self, action: "uploadAddress:", forControlEvents: UIControlEvents.TouchUpInside)
        
        
        self.view.addSubview(uploadBtn)
    }
    
    
    func uploadAddress(event:UIEvent){
        
//        从数据中找出要上传的数据
        var adrressbookupload:[UploadAddressStruct]=[]
        for book in adrressbook {
            if(book.isNeedUpload == true && book.addressbook.phoneNumbers.count > 0 ){
                adrressbookupload.append(book)
            }
          
        }
        
        if(adrressbookupload.count > 0){
            
            var dic:[NSDictionary]=[]
            for i in 0...adrressbookupload.count-1 {
                let contact  = adrressbookupload[i].addressbook
                var phone:String = ""
                var index = 1
                for number in contact.phoneNumbers {
                    
                    let phoneNumber = number.value as! CNPhoneNumber
                    if(index == contact.phoneNumbers.count){
                        phone.appendContentsOf(phoneNumber.stringValue.stringByReplacingOccurrencesOfString("-", withString: "").getPhone())
                    }else{
                        phone.appendContentsOf(phoneNumber.stringValue.stringByReplacingOccurrencesOfString("-", withString: "").getPhone()+":")
                        
                    }
                    index++
                    
                }
                let name = "\(contact.familyName)\(contact.givenName)"
                print(name)
                let add = ["name":name,"phone":phone]
                
               
                
               
                
                dic.append(add)
            }
            
            
            
            Register.getInstance().uploadByJson(dic, taken: tak,callback: { (result) -> Void in
                if(result == "0"){
                    
                    let db = SqliteOpertion()
                    db.createDataBase()
                    
                    for person in dic{
                        let persondic = person as NSDictionary
                        
                        print(persondic["name"])
                        
                        
                        
                        
                        db.insertdata(persondic["name"] as! String, phone:  persondic["phone"] as! String)
                        
                        
                        
                    }

                  
                    self.presentViewController(self.main, animated: true) { () -> Void in
                        
                    }
                }else{
                    MessageNotice.showNotice("上传失败")
                }
            
            })
            

        }else{
              MessageNotice.showNotice("没有勾选")
        }
    }
    
    
    func upStep(event:UIEvent){
       
        self.presentViewController(main, animated: true) { () -> Void in
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
    }
    

 
}
