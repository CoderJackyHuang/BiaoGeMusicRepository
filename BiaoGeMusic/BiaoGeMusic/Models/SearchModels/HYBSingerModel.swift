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
    
    ///
    /// 描述：解析数据
    ///
    /// 参数：dict 请求数据的字典数据
    ///
    /// 注明：这里只是个失误，不能像OC那样把NSString自动转换成Int,在Swift中是会崩溃
    func parse(dict: NSDictionary) {
        if let tuidStr = (dict["ting_uid"] as? NSString) {
            ting_uid = tuidStr.integerValue
        }
        
        if let u = dict["url"] as? NSString {
            url = u
        }
        
        if let as180 = dict["avatar_s180"] as? NSString {
            avatar_s180 = as180
        }
        
        if let value = dict["avatar_s500"] as? NSString {
            avatar_s500 = value
        }
        
        if let value = dict["avatar_s1000"] as? NSString {
            avatar_s1000 = value
        }

        if let value = dict["source"] as? NSString {
            source = value
        }
        
        if let value = dict["aliasname"] as? NSString {
            aliasname = value
        }

        if let value = dict["translatename"] as? NSString {
            translatename = value
        }
        
        if let value = dict["name"] as? NSString {
            name = value
        }

        if let value = dict["country"] as? NSString {
            country = value
        }
        
        if let value = dict["firstchar"] as? NSString {
            firstchar = value
        }

        if let value = dict["avatar_big"] as? NSString {
            avatar_big = value
        }
        if let value = dict["avatar_middle"] as? NSString {
            avatar_middle = value
        }
        if let value = dict["avatar_small"] as? NSString {
            avatar_small = value
        }
        if let value = dict["avatar_mini"] as? NSString {
            avatar_mini = value
        }
        if let value = dict["constellation"] as? NSString {
            constellation = value
        }
        if let value = dict["bloodtype"] as? NSString {
            bloodtype = value
        }
        if let value = dict["intro"] as? NSString {
            intro = value
        }
        if let value = dict["company"] as? NSString {
            company = value
        }

        if let sta =  dict["stature"] as? NSString {
            stature = sta.floatValue
        }
        if let w =  dict["weight"] as? NSString {
            weight = w.floatValue
        }
        if let gen = dict["gender"] as? NSString {
            gender = gen.integerValue
        }
        
        if let are = dict["area"] as? NSString {
            area = are.integerValue
        }
        
        if let piao =  dict["piao_id"] as? NSString {
            piao_id = piao.integerValue
        }
        if let artist = dict["artist_id"] as? NSString {
            artist_id = artist.integerValue
        }
        
        if let bir = dict["birth"] as? NSDate {
            birth = bir
        }
        
        if let alto = dict["albums_total"] as? NSString {
            albums_total = alto.integerValue
        }
        
        if let songTotal = dict["songs_total"] as? NSString {
            songs_total = songTotal.integerValue
        }
    }
    
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