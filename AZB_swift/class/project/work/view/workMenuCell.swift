//
//  workMenuCell.swift
//  AZB_swift
//
//  Created by limbo on 2020/4/4.
//  Copyright © 2020 limbo. All rights reserved.
//

import Foundation

let WorkMenuDis = CGFloat(20)
let WorkMenuW = (kCommonScreenWidth-CGFloat(WorkMenuDis*4))/3
let WorkMenuH = CGFloat(85)

class workMenuCell: UICollectionViewCell {
    
    var menuImage:UIImageView?
    var menuLabel:UILabel?
    var unreadBtn:UIButton?
    var model:workMenuModel?
    var pressBlock = {}
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 3
        self.layer.masksToBounds = true
        createUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createUI() {
        menuImage = UIImageView.init()
        self.contentView.addSubview(menuImage!)
        menuImage?.snp.makeConstraints({ (make) in
            make.bottom.equalTo(-(self.frame.size.height/2))
            make.width.height.equalTo(25)
            make.centerX.equalTo(self.snp_centerX)
        })
        
        menuLabel = UILabel.init()
        menuLabel?.textAlignment = .center
        menuLabel?.font = UIFont.systemFont(ofSize: 14)
        self.contentView.addSubview(menuLabel!)
        menuLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo(self.frame.size.height/2+10)
            make.centerX.equalTo(self.snp_centerX)
        })
        
        unreadBtn = UIButton.init()
//        unreadBtn?.backgroundColor = .white
//        unreadBtn?.titleLabel?.textAlignment = .center
//        unreadBtn?.titleLabel?.font = UIFont.systemFont(ofSize: 11)
//        unreadBtn?.layer.cornerRadius = 10
//        unreadBtn?.layer.masksToBounds = true
        unreadBtn?.addTarget(self, action: #selector(pressBtn), for: .touchUpInside)
        self.contentView.addSubview(unreadBtn!)
        unreadBtn?.snp.makeConstraints({ (make) in
            make.top.equalTo(5)
            make.right.equalTo(-5)
            make.width.height.equalTo(20)
        })
    }
    
    @objc func pressBtn(){
        self.pressBlock()
    }
    
    func refreshWithModel(model:workMenuModel) {
        self.model = model
        menuLabel?.text = model.name
//        menuImage?.image = UIImage.init(named: "menuIcon_" + model.code!)
        menuImage?.image = UIImage.init(named: "menuIcon_menu_m_3_285")
        unreadBtn?.setTitle(model.unreadCount, for: .normal)
        
        if model.editState == true{
            self.layer.borderColor = UIColor.black.cgColor
            unreadBtn?.isHidden = false
            switch model.state {
                case .MenuState_canAdd:
                    unreadBtn?.setImage(UIImage.init(named: "home_menu_add"), for: .normal)
                case .MenuState_repeat:
                    unreadBtn?.setImage(UIImage.init(named: "home_menu_repeat"), for: .normal)
                case .MenuState_canReduce:
                    unreadBtn?.setImage(UIImage.init(named: "home_menu_reduce"), for: .normal)
                default:
                break
            }
            
        }else{
            self.layer.borderColor = UIColor.clear.cgColor
            unreadBtn?.isHidden = true
        }
    }
    
}
