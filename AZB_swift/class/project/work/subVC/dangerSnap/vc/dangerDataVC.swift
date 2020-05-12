//
//  dangerDataVC.swift
//  AZB_swift
//
//  Created by limbo on 2020/4/9.
//  Copyright © 2020 limbo. All rights reserved.
//

import Foundation

class dangerDataVC: BaseVC,UITableViewDelegate,UITableViewDataSource {
    
    var pressBlock:((dangerSnapModel) -> ())?
    var dataArray:Results<dangerSnapModel>?
    var table:BaseTabelView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData()
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
    }
    
    func getData(){
        dataArray = dangerSnapDataTool.getDanger()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BaseTitleCell") as! BaseTitleCell
        let model = dataArray![indexPath.row]
        cell.refreshWith(title:String(model.id), content: model.postion)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.pressBlock != nil{
            let model = self.dataArray![indexPath.row]
            self.pressBlock!(model.mutableCopy() as! dangerSnapModel)
        }
        navigationController?.popViewController(animated: true)
    }
}
