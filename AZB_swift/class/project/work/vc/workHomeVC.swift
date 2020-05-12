//
//  workHomeVC.swift
//  AZB_swift
//
//  Created by limbo on 2020/4/1.
//  Copyright © 2020 limbo. All rights reserved.
//

import Foundation
import UIKit

class workHomeVC: BaseVC,UITableViewDelegate,UITableViewDataSource {
    
    var showEpidemic = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setEpidemicStatus()
        self.view.addSubview(headView!)
        self.view .addSubview(baseTable!)
        baseTable?.snp.makeConstraints({ (make) in
            make.top.equalTo(self.headView!.snp_bottom).offset(10)
            make.left.right.equalTo(0)
            make.bottom.equalTo(-kCommonTabAndStatus())
        })
        self.getIntegralData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        self.baseTable?.reloadData()
    }
    
    func setEpidemicStatus() {
//        let dict:Dictionary = Defaults[\.app_menuDict]!
//        let menuArray:Array = dict[menuDictKey] as! Array<Any>
//        for item in menuArray{
//            let dict = item as! Dictionary<String, Any>
//            if dict["code"] as! String == "menu_m_1_7"{
//                if(dict["show"] as? Bool == true){
//                    showEpidemic = true
//                    return
//                }
//            }
//        }
        showEpidemic = true
    }
    
// MARK: - network
    func getIntegralData() {
        NetworkTool.shareNetwork.POST(urlStr: "api/newkpi/v1/Result/app/scoreAndRank", parameDict: ["planId":"-1"], success: { (respon) in
            self.headView?.refreshWithDict(dict: respon!)
        }) { (error) in}
    }
    
// MARK: - tableview
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = workMenuHeadView.init(frame: CGRect.init(x: 0, y: 0, width: kCommonScreenWidth, height: 40))
        weak var weakSelf = self
        view.pressBlock = {
            let work = workHomeSubVC.init()
            work.refreshMenu = {
                let cell = weakSelf?.baseTable?.cellForRow(at:IndexPath.init(row: 0, section: 1)) as! workContentCell
                cell.refreshData()
            }
            weakSelf?.navigationController?.pushViewController(work, animated: true)
        }
        view.moreBtn?.isHidden = false
        view.titleLabel?.text = "常用功能"
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return section == 1 ? 40.0 : 0.0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return showEpidemic==true ? 1 : 0
        case 1:
            return 1
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell:workEpidemicCell = tableView.dequeueReusableCell(withIdentifier: "workEpidemicCell") as! workEpidemicCell
            return cell
        case 1:
            let cell:workContentCell = tableView.dequeueReusableCell(withIdentifier: "workContentCell") as! workContentCell
            cell.collectView?.reloadData()
            return cell
        default:
            return UITableViewCell.init()
        }
    }
    
// MARK: - lazy
    lazy var headView:workHeadView? = {
        return workHeadView.init(frame: CGRect.init(x: 0, y: 0, width: kCommonScreenWidth, height: 277))
    }()
    
    lazy var baseTable:BaseTabelView? = {
        let table = BaseTabelView.init(frame:CGRect.init(), style: .plain)
        table.delegate = self
        table.dataSource = self
        table.showsVerticalScrollIndicator = false
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = 50
        table.register(workContentCell.classForCoder(), forCellReuseIdentifier: "workContentCell")
        table.register(workEpidemicCell.classForCoder(), forCellReuseIdentifier: "workEpidemicCell")
        return table
    }()
}
