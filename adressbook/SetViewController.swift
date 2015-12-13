//
//  SetViewController.swift
//  adressbook
//
//  Created by hexiangpeng on 15/11/13.
//  Copyright © 2015年 huayuan. All rights reserved.
//

import UIKit

class SetViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {


    var rightView:UIView!
    var btnSina:UIButton!
    var btnQQ:UIButton!
    var btnWexin:UIButton!
    
    var isShow = false
    
    
    var setTable:UITableView!
    let fir = ["我的二维码","分享应用","修改我的手机号","关于"]
    let iconfir = ["qrcode","share","change","about"]
    let set = ["注销登录"]
    let iconsec = ["exit"]
    

    var ob:[NSArray]!
    var icon:[NSArray]!
    
    let alert = HYAlertViewController()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "navback"), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController!.navigationBar.translucent = false
        let lable = UILabel(frame: CGRectZero)
        lable.backgroundColor = UIColor.clearColor()
        lable.textColor = UIColor.whiteColor()
        lable.text = "设置"
        self.navigationItem.titleView = lable
        lable.sizeToFit()


        self.view.backgroundColor = UIColor.whiteColor()
       
        
        initRightView()
        
        ob = [fir,set]
        icon = [iconfir,iconsec]
        setTable = UITableView(frame: CGRectMake(0, 0, self.view.frame.width, self.view.frame.height), style: UITableViewStyle.Grouped)
        setTable.backgroundColor = UIColor.whiteColor()
        
        setTable.style 
        setTable.dataSource = self
        setTable.delegate = self
        setTable.rowHeight = 50
        
        self.view.addSubview(setTable)
        
        
       let window =  UIApplication.sharedApplication().keyWindow
        
        
        // Do any additional etup after loading the view.
    }
    
    func initRightView(){
        rightView = UIView(frame: CGRectMake(self.view.bounds.width-60,0,60,self.view.bounds.height))
        
        btnSina = UIButton(frame: CGRectMake(5,self.view.bounds.height*0.2,50,50))
        btnSina.setBackgroundImage(UIImage(named: "sina"), forState: UIControlState.Normal)
        btnSina.setBackgroundImage(UIImage(named: "sinaselect"), forState: .Selected)
        btnSina.addTarget(self, action: "sharebysina:", forControlEvents: UIControlEvents.TouchUpInside)
        rightView.addSubview(btnSina)
        
        btnQQ = UIButton(frame: CGRectMake(5,self.view.bounds.height*0.4,50,50))
        btnQQ.setBackgroundImage(UIImage(named: "QQ"), forState: UIControlState.Normal)
        btnQQ.setBackgroundImage(UIImage(named: "QQselect"), forState: .Selected)
        btnQQ.addTarget(self, action: "sharebyqq:", forControlEvents: UIControlEvents.TouchUpInside)
        rightView.addSubview(btnQQ)
        
        
        btnWexin = UIButton(frame: CGRectMake(5,self.view.bounds.height*0.6,50,50))
        btnWexin.setBackgroundImage(UIImage(named: "weixin"), forState: UIControlState.Normal)
        btnWexin.setBackgroundImage(UIImage(named: "weixinselect"), forState: UIControlState.Selected)
        btnWexin.addTarget(self, action: "sharebywexin:", forControlEvents: UIControlEvents.TouchUpInside)
        rightView.addSubview(btnWexin)
        
        
        
        self.view.addSubview(rightView)
        
        rightView.alpha = 0
    }
    
    func sharebysina(btn:UIButton){
        shareApp(SSDKPlatformType.TypeSinaWeibo)
    }
    
    func sharebyqq(btn:UIButton){
        shareApp(SSDKPlatformType.TypeQQ)
    }
    
    func sharebywexin(btn:UIButton){
        shareApp(SSDKPlatformType.TypeWechat)
    }
    
    
    func shareApp(type:SSDKPlatformType){
        
        
        // 1.创建分享参数
        var shareParames = NSMutableDictionary()
        
        shareParames.SSDKSetupShareParamsByText("分享内容",
            images : UIImage(named: "home"),
            url : NSURL(string:"http://frblo.sinaapp.com"),
            title : "分享App",
            type : SSDKContentType.WebPage)
        
        //2.进行分享
        ShareSDK.share(type, parameters: shareParames) { (state : SSDKResponseState, userData : [NSObject : AnyObject]!, contentEntity :SSDKContentEntity!, error : NSError!) -> Void in
            
            switch state{
                
            case SSDKResponseState.Success:
                print("分享成功")
                let alert = UIAlertView(title: "分享成功", message: "分享成功", delegate: self, cancelButtonTitle: "取消")
                alert.show()
            case SSDKResponseState.Fail:    print("分享失败,错误描述:\(error)")
            case SSDKResponseState.Cancel:  print("分享取消")
                
            default:
                break
            }
        }
        //        let activityController = UIActivityViewController(activityItems: [img], applicationActivities: nil)
        //
        //        presentViewController(activityController, animated: true) { () -> Void in
        //
        //        }
    }
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return ob.count
    }
    
 
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
       return ob[section].count
    }
    

   func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "cell")
    
//        ob[indexPath.section][indexPath.row]
       cell.textLabel?.text = ob[indexPath.section][indexPath.row] as? String
       cell.imageView?.image = UIImage(named: icon[indexPath.section][indexPath.row] as! String)

       return cell
    
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let index = indexPath.section
        let row = indexPath.row
        if index == 0 && row == 0{
            let personcode = PersonalCodeViewController()

            self.navigationController?.pushViewController(personcode, animated: true)
           

            
        }else if(index == 0 && row == 2){
        
//            let alert = HYAlertView(frame: CGRectMake(30,self.view.frame.height*0.5-(self.view.frame.width-80)*0.5,self.view.frame.width-60,self.view.frame.width-80))
//            alert.show()
            
            alert.show()
            
            let tap = UITapGestureRecognizer(target: self, action: "dismiss:")
            
            alert.view.addGestureRecognizer(tap)
           

            
//            self.view.addSubview(alert)
//            self.view.backgroundColor = UIColor.clearColor()
        
        
        
        }else if(index == 0 && row == 3){
            
            
            let per = AboutViewController()
            
            
            self.navigationController?.pushViewController(per, animated: true)
            
        }else if(index == 0 && row == 1){
//        tableview向左移动
            if(isShow == false){
                isShow = true
            UIView.animateKeyframesWithDuration(0.3, delay: 0, options: UIViewKeyframeAnimationOptions.CalculationModeLinear, animations: { () -> Void in
                
                self.setTable.frame.origin.x = -60
                self.rightView.alpha = 1
                
                }, completion: nil)
            }else{
                isShow = false
                UIView.animateKeyframesWithDuration(0.3, delay: 0, options: UIViewKeyframeAnimationOptions.CalculationModeLinear, animations: { () -> Void in
                    
                    self.setTable.frame.origin.x = 0
                    self.rightView.alpha = 0
                    
                    }, completion: nil)
            }
        }else if(index == 1 && row == 0){
           
            print(HYKeychain.delete("name"))
            if(HYKeychain.delete("name") == true || HYKeychain.delete("passwd") == true){
                
               
                let spalash = SplashViewController()
                let splashnav =  UINavigationController(rootViewController: spalash)
                
                self.presentViewController(splashnav, animated: true, completion: { () -> Void in
                    
                })
            }
            
           
        }
    }
    
    
    func dismiss(ges:UIGestureRecognizer){
       
        alert.view.removeFromSuperview()
    }

    
    
  
    
    override func viewWillAppear(animated: Bool) {
//        hidesBottomBarWhenPushed = false
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
