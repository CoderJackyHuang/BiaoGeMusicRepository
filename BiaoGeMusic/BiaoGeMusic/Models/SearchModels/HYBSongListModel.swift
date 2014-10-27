//
//  HYBSongListModel.swift
//  BiaoGeMusic
//
//  Created by ljy-335 on 14-10-24.
//  Copyright (c) 2014年 uni2uni. All rights reserved.
//

import Foundation

///
/// 歌曲列表及歌曲数据模型
///

/// 
/// 描述：歌曲模型
///
/// 作者：huangyibiao
class HYBSongModel: HYBBaseModel {
    var artist_id: NSString = "0"
    var all_artist_ting_uid: NSString = "0"
    var all_artist_id: NSString = "0"
    var album_no: NSString = "0"
    var area: NSString = "0"
    var hot: NSString = "0"
    var file_duration: NSString = "0"
    var del_status: NSString = "0"
    var resource_type: NSString = "0"
    var copy_type: NSString = "0"
    var relate_status: NSString = "0"
    var all_rate: NSString = "0"
    var has_mv_mobile: NSString = "0"
    var toneid: NSString = "0"
    var song_id: NSString = "0"
    var ting_uid: NSString = "0"
    var album_id: NSString = "0"
    var is_first_publish: NSString = "0"
    var havehigh: NSString = "0"
    var charge: NSString = "0"
    var has_mv: NSString = "0"
    var learn: NSString = "0"
    var piao_id: NSString = "0"
    var listen_total: NSString = "0"
    var language: NSString = ""
    var publishtime: NSString = ""
    var pic_big: NSString = ""
    var pic_small: NSString = ""
    var country: NSString = ""
    var lrclink: NSString = ""
    var title: NSString = ""
    var author: NSString = ""
    var album_title: NSString = ""
    var versions: NSString = ""
    var song_source: NSString = ""
    var resource_type_ext: NSString = ""
    var korean_bb_song: NSString = ""
}

///
/// 描述：歌曲列表模型
///
/// 作者：huangyibiao
class HYBSongListModel: HYBBaseModel {
    var songnums: NSString = "0"
    var havemore: NSString = "1"
    var error_code: NSString = "200"
    var songList = NSMutableArray() /// 存储的是HYBSongModel对象
}