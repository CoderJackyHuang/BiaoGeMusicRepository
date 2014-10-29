//
//  HYBBaseRequest.swift
//  BiaoGeMusic
//
//  Created by ljy-335 on 14-10-23.
//  Copyright (c) 2014年 uni2uni. All rights reserved.
//

import Foundation

/// 请求成功与失败的回调
typealias requestSuccessCloser = (responseObject: AnyObject?) ->Void
typealias failCloser = (error: NSError?) ->Void

///
/// 描述：网络请求基础类,所有GET请求方式都是以GET开头的类方法，POST请求方式会以POST开头命名类方法
///
/// 作者：huangyibiao
class HYBBaseRequest: NSObject {
    struct BaseURL {
        static var baseURL: String = kServerBase
    }
    
    ///
    /// 描述：解析JSON数据
    ///
    /// 参数：jsonObject 网络请求获取下来数据
    ///
    /// 返回：如果解析成功，返回字典，否则返回nil
    class func parseJSON(#jsonObject: AnyObject?) ->NSDictionary? {
        if let result = jsonObject as? NSDictionary {
            return result
        }
        return nil
    }
    
    ///
    /// 描述： GET请求方式
    ///
    /// 参数： serverPath --请求路径，不包含基础路径
    ///       success    --请求成功时的回调闭包
    ///       fail       --请求失败时的回调闭包
    ///
    /// 返回： AFHTTPRequestOperation类型对象，外部可以通过引用此对象实例，在需要取消请求时，调用cancel()方法
    class func GETRequest(serverPath: String, success: requestSuccessCloser, fail: failCloser) ->AFHTTPRequestOperation {
        var op =  manager().GET(serverPath, parameters: nil, success: { (op, responseObject) -> Void in
            success(responseObject: responseObject)
            }, failure: { (op, error) -> Void in
                fail(error: error)
        })
        return op
    }
    
    class func downloadFile(serverPath: String, success: requestSuccessCloser, fail: failCloser) ->AFHTTPRequestOperation {
        var op =  AFHTTPRequestOperation(request: NSURLRequest(URL: NSURL(string: String(format: "%@%@", kServeBase1, serverPath))))
        op.setCompletionBlockWithSuccess({ (requestOp, responseObject) -> Void in
            success(responseObject: responseObject)
        }, failure: { (requestOP, error) -> Void in
            fail(error: error)
        })
        op.start()
        return op
    }
    
    ///
    /// 私有方法区
    ///
    private  class func manager() ->AFHTTPRequestOperationManager {
        var manager = AFHTTPRequestOperationManager(baseURL: NSURL(string: BaseURL.baseURL))
        
        manager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Accept")
        manager.requestSerializer.setValue("application/json", forHTTPHeaderField: "content-type")
        manager.requestSerializer.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Accept")
        manager.requestSerializer.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

        // 设置响应头支持的格式
        manager.responseSerializer.acceptableContentTypes = NSSet(array: ["application/json", "application/javascript", "application/lrc", "application/x-www-form-urlencoded"])
        return manager
    }
}