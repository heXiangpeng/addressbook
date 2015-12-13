//
//  NumberPhone.swift
//  adressbook
//
//  Created by hexiangpeng on 15/11/16.
//  Copyright © 2015年 huayuan. All rights reserved.
//

import UIKit

class NumberPhone: UIView {
    var text:String = "0" {
         didSet{
             drawRect(self.frame)
         }
    }
        
    
    

  
    override func drawRect(rect: CGRect) {
        self.backgroundColor = UIColor.whiteColor()
       let context = UIGraphicsGetCurrentContext()
        CGContextSetAllowsAntialiasing(context, true)
         CGContextSetStrokeColorWithColor(context, UIColor.redColor().CGColor) //
        
        
        let img:UIImage = colorToImage(RGB(100, g: 139, b: 169), size: rect.size)
        img.drawAtPoint(CGPointMake(0, 0))
        
        
        
//        //画圆
//        CGContextAddEllipseInRect(context, CGRectMake(rect.size.width*0.5,rect.size.width*0.5,rect.size.width*0.5,rect.size.height*0.5)); //画圆
//        
//        CGContextStrokePath(context) //关闭路径
        
       text.drawAtPoint(CGPointMake(rect.size.width*0.3,rect.size.width*0.2), withAttributes: nil);
        

        
    }


}
