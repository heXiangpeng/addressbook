//
//  Register.swift
//  adressbook
//
//  Created by hexiangpeng on 15/11/8.
//  Copyright © 2015年 huayuan. All rights reserved.
//

import UIKit
import Contacts

/**
登录注册操作
*/

let url = "http://frblo.sinaapp.com/"

class Register: NSObject {
    
    
    
    class func getInstance() -> Register {
        var instance:Register? = nil
        if(instance == nil){
            instance = Register()
        }
        return instance!
    }
    
    
    
    func uploadByJson(books:[NSDictionary],taken:String,callback:((result:String)->Void)){
        let di:[String:NSObject] = ["taken":taken,"addressbook":books]
        request(.POST, url+"uploadadressbook.php", parameters: di, encoding: .JSON).responseJSON{
             response in
//            let st = NSString(data: data!, encoding: NSUTF8StringEncoding) as! String
//            print(response.result.value)
            
            if let JSON = response.result.value {
                 let taken = JSON["result"] as! String
                  callback(result: taken)
            }else{
                 callback(result: "error")
            }
            
            
         
            
        }
    }
    
    
    
    func userLogin(name:String,phone:String,callback:((taken:String,result:Int,msg:String)->Void)){
        let nameutf = name.cStringUsingEncoding(NSUTF8StringEncoding)!
        let parameters = ["name":name,"phone":phone]
        request(.POST, url+"login.php", parameters: parameters).responseJSON{
            response in
            
            if let JSON = response.result.value {
                let taken = JSON["taken"] as! String
                let message = JSON["message"] as! String
                let result = JSON["result"] as! Int
                callback(taken: taken, result: result,msg:message )
            }else{
                callback(taken: "", result: 5,msg:"网络出错")
            }
            
        }
    }
    
    
    func userRegister(name:String,phone:String,callback:((taken:String,result:String,msg:String)->Void)){
        let parameters = ["name":name,"phone":phone]
        request(.POST, url+"register.php", parameters: parameters).responseJSON{
            response in
            
            
            print(response.result.value)
            
            if let JSON = response.result.value {
                let taken =  JSON["taken"] as! String
                let message = JSON["message"] as! String
                let result = JSON["result"] as! String
                callback(taken: taken, result: result,msg:message )
            }else{
                callback(taken: "", result: "5",msg:"网络出错")
            }
            
            
        }
    }
    
    func userUpdate(taken:String,phone:String,type:String){
        let parameters = ["taken":taken,"phone":phone,"type":type]
        
        request(.POST, url+"updatePhone.php",parameters:parameters).responseJSON{
            response in
            
            print(response.result.value)
        }
    }
    
    
    func getAddressbook(taken:String,callback:((result:NSMutableArray) -> Void)){
        let di:[String:NSObject] = ["taken":taken]
        
        
        request(.POST, url+"getaddressbook.php", parameters: di).responseJSON{
            response in
            
            if let JSON = response.result.value {
                
//                把json数据转化成数组
                
                var persondic:[UserAddress] = []
                
                let ar = response.result.value as! NSArray
                
                print(ar.count)
                
                for person in ar {
                    let oneperson = person as! NSDictionary
                    let  newperson = UserAddress()
                    newperson.name = oneperson["addressname"] as! String
                    newperson.phone = oneperson["addressphone"] as! String
                    
                    
                    
                    persondic.append(newperson)
                }
               
                //                if JSON is NSArray {
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    callback(result: (persondic as NSArray).mutableCopy() as! NSMutableArray)
                  
                })
                
                //                }
            }
            
            
        }
    }
    
    
    
}
