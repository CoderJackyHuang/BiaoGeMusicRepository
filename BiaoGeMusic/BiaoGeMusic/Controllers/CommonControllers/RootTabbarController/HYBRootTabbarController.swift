//
//  HYBRootTabbarController.swift
//  BiaoGeMusic
//
//  Created by ljy-335 on 14-10-21.
//  Copyright (c) 2014年 uni2uni. All rights reserved.
//

import Foundation
import UIKit

///
/// @brief 标签栏控制器，程序入口处
/// @author huangyibiao
class HYBRootTabbarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var myMusic = UINavigationController(rootViewController: HYBMyMusicController())
        myMusic.tabBarItem.title = "我的音乐"
        myMusic.tabBarItem.image = UIImage(named: "mymusci")
        var search = UINavigationController(rootViewController: HYBSearchController())
        search.tabBarItem.title = "搜索"
        search.tabBarItem.image = UIImage(named: "tabbarSearch")
        var tudou = UINavigationController(rootViewController: HYBTudouController())
        tudou.tabBarItem.title = "土豆视频"
        tudou.tabBarItem.image = UIImage(named: "tabbarMovie")
        
        self.viewControllers = [myMusic, search, tudou]
    }
}