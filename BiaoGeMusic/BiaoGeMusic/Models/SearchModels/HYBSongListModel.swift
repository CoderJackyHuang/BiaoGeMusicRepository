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
    var artist_id: Int = 0
    var all_artist_ting_uid: Int = 0
    var all_artist_id: Int = 0
    var album_no: Int = 0
    var area: Int = 0
    var hot: Int = 0
    var file_duration: Int = 0
    var del_status: Int = 0
    var resource_type: Int = 0
    var copy_type: Int = 0
    var relate_status: Int = 0
    var all_rate: Int = 0
    var has_mv_mobile: Int = 0
    var toneid: Int = 0
    var song_id: Int = 0
    var ting_uid: Int = 0
    var album_id: Int = 0
    var is_first_publish: Int = 0
    var havehigh: Int = 0
    var charge: Int = 0
    var has_mv: Int = 0
    var learn: Int = 0
    var piao_id: Int = 0
    var listen_total: Int = 0
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
    var songnums: Int = 0
    var havemore: Bool = true
    var error_code: Int = 200
    var songList = NSMutableArray() /// 存储的是HYBSongModel对象
}