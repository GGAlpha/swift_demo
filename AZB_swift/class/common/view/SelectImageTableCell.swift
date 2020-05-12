//
//  SelectImageTableCell.swift
//  AZB_swift
//
//  Created by limbo on 2020/4/8.
//  Copyright © 2020 limbo. All rights reserved.
//

import Foundation

class SelectImageTableCell: BaseTableviewCell {
    
    var photoView:SelectImageView?
    override func createCellUI() {
        photoView = SelectImageView.init(frame: CGRect.init())
        self.contentView.addSubview(photoView!)
        photoView?.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalTo(0)
        }
    }
}
