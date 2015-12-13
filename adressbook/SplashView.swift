//
//  SplashView.swift
//  adressbook
//
//  Created by hexiangpeng on 15/11/4.
//  Copyright © 2015年 huayuan. All rights reserved.
//

import UIKit

class SplashView: UIView {
    let size = [100,130,100]
    var index = 0
    var loginBtn:UIButton!
    var register:UIButton!
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.whiteColor()
        loginBtn = UIButton(frame: CGRectMake(frame.width*0.05, frame.height*0.8, frame.width*0.4, 40))

        
        loginBtn.setBackgroundImage(colorToImage(RGB(61, g: 59, b: 79), size: loginBtn.frame.size), forState: UIControlState.Normal)
        loginBtn.setBackgroundImage(colorToImage(RGB(101, g: 98, b: 132), size: loginBtn.frame.size), forState: UIControlState.Selected)
        loginBtn.setTitle("登录", forState: UIControlState.Normal)
        let laylogin = loginBtn.layer
        laylogin.masksToBounds = true
        laylogin.cornerRadius = 5
        
        
      
        
        
        
        register = UIButton(frame: CGRectMake(frame.width*0.55, frame.height*0.8, frame.width*0.4, 40))
        
       
        
        register.setBackgroundImage(colorToImage(RGB(84, g: 150, b: 136), size: loginBtn.frame.size), forState: UIControlState.Normal)
        register.setBackgroundImage(colorToImage(RGB(103, g: 173, b: 158), size: loginBtn.frame.size), forState: UIControlState.Selected)
        
        register.setTitle("注册", forState: UIControlState.Normal)
        let layregister = register.layer
        layregister.masksToBounds = true
        layregister.cornerRadius = 5
        
      
   
     
        
        
        
        self.addSubview(loginBtn)
        self.addSubview(register)
        
        }
    
    
    
       
    
    func spinAndTransform() {
        // 1
        layer.anchorPoint = CGPointMake(0.5, 0.6)
        
        // 2
        let rotationAnimation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.toValue = CGFloat(M_PI * 2.0)
        rotationAnimation.duration = 0.45
        rotationAnimation.removedOnCompletion = true
//        lay.addAnimation(rotationAnimation, forKey: nil)
//        lay.offset = lay.pointB.x / 2.0
//        
        // 3
//         lay.contract()
    }
  
   
    
    override func drawRect(rect: CGRect) {
        
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
