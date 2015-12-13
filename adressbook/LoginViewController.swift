//
//  RegisterViewController.swift
//  adressbook
//
//  Created by hexiangpeng on 15/11/5.
//  Copyright © 2015年 huayuan. All rights reserved.
//

import AudioToolbox
import UIKit

class LoginViewController: UIViewController {
    
    var username:UITextField!
    var phonenumber:UITextField!
    var loginBtn:UIButton!
    var loginView:UIView!
    
    var uploadViewController:UploadAddressBookViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.lightGrayColor()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        let lable = UILabel(frame: CGRectZero)
        lable.backgroundColor = UIColor.clearColor()
        lable.textColor = UIColor.whiteColor()
        lable.text = "登录"
        self.navigationItem.titleView = lable
        lable.sizeToFit()
        
        self.navigationController!.navigationBar.backgroundColor =  RGB(84, g: 150, b: 136)
       

        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back"), style: UIBarButtonItemStyle.Plain, target: self, action: "back")
        
    
        
        initLogin()
        initview()
        
       NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyBoardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        
         NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyBoardWillDisAppear:", name: UIKeyboardWillHideNotification, object: nil)
        
        
  

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        
    }
    
    
    func keyBoardWillShow(note:NSNotification){
        let useinfo = note.userInfo as! NSDictionary
//        let keyBoardBounds = (useinfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        
         let duration = (useinfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        
//        let keyboardsRect = self.view.convertRect(keyBoardBounds, toView: nil)
        
//        let deltaY = keyBoardBounds.size.height
        
        
        UIView.animateWithDuration(duration) { () -> Void in
            self.view.frame.origin.y = -50
        }
        
        
        
    }
    
    func keyBoardWillDisAppear(note:NSNotification){
        let useinfo = note.userInfo as! NSDictionary
//        let keyBoardBounds = (useinfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
//
        let duration = (useinfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        
        UIView.animateWithDuration(duration) { () -> Void in
            self.view.frame.origin.y  = 0
        }
    }
    
    func back(){
       
        self.navigationController?.popViewControllerAnimated(true)
    
        
    }
    
    func initLogin(){
        loginView = UIView(frame: CGRectMake(20,self.view.frame.height*0.5-self.view.frame.height*0.3,self.view.frame.width-40,self.view.frame.height*0.2))
        
         loginView.backgroundColor = RGB(178, g: 186, b: 122)
         loginView.layer.cornerRadius = 5
        
        username = UITextField(frame:CGRectMake(2,10,loginView.frame.width-4,loginView.frame.height*0.3))
        
        //        username.placeholder = "名 字"
        username.attributedPlaceholder = NSAttributedString(string: "名   字", attributes: [NSForegroundColorAttributeName:UIColor.grayColor()])
        username.tintColor = RGB(84, g: 150, b: 136)
        username.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0)
        let image=UIImageView(image: UIImage(named:"username"))
        image.frame = CGRectMake(0, 0, 35, 35)
        username.leftView = image
        username.leftViewMode = UITextFieldViewMode.Always
        
        let line = UIView(frame: CGRectMake(0,loginView.frame.height*0.5,loginView.frame.width,1))
        line.backgroundColor = RGB(151, g: 151, b: 151)
        
        loginView.addSubview(username)
        loginView.addSubview(line)
        
        
        phonenumber = UITextField(frame:CGRectMake(2,loginView.frame.height*0.5+10,loginView.frame.width-4,loginView.frame.height*0.3))
        
        phonenumber.keyboardType = .DecimalPad
        
        phonenumber.attributedPlaceholder = NSAttributedString(string: "电话号码", attributes: [NSForegroundColorAttributeName:UIColor.grayColor()])
        phonenumber.tintColor = RGB(84, g: 150, b: 136)
        phonenumber.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0)
        let imagephone=UIImageView(image: UIImage(named:"phone"))
        imagephone.frame = CGRectMake(0, 0, 35,35)
        phonenumber.leftView = imagephone
        phonenumber.leftViewMode = UITextFieldViewMode.Always
        
         loginView.addSubview(phonenumber)
        
        self.view.addSubview(loginView)

    }
    
    func initview(){
      loginBtn = UIButton(frame: CGRectMake(self.view.frame.width*0.2, self.view.frame.height*0.5, self.view.frame.width*0.6, 35))
        
        loginBtn.setBackgroundImage(colorToImage(RGB(61, g: 59, b: 79), size: loginBtn.frame.size), forState: UIControlState.Normal)
        loginBtn.setBackgroundImage(colorToImage(RGB(101, g: 98, b: 132), size: loginBtn.frame.size), forState: UIControlState.Selected)
        
        loginBtn.setTitle("登录", forState: UIControlState.Normal)
        loginBtn.layer.cornerRadius = 5
        
        loginBtn.addTarget(self, action: "login:", forControlEvents: UIControlEvents.TouchUpInside)
        let laylogin = loginBtn.layer
        laylogin.masksToBounds = true
        laylogin.cornerRadius = 5
        self.view.addSubview(loginBtn)
    
    }
    
//    登录按结果
    func login(event:UIEvent){
        let user = username.text
        let phone = phonenumber.text
        
//        print(phone?.characters.count)
        
        if(user?.characters.count>0 || phone?.characters.count == 11){
           let indictorView = UIActivityIndicatorView(frame: CGRectMake(0,0,50,50))
            
            UIView.animateWithDuration(0.2, animations: { () -> Void in
                self.loginBtn.frame.size = CGSize(width: 50, height: 50)
                self.loginBtn.frame.origin.x = self.view.frame.width*0.5 - 25
                self.loginBtn.setTitle("", forState: UIControlState.Normal)
                self.loginBtn.layer.cornerRadius = 25
                }, completion: { (Bool) -> Void in
                
                    self.loginBtn.addSubview(indictorView)
                    indictorView.startAnimating()
            })
        
            
         Register.getInstance().userLogin(username.text!, phone: phonenumber.text!) { (taken,Result,msg) -> Void in
            
                // 用户注册成功
              if (Result == 0){
                // 存储seesion
                
                
                
                HYKeychain.set("name", value: self.username.text!)
                HYKeychain.set("passwd", value: self.phonenumber.text!)
                
                tak = taken
                
                self.uploadViewController = UploadAddressBookViewController()
                let navUploadAddressbook = UINavigationController(rootViewController: self.uploadViewController)
                
                self.presentViewController(navUploadAddressbook, animated: true, completion: nil)

                
                
               }else{
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                     MessageNotice.showNotice(msg)
                    self.loginBtn.frame.size = CGSize(width: self.view.frame.width*0.6, height: 40)
                    self.loginBtn.frame.origin.x = self.view.frame.width*0.2
                    indictorView.stopAnimating()
                    self.loginBtn.layer.cornerRadius = 5
                    }, completion: { (Bool) -> Void in
                        self.loginBtn.setTitle("登录", forState: UIControlState.Normal)
                    indictorView.removeFromSuperview()
                        
                })
                
               }
            
          }
            
            
        }else{
            MessageNotice.showNotice("用户名或电话出错")
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
            animationwillinputwrong(username)
        }
//        Register.getInstance().userRegister(username.text!, phone:phonenumber.text!)
        uploadViewController = UploadAddressBookViewController()
//        let navUploadAddressbook = UINavigationController(rootViewController: uploadViewController)
//        
//        self.presentViewController(navUploadAddressbook, animated: true, completion: nil)
    }
    
    
    func animationwillinputwrong(view:UIView){
        
//        username = UITextField(frame:CGRectMake(2,10,loginView.frame.width-4,loginView.frame.height*0.3))
        
        let animation = CAKeyframeAnimation(keyPath: "position")
        let p1 = CGPointMake(0, view.frame.origin.y)
        let p2 = CGPointMake(2, view.frame.origin.y)
        let p3 = CGPointMake(3, view.frame.origin.y)
        let p4 = CGPointMake(2, view.frame.origin.y)
        
        animation.values = [NSValue(CGPoint:p1),NSValue(CGPoint:p2),NSValue(CGPoint:p3),NSValue(CGPoint:p4)]
        
        animation.duration = 0.4
        
        
       view.layer.addAnimation(animation, forKey: "shake")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    


}
