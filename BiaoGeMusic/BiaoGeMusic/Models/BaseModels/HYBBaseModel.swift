//
//  HYBBaseModel.swift
//  BiaoGeMusic
//
//  Created by ljy-335 on 14-10-24.
//  Copyright (c) 2014年 uni2uni. All rights reserved.
//

import Foundation

///
/// 描述：基础数据模型，所有的数据模型都要直接或者间接继承于此模型
///
/// 作者：huangyibiao
class HYBBaseModel: NSObject {
    override func setValue(value: AnyObject!, forUndefinedKey key: String!) {
        println("unknownkey:\(key)")
    }
}