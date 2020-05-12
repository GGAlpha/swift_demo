//
//  collectStandLayout.swift
//  AZB_swift
//
//  Created by limbo on 2020/5/10.
//  Copyright © 2020 limbo. All rights reserved.
//

import Foundation

// - (CGRect)convertRect:(CGRect)rect toView:(nullable UIView *)view;
// 把以A视图为坐标系的rect1转换为以B视图为坐标系的rect2并返回rect2
//CGRect rect2 = [A convertRect:rect1 toView:B];

// - (CGRect)convertRect:(CGRect)rect fromView:(nullable UIView *)view;
// 把以B视图为坐标系的frame1转换为以B视图为坐标系的frame2并返回frame2
//CGRect frame2 = [A convertRect:frame1 fromView:B];

class collectStandLayout: BaseVC {
    
    var collect:UICollectionView?
    var layout:CollectionViewSlantedLayout?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout = CollectionViewSlantedLayout()
        layout?.isFirstCellExcluded = true
        layout?.isLastCellExcluded = true
        layout!.slantingSize = 50
        layout?.lineSpacing = 10
        //        layout.slantingDirection = .downward
        
        
        collect = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout!)
        collect?.delegate = self
        collect?.dataSource = self
        collect?.backgroundColor = .white
        collect!.register(CustomCollectionCell.classForCoder(), forCellWithReuseIdentifier: "CustomCollectionCell")
        self.view.addSubview(collect!)
        collect!.snp.makeConstraints { (make) in
            make.top.left.bottom.right.equalTo(0)
        }
        self.collect?.reloadData()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
}


extension collectStandLayout:UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCollectionCell", for: indexPath)
            as? CustomCollectionCell
        
        cell!.image = UIImage(named:String(indexPath.item))!


//        if let lay = collectionView.collectionViewLayout as? CollectionViewSlantedLayout {
//            cell!.lab.transform = CGAffineTransform(rotationAngle: 75)
//        }
        return cell!
    }
}

extension collectStandLayout: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let collectionView = collect else {return}
        guard let visibleCells = collectionView.visibleCells as? [CustomCollectionCell] else {return}
        for parallaxCell in visibleCells {
            let yOffset = (collectionView.contentOffset.y - parallaxCell.frame.origin.y) / parallaxCell.imageHeight
//            let xOffset = (collectionView.contentOffset.x - parallaxCell.frame.origin.x) / parallaxCell.imageWidth
            parallaxCell.offset(CGPoint(x: 0, y: yOffset * yOffsetSpeed))
        }
    }
}

let yOffsetSpeed: CGFloat = 150.0
let xOffsetSpeed: CGFloat = 100.0
// MARK:cell
class CustomCollectionCell: CollectionViewSlantedCell {

    var imageView = UIImageView.init()
    var lab = UILabel.init()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView.contentMode = .scaleAspectFill
        self.contentView.addSubview(self.imageView)
        imageView.snp.makeConstraints { (make) in
            make.width.equalTo(kCommonScreenWidth)
            make.height.equalTo(imageHeight)
            make.top.bottom.right.left.equalTo(0)
        }

        lab.frame = CGRect.init(x: 0, y: 0, width: 40, height: 20)
        lab.backgroundColor = .yellow
        lab.text = "asdf"
        self.contentView.addSubview(lab)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var image: UIImage = UIImage() {
        didSet {
            imageView.image = image
        }
    }

    var imageHeight: CGFloat {
        return (imageView.image?.size.height) ?? 0.0
    }

    var imageWidth: CGFloat {
        return (imageView.image?.size.width) ?? 0.0
    }

    func offset(_ offset: CGPoint) {
        imageView.frame = imageView.bounds.offsetBy(dx: offset.x, dy: offset.y)
    }
    
}
