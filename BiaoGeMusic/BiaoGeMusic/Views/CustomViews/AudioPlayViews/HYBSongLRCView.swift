//
//  HYBSongLRCView.swift
//  BiaoGeMusic
//
//  Created by ljy-335 on 14-10-24.
//  Copyright (c) 2014年 uni2uni. All rights reserved.
//

import Foundation

///
/// 描述： 显示歌词控件
///
/// 作者： huangyibiao
class HYBSongLRCView: UIView {
    private var scrollView: UIScrollView!
    private var keyArray = NSMutableArray()
    private var titleArray = NSMutableArray()
    private var lineLabelArray = NSMutableArray()
    
    ///
    /// 重写父类的方法
    ///
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.scrollView = UIScrollView(frame: self.bounds)
        // 暂时关闭可交互功能
        self.scrollView.userInteractionEnabled = false
        self.addSubview(self.scrollView)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    ///
    /// public方法区
    ///
    
    ///
    /// 描述：解析歌词
    ///
    /// 参数：lrcPath LRC歌词的路径
    func parseSong(lrcPath: String) {
        self.keyArray.removeAllObjects()
        self.titleArray.removeAllObjects()
        
        var content = NSString(contentsOfFile: lrcPath, encoding: NSUTF8StringEncoding, error: nil)
        var array = content.componentsSeparatedByString("\n")
        // 解析每一行
        for line in array {
            if let lrcLine = line as? NSString {
                if lrcLine.length != 0 {
                    self.parseLRCLine(lrcLine)
                }
            }
        }
        
        self.bubbleSortLrcLines(self.keyArray)
        
        self.scrollView.contentOffset = CGPointZero
        self.scrollView.contentSize = CGSizeMake(scrollView.width(), CGFloat(keyArray.count * 25))
        self.configureLRCLineLabels()
    }
    
    ///
    /// 描述：移除显示歌词的标签
    func removeAllSubviewsInScrollView() {
        for subview in self.scrollView.subviews {
            subview.removeFromSuperview()
        }
        
        self.lineLabelArray.removeAllObjects()
    }
    
    ///
    /// 描述：移除之前的歌词数据
    func clearLRCContents() {
        self.keyArray.removeAllObjects()
        self.titleArray.removeAllObjects()
    }
    
    ///
    /// 描述：指定歌词播放的时间，会根据时间滚动到对应的歌词行
    ///
    /// 参数：time 歌词行播放的时间
    func moveToLRCLine(#time: NSString) {
        if self.keyArray.count != 0 {
            var currentTimeValue = self.timeToFloat(time)
            
            var index = 0
            var hasFound = false
            for index = 0; index < self.keyArray.count; index++ {
                if let lrcTime = self.keyArray[index] as? NSString {
                    var tmpTimeValue = self.timeToFloat(lrcTime)
                    if tmpTimeValue == currentTimeValue {
                        hasFound = true
                        break
                    }
                }
            }
            
            if hasFound {
                if index < self.lineLabelArray.count {
                    if let label = self.lineLabelArray[index] as? UILabel {
                        label.textColor = kNavColor
                        self.scrollView.setContentOffset(CGPointMake(0.0, 25.0 * CGFloat(index)),
                            animated: true)
                    }
                }
            }
        }
    }
    
    ///
    /// private方法区
    ///
    
    ///
    /// 描述：解析歌词行
    ///
    /// 参数：lrcLine 该行歌词
    private func parseLRCLine(lrcLine: NSString) {
        if lrcLine.length == 0 {
            return
        }
        
        var array = lrcLine.componentsSeparatedByString("\n")
        for var i = 0; i < array.count; i++ {
            var tempString = array[i] as NSString
            var lineArray = tempString.componentsSeparatedByString("]")
            
            for var j = 0; j < lineArray.count - 1; j++ {
                var line = lineArray[j] as NSString
                
                if line.length > 8 {
                    var str1 = tempString.substringWithRange(NSMakeRange(3, 1))
                    var str2 = tempString.substringWithRange(NSMakeRange(6, 1))
                    
                    if str1 == ":" && str2 == "." {
                        var lrc = lineArray.last as NSString
                        var time = lineArray[j].substringWithRange(NSMakeRange(1, 8)) as NSString
                        // 时间作为KEY
                        self.keyArray.addObject(time.substringToIndex(5))
                        // 歌词会为值
                        self.titleArray.addObject(lrc)
                    }
                }
            }
        }
    }
    
    ///
    /// 描述：对所有歌词行进行冒泡排序
    ///
    /// 参数：array 要进行冒泡排序的数组
    private func bubbleSortLrcLines(array: NSMutableArray) {
        for var i = 0; i < array.count; i++ {
            var firstValue = self.timeToFloat(array[i] as NSString)
            
            for var j = i + 1; j < array.count; j++ {
                var secondValue = self.timeToFloat(self.keyArray[j] as NSString)
                
                if firstValue < secondValue {
                    array.exchangeObjectAtIndex(i, withObjectAtIndex: j)
                    self.titleArray.exchangeObjectAtIndex(i, withObjectAtIndex: j)
                }
                
            }
        }
    }
    
    ///
    /// 描述：把时间字符串转换成浮点值
    ///
    /// 参数：time 时间字符串，格式为："05:11"
    private func timeToFloat(time: NSString) ->float_t {
        var array = time.componentsSeparatedByString(":")
        
        var result: NSString = "\(array[0])"
        if array.count >= 2 {
            result = "\(array[0]).\(array[1])"
        }

        return result.floatValue
    }
    
    ///
    /// 描述：创建显示歌词的标签
    private func configureLRCLineLabels() {
        self.removeAllSubviewsInScrollView()
        
        for var i = 0; i < titleArray.count; i++ {
            var title = titleArray[i] as String
            var label = UIMaker.label(CGRectMake(0.0,
                25.0 * CGFloat(i) + scrollView.height() / 2.0,
                scrollView.width(),
                25.0),
                title: title)
            label.textColor = UIColor.lightGrayColor()
            label.font = UIFont.systemFontOfSize(14.0)
            
            scrollView.addSubview(label)
            lineLabelArray.addObject(scrollView)
        }
    }
}