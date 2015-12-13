//
//  MessageNotice.swift
//  adressbook
//
//  Created by hexiangpeng on 15/11/8.
//  Copyright © 2015年 huayuan. All rights reserved.
//

import UIKit

class MessageNotice: NSObject {
    static let window = UIApplication.sharedApplication().windows.last?.rootViewController
    
    static func showNotice(text:String){
        
        let viewmsg = UIView(frame: CGRectMake((window?.view.bounds.width)!*0.5-100,(window?.view.bounds.height)!-70,200,40))
        let label = UILabel(frame: CGRectMake(50,5,100,30))
      
        
        
        
        label.backgroundColor = UIColor.clearColor()
        label.textColor = UIColor.blackColor()
        label.text = text
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .Center
        label.alpha = 0
        viewmsg.alpha = 0
        viewmsg.layer.cornerRadius = 5
        viewmsg.backgroundColor = UIColor.lightGrayColor()
        viewmsg.addSubview(label)
        
        self.window?.view.addSubview(viewmsg)
        
        
        UIView.animateWithDuration(1.5, animations: { () -> Void in
            viewmsg.alpha = 1
            label.alpha = 1
           
            
            }) { (Bool) -> Void in
                
                
            viewmsg.removeFromSuperview()
        }
    }
    
    
    
}
