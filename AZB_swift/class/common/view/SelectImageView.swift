//
//  SelectImageView.swift
//  AZB_swift
//
//  Created by limbo on 2020/4/8.
//  Copyright © 2020 limbo. All rights reserved.
//

import Foundation
import Photos
let ImageW = (kCommonScreenWidth-60)/5
let ImageH = ImageW
let ImageDis = 10

class SelectImageView: UIView,UICollectionViewDelegate,UICollectionViewDataSource,OpalImagePickerControllerDelegate {

    var maxImage:Int!
    var countLabel:UILabel?
    var collect:UICollectionView?
    var imageArray:Array<AnyObject>?
    var refreshBlock = {}
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createUI() {
        imageArray = Array.init()
        maxImage = 9
        let titleLabel = UILabel.init()
        titleLabel.text = "附件照片"
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.top.equalTo(0)
            make.height.equalTo(50)
        }
        
        countLabel = UILabel.init()
        countLabel!.text = "(0/\(String(maxImage)))"
        countLabel!.font = UIFont.systemFont(ofSize: 16)
        self.addSubview(countLabel!)
        countLabel!.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel.snp_right).offset(10)
            make.top.equalTo(0)
            make.height.equalTo(50)
        }
        
        let addBtn = UIButton.init()
        addBtn.setImage(UIImage.init(named: "add_photo"), for: .normal)
        addBtn.addTarget(self, action: #selector(pressAdd), for: .touchUpInside)
        self.addSubview(addBtn)
        addBtn.snp.makeConstraints { (make) in
            make.right.equalTo(-15)
            make.top.equalTo(0)
            make.height.equalTo(50)
        }
        
        let layout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize.init(width: ImageW, height: ImageH)
        layout.sectionInset = UIEdgeInsets.init(top:0.0, left: CGFloat(ImageDis), bottom: CGFloat(ImageDis), right: CGFloat(ImageDis))
        layout.minimumLineSpacing = CGFloat(ImageDis)
        layout.minimumInteritemSpacing = CGFloat(ImageDis)
        collect = UICollectionView.init(frame: CGRect.init(), collectionViewLayout: layout)
        collect?.register(SelectImageCell.classForCoder(), forCellWithReuseIdentifier: "SelectImageCell")
        collect!.backgroundColor = .white
        collect!.delegate = self
        collect!.dataSource = self
        collect!.isScrollEnabled = false
        self.addSubview(collect!)
        collect?.snp.makeConstraints({ (make) in
            make.right.left.equalTo(0)
            make.top.equalTo(50)
            make.height.equalTo(1)
            make.bottom.equalTo(0)
        })
    }
    
    @objc func pressAdd(){
        
        let imagePicker = OpalImagePickerController()
        imagePicker.modalPresentationStyle = .fullScreen
        imagePicker.imagePickerDelegate = self
        imagePicker.selectionTintColor = UIColor.white.withAlphaComponent(0.5)
        imagePicker.selectionImageTintColor = kCommonBlue
        imagePicker.statusBarPreference = UIStatusBarStyle.lightContent
        imagePicker.maximumSelectionsAllowed = maxImage!
        let configuration = OpalImagePickerConfiguration()
        configuration.maximumSelectionsAllowedMessage = NSLocalizedString("请勿超出图片张数限制", comment: "")
        imagePicker.configuration = configuration
        kCommonWindow.rootViewController?.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePicker(_ picker: OpalImagePickerController, didFinishPickingAssets assets: [PHAsset]){
        if imageArray!.count + assets.count>maxImage!{
            SVProgressHUD.showError(withStatus: "请勿超出图片张数限制")
            SVProgressHUD.dismiss(withDelay: 2)
            picker.dismiss(animated: true, completion: nil)
            return
        }
        
        var i = 0
        for asset in assets {
            let options = PHImageRequestOptions.init();
            options.deliveryMode = .highQualityFormat; //I only want the highest possible quality
            options.isSynchronous = false;
            options.isNetworkAccessAllowed = true;
            PHImageManager.default().requestImage(for: asset, targetSize: kCommonWindow.frame.size, contentMode: .aspectFill, options: options) { (image, infoDict) in
                self.imageArray?.append(image!)
                i+=1
                if i == assets.count{
                    self.refreshData()
                    picker.dismiss(animated: true, completion: nil)
                }
            }
            
        }

    }
    
    func refreshData() {
        countLabel?.text = "(\(String(imageArray!.count))/\(String(maxImage)))"
        let surplus:Int = imageArray!.count%5
        let count:Int = imageArray!.count/5
        let h = CGFloat(count)*(ImageW+10) + (surplus == 0 ? 0.0 : (ImageW+10))
        collect?.snp.updateConstraints({ (make) in
            make.right.left.equalTo(0)
            make.top.equalTo(50)
            make.height.equalTo(h)
            make.bottom.equalTo(0)
        })
        collect?.reloadData()
        self.refreshBlock()
    }
    
//MARK: - collectionview
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:SelectImageCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectImageCell", for: indexPath) as! SelectImageCell
        cell.refreshImage(image: imageArray![indexPath.item] as AnyObject)
        return cell
    }
}
