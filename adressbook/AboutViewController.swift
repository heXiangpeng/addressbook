//
//  AboutViewController.swift
//  adressbook
//
//  Created by hexiangpeng on 15/11/22.
//  Copyright © 2015年 huayuan. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {
    
    var img:UIImageView!
    
    
 
    var textview:UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        
        let lable = UILabel(frame: CGRectZero)
        lable.backgroundColor = UIColor.clearColor()
        lable.textColor = UIColor.whiteColor()
        lable.text = "关于我们"
        self.navigationItem.titleView = lable
        lable.sizeToFit()
        
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back"), style: UIBarButtonItemStyle.Plain, target: self, action: "back")
        
        img = UIImageView(frame: CGRectMake(self.view.frame.width*0.5-50, 30, 100, 100))
        
        img.backgroundColor = UIColor.purpleColor()
        self.view.addSubview(img)
        
        
        textview = UITextView(frame: CGRectMake(0, 130, 100, 100))
        
        textview.text = "一个个人的产品"
        self.view.addSubview(textview)
        
        
        
        
        
        
        
        
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.tabBar.hidden = true
    }
    
    
    override func viewWillDisappear(animated: Bool) {
         self.tabBarController?.tabBar.hidden = false
    }

    
    func back(){
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    


}
