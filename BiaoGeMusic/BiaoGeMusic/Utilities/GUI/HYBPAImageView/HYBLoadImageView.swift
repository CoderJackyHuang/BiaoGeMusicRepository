//
//  HYBPAImageView.swift
//  BiaoGeMusic
//
//  Created by ljy-335 on 14-10-23.
//  Copyright (c) 2014年 uni2uni. All rights reserved.
//

import Foundation

///
/// 描述：图片加载
///
/// 作者：huangyibiao
class HYBLoadImageView: UIImageView {
    /// 是否显示成圆形头像
    var isCircle: Bool {
        get {
            return self.isCircle
        }
        set {
            if newValue == true {
                self.layer.cornerRadius = CGRectGetWidth(self.bounds) / 2.0
            } else {
                self.layer.cornerRadius = 0.0
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.masksToBounds = false
        self.clipsToBounds = true
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    ///
    /// 公开方法
    ///
    
    ///
    /// 要求传一个参数：
    /// urlString 请求网址
    func setImageURL(urlString: NSString?) {
        self.setImageURL(urlString, placeholder: "")
    }
    
    ///
    /// 要求传二个参数：
    /// urlString 请求网址
    /// placeholder 占位图片
    func setImageURL(urlString: NSString?, placeholder: NSString) {
        self.setImageURL(urlString, placeholder: placeholder, errorPlaceholder: nil)
    }
    
    /// 
    /// 要求传三个参数：
    /// urlString 请求网址
    /// placeholder 占位图片
    /// errorPlaceholder 加载失败时的占位图片
    func setImageURL(urlString: NSString?, placeholder: NSString, errorPlaceholder: NSString?) {
        if let url = urlString {
            self.sd_setImageWithURL(NSURL(string: url), placeholderImage: UIImage(named: placeholder), options: SDWebImageOptions.DelayPlaceholder, completed: { (image, error, cacheType, URL) -> Void in
                if error != nil && errorPlaceholder != nil {
                    self.image = UIImage(named: errorPlaceholder!)
                } else if image != nil {
                    self.image = image
                } else {
                    self.image = UIImage(named: placeholder)
                }
            })
        } else {
           self.image = UIImage(named: placeholder)
        }
    }
    
    ///
    /// 私有方法
    ///
    
    /// 把角度转换成进度
    private func radius(degrees: CGFloat) -> CGFloat {
        return degrees / (180.0 / CGFloat(M_PI))
    }
}