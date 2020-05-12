//
//  selectPeopleSubVC.swift
//  AZB_swift
//
//  Created by limbo on 2020/4/12.
//  Copyright © 2020 limbo. All rights reserved.
//

import Foundation

class selectPeopleSubVC: BaseVC,UITableViewDelegate,UITableViewDataSource {
   
    weak var superVC:selectPeopleVC?
    var table:UITableView?
    var array:Array = ["asdf","asdfasdfasdfasdf","as","asdffasdf","sdfasdfasdfasf"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .yellow
        createUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        superVC!.collect!.reloadData()
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
            make.top.equalTo(30)
            make.left.right.bottom.equalTo(0)
        }
        table!.reloadData()
    }
    
   
//MARK: - tableview
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BaseTitleCell") as! BaseTitleCell
        let array =
            cell.refreshWith(title:self.array[indexPath.item], content: "")
            return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let subvc = selectPeopleSubVC.init()
        subvc.superVC = self.superVC
        subvc.title = self.array[indexPath.item]
        self.navigationController?.pushViewController(subvc, animated: true)
    }
    
    
}
