//
//  AppDelegate.swift
//  WeiBoExercise
//
//  Created by lx on 16/9/19.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

import UIKit




//新特性页面进入未登录页面的通知名字
let FeatrueToNotLoginInterface : String = "featrueToNotLoginInterface"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    
//    let path : String = "linshouzhe"

    

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        
        //设置项目的 系统色调 为橘色
        UINavigationBar.appearance().tintColor = UIColor.orangeColor()
        UITabBar.appearance().tintColor =  UIColor.orangeColor()
        
        /**
        因为我使用的是storyBoard加载视图控制器，刚开始以为在这里改变window的根控制器会没有效果，不过经过尝试，发现这样是可以的。非常棒。

        */
        /**
        注册通知中心观察者，观察是否点击了进入微博按钮。

        */
        
        
        
        window?.rootViewController = loadRootViewController()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "featrueToNotLoginInterface:", name:FeatrueToNotLoginInterface, object: nil)
        
        
        
        return true
    }

    func loadRootViewController() -> UIViewController {
        
        
        if SZAccountModel.userLoginState() {
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "SZWelcome", bundle: nil)
            let welcomeVC : SZWelcomeVC = storyBoard.instantiateInitialViewController() as! SZWelcomeVC
            
            
            return welcomeVC
        }
        

        if isFirstTimeOrNot()
        {
        
            return SZNewFeatureCollectionVC()
        }
        else
        {
        
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let notLoginInterface : SZMainTabBarVC = storyBoard.instantiateInitialViewController() as! SZMainTabBarVC
            
            return notLoginInterface
            
        }
        
        
//        return isFirstTimeOrNot() ? SZNewFeatureCollectionVC() : SZHomeNaviVC()
        
        
    }
    
    
    
    //用偏好设置来继续版本判断
    private func isFirstTimeOrNot() -> Bool {
        
        
        //本地的bundle文件中，应该有当前的版本 的版本号
        let currentVersion = NSBundle.mainBundle().infoDictionary!["CFBundleShortVersionString"] as! String
        
        
        //用偏好设置 UserDefault 方式来获取到 在沙盒中默认存储的 版本号

        let sandBoxVersion = NSUserDefaults.standardUserDefaults().objectForKey("CFBundleShortVersionString") as? String ?? ""
        
        //比较 当前的app版本号，和沙盒中存储的版本号，如果前面这个比较大，就应该是新版， 走新特性

        if currentVersion.compare(sandBoxVersion) == NSComparisonResult.OrderedDescending {

            NSUserDefaults.standardUserDefaults().setObject(currentVersion, forKey: "CFBundleShortVersionString")
            
            //说明是新版本，进入新特性页面。
            return true
            
        }
        
        
        
        return false
        
    }
    
    //MARK: - 通知中心相应方法
    
    func featrueToNotLoginInterface(notification : NSNotification)
    {
        
    
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let notLoginInterface : SZMainTabBarVC = storyBoard.instantiateInitialViewController() as! SZMainTabBarVC
        
        window?.rootViewController = notLoginInterface
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

