//
//  MDCSwipeToChoose.swift
//  AZB_swift
//
//  Created by limbo on 2020/5/8.
//  Copyright © 2020 limbo. All rights reserved.
//

import Foundation

class MDCSwipeToChoose:BaseVC,MDCSwipeToChooseDelegate {
    
    var dataArray:Array<MDCSwipeToChooseView> = Array.init()
    var viewIndex:NSInteger?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let options = MDCSwipeToChooseViewOptions()
        //可以禁用手势，只通过代码滑动
//        options.swipeEnabled = false
        options.delegate = self as MDCSwipeToChooseDelegate
        options.likedText = "Keep"
        options.likedColor = UIColor.blue
        options.nopeText = "Delete"
        options.nopeColor = UIColor.red
        options.onPan = { state -> Void in
            if state?.thresholdRatio == 1 && state?.direction == .left {
                print("Photo deleted!")
            }
        }
        
        for i in 0..<2{
            let btn = UIButton.init()
            btn.backgroundColor = .yellow
            btn.setTitle(i == 0 ? "left" : "right", for: .normal)
            self.view.addSubview(btn)
            btn.snp.makeConstraints { (make) in
                make.width.equalTo(80)
                make.height.equalTo(50)
                make.top.equalTo(30)
                make.left.equalTo(i == 0 ? (kCommonScreenWidth/2-10-80) : (kCommonScreenWidth/2+10))
            }
            btn.reactive.controlEvents(.touchUpInside).observeValues { (btn) in
                if(self.viewIndex!<1){
                    return
                }
                let swipView = self.dataArray[self.viewIndex!]
                if(btn.titleLabel?.text=="left"){
                    swipView.mdc_swipe(.left)
                }else{
                    swipView.mdc_swipe(.right)
                }
            }
        }


        for i in 0..<15{
            let view = MDCSwipeToChooseView(frame: CGRect.init(x: (kCommonScreenWidth-300)/2+(i == 14 ? 6 : 0), y: (kCommonScreenHeight-500)/2+(i == 14 ? 6 : 0), width: 300, height: 500), options: options)
            dataArray.append(view!)
            view?.tag = i+100
            view?.imageView.image = UIImage(named: "login_BG")
            self.view.addSubview(view!)
        }
        viewIndex = dataArray.count-1
        
    }

    // This is called when a user didn't fully swipe left or right.
    func viewDidCancelSwipe(_ view: UIView) -> Void{
        print("Couldn't decide, huh?")
    }

    // Sent before a choice is made. Cancel the choice by returning `false`. Otherwise return `true`.
    func view(_ view: UIView, shouldBeChosenWith: MDCSwipeDirection) -> Bool {
        viewIndex = view.tag-100-1
        if(viewIndex!<0){
            SVProgressHUD.showInfo(withStatus: "已无更多卡片")
            // Snap the view back and cancel the choice.
            UIView.animate(withDuration: 0.16, animations: { () -> Void in
                view.transform = CGAffineTransform.identity
                view.center = view.superview!.center
            })
            return false
        }
        let newView = dataArray[viewIndex!]
        newView.frame = CGRect.init(x: (kCommonScreenWidth-300)/2+6, y: (kCommonScreenHeight-500)/2+6,width: 300, height: 500)
        return true
    }

    // This is called when a user swipes the view fully left or right.
    func view(_ view: UIView, wasChosenWith: MDCSwipeDirection) -> Void {
        if wasChosenWith == .left {
            print("Photo deleted!")
        } else {
            print("Photo saved!")
        }
    }
}

