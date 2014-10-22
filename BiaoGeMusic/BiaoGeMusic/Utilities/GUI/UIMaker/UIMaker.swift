//
//  UIMaker.swift
//  BiaoGeMusic
//
//  Created by ljy-335 on 14-10-21.
//  Copyright (c) 2014年 uni2uni. All rights reserved.
//

import Foundation
import UIKit

/// @brief 控件生成器类
/// @author huangyibiao
/// @date 2014-10-22
class UIMaker {
    ///
    /// @brief 生成按钮
    ///
    class func button(#imageName: String, target: AnyObject?, action: Selector) ->UIButton {
        var img = UIImage(named: imageName)
        var button = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        button.frame = CGRectMake(0, 0, img.size.width, img.size.height)
        button.addTarget(target, action: action, forControlEvents: UIControlEvents.TouchUpInside)
        button.setImage(UIImage(named: imageName), forState: UIControlState.Normal)
        button.imageView?.contentMode = UIViewContentMode.ScaleAspectFill
        return button
    }
    
    ///
    /// @brief 生成标签
    ///
    class func label(frame: CGRect, title: String?) ->UILabel {
        var label = UILabel(frame: frame)
        label.backgroundColor = UIColor.clearColor()
        label.textAlignment = NSTextAlignment.Center
        label.textColor = UIColor.whiteColor()
        label.font = UIFont.systemFontOfSize(14.0)
        label.text = title
        
        return label
    }
}
