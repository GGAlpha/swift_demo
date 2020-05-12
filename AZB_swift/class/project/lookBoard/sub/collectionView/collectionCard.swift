//
//  collectionCard.swift
//  AZB_swift
//
//  Created by limbo on 2020/5/8.
//  Copyright © 2020 limbo. All rights reserved.
//

import Foundation

class collectionCardTable: BaseVC,UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell")
        cell?.textLabel?.text = "\(dataArray[indexPath.row].self)"
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let card = collectionCard.init()
        card.animated = dataArray[indexPath.row] as! LayoutAttributesAnimator
        navigationController?.pushViewController(card, animated: true)
    }
    
    var dataArray = [CrossFadeAttributesAnimator(),CubeAttributesAnimator(),LinearCardAttributesAnimator(),PageAttributesAnimator(),ParallaxAttributesAnimator(),RotateInOutAttributesAnimator(),SnapInAttributesAnimator(),ZoomInOutAttributesAnimator()] as [Any]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let table = UITableView.init()
        table.delegate = self
        table.dataSource = self
        table.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "UITableViewCell")
        self.view.addSubview(table)
        table.snp.makeConstraints { (make) in
            make.top.bottom.right.left.equalTo(0)
        }
    }
}

class collectionCard: BaseVC {
    
    var animated:LayoutAttributesAnimator?
//    var animator: (LayoutAttributesAnimator, Bool, Int, Int)?
    var collect:UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = AnimatedCollectionViewLayout()
        layout.scrollDirection = .horizontal
        layout.animator = animated
        layout.itemSize = CGSize.init(width: kCommonScreenWidth, height: kCommonScreenHeight-kCommonNavAndStatus())
        //使用该库行列间距需设置为0，否则会跟库中的预设冲突
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
//        layout.sectionInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        
        collect = UICollectionView.init(frame: CGRect.init(x: 0, y: 0, width: kCommonScreenWidth, height: kCommonScreenHeight), collectionViewLayout: layout as UICollectionViewFlowLayout)
        collect?.isPagingEnabled = true
        collect?.delegate = self
        collect?.dataSource = self
        collect?.backgroundColor = .white
        collect!.register(collectionCell.classForCoder(), forCellWithReuseIdentifier: "collectionCell")
        collect?.register(UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "UICollectionViewCell")
        self.view.addSubview(collect!)
        collect!.snp.makeConstraints { (make) in
            make.top.left.bottom.right.equalTo(0)
        }
    }
}

extension collectionCard:UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell", for: indexPath)
        cell.contentView.backgroundColor = kCommonRandomRGB()
        return cell
    }
}

// MARK:cell
class collectionCell: UICollectionViewCell {
    
    var label:UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createUI(){
        label = UILabel.init()
        contentView.addSubview(label!)
        label?.backgroundColor = kCommonRandomRGB()
        label?.textAlignment = .center
        label!.snp.makeConstraints { (make) in
            make.top.bottom.left.right.equalTo(0)
            make.height.width.equalTo(50)
        }
    }
}
