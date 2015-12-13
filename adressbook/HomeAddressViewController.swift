
//  HomeAddressViewController.swift
//  adressbook
//
//  Created by hexiangpeng on 15/11/8.
//  Copyright © 2015年 huayuan. All rights reserved.
//

import UIKit

class HomeAddressViewController: UIViewController,UITableViewDelegate,UITableViewDataSource, dataupdate{
    
    var tableview:HYUitableView!
    var Info:NSMutableArray!
    
    let db = SqliteOpertion()
    
    
    let color = [acolor,bcolor,ccolor,dcolor,ecolor,fcolor]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        let lable = UILabel(frame: CGRectZero)
        lable.backgroundColor = UIColor.clearColor()
        lable.textColor = UIColor.whiteColor()
        lable.text = "首页"
        self.navigationItem.titleView = lable
        lable.sizeToFit()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "navback"), forBarMetrics: UIBarMetrics.Default)
        
        
//        self.tabBarController?.delegate = self
        
        Info = NSMutableArray()
        //        初始化 tableview
        initView()
        
        db.createDataBase()
        //        加载数据
        
        reloadData(0)
        
        
       let tabbar = self.tabBarController as! AddressBookTabBarControllerViewController
        
        tabbar.delegate1 = self
        
        
        
    }
    
    
    func reloadData(type:Int){
        // 从数据库中加载
       
        print(db.query().count)
        if(type == 0 && db.query().count>0){
           
            self.Info = db.query()
            
        }else{
            
            
            
            
            //       从网络中加载数据
            Register.getInstance().getAddressbook(tak) { (result) -> Void in
                
                self.Info = result as NSMutableArray
                
                
            }
            
            
        }
        
        self.tableview.reloadData()
    }
    
    
    
    func initView(){
        
        tableview = HYUitableView(frame: CGRectMake(0, 0,self.view.frame.width, self.view.frame.height))
        
        
        tableview.dataSource = self
        tableview.delegate = self
        tableview.rowHeight = 50
        tableview.registerClass(HomeAddressTableViewCell.self, forCellReuseIdentifier: "cell")
        tableview.tableFooterView = UIView()
        //        tableview.style = UITableViewStyle.Plain
        self.view.addSubview(tableview)
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        tableview.tableViewDisPlayWithMsg("没有电话本数据，请上传", rowcount: Info.count)
        return Info.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableview.dequeueReusableCellWithIdentifier("cell") as! HomeAddressTableViewCell
        
        let randomcolor = random() % color.count
        
        
        cell.firstName.textColor = color[randomcolor]
        let dic = Info[indexPath.row] as! UserAddress
        cell.firstName.text = dic.name.getFirst()
        
        cell.name.text = dic.name.getfromto(1)
        
        let phones = dic.phone.split(":")
        cell.phone.text = phones[0] as String
        
        cell.numberPhone.text = "\(phones.count)"
        
        
        
        return cell
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let dic = Info[indexPath.row] as! UserAddress
        
        
        let phones = dic.phone.split(":")
        
        
        
        let call = UITableViewRowAction(style: UITableViewRowActionStyle.Destructive, title: "消息") { (UITableViewRowAction, NSIndexPath) -> Void in
            
            let sms = "sms://"+phones[0]
            //            let url = s
            
            
            UIApplication.sharedApplication().openURL(NSURL(string: sms)!)
            
        }
        call.backgroundColor = RGB(77, g: 91, b: 31)
        
        
        let mes = UITableViewRowAction(style: UITableViewRowActionStyle.Destructive, title: "电话") { (UITableViewRowAction, NSIndexPath) -> Void in
            
            UIApplication.sharedApplication().openURL(NSURL(string: "tel://"+phones[0])!)
            
        }
        mes.backgroundColor = RGB(84, g: 150, b: 136)
        
        
        let delete = UITableViewRowAction(style: UITableViewRowActionStyle.Destructive, title: "删除") { (UITableViewRowAction, NSIndexPath) -> Void in
            
            
            let alert = UIAlertController(title: "删除", message: "确定删除联系人!", preferredStyle: UIAlertControllerStyle.ActionSheet)
            
            let delete = UIAlertAction(title: "删除", style: UIAlertActionStyle.Default, handler: { (UIAlertAction) -> Void in
                
                
                
                self.Info.removeObjectAtIndex(indexPath.row)
                
                
                print("个数：\(self.Info.count)")
                //                self.tableview.beginUpdates()
                //                self.tableview.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Left)
                //                self.tableview.endUpdates()
               
                Register.getInstance().userUpdate(tak, phone: dic.phone, type: "1")
                
                
                self.db.deletedata(dic.phone)
                //                self.tableview.reloadData()
                self.reloadData(0)
                
            })
            
            
            let cancel = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: { (UIAlertAction) -> Void in
                
            })
            
            alert.addAction(delete)
            alert.addAction(cancel)
            
            self.presentViewController(alert, animated: true, completion: { () -> Void in
                
            })
            
            
        }
        delete.backgroundColor = RGB(244, g: 123, b: 123)
        
        return [delete,call,mes]
    }
    
    
    func update() {
       
        
        
        self.reloadData(0)
    }
    
    override func viewWillAppear(animated: Bool) {
        print("update")
        
        
        self.reloadData(0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
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
