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
class HYBSongPlayController: HYBBaseController {
    private var currentSongModel: HYBSongModel!
    
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
    }
}