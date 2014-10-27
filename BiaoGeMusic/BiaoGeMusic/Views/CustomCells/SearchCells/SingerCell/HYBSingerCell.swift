//
//  HYBSingerCell.swift
//  BiaoGeMusic
//
//  Created by ljy-335 on 14-10-23.
//  Copyright (c) 2014年 uni2uni. All rights reserved.
//

import Foundation

///
/// 描述：歌手信息显示的Cell
///
/// 作者：huangyibiao
class HYBSingerCell: StyledTableViewCell {
    private var headImageView: HYBLoadImageView!
    private var nameLabel: UILabel!
    private var titleLabel: UILabel!
    ///
    /// 配置数据
    func configureCell(model: HYBSingerModel) {
        // 头像
        headImageView.setImageURL(model.avatar_big, placeholder: "headerImage")
        
        // 姓名
        nameLabel.text = model.name
        
        // 公司
        if model.company.length != 0 {
            titleLabel.text = model.company
        } else {
            titleLabel.text = "<暂无信息>"
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        // 头像
        headImageView = HYBLoadImageView(frame: CGRectMake(5, 5, 60, 60))
        headImageView.isCircle = true
        self.contentView.addSubview(headImageView)
        
        // 姓名
        nameLabel = UIMaker.label(CGRectMake(headImageView.rightX() + 5,
            5,
            self.contentView.width() - headImageView.rightX() - 30, 30),
            title: "")
        nameLabel.textColor = UIColor.blackColor()
        nameLabel.textAlignment = NSTextAlignment.Left
        self.contentView.addSubview(nameLabel)
        
        // 标题
        titleLabel = UIMaker.label(CGRectMake(nameLabel.originX(),
            nameLabel.bottomY() + 5,
            nameLabel.width(),
            nameLabel.height() - 10),
            title: "")
        titleLabel.font = UIFont.systemFontOfSize(13.0)
        titleLabel.textColor = UIColor.lightGrayColor()
        titleLabel.textAlignment = NSTextAlignment.Left
        self.contentView.addSubview(titleLabel)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}