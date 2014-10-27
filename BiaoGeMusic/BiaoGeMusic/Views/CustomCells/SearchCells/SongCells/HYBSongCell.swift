//
//  HYBSongCell.swift
//  BiaoGeMusic
//
//  Created by ljy-335 on 14-10-24.
//  Copyright (c) 2014年 uni2uni. All rights reserved.
//

import Foundation

///
/// 描述：歌曲信息显示的Cell
///
/// 作者：huangyibiao
class HYBSongCell: StyledTableViewCell {
    private var nameLabel: UILabel!
    private var titleLabel: UILabel!
    private var timeLabel: UILabel!
    
    ///
    /// 配置数据
    func configureCell(model: HYBSongModel) {
        nameLabel.text = model.title
        titleLabel.text = "\(model.author)•\(model.album_title)"
        timeLabel.text = String.time(fromSeconds: model.file_duration.integerValue)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        // 歌曲名
        nameLabel = UIMaker.label(CGRectMake(8,
            5,
            self.contentView.width() - 16 - 60, 25),
            title: "")
        nameLabel.font = UIFont.systemFontOfSize(16.0)
        nameLabel.textColor = UIColor.blackColor()
        nameLabel.textAlignment = NSTextAlignment.Left
        self.contentView.addSubview(nameLabel)
        
        // 标题
        titleLabel = UIMaker.label(CGRectMake(nameLabel.originX(),
            nameLabel.bottomY() + 5,
            nameLabel.width(),
            nameLabel.height()),
            title: "")
        titleLabel.font = UIFont.systemFontOfSize(14.0)
        titleLabel.textColor = UIColor.lightGrayColor()
        titleLabel.textAlignment = NSTextAlignment.Left
        self.contentView.addSubview(titleLabel)
        
        // 时间
        timeLabel = UIMaker.label(CGRectMake(nameLabel.rightX(),
            0,
            60,
            60),
            title: "")
        timeLabel.font = UIFont.systemFontOfSize(14.0)
        timeLabel.textColor = UIColor.lightGrayColor()
        timeLabel.textAlignment = NSTextAlignment.Left
        self.contentView.addSubview(timeLabel)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}