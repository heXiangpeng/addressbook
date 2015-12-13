//
//  RegisterView.swift
//  adressbook
//
//  Created by hexiangpeng on 15/11/5.
//  Copyright © 2015年 huayuan. All rights reserved.
//

import UIKit

class RegisterView: UIView {
    var username:UITextField!
    var phonenumber:UITextField!
    var vercode:UITextField!
    var getvercodeBtn:UIButton!
    
    var registCompont:UIView!
    
    var delegate:vercodefy!
    
    
    var register:UIButton!
    override init(frame: CGRect) {
        super.init(frame: frame)
        initCompont()
        initview()
        
        
    }
    
    
    func initCompont(){
        registCompont = UIView(frame: CGRectMake(20,frame.height*0.5-frame.height*0.3,frame.width-40,frame.height*0.2))
        
        registCompont.backgroundColor = RGB(178, g: 186, b: 122)
        registCompont.layer.cornerRadius = 5
        
        username = UITextField(frame:CGRectMake(2,2,registCompont.frame.width-4,registCompont.frame.height*0.3))
        
        //        username.placeholder = "名 字"
        username.attributedPlaceholder = NSAttributedString(string: "名   字", attributes: [NSForegroundColorAttributeName:UIColor.whiteColor()])
        username.tintColor = RGB(84, g: 150, b: 136)
        username.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0)
        let image=UIImageView(image: UIImage(named:"username"))
        image.frame = CGRectMake(0, 0, 35, 35)
        username.leftView = image
        username.leftViewMode = UITextFieldViewMode.Always
        let line = UIView(frame: CGRectMake(0,registCompont.frame.height*0.3+2,registCompont.frame.width,1))
        line.backgroundColor = RGB(151, g: 151, b: 151)
        
        self.registCompont.addSubview(username)
        self.registCompont.addSubview(line)
        
        
        
        phonenumber = UITextField(frame:CGRectMake(2,registCompont.frame.height*0.3+3,registCompont.frame.width-4,registCompont.frame.height*0.3))
        
        phonenumber.keyboardType = .DecimalPad
        phonenumber.attributedPlaceholder = NSAttributedString(string: "电话号码", attributes: [NSForegroundColorAttributeName:UIColor.whiteColor()])
        phonenumber.tintColor = RGB(84, g: 150, b: 136)
        phonenumber.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0)
        let imagephone=UIImageView(image: UIImage(named:"phone"))
        imagephone.frame = CGRectMake(0, 0, 35,35)
        phonenumber.leftView = imagephone
        phonenumber.leftViewMode = UITextFieldViewMode.Always
        
        let linephone = UIView(frame: CGRectMake(0,registCompont.frame.height*0.6+2,registCompont.frame.width,1))
        linephone.backgroundColor = RGB(151, g: 151, b: 151)
        
        self.registCompont.addSubview(phonenumber)
        self.registCompont.addSubview(linephone)
        
        
        //        验证码
        
        vercode = UITextField(frame:CGRectMake(2,registCompont.frame.height*0.63+2,registCompont.frame.width-registCompont.frame.width*0.3,registCompont.frame.height*0.3))
        vercode.attributedPlaceholder = NSAttributedString(string: "验证码", attributes: [NSForegroundColorAttributeName:UIColor.whiteColor()])
        vercode.tintColor = RGB(84, g: 150, b: 136)
        vercode.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0)
        vercode.keyboardType = .DecimalPad
        
        getvercodeBtn = UIButton(frame: CGRectMake(registCompont.frame.width*0.7,registCompont.frame.height*0.63+registCompont.frame.height*0.3-32,registCompont.frame.width*0.3,32))
        getvercodeBtn.setBackgroundImage(colorToImage(RGB(147, g:147, b: 147), size:  getvercodeBtn.frame.size), forState: UIControlState.Normal)
        getvercodeBtn.setBackgroundImage(colorToImage(RGB(165, g: 165, b: 165), size:  getvercodeBtn.frame.size), forState: UIControlState.Selected)
        getvercodeBtn.titleLabel?.font = UIFont.systemFontOfSize(12)
        
        getvercodeBtn.setTitle("获取验证码", forState: UIControlState.Normal)
        getvercodeBtn.layer.masksToBounds = true
        getvercodeBtn.layer.cornerRadius = 5
        
        
        getvercodeBtn.addTarget(self, action: "click:", forControlEvents: UIControlEvents.TouchUpInside)
        
       
         registCompont.addSubview(getvercodeBtn)
        
        registCompont.addSubview(vercode)
        
        self.addSubview(registCompont)
    }
    
    func initview(){
       register = UIButton(frame: CGRectMake(frame.width*0.2, frame.height*0.5, frame.width*0.6, 40))
        
        
       register.setBackgroundImage(colorToImage(RGB(84, g: 150, b: 136), size: register.frame.size), forState: UIControlState.Normal)
      register.setBackgroundImage(colorToImage(RGB(103, g: 173, b: 158), size: register.frame.size), forState: UIControlState.Selected)
        
        register.setTitle("注册", forState: UIControlState.Normal)
        register.addTarget(self, action: "register:", forControlEvents: UIControlEvents.TouchUpInside)
        let laygister = register.layer
        laygister.masksToBounds = true
        laygister.cornerRadius = 5
        
        self.addSubview(register)
        
    }

//    获取验证码
    func click(btn:UIButton){
        let phone = phonenumber.text!  as String
        SMSSDK.getVerificationCodeByMethod(SMSGetCodeMethodSMS, phoneNumber: phone, zone: "86", customIdentifier: "来自通讯录") { (error) -> Void in
            
            if((error == nil)){
//               执
            }else{
                  MessageNotice.showNotice("验证码获取错误！")
            }
        
        }
    }
    
    func register(btn:UIButton){
      
        
        let code  = vercode.text! as String
        let phone = phonenumber.text!  as String
        let name = username.text! as String
        
        if(name.characters.count>0 && phone.characters.count>0 && code.characters.count>0){
            
            checkcode(name, phone: phone, code: code)
            
        }else{
                MessageNotice.showNotice("用户名电话出错！")
        }
       
    
        
        
        
    }
    
//    验证码验证,shi
    func checkcode(name:String,phone:String,code:String){
        SMSSDK.commitVerificationCode(code, phoneNumber: phone, zone: "86") { (error) -> Void in
            
            if((error == nil)){
                
                Register.getInstance().userRegister(name, phone: phone, callback: { (taken, result, msg) -> Void in
                    if(result == "0"){
                        tak = taken
                        HYKeychain.set("name", value: name)
                        HYKeychain.set("passwd", value: phone)
                        //                        跳转到主页面
                        self.delegate.gotomain()
                        
                        
                    }else{
                        MessageNotice.showNotice("登陆失败！")
                    }
                })
                
                
            }else{
                
                MessageNotice.showNotice("验证码验证错误！")
                
            }
            
        }

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}


protocol vercodefy{
    func gotomain()
}
