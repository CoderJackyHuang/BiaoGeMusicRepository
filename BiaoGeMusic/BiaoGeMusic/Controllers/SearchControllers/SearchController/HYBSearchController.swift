//
//  HYBSearchController.swift
//  BiaoGeMusic
//
//  Created by ljy-335 on 14-10-21.
//  Copyright (c) 2014年 uni2uni. All rights reserved.
//

import Foundation
import UIKit

class HYBSearchController: HYBParentTableController, UISearchBarDelegate {
    var searchBar: UISearchBar?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addTitleView(title: "标哥音乐")
        addRightButton(imageName: "nav_music")
        configureLayout()
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
        
        HYBProgressHUD.show("yes")

    }
}