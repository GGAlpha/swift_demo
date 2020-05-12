//
//  dangerSnapSelectCell.swift
//  AZB_swift
//
//  Created by limbo on 2020/4/9.
//  Copyright © 2020 limbo. All rights reserved.
//

import Foundation

class dangerSnapSelectCell: BaseTableviewCell {
    
    var pressBlock = {}
    var passBtn:UIButton?
    var chBtn:UIButton?
    
    override func createCellUI() {
        for i in 0...1{
            let seleBtn = UIButton.init()
            seleBtn.setTitle(i==0 ? "通过" : "整改", for: .normal)
            seleBtn.setTitleColor(.black, for: .normal)
            seleBtn.setTitleColor(kCommonBlue, for: .selected)
            seleBtn.addTarget(self, action: #selector(pressBtn(_:)), for: .touchUpInside)
            if i == 0{
                seleBtn.isSelected = true
                passBtn = seleBtn
            }else{
                chBtn = seleBtn
            }
            self.contentView.addSubview(seleBtn)
            seleBtn.snp.makeConstraints { (make) in
                make.left.equalTo(i==0 ? 0 : kCommonScreenWidth/2)
                make.width.equalTo(kCommonScreenWidth/2)
                make.top.bottom.equalTo(0)
                make.height.equalTo(50)
            }
            
            
        }
    }
    
    @objc func pressBtn(_ btn:UIButton){
        self.pressBlock()
        chBtn?.isSelected = !chBtn!.isSelected
        passBtn?.isSelected = !passBtn!.isSelected
    }
}
