//
//  SelectImageCell.swift
//  AZB_swift
//
//  Created by limbo on 2020/4/8.
//  Copyright © 2020 limbo. All rights reserved.
//

import Foundation

class SelectImageCell: UICollectionViewCell {
    
    var imageView:UIImageView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createUI() {
        imageView = UIImageView.init()
        imageView?.contentMode = .scaleAspectFill
        imageView?.clipsToBounds = true
        self.contentView.addSubview(imageView!)
        imageView?.snp.makeConstraints({ (make) in
            make.top.right.left.bottom.equalTo(0)
        })
    }
    
    func refreshImage(image:AnyObject)  {
        if image.isKind(of:NSString.classForCoder()) {
            imageView?.kf.setImage(with: URL(string:image as! String))
        }
        if image.isKind(of:UIImage.classForCoder()){
            imageView?.image = image as? UIImage
        }
        if image.isKind(of:NSData.classForCoder()){
            imageView?.image = UIImage.init(data: (image as! NSData) as Data)
        }
    }
}
