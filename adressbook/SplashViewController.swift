//
//  SplashViewController.swift
//  adressbook
//
//  Created by hexiangpeng on 15/11/4.
//  Copyright © 2015年 huayuan. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    var splashview:SplashView!
    var loginController:LoginViewController!
    var registerController:RegisterViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        splashview = SplashView(frame: self.view.frame)
        
        splashview.register.addTarget(self, action: "register:", forControlEvents: UIControlEvents.TouchUpInside )
        
        splashview.loginBtn.addTarget(self, action: "login:", forControlEvents: UIControlEvents.TouchUpInside )
        
        
        self.view.addSubview(splashview)
        

      
    }
    
    override func viewWillAppear(animated: Bool) {
         self.navigationController?.setNavigationBarHidden(true, animated: true)
         self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "navback"), forBarMetrics: UIBarMetrics.Default)
//        self.navigationController!.navigationBar.backgroundColor =  RGB(84, g: 150, b: 136)
        self.navigationController!.navigationBar.translucent = false
    }
    
    func login(event:UIEvent){
       
        loginController = LoginViewController()
        self.navigationController?.pushViewController(loginController, animated: true)
        
    
    }
    
    func register(event:UIEvent){
        registerController = RegisterViewController()
        self.navigationController?.pushViewController(registerController, animated: true)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
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
