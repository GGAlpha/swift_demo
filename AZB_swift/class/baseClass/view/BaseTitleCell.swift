//
//  BaseTitleCell.swift
//  AZB_swift
//
//  Created by limbo on 2020/4/8.
//  Copyright © 2020 limbo. All rights reserved.
//

import Foundation

class BaseTitleCell: BaseTableviewCell {
    
    var titleLabel:UILabel?
    var contentLabel:UILabel?
    
    override func createCellUI() {
        titleLabel = UILabel.init()
        titleLabel?.font = UIFont.systemFont(ofSize: 14)
        self.contentView.addSubview(titleLabel!)
        titleLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo(15)
            make.centerY.equalTo(self.snp_centerY)
        })
        
        contentLabel = UILabel.init()
        contentLabel?.numberOfLines = 0
        contentLabel?.textAlignment = .right
        contentLabel?.font = UIFont.systemFont(ofSize: 14)
        self.contentView.addSubview(contentLabel!)
        contentLabel?.snp.makeConstraints({ (make) in
            make.right.equalTo(-15)
            make.left.greaterThanOrEqualTo(kCommonScreenWidth/2)
            make.height.greaterThanOrEqualTo(30)
            make.top.equalTo(10)
            make.bottom.equalTo(-10)
        })
        
        let line = UIView.init()
        line.backgroundColor = kCommonLigthGray
        self.contentView.addSubview(line)
        line.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: kCommonScreenWidth, height: 1))
            make.bottom.equalTo(0)
        }
    }
    
    func refreshWith(title:String,content:String) {
        titleLabel?.text = title
        contentLabel?.text = content
    }
}
