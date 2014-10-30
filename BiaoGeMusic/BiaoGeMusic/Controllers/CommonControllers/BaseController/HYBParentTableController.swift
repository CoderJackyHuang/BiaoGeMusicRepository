//
//  HYBParentTableController.swift
//  BiaoGeMusic
//
//  Created by ljy-335 on 14-10-21.
//  Copyright (c) 2014年 uni2uni. All rights reserved.
//

import Foundation
import UIKit

///
/// 描述：所有使用到tableView显示数据列表的，都可以继承于此类，专门封装此类来共同处理表格数据列表
///
/// 作者：huangyibiao
class HYBParentTableController:HYBBaseController, UITableViewDelegate, UITableViewDataSource {
    var tableView: UITableView?
    var datasource = NSMutableArray()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView = UITableView(frame: CGRectMake(0, self.originY, kScreenWidth, kMiddleScreenHeight))
        self.view.addSubview(self.tableView!)
        self.tableView?.dataSource = self
        self.tableView?.delegate = self
        self.tableView?.separatorStyle = UITableViewCellSeparatorStyle.None
        self.view.addSubview(self.tableView!)
    }
    
    ///
    /// UITableViewDataSource 代理方法实现
    ///
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("CellIdentifier") as UITableViewCell
        println("子类需要重写")
        return cell
    }
}