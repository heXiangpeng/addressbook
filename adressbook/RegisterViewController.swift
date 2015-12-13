//
//  RegisterViewController.swift
//  adressbook
//
//  Created by hexiangpeng on 15/11/5.
//  Copyright © 2015年 huayuan. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController,vercodefy {

    var registerView:RegisterView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.lightGrayColor()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        let lable = UILabel(frame: CGRectZero)
        lable.backgroundColor = UIColor.clearColor()
        lable.textColor = UIColor.whiteColor()
        lable.text = "注册"
        self.navigationItem.titleView = lable
        lable.sizeToFit()
        
        self.navigationController!.navigationBar.backgroundColor =  RGB(84, g: 150, b: 136)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back"), style: UIBarButtonItemStyle.Plain, target: self, action: "back")
      
        
        registerView = RegisterView(frame: self.view.frame)
        
        registerView.delegate = self
        
        self.view.addSubview(registerView)
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyBoardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyBoardWillDisAppear:", name: UIKeyboardWillHideNotification, object: nil)
        
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
    
//    进入跳转上传界面
    func gotomain() {
          let tabbar =  UINavigationController(rootViewController:UploadAddressBookViewController())
        
        self.presentViewController(tabbar, animated: true) { () -> Void in
            
        }
    }
    func back(){
        
        self.navigationController?.popViewControllerAnimated(true)
        
        
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
