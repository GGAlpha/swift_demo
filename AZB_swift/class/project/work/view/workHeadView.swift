//
//  workHeadView.swift
//  AZB_swift
//
//  Created by limbo on 2020/4/3.
//  Copyright © 2020 limbo. All rights reserved.
//

import Foundation
import UIKit

class workHeadView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.createUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createUI() {
        
        let image = UIImageView.init(frame: self.frame)
        image.image = UIImage.init(named: "home_topBG")
        self.addSubview(image)
        
        let line = UIView.init()
        line.backgroundColor = .white
        line.alpha = 0.6
        self.addSubview(line)
        line.snp.makeConstraints { (make) in
            make.top.equalTo(100)
            make.bottom.equalTo(-30)
            make.width.equalTo(0.5)
            make.centerX.equalTo(kCommonScreenWidth/2)
        }
        
        for i in 0...2{
            for j in 0...1{
                let label = UILabel.init()
                label.textColor = .white
                label.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
                if i == 2{
                    label.backgroundColor = kCommonRGB(redFlot: 13, greenFloat: 110, blueFloat: 205)
                    label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
                }
                labelArray?.append(label)
                self.addSubview(label)
                label.snp.makeConstraints { (make) in
                    make.top.equalTo(100+i*50)
                    make.left.equalTo(40+CGFloat(j)*(kCommonScreenWidth/2))
                    make.height.equalTo(35)
                    make.width.equalTo(kCommonScreenWidth/2-80)
                }
                
            }
        }
        
    }
    
    func refreshWithDict(dict:Any){
        
        let json = JSON(dict)
        var i = 0
        for label in labelArray!{
            
            switch i {
            case 0:
                label.text = "个人"
                break
            case 1:
                label.text = "机构"
                break
            case 2:
                label.text = "0分"
                break
            case 3:
                label.text = "0分"
                break
            case 4:
                label.text = "     排名 0/0"
                break
            case 5:
                label.text = "     排名 0/0"
                break
            default:
                break
            }
            i+=1
        }
    }
    
    var labelArray:Array<UILabel>? = {
        return Array.init()
    }()
}
