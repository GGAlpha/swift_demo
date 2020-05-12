//
//  WaterfallLayout.swift
//  AZB_swift
//
//  Created by limbo on 2020/5/12.
//  Copyright © 2020 limbo. All rights reserved.
//

import Foundation

class WaterfallLayoutVC: BaseVC {
    
    var collect:UICollectionView?
    lazy var dataArray:Array<CGFloat> = {
        var array = Array<CGFloat>.init()
        for i in 0..<30{
            array.append(CGFloat(arc4random()%110+80))
        }
        return array
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = waterLayout.init(HeightArr: dataArray)
        
        collect = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
        collect?.delegate = self
        collect?.dataSource = self
        collect?.backgroundColor = .white
        collect!.register(waterCell.self, forCellWithReuseIdentifier: "waterCell")
        self.view.addSubview(collect!)
        collect!.snp.makeConstraints { (make) in
            make.top.left.bottom.right.equalTo(0)
        }
        self.collect?.reloadData()
    }
}


extension WaterfallLayoutVC:UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "waterCell", for: indexPath)
            as? waterCell
        return cell!
    }
}

// MARK:layout
class waterLayout: UICollectionViewFlowLayout{
    var heigthArray:Array<CGFloat>?
    var attribArray = [UICollectionViewLayoutAttributes]()
    
    init(HeightArr:Array<CGFloat>){
        super.init()
        self.heigthArray = HeightArr
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepare() {
        super.prepare()
        self.minimumLineSpacing = 10
        self.minimumInteritemSpacing = 10
        scrollDirection = .vertical
        //记录两列分别的总高度
        var tupleH:(CGFloat,CGFloat) = (0.0,0.0)
        let width = (kCommonScreenWidth-minimumInteritemSpacing)/2
        for ( i,height) in (heigthArray?.enumerated())!{
            let layoutAttrib = UICollectionViewLayoutAttributes.init(forCellWith: IndexPath.init(item: i, section: 0))
            var rect = CGRect.init(x: 0, y: 0, width: width, height: height)
            if i == 0{
                rect.origin.x = 0
                rect.origin.y = 0
                rect.size.width = kCommonScreenWidth
                rect.size.height = 200
                tupleH.0+=200
                tupleH.1+=200
            }else{
                if tupleH.0<=tupleH.1{
                    rect.origin.x = 0
                    rect.origin.y = tupleH.0+minimumLineSpacing
                    tupleH.0+=(height+minimumLineSpacing)
                }else{
                    rect.origin.x = width+self.minimumInteritemSpacing
                    rect.origin.y = tupleH.1+minimumLineSpacing
                    tupleH.1+=(height+minimumLineSpacing)
                }
            }
            
            layoutAttrib.frame = rect
            attribArray.append(layoutAttrib)
        }
        //以最大一列的高度计算每个item高度的中间值，这样可以保证滑动范围的正确
        self.itemSize = CGSize.init(width: width, height: (tupleH.0<=tupleH.1 ? tupleH.1 : tupleH.0)*2.0/CGFloat(attribArray.count)-minimumLineSpacing)
        
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return self.attribArray
    }
    
}

// MARK:cell
class waterCell: CollectionViewSlantedCell {
    
    var imageView = UIImageView.init()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView.backgroundColor = kCommonRandomRGB()
        imageView.contentMode = .scaleAspectFill
        self.contentView.addSubview(self.imageView)
        imageView.snp.makeConstraints { (make) in
            make.top.bottom.right.left.equalTo(0)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


