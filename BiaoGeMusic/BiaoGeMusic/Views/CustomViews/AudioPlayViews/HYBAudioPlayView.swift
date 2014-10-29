//
//  HYBAudioPlayView.swift
//  BiaoGeMusic
//
//  Created by ljy-335 on 14-10-24.
//  Copyright (c) 2014年 uni2uni. All rights reserved.
//

import Foundation

///
/// 描述： 音频播放操作代理
///
/// 作者： huangyibiao
@objc protocol HYBAudioPlayViewDelegate {
    ///
    /// 描述：点击播放按钮的回调函数
    ///
    /// 参数：audioView -- 播放视图  didClickPlayButton 点击的按钮
    optional func audioPlayView(audioView: HYBAudioPlayView, didClickPlayButton button: UIButton)
    ///
    /// 描述：点击下载按钮的回调函数
    ///
    /// 参数：audioView -- 播放视图  didClickDownloadButton 点击的按钮
    optional func audioPlayView(audioView: HYBAudioPlayView, didClickDownloadButton button: UIButton)
    ///
    /// 描述：点击播放前一首按钮的回调函数
    ///
    /// 参数：audioView -- 播放视图  didClickPreviousButton 点击的按钮
    optional func audioPlayView(audioView: HYBAudioPlayView, didClickPreviousButton button: UIButton)
    ///
    /// 描述：点击播放下一首按钮的回调函数
    ///
    /// 参数：audioView -- 播放视图  didClickNextButton 点击的按钮
    optional func audioPlayView(audioView: HYBAudioPlayView, didClickNextButton button: UIButton)
    ///
    /// 描述：点击停止播放按钮的回调函数
    ///
    /// 参数：audioView -- 播放视图  didClickStopAtIndex 播放模式 0表示顺序、1表示随机、2表示单曲
    optional func audioPlayView(audioView: HYBAudioPlayView, didClickStopAtIndex modelIndex: Int)
}

///
/// 描述：播放模式
enum HYBPlaybackMode {
    case OrderMode  // 顺序播放
    case RandomMode // 随机播放
    case SingleMode // 单曲播放
}

///
/// 描述： 音频播放视图
///
/// 作者： huangyibiao
class HYBAudioPlayView: UIView, AudioPlayerDelegate {
    ///
    /// 公开属性
    ///
    var songModel: HYBSongModel!             // 歌曲模型
    var playingSongModel: HYBPlaySongModel!  // 正在播放的歌曲的模型
    var selectedPlaylistItem: FSPlaylistItem!// 当前播放项
    var delegate: HYBAudioPlayViewDelegate?  // 代理
    
    ///
    /// 私有属性
    ///
    private var audioPlayer: AudioPlayer!          // 音频播放类
    private var currentPlaybackTimeLabel: UILabel! // 当前回放时间标签
    private var totalPlaybackTimeLabel: UILabel!   // 总回放时间标签
    private var progressSlider: UISlider!          // 播放进度条
    private var lrcView: HYBSongLRCView!           // 歌词显示
    
    private var playButton: UIButton!              // 播放按钮
    private var preButton: UIButton!               // 播放前一首按钮
    private var nextButton: UIButton!              // 播放下一首按钮
    private var playModeButton: UIButton!          // 播放模式
    private var playListButton: UIButton!          // 播放列表
    private var collectButton: UIButton!           // 收藏按钮
    private var downloadButton: UIButton!          // 下载按钮
    
    private var noLRCLabel: UILabel!               // 无歌词显示时显示的提示语标签
    private var singerHeadImageView: HYBLoadImageView! // 歌手头像
    
    private var hasLRC = false // 是否有歌词
    private var isPlaying = false
    private var progressTimer: NSTimer?
    private var playbackMode: HYBPlaybackMode = HYBPlaybackMode.OrderMode // 默认为顺序播放
    private var playbackModeValue: Int = 0 // 默认为顺序播放
    private var playlistItem: FSPlaylistItem?
    
    ///
    /// 生命周期函数
    ///
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.whiteColor()
        // 注册播放状态改变通知
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "applicationDidEnterBackgroundControlAudioPlayStatus:",
            name: kHYBAudioPlayViewStatusNotifiation,
            object: nil)
        
        self.audioPlayer = AudioPlayer()
        self.audioPlayer.delegate = self
        
        // 当前回放时间标签
        currentPlaybackTimeLabel = UIMaker.label(CGRectMake(5, 5, 50, 25), title: "00:00")
        currentPlaybackTimeLabel.font = UIFont.boldSystemFontOfSize(14.0)
        currentPlaybackTimeLabel.textColor = UIColor.blackColor()
        self.addSubview(currentPlaybackTimeLabel)
        
        // 播放进度条
        progressSlider = UISlider(frame: CGRectMake(currentPlaybackTimeLabel.rightX(),
            18,
            self.width() - 110.0,
            5))
        progressSlider.continuous = true
        progressSlider.minimumTrackTintColor = UIColor(red: 244.0 / 255.0, green: 147.0 / 255.0, blue: 23.0 / 255.0, alpha: 1.0)
        progressSlider.maximumTrackTintColor = UIColor.lightGrayColor()
        progressSlider.setThumbImage(UIImage(named: "player-progress-point-h"), forState: UIControlState.Normal)
        self.addSubview(progressSlider)
        
        // 总回放时间标签
        totalPlaybackTimeLabel = UIMaker.label(CGRectMake(progressSlider.rightX(), 5, 50, 25), title: "00:00")
        totalPlaybackTimeLabel.font = UIFont.boldSystemFontOfSize(14.0)
        totalPlaybackTimeLabel.textColor = UIColor.blackColor()
        self.addSubview(totalPlaybackTimeLabel)
        
        // 歌词显示视图
        lrcView = HYBSongLRCView(frame: CGRectMake(0, progressSlider.bottomY() + 10, self.width(), self.height() - 100))
        self.addSubview(lrcView)
        
        singerHeadImageView = HYBLoadImageView(frame: CGRectMake((self.width() - 64.0) / 2.0,
            self.height() - 64.0 - 10.0, 64, 64))
        singerHeadImageView.isCircle = true
        self.addSubview(singerHeadImageView)
        
        // 播放按钮
        playButton = UIMaker.button(imageName: "play", target: self, action: "onPlayButtonClicked:")
        playButton.setImage(UIImage(named: "playHight"), forState: UIControlState.Highlighted)
        playButton.frame = CGRectMake((self.width() - 64.0) / 2.0, self.height() - 64.0 - 10.0, 64, 64)
        self.addSubview(playButton)
        
        // 前一首按钮
        preButton = UIMaker.button(imageName: "preSong", target: self, action: "onPreviousButtonClicked:")
        preButton.frame = CGRectMake(playButton.originX() - 60, playButton.originY() + 8, 48, 48)
        self.addSubview(preButton)
        
        // 下一首按钮
        nextButton = UIMaker.button(imageName: "nextSong", target: self, action: "onNextButtonClicked:")
        nextButton.frame = CGRectMake(playButton.originX() + 70, playButton.originY() + 8, 48, 48)
        self.addSubview(nextButton)
        
        // 播放模式按钮
        playModeButton = UIMaker.button(imageName: "order", target: self, action: "onPlayModeButtonClicked:")
        playModeButton.frame = CGRectMake(5, preButton.originY(), 48, 48)
        self.addSubview(playModeButton)
        
        // 播放列表按钮
        playListButton = UIMaker.button(imageName: "playList", target: self, action: "onPlayListButtonClicked:")
        playListButton.frame = CGRectMake(self.width() - 5.0 - 48.0, preButton.originY(), 48, 48)
        self.addSubview(playListButton)
        
        // 收藏按钮
        collectButton = UIMaker.button(imageName: "collect", target: self, action: "onCollectButtonClicked:")
        collectButton.frame = CGRectMake(currentPlaybackTimeLabel.originX(), currentPlaybackTimeLabel.bottomY(), 48, 48)
        self.addSubview(collectButton)
        
        // 下载按钮
        downloadButton = UIMaker.button(imageName: "downLoad", target: self, action: "onDownloadButtonClicked:")
        downloadButton.frame = CGRectMake(self.width() - currentPlaybackTimeLabel.rightX(), totalPlaybackTimeLabel.bottomY(), 48, 48)
        self.addSubview(downloadButton)
        downloadButton.enabled = false
        
        // 无歌词显示标签
        noLRCLabel = UIMaker.label(CGRectMake(0, (self.height() - 25.0) / 2.0, self.width(), 25.0), title: "")
        noLRCLabel.font = UIFont.boldSystemFontOfSize(14.0)
        noLRCLabel.textColor = kNavColor
        self.addSubview(noLRCLabel)
    }
    
    ///
    /// 公开方法
    ///
    
    ///
    /// 描述：调用此方法来触发点击播放按钮，进行音乐播放
    func playMusic() {
        self.isPlaying = !self.isPlaying
        
        switch (self.audioPlayer.state) {
            // 如果当前是暂停播放的状态，则开启继续播放
            // 并启动定时器
        case AudioPlayerState.Paused:
            self.audioPlayer.resume()  // 继续播放
            self.startTimer()
            break
        default:
            self.audioPlayer.pause()
            self.stopTimer()
            break
        }
        
        var imgName = (isPlaying == true ? "pasue" : "play")
        playButton.setImage(UIImage(named: imgName), forState: UIControlState.Normal)
        
        imgName = (isPlaying == true ? "pasueHight" : "playHight")
        playButton.setImage(UIImage(named: imgName), forState: UIControlState.Highlighted)
    }
    
    ///
    /// 描述：指定播放的歌曲
    func setPlaylistItem(item: FSPlaylistItem) {
        if item != self.playlistItem {
            playlistItem = item
            
            self .stopCurrentState()
            var path = String.documentPath().stringByAppendingPathComponent(String(format: "%@/%@/%@.mp3",
                songModel.ting_uid,
                songModel.song_id,
                songModel.song_id))
            if NSFileManager.defaultManager().fileExistsAtPath(path) {
                self.playlistItem?.url = "file://\(path)"
                self.downloadButton.enabled = true
            } else {
                self.downloadButton.enabled = false
            }
            
            self.totalPlaybackTimeLabel.text = String.time(fromSeconds: self.playingSongModel.time.integerValue)
            startToPlayMusic()
            startTimer()
        }
    }
    
    ///
    /// 描述：调用此方法来加载LRC歌曲
    func updateLRC() {
        // 更新歌手头像
        singerHeadImageView.setImageURL(playingSongModel.songPicBig)
        
        if playingSongModel.lrcLink.length != 0 {
            noLRCLabel.text = ""
            
            var path = String.documentPath().stringByAppendingPathComponent(String(format: "%d/%d/%d.lrc",
                songModel.ting_uid,
                songModel.song_id,
                songModel.song_id))
            if NSFileManager.defaultManager().fileExistsAtPath(path) {
                lrcView.parseSong(path)
            } else {
                HYBBaseRequest.songLRC(playingSongModel.lrcLink,
                    ting_uid: songModel.ting_uid.integerValue,
                    song_id: songModel.song_id.integerValue,
                    succss: { (success, path) -> Void in
                        if success {
                            self.lrcView.parseSong(path!)
                            self.hasLRC = true
                        } else {
                            self.noLRCLabel.text = "加载歌词失败"
                            self.hasLRC = false
                        }
                    }, fail: { (error) -> Void in
                        self.noLRCLabel.text = "加载歌词失败"
                        self.lrcView.removeAllSubviewsInScrollView()
                        self.lrcView.clearLRCContents()
                        self.hasLRC = false
                })
            }
        }
    }
    
    
    ///
    /// private 方法区
    ///
    
    ///
    /// 描述：开启定时器
    private func startTimer() {
        progressTimer = NSTimer(timeInterval: 1.0,
            target: self,
            selector: "updatePlaybackProgress",
            userInfo: nil,
            repeats: true)
        NSRunLoop.currentRunLoop().addTimer(progressTimer!, forMode: NSRunLoopCommonModes)
        
        singerHeadImageView.layer.speed = 2.0
        var pausedTime = singerHeadImageView.layer.timeOffset
        var timeSincePause = singerHeadImageView.layer.convertTime(CACurrentMediaTime(), fromLayer: nil) - pausedTime
        singerHeadImageView.layer.beginTime = timeSincePause
    }
    
    ///
    /// 描述：取消定时器
    private func stopTimer() {
        progressTimer?.invalidate()
        
        singerHeadImageView.layer.speed = 0.0
        // 获取暂停动画的时间
        var pausedTime = singerHeadImageView.layer.convertTime(CACurrentMediaTime(), fromLayer: nil)
        singerHeadImageView.layer.timeOffset = pausedTime
    }
    
    ///
    /// 描述：修改播放模式
    func onPlayModeButtonClicked(sender: UIButton) {
        var name = ""
        var title = ""
        switch (self.playbackMode) {
        case .OrderMode: // 当前是顺序播放，就切换成随机播放
            name = "random"
            title = "随机播放"
            self.playbackModeValue = 1
            break
        case .RandomMode:// 当前是顺序播放，就切换成单曲播放
            name = "lock"
            title = "单曲播放"
            self.playbackModeValue = 2
            break
        default:
            name = "order"
            title = "顺序播放"
            self.playbackModeValue = 0
            break
        }
        
        self.playModeButton.setImage(UIImage(named: name), forState: UIControlState.Normal)
        HYBProgressHUD.showSuccess(title)
    }
    
    ///
    /// 描述：点击播放
    func onPlayButtonClicked(sender: UIButton) {
        self.playMusic()
        
        if self.isPlaying {
            self.delegate?.audioPlayView?(self, didClickPlayButton: sender)
        } else {
            self.delegate?.audioPlayView?(self, didClickStopAtIndex: self.playbackModeValue)
        }
    }
    
    ///
    /// 描述：播放前一首
    func onPreviousButtonClicked(sender: UIButton) {
        stopCurrentState()
        
        self.delegate?.audioPlayView?(self, didClickPreviousButton: sender)
    }
    
    ///
    /// 描述：播放下一首
    func onNextButtonClicked(sender: UIButton) {
        stopCurrentState()
        
        self.delegate?.audioPlayView?(self, didClickNextButton: sender)
    }
    
    ///
    /// 描述：播放列表
    func onPlayListButtonClicked(sender: UIButton) {
        self.delegate?.audioPlayView?(self, didClickNextButton: sender)
    }
    
    ///
    /// 描述：下载
    func onDownloadButtonClicked(sender: UIButton) {
        self.delegate?.audioPlayView?(self, didClickDownloadButton: sender)
    }
    
    ///
    /// 描述：收藏
    func onCollectButtonClicked(sender: UIButton) {
        
    }
    
    ///
    /// 描述：停止当前播放状态
    private func stopCurrentState() {
        self.downloadButton.enabled = false
        self.isPlaying = false
        self.audioPlayer.stop()
        self.stopTimer()
    }
    
    ///
    /// 描述：更新控件状态
    private func updateControls() {
        switch (self.audioPlayer.state) {
        case .Stopped:
            if self.isPlaying {
                self.delegate?.audioPlayView?(self, didClickStopAtIndex: self.playbackModeValue)
            }
            self.isPlaying = false
            break
        case .Playing:
            self.isPlaying = true
            break
        default:
            break
        }
        
        
        var imgName = (isPlaying == true ? "pasue" : "play")
        playButton.setImage(UIImage(named: imgName), forState: UIControlState.Normal)
        
        imgName = (isPlaying == true ? "pasueHight" : "playHight")
        playButton.setImage(UIImage(named: imgName), forState: UIControlState.Highlighted)
    }
    
    ///
    /// 描述：更新播放进度
    func updatePlaybackProgress() {
        println(self.audioPlayer.duration)
        if self.audioPlayer.duration == 0.0 {
            progressSlider.value = 0.0
        } else {
            progressSlider.minimumValue = 0.0
            progressSlider.maximumValue = Float(audioPlayer.duration)
            progressSlider.value = Float(audioPlayer.progress)
            
            currentPlaybackTimeLabel.text = String.time(fromSeconds: Int(audioPlayer.progress))
            if self.noLRCLabel.text?.isEmpty == false {
                lrcView.moveToLRCLine(time: String(format: "%@", currentPlaybackTimeLabel.text!))
            }
        }
    }
    
    ///
    /// 描述：开始播放
    private func startToPlayMusic() {
        self.audioPlayer.play(NSURL(string: self.playlistItem!.url))
        
        var animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.toValue = NSNumber(double: 2.0 * M_PI)
        animation.duration = 1.5
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.cumulative = false
        animation.removedOnCompletion = false
        animation.repeatCount = FLT_MAX
        singerHeadImageView.layer.addAnimation(animation, forKey: "AnimatedKey")
        singerHeadImageView.layer.speed = 0.2
        singerHeadImageView.layer.beginTime = 0.0
    }
    
    ///
    /// AudioPlayerDelegate
    ///
    func audioPlayer(audioPlayer: AudioPlayer!, didStartPlayingQueueItemId queueItemId: NSObject!) {
        updateControls()
    }
    
    func audioPlayer(audioPlayer: AudioPlayer!, didEncounterError errorCode: AudioPlayerErrorCode) {
        updateControls()
    }
    
    func audioPlayer(audioPlayer: AudioPlayer!,
        didFinishPlayingQueueItemId queueItemId: NSObject!,
        withReason stopReason: AudioPlayerStopReason,
        andProgress progress: Double,
        andDuration duration: Double) {
            updateControls()
    }
    
    func audioPlayer(audioPlayer: AudioPlayer!, didFinishBufferingSourceWithQueueItemId queueItemId: NSObject!) {
        updateControls()
    }
    
    func audioPlayer(audioPlayer: AudioPlayer!, stateChanged state: AudioPlayerState) {
        updateControls()
    }
}

