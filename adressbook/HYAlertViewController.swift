//
//  HYAlertViewController.swift
//  adressbook
//
//  Created by hexiangpeng on 15/11/21.
//  Copyright © 2015年 huayuan. All rights reserved.
//

import UIKit


//修改电话号码

class HYAlertViewController: UIViewController {
    
    var baseview = UIView()
    
    var contentview = UIView()
    
    var phone:UITextField!
    var vercode:UITextField!
    
    var button:UIButton!
    
    
    var ensureBtn:UIButton!
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    required  init(){
        super.init(nibName: nil, bundle: nil)
        view.frame = UIScreen.mainScreen().bounds
        view.autoresizingMask = [.FlexibleHeight,.FlexibleWidth]
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        
        view.addSubview(baseview)
        baseview.frame = view.frame
        
        baseview.addSubview(contentview)
        contentview.backgroundColor = UIColor.whiteColor()
        contentview.layer.cornerRadius = 5
        contentview.layer.masksToBounds = true
        
       
        
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
     
        
        
        let rv = UIApplication.sharedApplication().keyWindow! as UIWindow
        let sz = rv.frame.size
        
        
      
        // Set background frame
        view.frame.size = sz
        
       
        
        contentview.frame = CGRect(x:30, y:sz.height*0.5-(sz.width-80)*0.5, width:sz.width-60, height:sz.width*0.5)
        contentview.layer.cornerRadius = 5
        
        
        phone = UITextField(frame: CGRectMake(10,10, contentview.frame.width-20,40))
        phone.backgroundColor = RGB(240, g: 240, b: 240)
        phone.layer.cornerRadius = 5
        phone.keyboardType = .DecimalPad
        phone.attributedPlaceholder = NSAttributedString(string: "修改后电话", attributes: [NSForegroundColorAttributeName:UIColor.grayColor()])
        phone.tintColor = RGB(84, g: 150, b: 136)
//        phone.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0)
        contentview.addSubview(phone)
        
        let codeview = UIView(frame:CGRectMake(10,60,contentview.frame.width-20,40))
        codeview.backgroundColor = RGB(240, g: 240, b: 240)
        
        codeview.layer.cornerRadius = 5
        
        contentview.addSubview(codeview)
        
        vercode = UITextField(frame: CGRectMake(0,0,codeview.frame.width-80,40))
        vercode.backgroundColor = RGB(240, g: 240, b: 240)
         vercode.layer.cornerRadius = 5
        vercode.keyboardType = .DecimalPad
         vercode.attributedPlaceholder = NSAttributedString(string: "验证码", attributes: [NSForegroundColorAttributeName:UIColor.grayColor()])
        vercode.tintColor = RGB(84, g: 150, b: 136)
//        vercode.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0)
        
        codeview.addSubview(vercode)
        
        button = UIButton(frame: CGRectMake(vercode.frame.width,0,80,40))
        button.setTitle("获取验证码", forState: UIControlState.Normal)
        button.titleLabel?.font = UIFont.systemFontOfSize(14)
        
        button.addTarget(self, action: "getvercode:", forControlEvents: UIControlEvents.TouchUpInside)
        
        
         button.setBackgroundImage(colorToImage(RGB(240, g: 240, b: 240),size:  button.frame.size), forState: UIControlState.Normal)
         button.setBackgroundImage(colorToImage(RGB(240, g: 240, b: 240),size:  button.frame.size), forState: UIControlState.Selected)
        
        button.layer.cornerRadius = 2
        button.layer.masksToBounds = true
        button.setTitleColor(UIColor.grayColor(), forState: .Normal)
        
        codeview.addSubview(button)
        
        
        ensureBtn = UIButton(frame: CGRectMake(10,110,contentview.frame.width-20,40))
  
        ensureBtn.setTitle("确定", forState: UIControlState.Normal)
        ensureBtn.setBackgroundImage(colorToImage(RGB(84, g: 150, b: 136),size: ensureBtn.frame.size), forState: UIControlState.Normal)
         ensureBtn.setBackgroundImage(colorToImage(RGB(95, g: 124, b: 118),size: ensureBtn.frame.size), forState: UIControlState.Selected)
          ensureBtn.addTarget(self, action: "update:", forControlEvents: UIControlEvents.TouchUpInside)
        
        ensureBtn.layer.masksToBounds = true
        ensureBtn.layer.cornerRadius = 5
        
        
        ensureBtn.addTarget(self, action: "updatephone:", forControlEvents: UIControlEvents.TouchUpInside)
        
        contentview.addSubview(ensureBtn)

        // Do any additional setup after loading the view.
    }
    
//    获取验证码
    func getvercode(btn:UIButton){
       
        let pass = HYKeychain.get("passwd") as! String
        SMSSDK.getVerificationCodeByMethod(SMSGetCodeMethodSMS, phoneNumber:pass, zone: "86", customIdentifier: "来自通讯录") { (error) -> Void in
            
            if((error == nil)){
                //               执
            }else{
                MessageNotice.showNotice("验证码获取错误！")
            }
            
        }
    }
    
    
//    修改电话
    func updatephone(btn:UIButton){
         let phonenumber = phone.text!  as String
        
        let codenumber = vercode.text! as String
        
        SMSSDK.commitVerificationCode(codenumber, phoneNumber: phonenumber, zone: "86") { (error) -> Void in
            
            if(error == nil){
                Register.getInstance().userUpdate(tak, phone: phonenumber, type: "0")
                self.dismissViewControllerAnimated(true, completion: { () -> Void in
                      MessageNotice.showNotice("修改成功！")
                })
            }
            
            
        }
        
                

       
        
    }
    
    func update(btn:UIButton){
        print(phone.text)
    }
    
    func dismiss(ges:UIGestureRecognizer){
//        print("das")
     self.dismissViewControllerAnimated(true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    func show(){
        let rv = UIApplication.sharedApplication().keyWindow! as UIWindow
        rv.addSubview(view)
        view.frame = rv.bounds
        baseview.frame = rv.bounds
        
//        let tap = UITapGestureRecognizer(target: self, action: "dismiss:")
//        
//        
//       self.view.addGestureRecognizer(tap)
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
