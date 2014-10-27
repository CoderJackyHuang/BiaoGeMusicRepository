//
//  HYBRefreshController.swift
//  BiaoGeMusic
//
//  Created by ljy-335 on 14-10-24.
//  Copyright (c) 2014年 uni2uni. All rights reserved.
//

import Foundation

///
/// 描述：追加了上拉加载更多及下拉刷新功能
///
/// 作者：huangyibiao
class HYBRefreshController: HYBParentTableController, RefreshViewDelegate {
    var refreshView: RefreshView?
    var currentPage: Int = 0
    
    ///
    /// 公开方法
    ///
    
    /// 添加显示加载更多，子类需要调用此方法来添加
    func addRefreshView() {
        var array = NSBundle.mainBundle().loadNibNamed("RefreshView", owner: self, options: nil) as NSArray
        self.refreshView = array[0] as? RefreshView
        self.refreshView?.delegate = self
        self.tableView?.tableFooterView = self.refreshView!
    }
    
    
    ///
    /// RefreshViewDelegate
    ///
    func refresh(refreshView: RefreshView, didClickButton button: UIButton) {
        println("子类再重写")
    }
}