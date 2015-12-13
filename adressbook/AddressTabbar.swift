//
//  AddressTabbar.swift
//  adressbook
//
//  Created by hexiangpeng on 15/11/5.
//  Copyright © 2015年 huayuan. All rights reserved.
//

import UIKit

protocol clicplus{
    func plusisclik()
}

class AddressTabbar: UITabBar {

    var clic:clicplus!
    var plusButton:UIButton = UIButton()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let width = self.frame.width / 3
        
        var index:Int = 0
        for l in 0...self.subviews.count - 1
        {
            if l == 2
            {
                index++
            }
            if self.subviews[l].isKindOfClass(NSClassFromString("UITabBarButton")!)
            {
                let childButton:UIView = self.subviews[l]
                childButton.frame = CGRectMake(width * CGFloat(index), childButton.frame.minY, self.frame.width / 3, self.frame.height)
                index++
            }
        }
        addpusButon()
        

    }
    
    
    func addpusButon(){

        
        
        plusButton.addTarget(self, action: "clickplus:", forControlEvents: UIControlEvents.TouchUpInside)
        plusButton.frame.size = CGSize(width: 70, height: 50)
        plusButton.center = CGPointMake(self.frame.width * 0.5, self.frame.height * 0.5)
        plusButton.layer.masksToBounds = true
        plusButton.layer.cornerRadius = 4
        
         plusButton.setImage(UIImage(named: "plusbutton"), forState: UIControlState.Normal)
        
        plusButton.setBackgroundImage(colorToImage(RGB(84, g: 150, b: 136), size: plusButton.frame.size), forState: UIControlState.Normal)
        plusButton.setBackgroundImage(colorToImage(RGB(101, g: 98, b: 132), size: plusButton.frame.size), forState: UIControlState.Selected)
        self.addSubview(plusButton)
    }
    
    
    func clickplus(btn:UIButton){
//        print("ok")
        clic.plusisclik()
        
//             noticeOnSatusBar("ok", autoClear: false, autoClearTime: 1)
    }
    
    
    
        
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
