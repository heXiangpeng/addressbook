//
//  HYUitableView.swift
//  adressbook
//
//  Created by hexiangpeng on 15/11/18.
//  Copyright © 2015年 huayuan. All rights reserved.
//

import UIKit

class HYUitableView: UITableView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    
    func tableViewDisPlayWithMsg(msg:String,rowcount:Int){
        
        if(rowcount == 0){
            
            let messagelabel = UILabel()
            messagelabel.text = msg
            messagelabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
            messagelabel.textColor = UIColor.lightGrayColor()
            messagelabel.textAlignment = .Center
            messagelabel.sizeToFit()
            self.backgroundView = messagelabel
            
            self.separatorStyle = .None
            
            
        }else{
            
            self.backgroundView = nil
            self.separatorStyle = .SingleLine
            
        }
        
    }

}
