//
//  HYAlertView.swift
//  adressbook
//
//  Created by hexiangpeng on 15/11/21.
//  Copyright © 2015年 huayuan. All rights reserved.
//

import UIKit

class HYAlertView: UIView {
    
    var contentview = UIView()
    
    var phone:UITextField!
    var vercode:UITextField!
    
    var button:UIButton!
    
    
    var ensureBtn:UIButton!


    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.whiteColor()
        contentview.backgroundColor = UIColor.whiteColor()
        contentview.frame = CGRect(x:30, y:0, width:frame.width, height:frame.width)
        contentview.layer.cornerRadius = 5
         contentview.layer.masksToBounds = true
        
        
        
        phone = UITextField(frame: CGRectMake(10,10, contentview.frame.width-20,40))
        phone.backgroundColor = RGB(240, g: 240, b: 240)
        phone.layer.cornerRadius = 5
        phone.attributedPlaceholder = NSAttributedString(string: "电话", attributes: [NSForegroundColorAttributeName:UIColor.grayColor()])
        phone.tintColor = RGB(84, g: 150, b: 136)
        //        phone.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0)
        contentview.addSubview(phone)
        
        vercode = UITextField(frame: CGRectMake(10,60,contentview.frame.width-120,40))
        vercode.backgroundColor = RGB(240, g: 240, b: 240)
        vercode.layer.cornerRadius = 5
        vercode.attributedPlaceholder = NSAttributedString(string: "验证码", attributes: [NSForegroundColorAttributeName:UIColor.grayColor()])
        vercode.tintColor = RGB(84, g: 150, b: 136)
        //        vercode.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0)
        
        contentview.addSubview(vercode)
        
        button = UIButton(frame: CGRectMake(contentview.frame.width-110,60,100,40))
        button.setTitle("获取验证码", forState: UIControlState.Normal)
        
        button.backgroundColor = RGB(84, g: 150, b: 136)
        button.layer.cornerRadius = 5
        
        
        contentview.addSubview(button)
        
        
        ensureBtn = UIButton(frame: CGRectMake(10,105,contentview.frame.width-20,40))
        
        ensureBtn.backgroundColor = UIColor.blueColor()
        
        ensureBtn.setTitle("确定", forState: UIControlState.Normal)
        
        contentview.addSubview(ensureBtn)
        
        self.addSubview(contentview)
        
        
        
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
