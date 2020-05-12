//
//  selectPeopleVC.swift
//  AZB_swift
//
//  Created by limbo on 2020/4/12.
//  Copyright © 2020 limbo. All rights reserved.
//

import Foundation

class selectPeopleVC: BaseVC,UICollectionViewDelegate,UICollectionViewDataSource{
    
    var nav:BaseNavigationVC?
    var table:UITableView?
    var collect:UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "选人"
        
        let subvc:selectPeopleSubVC = selectPeopleSubVC.init() 
        subvc.superVC = self
        nav = BaseNavigationVC.init(rootViewController:subvc )
        self.addChild(nav!)
        self.view.addSubview(nav!.view)
        addCollectionview()
    }
    
    
    func addCollectionview(){
        let layout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = CGSize.init(width: kCommonScreenWidth, height: 30)
        layout.sectionInset = UIEdgeInsets.init(top: 0, left: 15, bottom: 0, right: 15)
        collect = UICollectionView.init(frame: CGRect.init(), collectionViewLayout: layout)
        collect!.showsVerticalScrollIndicator = false
        collect!.register(selectPeopleNavCell.classForCoder(), forCellWithReuseIdentifier: "selectPeopleNavCell")
        collect?.showsHorizontalScrollIndicator = true
        collect!.backgroundColor = .white
        collect!.delegate = self
        collect!.dataSource = self
        self.view.addSubview(collect!)
        collect!.snp.makeConstraints { (make) in
            make.top.right.left.equalTo(0)
            make.height.equalTo(30)
        }
        collect!.reloadData()
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (nav?.children.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "selectPeopleNavCell", for: indexPath) as! selectPeopleNavCell
        cell.label?.text = indexPath.item == 0 ? title : nav?.children[indexPath.item].title
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        nav?.popToViewController((nav?.children[indexPath.item])!, animated: true)
        collectionView.reloadData()
    }
}
