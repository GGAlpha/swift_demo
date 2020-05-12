//
//  BaseTableView.swift
//  AZB_swift
//
//  Created by limbo on 2020/4/1.
//  Copyright © 2020 limbo. All rights reserved.
//

import Foundation
import UIKit

class BaseTabelView: UITableView {
    
  
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.separatorStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
