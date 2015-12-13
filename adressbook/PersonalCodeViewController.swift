//
//  PersonalCodeViewController.swift
//  adressbook
//
//  Created by hexiangpeng on 15/11/14.
//  Copyright © 2015年 huayuan. All rights reserved.
//

import UIKit

class PersonalCodeViewController: UIViewController {
    var code:UIImageView!
    var path:String!
    
    var codeview:UIView!
    var labelName:UILabel!
    var labelphone:UILabel!
    var labelnotice:UILabel!
    
    
    
    var qqView:UIButton!
    var weixin:UIButton!
    var sina:UIButton!
    
    
    
    var shareview:UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = RGB(69, g: 69, b: 69)
        
        let lable = UILabel(frame: CGRectZero)
        lable.backgroundColor = UIColor.clearColor()
        lable.textColor = UIColor.whiteColor()
        lable.text = "我的二维码"
        self.navigationItem.titleView = lable
        lable.sizeToFit()
        
      
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back"), style: UIBarButtonItemStyle.Plain, target: self, action: "back")
        
       initview()
        
        let name = HYKeychain.get("name") as? String
        let phone = HYKeychain.get("passwd") as? String
        let text = "huayuan:" + name! + ":" + phone!
        
        let image = createQr(text)
        code.image = image
        labelName.text =  name!
        
        labelphone.text = "电话：" + phone!
        
        
       
    }
    
    
    func initview(){
        codeview = UIView(frame: CGRectMake(20, self.view.frame.height*0.5-self.view.frame.width*0.8, self.view.frame.width-40, self.view.frame.width))
        codeview.backgroundColor = UIColor.whiteColor()
        
        
        labelName = UILabel(frame: CGRectMake(codeview.bounds.width*0.15,5,codeview.bounds.width,20))
        
        labelName.font = UIFont.systemFontOfSize(18)
        labelName.textColor = UIColor.blackColor()
        
        labelphone = UILabel(frame: CGRectMake(codeview.bounds.width*0.15,30,codeview.bounds.width,20))
        labelphone.font = UIFont.systemFontOfSize(14)
        labelphone.textColor = RGB(96, g: 96, b: 96)

        code = UIImageView(frame: CGRectMake(codeview.bounds.width*0.15,55,codeview.bounds.width*0.7,codeview.bounds.width*0.7))
        
        labelnotice = UILabel(frame:  CGRectMake(0,codeview.bounds.width*0.7+55,codeview.bounds.width,20))
        
        labelnotice.textAlignment = .Center
        
        labelnotice.text = "扫一扫上面的二维码，加我通讯录"
        labelnotice.font = UIFont.systemFontOfSize(12)
        labelnotice.textColor = RGB(200, g: 196, b: 196)

        
        codeview.addSubview(labelName)
        codeview.addSubview(labelphone)
          codeview.addSubview(code)
        codeview.addSubview(labelnotice)
      
        codeview.layer.cornerRadius = 5
        
        
        self.view.addSubview(codeview)
        
        
        
        
        shareview = UIView(frame:  CGRectMake(20, self.view.frame.width+self.view.frame.height*0.5-self.view.frame.width*0.75, self.view.frame.width-40, 50))
        
        shareview.backgroundColor = UIColor.blueColor()
        
        
        
        
        
//        self.view.addSubview(shareview)
        
        
        weixin = UIButton(frame: CGRectMake(20, self.view.frame.width+self.view.frame.height*0.5-self.view.frame.width*0.75, 60, 60))
        
        
        qqView = UIButton(frame: CGRectMake(self.view.frame.width*0.5-30, self.view.frame.width+self.view.frame.height*0.5-self.view.frame.width*0.75, 60, 60))
        
        sina = UIButton(frame: CGRectMake(self.view.frame.width-80, self.view.frame.width+self.view.frame.height*0.5-self.view.frame.width*0.75, 60, 60))
        
        
        weixin.setBackgroundImage(UIImage(named: "webview_weixin"), forState: UIControlState.Normal)
        
        qqView.setBackgroundImage(UIImage(named: "webview_qq"), forState: UIControlState.Normal)
        
        sina.setBackgroundImage(UIImage(named: "webview_sinaweibo"), forState: UIControlState.Normal)
        
        weixin.addTarget(self, action: "weixinshare:", forControlEvents: UIControlEvents.TouchUpInside)
        
        qqView.addTarget(self, action: "qqshare:", forControlEvents: UIControlEvents.TouchUpInside)
        sina.addTarget(self, action: "sinashare:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(weixin)
        self.view.addSubview(qqView)
        self.view.addSubview(sina)
        
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
    
    func weixinshare(btn:UIButton){
        let img = screenQrcode()
        sharQrCode(img,type: SSDKPlatformType.TypeWechat)
    }
    
    func qqshare(btn:UIButton){
        let img = screenQrcode()
        sharQrCode(img,type: SSDKPlatformType.TypeQQ)
    }
    
    
    func  sinashare(btn:UIButton){
        let img = screenQrcode()
        sharQrCode(img,type: SSDKPlatformType.TypeSinaWeibo)
    }
    
    func share(){
        
        let img = screenQrcode()
//        sharQrCode(img)
    }
    
    
    
    func screenQrcode() -> UIImage  {
        
        UIGraphicsBeginImageContextWithOptions(codeview.bounds.size, true, 0)    //设置截屏大小
        
        codeview.drawViewHierarchyInRect(codeview.bounds, afterScreenUpdates: true)
        
        
        
       let viewImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
       
       
        
        return viewImage
   

        
        
        
    }
    
    func sharQrCode(img:UIImage,type:SSDKPlatformType){
        
        
        // 1.创建分享参数
        var shareParames = NSMutableDictionary()
        
        shareParames.SSDKSetupShareParamsByText("分享内容",
            images : img,
            url : nil,
            title : "扫我二维码，加通讯录",
            type : SSDKContentType.Image)
        
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
    
    func createQr(qrString:String) -> UIImage{
        
        let stringData = qrString.dataUsingEncoding(NSUTF8StringEncoding)
        
        let qrFilter = CIFilter(name: "CIQRCodeGenerator")
        qrFilter?.setDefaults()
        
        qrFilter?.setValue(stringData, forKey: "inputMessage")
//        qrFilter?.setValue("H", forKey: "inputCorrectionLevel")
        
        let qrImage = qrFilter?.outputImage
        
        let colorFilter = CIFilter(name: "CIFalseColor")
        colorFilter?.setDefaults()
        colorFilter?.setValue(qrImage, forKey: "inputImage")
        colorFilter?.setValue(CIColor(red: 0, green: 0, blue: 0), forKey: "inputColor0")
        colorFilter?.setValue(CIColor(red: 1, green: 1, blue: 1), forKey: "inputColor1")
        
        let codeImage = UIImage(CIImage: (colorFilter?.outputImage!.imageByApplyingTransform(CGAffineTransformMakeScale(5, 5)))!)
        return codeImage
        
        
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
