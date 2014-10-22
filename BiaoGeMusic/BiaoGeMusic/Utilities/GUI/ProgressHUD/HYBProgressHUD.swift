//
//  ProgressHUD.swift
//  BiaoGeMusic
//
//  Created by ljy-335 on 14-10-21.
//  Copyright (c) 2014年 uni2uni. All rights reserved.
//

import Foundation
import UIKit

///
/// @brief 定制显示通知的视图HUD
/// @author huangyibiao
class HYBProgressHUD: UIView {
    var hud: UIToolbar?
    var spinner: UIActivityIndicatorView?
    var imageView: UIImageView?
    var titleLabel: UILabel?
    
    ///
    /// @brief 单例方法，只允许内部调用
   private class func sharedInstance() ->HYBProgressHUD {
        struct Instance {
            static var onceToken: dispatch_once_t = 0
            static var instance: HYBProgressHUD?
        }
        
        dispatch_once(&Instance.onceToken, { () -> Void in
            Instance.instance = HYBProgressHUD()
        })
        
        return Instance.instance!
    }
    
    override init() {
        super.init()
        
        self.frame = UIScreen.mainScreen().bounds
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    ///
    /// 公开方法
    ///
    
    /// 显示信息
    class func show(message: String) {
        HYBProgressHUD.sharedInstance()
    }
    
    /// 显示成功信息
    class func showSuccess(message: String) {
    
    }
    
    /// 显示出错信息
    class func showError(message: String) {
        
    }
    
    /// 隐藏
    class func dismiss() {
        
    }
}