//
//  HYBSongListController.swift
//  BiaoGeMusic
//
//  Created by ljy-335 on 14-10-24.
//  Copyright (c) 2014年 uni2uni. All rights reserved.
//

import Foundation

///
/// 描述：歌手的所有歌曲列表类
///
/// 作者：huangyibiao
class HYBSongListController: HYBRefreshController {
    private var request: AFHTTPRequestOperation?
    private var totalSongs: Int = 0
    private var songListModel: HYBSongListModel?
    
    var singerModel: HYBSingerModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addLeftButton(imageName: "nav_backbtn")
        self.tableView?.height(kScreenHeight - 64.0)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        addTitleView(title: "\(self.singerModel.name)(\(self.singerModel.songs_total))")
        if self.songListModel == nil {
            if self.singerModel.songs_total < 20 {
                self.totalSongs =  self.singerModel.songs_total
            } else {
                self.totalSongs = 20
                self.addRefreshView()
            }
            self.downloadSongList()
        }
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
        self.request?.cancel()
    }
    
    ///
    /// 注明：由于这里不知道接口如何正确使用，没有办法只提取某一页的数据，所以这里干脆就一次提取指定的条数
    func downloadSongList() {
        var path = "/v1/restserver/ting?from=android&version=2.4.0&method=baidu.ting.artist.getSongList&format=json&order=2&tinguid=\(self.singerModel.ting_uid)&offset=0&limits=\(self.totalSongs)"
        HYBProgressHUD.show(kLoadingMsg)
        self.refreshView?.startLoadingMore()
        request = HYBBaseRequest.songList(path, success: { (songListModels) -> Void in
            if songListModels != nil {
                self.songListModel = songListModels
                self.tableView?.reloadData()
            }
            HYBProgressHUD.dismiss()
            self.refreshView?.stopLoadingMore()
            }, fail: { (error) -> Void in
                HYBProgressHUD.showError(kNetworkErrorMsg)
                self.refreshView?.stopLoadingMore()
        })
    }
    
    ///
    /// RefreshViewDelegate
    ///
    override func refresh(refreshView: RefreshView, didClickButton button: UIButton) {
        if self.totalSongs < self.singerModel.songs_total {
            self.totalSongs += 20
            self.downloadSongList()
        } else {
            self.refreshView?.removeFromSuperview()
            self.tableView?.tableFooterView = nil
        }
    }
    
    ///
    /// UITableViewDatasource
    ///
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let list = self.songListModel {
            return list.songList.count
        }
        return 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "HYBSingerCellIdentifier"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? HYBSongCell
        
        if cell == nil {
            cell = HYBSongCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: cellIdentifier)
        }
        
        if let list = self.songListModel {
            if indexPath.row < list.songList.count {
                if var model = list.songList[indexPath.row] as? HYBSongModel {
                    cell!.configureCell(model)
                }
            }
        }
        
        return cell!
    }
    
    ///
    /// UITableViewDelegate
    ///
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60.0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var songModel = self.songListModel?.songList.objectAtIndex(indexPath.row) as? HYBSongModel
        
        var musicPlayController = HYBSongPlayController.sharedMusicPlayController()
        musicPlayController.songModel = songModel
        musicPlayController.songListModelArray = self.songListModel!.songList
        musicPlayController.currentIndex = indexPath.row
        
        musicPlayController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(musicPlayController, animated: true)
    }
}