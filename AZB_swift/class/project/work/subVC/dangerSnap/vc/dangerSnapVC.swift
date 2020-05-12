//
//  dangerSnapVC.swift
//  AZB_swift
//
//  Created by limbo on 2020/4/7.
//  Copyright © 2020 limbo. All rights reserved.
//

import Foundation

class dangerSnapVC: BaseVC,OpalImagePickerControllerDelegate,UITableViewDelegate,UITableViewDataSource {
    
    var imageCell:SelectImageTableCell?
    var model:dangerSnapModel?
    var table:UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "巡视快拍"
        let array = dangerSnapDataTool.getDanger()
        model = dangerSnapModel.init()
        model?.content = "内容"+String(array.count)
        model?.postion = "部位"+String(array.count)
        model?.typ = "类型"+String(array.count)
        model?.people = "人"+String(array.count)
        model?.time = "时间"+String(array.count)
        self.setRightBarButtonItemTitle(title: "记录")
        createUI()
    }
    
    func createUI() {
        table = BaseTabelView.init()
        table!.delegate = self
        table!.dataSource = self
        table!.rowHeight = UITableView.automaticDimension
        table!.estimatedRowHeight = 50
        table!.register(SelectImageTableCell.classForCoder(), forCellReuseIdentifier: "SelectImageTableCell")
        table!.register(BaseTitleCell.classForCoder(), forCellReuseIdentifier: "BaseTitleCell")
        table!.register(dangerSnapSelectCell.classForCoder(), forCellReuseIdentifier: "dangerSnapSelectCell")
        self.view.addSubview(table!)
        table!.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(0)
        }
        table!.reloadData()
        
        let logOutBtn = UIButton.init()
        logOutBtn.setTitle("本地保存", for: .normal)
        logOutBtn.setTitleColor(.white, for: .normal)
        logOutBtn.backgroundColor = kCommonBlue
        logOutBtn.addTarget(self, action: #selector(pressSave), for: .touchUpInside)
        self.view.addSubview(logOutBtn)
        logOutBtn.snp.makeConstraints { (make) in
            make.bottom.equalTo(-100)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(50)
        }
    }
    
    @objc func pressSave(){
        self.model?.imageArray.removeAll()
        for obj in (imageCell?.photoView?.imageArray!)!{
            let submodel = SelectImageModel.init()
            if obj.isKind(of: UIImage.classForCoder()){
                submodel.imageData = UIImage.pngData(obj as! UIImage)() as NSData?
            }
            if obj.isKind(of: NSData.classForCoder()){
                submodel.imageData = (obj as! NSData)
            }
            self.model?.imageArray.append(submodel)
        }
        
        let array = dangerSnapDataTool.getDanger()
        model?.id = array.count
        
        dangerSnapDataTool.insertDanger(by: self.model!.mutableCopy() as! dangerSnapModel)
        SVProgressHUD.showSuccess(withStatus: "保存成功")
        SVProgressHUD.dismiss(withDelay: 2)
    }
    
    @objc override func rightClick(){
        let danger = dangerDataVC.init()
        danger.pressBlock = {(model) in
            self.model = model
            self.imageCell?.photoView?.imageArray?.removeAll()
            for item in model.imageArray{
                self.imageCell?.photoView?.imageArray?.append(item.imageData!)
            }
            self.imageCell?.photoView?.refreshData()
            self.table?.reloadData()
        }
        navigationController?.pushViewController(danger, animated: true)
    }
    
//MARK: - tableview
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 3
        case 2:
            return model?.index == 0 ? 1 : 3
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SelectImageTableCell") as! SelectImageTableCell
            imageCell = cell
            cell.photoView?.maxImage = 20
            cell.photoView!.refreshBlock = {
                tableView.reloadData()
            }
            return cell
        case 1:
            let titleArr = ["检查部位","检查内容","检查类别"]
            let contentArr = [model?.postion,model?.content,model?.typ]
            let cell = tableView.dequeueReusableCell(withIdentifier: "BaseTitleCell") as! BaseTitleCell
            cell.refreshWith(title: titleArr[indexPath.row], content: contentArr[indexPath.row]!)
            return cell
        case 2:
            if(indexPath.row == 0){
                weak var weakSelf = self
                let cell = tableView.dequeueReusableCell(withIdentifier: "dangerSnapSelectCell") as! dangerSnapSelectCell
                cell.pressBlock = {
                    weakSelf?.model?.index = weakSelf?.model?.index == 0 ? 1 : 0
                    weakSelf?.table?.reloadData()
                }
                return cell
            }else{
                let titleArr = ["","整改人","整改期限"]
                let contentArr = ["",model?.people,model?.time]
                let cell = tableView.dequeueReusableCell(withIdentifier: "BaseTitleCell") as! BaseTitleCell
                cell.refreshWith(title: titleArr[indexPath.row], content: contentArr[indexPath.row]!)
                return cell
            }
            
        default:
            return BaseTableviewCell.init()
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 2 && indexPath.row == 1{
            let vc = selectPeopleVC.init()
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
