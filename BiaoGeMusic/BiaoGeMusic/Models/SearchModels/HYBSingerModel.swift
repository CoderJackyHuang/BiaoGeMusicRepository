//
//  HYBSingerModel.swift
//  BiaoGeMusic
//
//  Created by ljy-335 on 14-10-23.
//  Copyright (c) 2014年 uni2uni. All rights reserved.
//

import Foundation

///
/// 描述：歌手数据模型
///
/// 作者： huangyibiao
class HYBSingerModel: HYBBaseModel {
    var ting_uid: Int = 0
    var name: NSString = ""
    var firstchar: NSString = ""
    var gender: Int = 0
    var area: Int = 0
    var country: NSString = ""
    
    // 头像
    var avatar_big: NSString = ""
    var avatar_middle: NSString = ""
    var avatar_small: NSString = ""
    var avatar_mini: NSString = ""
    
    var constellation: NSString = ""
    var stature: float_t = 0.0
    var weight: float_t = 0.0
    var bloodtype: NSString = ""
    var company: NSString = ""
    var intro: NSString = ""
    
    var albums_total: Int = 0
    var songs_total: Int = 0
    
    var birth: NSDate?
    var url: NSString = ""
    
    var artist_id: Int = 0
    var avatar_s180: NSString = ""
    var avatar_s500: NSString = ""
    var avatar_s1000: NSString = ""
    var piao_id: Int = 0
    var source: NSString = ""
    var aliasname: NSString = ""
    var translatename: NSString = ""
    
    override class func getTableName() ->String {
        return "FMSongerInfor"
    }
    
    override class func getPrimaryKey() ->String {
        return "ting_uid"
    }
    
    class func top100Songers() ->NSMutableArray? {
      return  HYBSingerModel.searchWithWhere("name like '%李%'", orderBy: nil, offset: 0, count: 0)
    }
}