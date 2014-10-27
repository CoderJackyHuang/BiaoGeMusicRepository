//
//  NSStringCommonExtension.swift
//  BiaoGeMusic
//
//  Created by ljy-335 on 14-10-21.
//  Copyright (c) 2014年 uni2uni. All rights reserved.
//

import Foundation
import UIKit

///
/// @brief String结构通用功能扩展
/// @author huangyibiao
extension String {
    ///
    /// @brief 获取沙盒路径下的Documents路径
    static func documentPath() ->String {
        return NSHomeDirectory().stringByAppendingPathComponent("Documents")
    }
    
    ///
    /// 描述：把秒数转换成时间
    ///
    /// 参数：seconds 秒数
    static func time(fromSeconds seconds: Int) ->NSString {
        var totalm = seconds / (60);
        var h = totalm / (60);
        var m = totalm % (60);
        var s = seconds % (60);
        
        if (h == 0) {
           return NSString(format: "%02d:%02d", m, s).substringToIndex(5)
        }
        return NSString(format: "%02d:%02d:%02d", h, m, s)
    }
}
