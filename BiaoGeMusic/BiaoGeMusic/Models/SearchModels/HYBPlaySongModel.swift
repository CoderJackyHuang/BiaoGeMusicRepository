//
//  HYBPlaySongModel.swift
//  BiaoGeMusic
//
//  Created by ljy-335 on 14-10-24.
//  Copyright (c) 2014年 uni2uni. All rights reserved.
//

import Foundation

///
/// 描述：歌手数据模型
///
/// 作者： huangyibiao
class HYBPlaySongModel: HYBBaseModel {
    var queryId: Int = 0
    var songId: Int = 0
    var artistId: Int = 0
    var albumId: Int = 0
    var copyType: Int = 0
    var time: Int = 0
    var linkCode: Int = 0
    var rate: Int = 0
    var size: Int = 0
    
    var songName: NSString = ""
    var artistName: NSString = ""
    var songPicSmall: NSString = ""
    var songPicBig: NSString = ""
    var songPicRadio: NSString = ""
    var lrcLink: NSString = ""
    var version: NSString = ""
    var songLink: NSString = ""
    var showLink: NSString = ""
    var format: NSString = ""
}