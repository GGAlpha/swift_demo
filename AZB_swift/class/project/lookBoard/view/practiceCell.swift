//
//  practiceCell.swift
//  AZB_swift
//
//  Created by limbo on 2020/5/7.
//  Copyright © 2020 limbo. All rights reserved.
//

import Foundation

class practiceCell: UICollectionViewCell {
    
    var label:UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createUI(){
        label = UILabel.init()
        label?.font = UIFont.systemFont(ofSize: 15)
        label?.backgroundColor = .yellow
        self.contentView.addSubview(label!)
        label!.snp.makeConstraints { (make) in
            make.top.bottom.right.left.equalTo(5)
            make.height.equalTo(30)
        }
    }
}
