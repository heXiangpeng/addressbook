//
//  AddressBookTabBarControllerViewController.swift
//  adressbook
//
//  Created by hexiangpeng on 15/11/5.
//  Copyright © 2015年 huayuan. All rights reserved.
//

import UIKit
import Contacts
import ContactsUI

class AddressBookTabBarControllerViewController: UITabBarController,clicplus ,CNContactViewControllerDelegate{
   
  
    var isshow = false
    var scanView:UIView!
    var iputview:UIView!
    
    var delegate1:dataupdate!
    
   
    
    
    var shapeLayer:CAShapeLayer!
    
    let tabbar = AddressTabbar()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let first = HomeAddressViewController()
         let second = SetViewController()
        
        let a = addChildVc(first, title: "首页", image: "home", selectedImage: "home")
        let b = addChildVc(second, title: "设置", image: "setting", selectedImage: "setting")
        
        
        self.addChildViewController(a)
        self.addChildViewController(b)
        
        
        tabbar.clic = self
        
        tabbar.tintColor = UIColor.orangeColor()
        self.setValue(tabbar, forKey: "tabBar")
        
         iniview()
        
     

        // Do any additional setup after loading the view.
    }
    
    
    override func viewDidAppear(animated: Bool) {
     hidesBottomBarWhenPushed = false
      
    }
    
    func iniview(){
        scanView = UIView(frame: CGRectMake(self.view.frame.width*0.5-25,self.view.frame.height,50,50))
        scanView.layer.cornerRadius = 25
        scanView.backgroundColor = RGB(112, g: 127, b: 133)
        scanView.alpha = 0
        let image = UIImageView(frame: CGRectMake(10, 10, 30, 30))

        image.image = UIImage(named: "scan")
        scanView.addSubview(image)
    
        let scanViewTap = UITapGestureRecognizer(target: self, action: "tapScanView:")
        self.scanView.addGestureRecognizer(scanViewTap)
        
        self.view.addSubview(scanView)
        
        iputview = UIView(frame: CGRectMake(self.view.frame.width*0.5-25,self.view.frame.height,50,50))
        iputview.layer.cornerRadius = 25
        iputview.backgroundColor =  RGB(112, g: 127, b: 133)
        iputview.alpha = 0
        
        let editimage = UIImageView(frame: CGRectMake(10, 10, 30, 30))

        editimage.image = UIImage(named: "adduser")
        
        let inputViewTap = UITapGestureRecognizer(target: self, action: "tapinputView:")
        iputview.addGestureRecognizer(inputViewTap)
        iputview.addSubview(editimage)

        
        
        self.view.addSubview(iputview)
    }
    
    
    func tapinputView(sender:UITapGestureRecognizer){
        let con = CNContactViewController(forNewContact: nil)
        let navigation = UINavigationController(rootViewController:con)
       
        con.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "navback"), forBarMetrics: UIBarMetrics.Default)
        let lable = UILabel(frame: CGRectZero)
        lable.backgroundColor = UIColor.clearColor()
        lable.textColor = UIColor.whiteColor()
        lable.text = "增加联系人"
        con.navigationItem.titleView = lable
        lable.sizeToFit()
        
 
      
        con.delegate = self
        self.presentViewController(navigation, animated: true, completion: nil)
        

    }
    
    
    func tapScanView(sender:UITapGestureRecognizer){

    
        let sca = ScanQrCodeViewController()
       
        let nav = UINavigationController(rootViewController: sca)
        
        self.presentViewController(nav, animated: true, completion: nil)
        
        
        
    }
    
   
    
    func contactViewController(viewController: CNContactViewController, didCompleteWithContact contact: CNContact?) {
         self.dismissViewControllerAnimated(true, completion: nil)
        
//        上传数据
        if(contact?.phoneNumbers.count>=1){
            let addre = UploadAddressStruct()
            addre.isNeedUpload = true
            addre.addressbook = contact
            let adrressbook:[UploadAddressStruct] = [addre]
            
            
            
            var dic:[NSDictionary]=[]
            
        
            for i in 0...adrressbook.count-1 {
                let contact  = adrressbook[i].addressbook
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
                
                let add = ["name":contact.familyName,"phone":phone]
                dic.append(add)
            }

            
            
            Register.getInstance().uploadByJson(dic, taken: tak, callback: { (result) -> Void in
                if(result == "0"){
                
                    
                  
                    let db = SqliteOpertion()
                    db.createDataBase()
                    
                    for person in dic{
                        let persondic = person as NSDictionary
                        
                        print(persondic["name"])
                        
                       
                    
                        
                        db.insertdata(persondic["name"] as! String, phone:  persondic["phone"] as! String)
                        
                        
                        
                    }
                    
                    
                    self.delegate1.update()
//                    let home =  HomeAddressViewController()
                    
//                    home.reloadData(0)
                }else{
                      MessageNotice.showNotice("上传失败")
                }
            })
            
            
          
            
            
            
        }else{
            MessageNotice.showNotice("没有填写电话呀")
        }
        
        
        
    }
    
    func contactViewController(viewController: CNContactViewController, shouldPerformDefaultActionForContactProperty property: CNContactProperty) -> Bool {
        return true
    }
    
   
    
    func plusisclik() {
        
        if isshow == false {
            
            isshow = true
        UIView.animateWithDuration(0.3) { () -> Void in
            self.scanView.alpha = 0.5
           
            self.scanView.frame.origin.x = self.view.frame.width*0.5 - 25
            self.scanView.frame.origin.y = self.view.frame.height - self.tabbar.frame.height-90
            
            
            self.iputview.alpha = 0.5
            self.iputview.frame.origin.x = self.view.frame.width*0.5 - 25
            self.iputview.frame.origin.y = self.view.frame.height - self.tabbar.frame.height-90
            
        }
            
           
        
        UIView.animateWithDuration(0.3, delay: 0.3, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            
           self.scanView.alpha = 1
            self.scanView.frame.origin.x = self.view.frame.width*0.5*0.4
            
            self.scanView.frame.origin.y = self.view.frame.height - self.tabbar.frame.height-90
            
            
            self.iputview.alpha = 1
            self.iputview.frame.origin.x = self.view.frame.width*0.6
            
            self.iputview.frame.origin.y = self.view.frame.height - self.tabbar.frame.height-90
            
            }, completion: { (Bool) -> Void in
              
               
            
          })
            
        }else{
             isshow = false
            
            
            UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                self.scanView.alpha = 0.1
                self.scanView.frame.origin.x = self.view.frame.width*0.5 - 25
                self.scanView.frame.origin.y = self.view.frame.height - self.tabbar.frame.height-90
                
                
                self.iputview.alpha = 0.1
                self.iputview.frame.origin.x = self.view.frame.width*0.5 - 25
                self.iputview.frame.origin.y = self.view.frame.height - self.tabbar.frame.height-90
                
                }, completion: nil)
            
            
            
            UIView.animateWithDuration(0.3, delay: 0.3, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                self.scanView.alpha = 0
                self.scanView.frame.origin.x = self.view.frame.width*0.5-25
                self.scanView.frame.origin.y = self.view.frame.height
                
                
                self.iputview.alpha = 0
                self.iputview.frame.origin.x = self.view.frame.width*0.5-25
                self.iputview.frame.origin.y = self.view.frame.height
                
                }, completion: nil)
            
            
            
            
        }

    }

    

    
    
    func addChildVc(childVc:UIViewController,title:String,image:String,selectedImage:String) -> UINavigationController
    {
        // childVc.tabBarItem.title = title   //导航控制器名称
        childVc.title = title
        childVc.tabBarItem.image = UIImage(named: image)//导航控制器默认图片
        childVc.tabBarItem.selectedImage = UIImage(named: selectedImage)?.imageWithRenderingMode( UIImageRenderingMode.AlwaysOriginal)//导航控制器点击后图片//背景渲染
        
        let selectedtext = NSMutableDictionary()
        selectedtext[NSForegroundColorAttributeName] = UIColor.blackColor()
        
        //        childVc.tabBarItem.setTitleTextAttributes(selectedtext as [NSObject : AnyObject], forState: UIControlState.Selected)
        
        let nav = UINavigationController(rootViewController: childVc)
        return nav
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


protocol dataupdate{
    func update()
}
