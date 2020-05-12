//
//  KolodaCards.swift
//  AZB_swift
//
//  Created by limbo on 2020/5/8.
//  Copyright © 2020 limbo. All rights reserved.
//

import Foundation

class KolodaCards:BaseVC{
    
    var kolodaView: KolodaView?
    var dataArray = ["","","","","","","","","",""]
    override func viewDidLoad() {
        super.viewDidLoad()
        kolodaView = KolodaView.init(frame: CGRect.init(x: (kCommonScreenWidth-300)/2, y: (kCommonScreenHeight-500)/2, width: 300, height: 500))
        kolodaView!.visibleCardsDirection = .top
        kolodaView!.dataSource = self
        kolodaView!.delegate = self
        self.view.addSubview(kolodaView!)
        
        let titleArray = ["left","right","reset","add","remove"]
        for i in 0..<titleArray.count{
            let btn = UIButton.init()
            btn.setTitleColor(.black, for: .normal)
            btn.backgroundColor = .yellow
            btn.setTitle(titleArray[i], for: .normal)
            self.view.addSubview(btn)
            btn.snp.makeConstraints { (make) in
                make.width.equalTo(50)
                make.height.equalTo(50)
                make.top.equalTo(30)
                make.left.equalTo(60*i+0)
            }
            btn.reactive.controlEvents(.touchUpInside).observeValues { (btn) in
                switch btn.titleLabel?.text{
                case "left":
                    self.kolodaView?.swipe(.left)
                    break
                case "reset":
                    self.kolodaView?.reloadData()
                    break
                case "right":
                    self.kolodaView?.swipe(.right)
                    break
                case "add":
                    
                    self.dataArray.insert("", at: 0)
                    self.dataArray.insert("", at: 1)
                    self.kolodaView?.insertCardAtIndexRange(0 ..< 2, animated: true)
                    
                    break
                case "remove":
                    self.dataArray.remove(at: 0)
                    self.kolodaView?.removeCardInIndexRange(0 ..< 1, animated: true)
                    break
                default:
                    break
                }
                
            }
        }
    }
}

extension KolodaCards: KolodaViewDelegate {
    func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
//        koloda.reloadData()
    }

    func koloda(_ koloda: KolodaView, didSelectCardAt index: Int) {
        UIApplication.shared.openURL(URL(string: "https://baidu.com")!)
    }
}

extension KolodaCards: KolodaViewDataSource {

    func kolodaNumberOfCards(_ koloda:KolodaView) -> Int {
        return dataArray.count
    }

    func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed {
        return .default
    }

    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        let label = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 50, height: 30))
        label.text = String(index)
        let imageView = UIImageView(image:UIImage.init(named: "login_BG"))
        imageView.addSubview(label)
        return imageView
    }
    

}
