//
//  BaseTableviewCell.swift
//  AZB_swift
//
//  Created by limbo on 2020/4/3.
//  Copyright © 2020 limbo. All rights reserved.
//

import Foundation
import UIKit

class BaseTableviewCell: UITableViewCell {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = .white
        self.selectionStyle = .none
        self.createCellUI()
    }
    
    func createCellUI() {
        
    }
}

