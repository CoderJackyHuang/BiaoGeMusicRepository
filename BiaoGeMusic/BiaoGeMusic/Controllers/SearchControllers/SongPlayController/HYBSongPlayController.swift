//
//  HYBSongPlayController.swift
//  BiaoGeMusic
//
//  Created by ljy-335 on 14-10-24.
//  Copyright (c) 2014年 uni2uni. All rights reserved.
//

import Foundation
import UIKit

///
/// 描述：歌曲播放界面
///
/// 作者：huangyibiao
class HYBSongPlayController: HYBBaseController, HYBAudioPlayViewDelegate {
    var currentIndex: Int = 0                        // 当前第几首
    var songListModelArray = NSMutableArray()        // 歌词列表
    var songModel: HYBSongModel?                     // 即将要播放的歌曲
    
    private var currentSongModel: HYBPlaySongModel? // 当前播放的数据模型
    private var audioPlayView: HYBAudioPlayView?
    private var isCurrentPlaying = false            // 当前是否正在播放
    
    ///
    /// 单例模式创建播放类
    ///
    class func sharedMusicPlayController() ->HYBSongPlayController {
        struct Instance {
            static var onceToken: dispatch_once_t = 0
            static var instance: HYBSongPlayController? = nil
        }
        
        dispatch_once(&Instance.onceToken, { () -> Void in
            Instance.instance = HYBSongPlayController()
        })
        
        return Instance.instance!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addLeftButton()
        audioPlayView = HYBAudioPlayView(frame: CGRectMake(0, originY, kScreenWidth, kScreenHeight - 64))
        audioPlayView!.delegate = self
        self.view.addSubview(audioPlayView!)
        
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "applicationDidEnterBackgroundAudioPlayViewUpdateSongInformationNotification:",
            name: kHYBAudioPlayViewUpdateSongInformationNotification,
            object: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if  self.songModel != nil {
            addTitleView(title: self.songModel!.title)
        }
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self,
            name: kHYBAudioPlayViewUpdateSongInformationNotification,
            object: nil)
    }
    
    ///
    /// 公开方法
    ///
    
    ///
    /// 描述：播放歌曲
    ///
    /// 参数：songModel 歌曲数据模型
    func playMusic(#songModel: HYBSongModel) {
        self.isCurrentPlaying = !self.isCurrentPlaying
        self.songModel = songModel
        
        var path = "/data/music/links?songIds=\(songModel.song_id)"
        HYBBaseRequest.songInfo(path, success: { (playSongModel) -> Void in
            if playSongModel != nil {
                self.addTitleView(title: playSongModel!.songName)
                
                self.audioPlayView?.songModel = self.songModel
                self.audioPlayView?.playingSongModel = playSongModel
                self.audioPlayView?.updateLRC()
                HYBMusicManager.sharedInstance().isPlaying = true
                self.currentSongModel = playSongModel
                
                // 设置播放项
                var item = FSPlaylistItem()
                item.title = playSongModel!.songName
                item.url = playSongModel!.songLink
                self.audioPlayView?.setPlaylistItem(item)
                
                if HYBMusicManager.sharedInstance().isApplicationEnterBackground {
                    
                }
            } else {
                HYBProgressHUD.showError("歌词加载失败")
            }
            }) { (error) -> Void in
                HYBProgressHUD.showError("歌词加载失败")
        }
    }
    
    ///
    ///
    ///
    
    ///
    /// 描述：进入后台播放通知
    func applicationDidEnterBackgroundAudioPlayViewUpdateSongInformationNotification(sender: NSNotification) {
        if (NSClassFromString("MPNowPlayingInfoCenter") != nil) {
           
        }
    }
    
    ///
    /// HYBAudioPlayViewDelegate
    ///
    func audioPlayView(audioView: HYBAudioPlayView, didClickStopAtIndex modelIndex: NSInteger) {
        var model: HYBSongModel? = nil
        
        switch (modelIndex) {
        case 0: // 顺序
            currentIndex += 1
            if currentIndex >= songListModelArray.count {
                currentIndex = 0
            }
            model = songListModelArray[currentIndex] as? HYBSongModel
            if model != nil {
                playMusic(songModel: model!)
            }
            break
        case 1: // 随机
            var number = arc4random() % UInt32(songListModelArray.count)
            model = songListModelArray[Int(number)] as? HYBSongModel
            if model != nil {
                playMusic(songModel: model!)
            }
            break
        default: // 单曲循环
            model = self.songModel
            if model != nil {
                playMusic(songModel: model!)
            }
        }
    }
    
    func audioPlayView(audioView: HYBAudioPlayView, didClickPlayButton button: UIButton) {
        playMusic(songModel: self.songModel!)
    }
    
    func audioPlayView(audioView: HYBAudioPlayView, didClickNextButton button: UIButton) {
        if songListModelArray.count != 0 {
            currentIndex++;
            if currentIndex == songListModelArray.count {
                currentIndex = currentIndex - 1
            }
           var model = songListModelArray[currentIndex] as? HYBSongModel
            if model != nil {
                playMusic(songModel: model!)
            }
        }
    }
    
    func audioPlayView(audioView: HYBAudioPlayView, didClickPreviousButton button: UIButton) {
        if songListModelArray.count != 0 {
            currentIndex--;
            if currentIndex < 0 {
                currentIndex = 0
            }
            var model = songListModelArray[currentIndex] as? HYBSongModel
            if model != nil {
                playMusic(songModel: model!)
            }
        }
    }
}