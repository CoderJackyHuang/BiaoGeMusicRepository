//
//  AppDelegate.swift
//  BiaoGeMusic
//
//  Created by ljy-335 on 14-10-21.
//  Copyright (c) 2014年 uni2uni. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // 初始化数据
        HYBMusicManager.sharedInstance().isPlaying = true
        self.requestSongerInfoToDb(index: 1025)
        
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        // 程序入口
        var rootController = HYBRootTabbarController()
        self.window?.rootViewController = rootController
        return true
    }
    
    private func requestSongerInfoToDb(index: Int = 1025) {
        // 当数据库中没有数据时，请打开这里，当请求到的数据都写入到数据后，请关闭这里
        var path = "/v1/restserver/ting?from=android&version=2.4.0&method=baidu.ting.artist.getinfo&format=json&tinguid=\(index)"
        
//        HYBBaseRequest.singerInfo(path, success: { (singerModel) -> Void in
//            if let model = singerModel {
//                HYBSingerModel.insertToDB(model)
//            }
//            
//            if index < 136085621 {
//                self.requestSongerInfoToDb(index: index + 1)
//            }
//        }) fail: { (error) -> Void in
//            
//        }
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

