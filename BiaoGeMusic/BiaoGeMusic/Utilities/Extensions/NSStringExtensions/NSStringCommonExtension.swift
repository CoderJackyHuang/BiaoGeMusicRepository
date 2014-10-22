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
}
