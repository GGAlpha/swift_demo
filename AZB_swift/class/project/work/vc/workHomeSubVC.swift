//
//  workHomeSubVC.swift
//  AZB_swift
//
//  Created by limbo on 2020/4/5.
//  Copyright © 2020 limbo. All rights reserved.
//

import Foundation

class workHomeSubVC: BaseVC,UICollectionViewDelegate,UICollectionViewDataSource {
    
    var collectionView:UICollectionView? = nil
    var editState:Bool = false
    var refreshMenu = {}

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "全部功能"
        self.setRightBarButtonItemTitle(title: "编辑")
        self.createUI()
    }
    
    
    @objc override func rightClick(){
        editState = !editState
        let title = editState == true ? "完成" : "编辑"
        self.setRightBarButtonItemTitle(title:title)
        for sectionModel in self.headArray{
            for model in sectionModel.children!{
                model.editState = !model.editState
            }
        }
        collectionView?.reloadData()
        if editState == false {
            var array = Array<Dictionary<String, Any>>.init()
            for item in headArray[0].children!{
                var dict = Dictionary<String, Any>.init()
                dict["name"] = item.name
                dict["code"] = item.code
                dict["id"] = item.id
                array.append(dict)
            }
            let jsonStr = CommonTool.getJSONStringFromArray(array: array)
            SVProgressHUD.show(withStatus: "保存中")
            NetworkTool.shareNetwork.POST(urlStr: "api/business/v1/roles/saveMenuApp", parameDict:["record":jsonStr], success: { (respon) in
                
                SVProgressHUD.showSuccess(withStatus: "已保存")
                SVProgressHUD.dismiss(withDelay: 2)
                Defaults[\.app_homeCustomMenuDict] = [homeMenuDictKey:array]
                self.refreshMenu()
                
            }) { (error) in}
        }
    }
    
    func createUI() {
        let layout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .vertical
        layout.headerReferenceSize = CGSize.init(width: kCommonScreenWidth, height: 40)
        layout.footerReferenceSize = CGSize.init(width: kCommonScreenWidth, height: 10)
        layout.itemSize = CGSize.init(width: WorkMenuW, height: WorkMenuH)
        layout.sectionInset = UIEdgeInsets.init(top: 10, left: CGFloat(WorkMenuDis), bottom: 10, right: CGFloat(WorkMenuDis))
        layout.minimumLineSpacing = CGFloat(WorkMenuDis)
        layout.minimumInteritemSpacing = CGFloat(WorkMenuDis)
        let collect = UICollectionView.init(frame: CGRect.init(), collectionViewLayout: layout)
        collectionView = collect
        collect.showsVerticalScrollIndicator = false
        collect.register(workMenuCell.classForCoder(), forCellWithReuseIdentifier: "workMenuCell")
        collect.register(workMenuHeadView.classForCoder(), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "workMenuHeadView")
        collect.register(UICollectionReusableView.classForCoder(), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "footView")
        collect.backgroundColor = .white
        collect.delegate = self
        collect.dataSource = self
        self.view.addSubview(collect)
        collect.snp.makeConstraints { (make) in
            make.top.right.left.bottom.equalTo(0)
        }
        collect.reloadData()
    }
    
// MARK: - collectionView
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader{
            let headerView : workMenuHeadView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "workMenuHeadView", for: indexPath) as! workMenuHeadView
            headerView.titleLabel?.text = headArray[indexPath.section].name
            return headerView as UICollectionReusableView
        }else{
            let footView : UICollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "footView", for: indexPath)
            footView.backgroundColor = kCommonLigthGray
            return footView
        }
    }

    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return headArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let model = headArray[section]
        return model.children!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:workMenuCell = collectionView.dequeueReusableCell(withReuseIdentifier: "workMenuCell", for: indexPath) as! workMenuCell
        let model = headArray[indexPath.section]
        cell.refreshWithModel(model: model.children![indexPath.item])
        weak var weakSelf = self
        weak var weakModel = model
        cell.pressBlock = {
            weakSelf?.refreshData(indexpath:indexPath, model: weakModel!.children![indexPath.item])
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        HomeMenuJumpTool.jumpWithModel(model: headArray[indexPath.section].children![indexPath.item])
    }
    
    func refreshData(indexpath:IndexPath,model:workMenuModel) {
        if indexpath.section == 0 {
            if headArray[0].children!.count <= 2 {
                SVProgressHUD.showInfo(withStatus: "自选菜单不得少于2个")
                SVProgressHUD.dismiss(withDelay: 2)
                return
            }else{
                self.headArray[0].children?.remove(at: indexpath.item)
                for i in 1...headArray.count-1 {
                    let sectionM = headArray[i]
                    for item in sectionM.children!{
                        if item.code == model.code {
                            item.state = MenuState.MenuState_canAdd
                            self.collectionView?.reloadData()
                            return
                        }
                    }
                }
            }
        }else{
            if model.state == MenuState.MenuState_canAdd{
                if headArray[0].children!.count == 9 {
                    SVProgressHUD.showInfo(withStatus: "自选菜单不得多于9个")
                    SVProgressHUD.dismiss(withDelay: 2)
                    return
                }else{
                    model.state = MenuState.MenuState_repeat
                    let addModel = workMenuModel.init()
                    addModel.code = model.code
                    addModel.name = model.name
                    addModel.id = model.id
                    addModel.state = MenuState.MenuState_canReduce
                    addModel.editState = true
                    self.headArray[0].children?.append(addModel)
                    self.collectionView?.reloadData()
                }
            }
        }
    }
    
//MARK: - lazy
    lazy var headArray:Array<workSectionMeunModel> = {
        let menuArray:Array = Defaults[\.app_menuDict]?[menuDictKey] as! Array<Any>
        var i = 0
        for item in menuArray{
            let dict = item as! Dictionary<String, Any>
            let code:String = dict["code"] as! String
            let name:String = dict["name"] as! String
            let isShow:Bool = dict["show"] as! Bool
            if isShow == true && code == "menu_m_1_1"{
                var array = Array<workSectionMeunModel>.init()
                //自定义菜单
                let customModel = workSectionMeunModel.init()
                var customModelArray = Array<workMenuModel>.init()
                for item in Defaults[\.app_homeCustomMenuDict]![homeMenuDictKey] as! Array<Dictionary<String, Any>>{
                    let model = workMenuModel()
                    model.setValuesForKeys(item)
                    model.state = MenuState.MenuState_canReduce
                    customModelArray.append(model)
                }
                customModel.children = customModelArray
                customModel.name = "常用功能"
                array.append(customModel)
                //非自定义菜单
                for item in dict["children"] as! Array<Dictionary<String, Any>>{
                    let model = workSectionMeunModel.init()
                    model.setValuesForKeys(item)
                    array.append(model)
                    //筛选重复的菜单并标注
                    var repeatCount = 0
                    for subItem in model.children!{
                        for customItem in customModel.children!{
                            if customItem.code == subItem.code{
                                subItem.state = MenuState.MenuState_repeat
                                repeatCount+=1
                                break
                            }
                        }
                        if(repeatCount == customModel.children?.count){
                            break
                        }
                    }
                }
                return array
            }
        }
        return []
    }()
}
