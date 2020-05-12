//
//  workMenuHeadView.swift
//  AZB_swift
//
//  Created by limbo on 2020/4/5.
//  Copyright © 2020 limbo. All rights reserved.
//

import Foundation
import UIKit

class workMenuHeadView: UICollectionReusableView {
    
    var titleLabel:UILabel?
    var moreBtn:UIButton?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        createUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createUI() {
        let line = UIView.init()
        line.backgroundColor = kCommonBlue
        self.addSubview(line)
        line.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.top.equalTo(10)
            make.bottom.equalTo(-10)
            make.width.equalTo(3)
        }
        
        titleLabel = UILabel.init()
        titleLabel?.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(titleLabel!)
        titleLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo(line.snp_right).offset(5)
            make.top.bottom.equalTo(0)
        })
        
        moreBtn = UIButton.init()
        moreBtn?.setTitleColor(kCommonBlue, for: .normal)
        moreBtn?.setTitle("更多", for: .normal)
        moreBtn?.isHidden = true
        moreBtn?.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        moreBtn?.addTarget(self, action: #selector(pressMore), for: .touchUpInside)
        self.addSubview(moreBtn!)
        moreBtn?.snp.makeConstraints({ (make) in
            make.right.equalTo(-15)
            make.top.bottom.equalTo(0)
        })
        
        let bottomLine = UIView.init()
        bottomLine.backgroundColor = .gray
        self.addSubview(bottomLine)
        bottomLine.snp.makeConstraints { (make) in
            make.left.bottom.right.equalTo(0)
            make.height.equalTo(0.5)
        }
    }
    
    @objc func pressMore(){
        self.pressBlock()
    }
    
    var pressBlock = {}
}
