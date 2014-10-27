//
//  HYBSongPlayController.swift
//  BiaoGeMusic
//
//  Created by ljy-335 on 14-10-24.
//  Copyright (c) 2014年 uni2uni. All rights reserved.
//

import Foundation

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
            selector: "applicationDidEnterBackgroundAudioPlayViewUpdateSongInformationNotification",
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
        
 
    }
    
    ///
    /// HYBAudioPlayViewDelegate
    ///
    func audioPlayView(audioView: HYBAudioPlayView, didClickStopAtIndex modelIndex: NSInteger) {
        
    }
}