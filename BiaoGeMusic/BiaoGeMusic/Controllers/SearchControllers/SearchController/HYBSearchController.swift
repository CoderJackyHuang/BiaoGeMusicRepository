//
//  HYBSearchController.swift
//  BiaoGeMusic
//
//  Created by ljy-335 on 14-10-21.
//  Copyright (c) 2014年 uni2uni. All rights reserved.
//

import Foundation
import UIKit

///
/// 描述：搜索歌手界面
///
/// 作者：huangyibiao
class HYBSearchController: HYBParentTableController, UISearchBarDelegate {
    var searchBar: UISearchBar?
    var request: AFHTTPRequestOperation?
    var songListModels: HYBSongListModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addTitleView(title: "标哥音乐")
        addRightButton(imageName: "nav_music")
        configureLayout()
        
        if let array = HYBSingerModel.top100Songers() {
            self.datasource.addObjectsFromArray(array)
        }
        self.tableView?.reloadData()
    }
    
    ///
    /// 私有方法
    ///
    private func configureLayout() {
        searchBar = UISearchBar(frame: CGRectMake(0, originY, kScreenWidth, 44.0))
        searchBar!.delegate = self
        searchBar!.placeholder = "搜索：歌手"
        searchBar!.showsCancelButton = true
        searchBar!.autocapitalizationType = UITextAutocapitalizationType.None
        searchBar!.autocorrectionType = UITextAutocorrectionType.No
        searchBar!.keyboardType = UIKeyboardType.Default
        self.view.addSubview(searchBar!)
        
        self.tableView!.originY(searchBar!.bottomY())
        self.tableView!.height(kMiddleScreenHeight - searchBar!.height())
    }
    
    ///
    /// UISearchBarDelegate 代理方法
    ///
    
    /// 点击键盘上的搜索按钮时的回调
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        if datasource.count != 0 {
            datasource.removeAllObjects()
        }
        
        HYBProgressHUD.show("")
        requestSingersData()
    }
    
    ///
    /// 私有铺助方法区
    ///
    
    ///
    /// @brief 获取歌手数据
    private func requestSingersData() {
        var model = HYBSingerModel()
        
        datasource.removeAllObjects()
        // datasource.addObjectsFromArray(model.items(searchBar!.text))
        tableView?.reloadData()
        HYBProgressHUD.dismiss()
        
        if datasource.count > 0 {
            var indexPath = NSIndexPath(forRow: 0, inSection: 0)
            tableView?.scrollToRowAtIndexPath(indexPath,
                atScrollPosition: UITableViewScrollPosition.Top,
                animated: false)
        }
    }
    
    ///
    /// UITableViewDatasource
    ///
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "HYBSingerCellIdentifier"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? HYBSingerCell
        
        if cell == nil {
            cell = HYBSingerCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: cellIdentifier)
        }
        
        if indexPath.row < datasource.count {
            if var model = datasource[indexPath.row] as? HYBSingerModel {
                cell!.configureCell(model)
            }
        }
        
        return cell!
    }
    
    ///
    /// UITableViewDelegate
    ///
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 70.0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var songListController = HYBSongListController()
        var model = self.datasource[indexPath.row] as HYBSingerModel
        songListController.singerModel = model
        songListController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(songListController, animated: true)
    }
}