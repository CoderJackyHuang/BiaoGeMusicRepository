//
//  HYBBaseController.swift
//  BiaoGeMusic
//
//  Created by ljy-335 on 14-10-21.
//  Copyright (c) 2014年 uni2uni. All rights reserved.
//

import UIKit

///
/// @brief  最顶层根类视图控制器，所有视图控制器都要直接或者间接继承于此类
/// @author huangyibiao
/// @date   2014-10-22
class HYBBaseController: UIViewController {
    var originY: CGFloat = 64.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureLayout()
    }
    
    private func configureLayout() {
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.backgroundColor = kNavColor
        self.navigationController?.navigationBar.barTintColor = kNavColor
        
        // 设置状态栏字体颜色为白色
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
    }
    
    ///
    /// 公开方法，定制导航条使用到的方法
    ///
    
    ///
    /// @brief 添加或者修改导航的标题
    func addTitleView(#title: String) {
        self.navigationItem.titleView?.removeFromSuperview()
        self.navigationItem.titleView = nil
        
        var titleLabel = UIMaker.label(CGRectMake(90, 0, kScreenWidth - 90 * 2, kNavigationBarHeight), title: title)
        titleLabel.font = UIFont.boldSystemFontOfSize(18.0)
        self.navigationItem.titleView = titleLabel
    }
    
    ///
    /// @brief 添加返回按钮
    func addLeftButton(imageName: String = "nav_backbtn") {
      var button = UIMaker.button(imageName: imageName, target: self, action: "onLeftButtonClicked:")
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
    }
    
    ///
    /// @brief 点击返回按钮
    func onLeftButtonClicked(sender: UIButton) {
        self.navigationController?.popViewControllerAnimated(true)
        println("让子类重写")
    }
    
    ///
    /// @brief 添加右侧按钮
    func addRightButton(#imageName: String) {
       var button = UIMaker.button(imageName: imageName, target: self, action: "onRightButtonClicked:")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
    }
    
    ///
    /// @brief 点击右侧按钮
    func onRightButtonClicked(sender: UIButton) {
        println("让子类重写")
    }
}
