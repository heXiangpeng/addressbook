//
//  AppDelegate.swift
//  adressbook
//
//  Created by hexiangpeng on 15/11/4.
//  Copyright © 2015年 huayuan. All rights reserved.
//

import UIKit

func RGB(r:CGFloat,g:CGFloat,b:CGFloat) -> (UIColor)
{
    return UIColor(red: (r/255) as CGFloat, green: (g/255) as CGFloat, blue: (b/255) as CGFloat, alpha: 1)
}

var tak = ""

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    var splash:SplashViewController!
    
    //    接入第三方
    func interfaceThirdServer(){
        /**
        *  设置ShareSDK的appKey，如果尚未在ShareSDK官网注册过App，请移步到http://mob.com/login 登录后台进行应用注册，
        *  在将生成的AppKey传入到此方法中。
        *  方法中的第二个参数用于指定要使用哪些社交平台，以数组形式传入。第三个参数为需要连接社交平台SDK时触发，
        *  在此事件中写入连接代码。第四个参数则为配置本地社交平台时触发，根据返回的平台类型来配置平台信息。
        *  如果您使用的时服务端托管平台信息时，第二、四项参数可以传入nil，第三项参数则根据服务端托管平台来决定要连接的社交SDK。
        */
        
        ShareSDK.registerApp("c4e26cd40308",
            
            activePlatforms: [SSDKPlatformType.TypeSinaWeibo.rawValue,
                SSDKPlatformType.TypeTencentWeibo.rawValue,
                SSDKPlatformType.TypeFacebook.rawValue,
                SSDKPlatformType.TypeQQ.rawValue,
                SSDKPlatformType.TypeWechat.rawValue,],
            onImport: {(platform : SSDKPlatformType) -> Void in
                
                switch platform{
                    
                case SSDKPlatformType.TypeWechat:
                    ShareSDKConnector.connectWeChat(WXApi.classForCoder())
                    
                case SSDKPlatformType.TypeQQ:
                    ShareSDKConnector.connectQQ(QQApiInterface.classForCoder(), tencentOAuthClass: TencentOAuth.classForCoder())
                default:
                    break
                }
            },
            onConfiguration: {(platform : SSDKPlatformType,appInfo : NSMutableDictionary!) -> Void in
                switch platform {
                    
                case SSDKPlatformType.TypeSinaWeibo:
                    //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                    appInfo.SSDKSetupSinaWeiboByAppKey("568898243",
                        appSecret : "38a4f8204cc784f81f9f0daaf31e02e3",
                        redirectUri : "http://www.sharesdk.cn",
                        authType : SSDKAuthTypeBoth)
                    break
                    
                case SSDKPlatformType.TypeWechat:
                    //设置微信应用信息
                    appInfo.SSDKSetupWeChatByAppId("wx666c2f7278ee0df4", appSecret: "d4624c36b6795d1d99dcf0547af5443d")
                    break
                    
                case SSDKPlatformType.TypeTencentWeibo:
                    //设置腾讯微博应用信息，其中authType设置为只用Web形式授权
                    appInfo.SSDKSetupTencentWeiboByAppKey("801307650",
                        appSecret : "ae36f4ee3946e1cbb98d6965b0b2ff5c",
                        redirectUri : "http://www.sharesdk.cn")
                    break
                    
                case SSDKPlatformType.TypeQQ:
                    //设置QQ应用信息
                    appInfo.SSDKSetupQQByAppId("1104972354", appKey: "5hub1j48VRBSqmGK",  authType: SSDKAuthTypeBoth)
                    
                    break
                    
                default:
                    break
                    
                }
        })
        
        
        
    }
    
    
    
//    创建数据库和表
    func createdatabase(){
        SqliteOpertion.getInstance().createDataBase()
//        SqliteOpertion.getInstance().createTable()
        
    }
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        dispatch_async(dispatch_get_global_queue(0, 0)) { () -> Void in
            self.interfaceThirdServer()
            self.createdatabase()
        }
        
        
        SMSSDK.registerApp("d44ed54860e0", withSecret: "783daf05b9d63f14f87a2d39575b9f29")
        
        
        
        if( HYKeychain.get("name") == nil || HYKeychain.get("passwd") == nil ){
            
            splash = SplashViewController()
            
            let navsplash = UINavigationController(rootViewController: splash)
            
            window?.rootViewController = navsplash
        }else{
            
            let name = HYKeychain.get("name") as! String
            let pass = HYKeychain.get("passwd") as! String
            Register.getInstance().userLogin(name, phone: pass, callback: { (taken, result, msg) -> Void in
                if (result == 0){
                    tak = taken
                    
                    let tabbar = AddressBookTabBarControllerViewController()
                    
                    
                    self.window?.rootViewController = tabbar
                }else{
                    self.window?.rootViewController = UINavigationController(rootViewController: SplashViewController())
                }
               
            })
            
            
        }
        return true
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}

