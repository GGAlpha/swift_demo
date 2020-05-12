//
//  selectPeopleNavCell.swift
//  AZB_swift
//
//  Created by limbo on 2020/4/12.
//  Copyright © 2020 limbo. All rights reserved.
//

import Foundation

class selectPeopleNavCell: UICollectionViewCell {
    
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
        self.contentView.addSubview(label!)
        label!.snp.makeConstraints { (make) in
            make.top.bottom.right.left.equalTo(0)
        }
    }
    
//    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
//      
//    }
}
