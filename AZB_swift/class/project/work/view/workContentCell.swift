//
//  workContentCell.swift
//  AZB_swift
//
//  Created by limbo on 2020/4/3.
//  Copyright © 2020 limbo. All rights reserved.
//

import Foundation

class workContentCell: BaseTableviewCell,UICollectionViewDelegate,UICollectionViewDataSource {
    
    var collectView:UICollectionView?
    var menuArray:Array<workMenuModel>? = []
    
    override func createCellUI() {
        self.refreshData()
        
        let layout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize.init(width: WorkMenuW, height: WorkMenuH)
        layout.sectionInset = UIEdgeInsets.init(top: 10, left: CGFloat(WorkMenuDis), bottom: 10, right: CGFloat(WorkMenuDis))
        layout.minimumLineSpacing = CGFloat(WorkMenuDis)
        layout.minimumInteritemSpacing = CGFloat(WorkMenuDis)
        let collect = UICollectionView.init(frame: CGRect.init(), collectionViewLayout: layout)
        collect.register(workMenuCell.classForCoder(), forCellWithReuseIdentifier: "workMenuCell")
        collectView = collect
        collect.backgroundColor = .white
        collect.delegate = self
        collect.dataSource = self
        collect.isScrollEnabled = false
        self.contentView.addSubview(collect)
        var h = CGFloat(0)
        if(menuArray!.count<=3 && menuArray!.count>0){
            h = CGFloat(WorkMenuH) + CGFloat(WorkMenuDis*2)
        }else if (menuArray!.count<=6){
            h = CGFloat(WorkMenuH*2)+CGFloat(WorkMenuDis*3)
        }else{
            h = CGFloat(WorkMenuH*3)+CGFloat(WorkMenuDis*4)
        }
        collect.snp.makeConstraints { (make) in
            make.top.right.left.bottom.equalTo(0)
            make.height.equalTo(h)
        }
        collect.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.menuArray!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:workMenuCell = collectionView.dequeueReusableCell(withReuseIdentifier: "workMenuCell", for: indexPath) as! workMenuCell
        cell.refreshWithModel(model: self.menuArray![indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        HomeMenuJumpTool.jumpWithModel(model: menuArray![indexPath.item])
    }
    
    func refreshData() {
        self.menuArray?.removeAll()
        let jsonArray = Defaults[\.app_homeCustomMenuDict]![homeMenuDictKey]
        for item in jsonArray as! Array<Dictionary<String, Any>>{
            let model = workMenuModel()
            model.setValuesForKeys(item)
            self.menuArray?.append(model)
        }
    }
}
