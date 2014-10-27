//
//  HYBSearchRequest.swift
//  BiaoGeMusic
//
//  Created by ljy-335 on 14-10-23.
//  Copyright (c) 2014年 uni2uni. All rights reserved.
//

import Foundation

///
/// 描述：(HYBSearchRequest) 扩展HYBBaseRequest网络请求类，把Search模块对应的请求都放到此文件扩展中解析数据等
///
/// 作者：huangyibiao
extension HYBBaseRequest  {
    ///
    /// 描述：获取某个歌手的详情信息接口
    ///
    /// 方式：GET请求
    typealias singerInfoSuccess = (singerModel: HYBSingerModel?) -> Void
    class func singerInfo(path: String, succss: singerInfoSuccess, fail: failCloser) -> AFHTTPRequestOperation {
        var op = GETRequest(path,
            success: { (responseObject) -> Void in // 请求成功，解析数据
                dispatch_async(kGlobalThread, { () -> Void in
                    // 解析数据
                    var dict = self.parseJSON(jsonObject: responseObject)
                    
                    // 处理数据
                    if dict != nil {
                        var singerModel = HYBSingerModel()
                        // 把数据填充到模型中
                        singerModel.parse(dict!)
                        
                        dispatch_async(kMainThread, { () -> Void in
                            succss(singerModel: singerModel)
                        })
                    } else { // 解析失败
                        dispatch_async(kMainThread, { () -> Void in
                            succss(singerModel: nil)
                        })
                    }
                })
            }) { (error) -> Void in             // 请求失败，处理失败
                fail(error: error)
        }
        
        return op
    }
    
    ///
    /// 描述：获取歌曲列表
    ///
    /// 方式：GET请求
    typealias songListSuccess = (songListModels: HYBSongListModel?) -> Void
    class func songList(path: String, succss: songListSuccess, fail: failCloser) -> AFHTTPRequestOperation {
        var op = GETRequest(path,
            success: { (responseObject) -> Void in // 请求成功，解析数据
                dispatch_async(kGlobalThread, { () -> Void in
                    // 解析数据
                    var dict = self.parseJSON(jsonObject: responseObject)
                    
                    var isSuccess = (dict == nil)
                    // 处理数据
                    if dict != nil {
                        var songListModel = HYBSongListModel()
                        // 把数据填充到模型中
                        songListModel.setValuesForKeysWithDictionary(dict)
                        
                        if let songlist = dict!["songlist"] as? NSArray {
                            for songInfo in songlist {
                                if let song = songInfo as? NSDictionary {
                                    var model = HYBSongModel()
                                    model.setValuesForKeysWithDictionary(song)
                                    songListModel.songList.addObject(model)
                                }
                            }
                        }
                        
                        isSuccess = true
                        dispatch_async(kMainThread, { () -> Void in
                            succss(songListModels: songListModel)
                        })
                    }
                    
                    if !isSuccess {
                        dispatch_async(kMainThread, { () -> Void in
                            succss(songListModels: nil)
                        })
                    }
                })
            }) { (error) -> Void in             // 请求失败，处理失败
                fail(error: error)
        }
        
        return op
    }
    
    ///
    /// 描述：获取歌曲的歌词LRC
    ///
    /// 方式：GET请求
    typealias songLRCSuccess = (success: Bool, storePathInDisk: String?) -> Void
    class func songLRC(path: String, ting_uid: Int, song_id: Int, succss: songLRCSuccess, fail: failCloser) -> AFHTTPRequestOperation {
        var op = GETRequest(path,
            success: { (responseObject) -> Void in // 请求成功，解析数据
                dispatch_async(kGlobalThread, { () -> Void in
                    // 解析数据
                    var dict = self.parseJSON(jsonObject: responseObject)
                    
                    var isSuccess = (dict == nil)
                    // 处理数据
                    if dict != nil {
                        // 建立ting_uid文件夹
                        var ting_uidPath = String.documentPath().stringByAppendingPathComponent(String(format: "%d", ting_uid))
                        if !NSFileManager.defaultManager().fileExistsAtPath(ting_uidPath) {
                            if NSFileManager.defaultManager().createDirectoryAtPath(ting_uidPath,
                                withIntermediateDirectories: true,
                                attributes: nil,
                                error: nil) {
                                    println("建立ting_uid文件夹成功")
                            }
                        }
                        
                        // 建立sing_uid文件夹下的song_id文件夹
                        var song_idPath = ting_uidPath.stringByAppendingPathComponent(String(format: "%d", song_id))
                        if !NSFileManager.defaultManager().fileExistsAtPath(song_idPath) {
                            if NSFileManager.defaultManager().createDirectoryAtPath(song_idPath,
                                withIntermediateDirectories: true,
                                attributes: nil,
                                error: nil) {
                                    println("建立song_idPath文件夹成功")
                            }
                        }
                        
                        // 把歌词写入文件中
                        isSuccess = false
                        var storePath = song_idPath.stringByAppendingPathComponent(String(format: "%d.lrc", song_id))
                        if !NSFileManager.defaultManager().fileExistsAtPath(storePath) {
                            if NSFileManager.defaultManager().createFileAtPath(storePath,
                                contents: responseObject as? NSData,
                                attributes: nil) {
                                    isSuccess = true
                            }
                        }
                        
                        dispatch_async(kMainThread, { () -> Void in
                            succss(success: isSuccess, storePathInDisk: storePath)
                        })
                    } else {
                        dispatch_async(kMainThread, { () -> Void in
                            succss(success: false, storePathInDisk: nil)
                        })
                    }
                })
            }) { (error) -> Void in             // 请求失败，处理失败
                fail(error: error)
        }
        
        return op
    }
}