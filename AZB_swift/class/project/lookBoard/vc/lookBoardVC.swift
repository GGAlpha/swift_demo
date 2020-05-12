//
//  lookBoardVC.swift
//  AZB_swift
//
//  Created by limbo on 2020/4/1.
//  Copyright © 2020 limbo. All rights reserved.
//

import Foundation

class lookBoardVC: BaseVC,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createUI()
    }
    
    func createUI() {
        let layout = UICollectionViewLeftFlowLayout.init()
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = CGSize.init(width: kCommonScreenWidth, height: 30)
        layout.sectionInset = UIEdgeInsets.init(top: 15, left: 15, bottom: 15, right: 15)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        let collect = UICollectionView.init(frame: CGRect.init(), collectionViewLayout: layout)
        collect.backgroundColor = .white
        collect.showsVerticalScrollIndicator = false
        collect.register(practiceCell.classForCoder(), forCellWithReuseIdentifier: "practiceCell")
        collect.delegate = self
        collect.dataSource = self
        self.view.addSubview(collect)
        collect.snp.makeConstraints { (make) in
            make.top.right.left.bottom.equalTo(0)
        }
        collect.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return lookJumpTool.getArray().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:practiceCell = collectionView.dequeueReusableCell(withReuseIdentifier: "practiceCell", for: indexPath) as! practiceCell
        cell.label?.text = lookJumpTool.getArray()[indexPath.item]
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        lookJumpTool.jumpWith(text:lookJumpTool.getArray()[indexPath.item],navigationController:self.navigationController as! BaseNavigationVC)
    }
    
    
}


