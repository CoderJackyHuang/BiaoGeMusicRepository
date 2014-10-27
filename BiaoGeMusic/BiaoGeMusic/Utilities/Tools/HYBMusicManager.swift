//
//  HYBMusicManager.swift
//  BiaoGeMusic
//
//  Created by ljy-335 on 14-10-21.
//  Copyright (c) 2014年 uni2uni. All rights reserved.
//

import Foundation

///
/// @brief 音乐文件管理器类
/// @author huangyibiao
class HYBMusicManager {
    var isPlaying = false
    var isApplicationEnterBackground = false;
    
    ///
    /// @brief 单例方法
    class func sharedInstance() ->HYBMusicManager {
        struct Instance {
            static var onceToken: dispatch_once_t = 0
            static var instance: HYBMusicManager? = nil
        }
        
        dispatch_once(&Instance.onceToken, { () -> Void in
            Instance.instance = HYBMusicManager()
            Instance.instance?.copyDatabasePath()
        })
        
        return Instance.instance!
    }
    
    ///
    /// @brief 拷贝音乐数据库路径
    func copyDatabasePath() {
        var path = String.documentPath().stringByAppendingPathComponent("FreeMusic.db")
    
        if !NSFileManager.defaultManager().fileExistsAtPath(path) {
            var srcPath = NSBundle.mainBundle().pathForResource("FreeMusic", ofType: "db")
            if srcPath != nil {
                NSFileManager.defaultManager().copyItemAtPath(srcPath!, toPath: path, error: nil)
            }
        }
        
        /// 初始化数据库
        LKDBHelper.getUsingLKDBHelper().setDBPath(path)
    }
}