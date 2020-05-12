//
//  workEpidemicCell.swift
//  AZB_swift
//
//  Created by limbo on 2020/4/4.
//  Copyright © 2020 limbo. All rights reserved.
//

import Foundation

class workEpidemicCell: BaseTableviewCell {
    
    var imageV:UIImageView?
    
    override func createCellUI() {
        imageV = UIImageView.init()
        imageV?.kf.setImage(with: URL(string: "https://cloud.qhse.cn/home-banner.png"))
        self.contentView.addSubview(imageV!)
        imageV!.snp.makeConstraints { (make) in
            make.left.top.equalTo(10)
            make.right.bottom.equalTo(-10)
            make.width.equalTo(kCommonScreenWidth-20)
            make.height.equalTo(kCommonScreenWidth*2/7-20)
        }
    }
    
    func refreshImage(imageStr:String){
        imageV!.kf.setImage(with:URL(string: imageStr))
    }
}
