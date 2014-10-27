//
//  GlobalDefine.swift
//  BiaoGeMusic
//
//  Created by ljy-335 on 14-10-21.
//  Copyright (c) 2014年 uni2uni. All rights reserved.
//

import Foundation
import UIKit

///
/// 与设备相关的常量
///

/// 获取屏幕的宽和高
let kScreenWidth = UIScreen.mainScreen().bounds.width
let kScreenHeight = UIScreen.mainScreen().bounds.height

/// 获取状态栏的高度
let kStatusBarHeight = UIApplication.sharedApplication().statusBarFrame.height

/// 获取导航条的高度
let kNavigationBarHeight:CGFloat = 44.0

// 中间可以显示的区域的高度
let kMiddleScreenHeight = kScreenHeight - kStatusBarHeight - kNavigationBarHeight - 49

/// 导航颜色
let kNavColor = UIColor(red: 192.0 / 255.0, green: 37.0 / 255.0, blue: 62.0 / 255.0, alpha: 1.0)

///
/// 与请求数据相关的定义
///
let kNetworkErrorMsg = "网络不给力，请检查网络设置"
let kLoadingMsg = "加载中..."