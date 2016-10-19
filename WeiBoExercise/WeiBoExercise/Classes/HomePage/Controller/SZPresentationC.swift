//
//  SZPresentationC.swift
//  WeiBoExercise
//
//  Created by lx on 16/9/20.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

import UIKit

class SZPresentationC: UIPresentationController {

    
    var newFrame : CGRect = CGRectZero
    
    override init(presentedViewController: UIViewController, presentingViewController: UIViewController) {
        
        super.init(presentedViewController: presentedViewController, presentingViewController: presentingViewController)
        
        

        
        
    }
    
    
    
    // PresentationController 用过一个 容器 container来管理 它上面的 presentedView --》 是presentedViewController
    override func containerViewWillLayoutSubviews() {
        //容器视图 将要布局子视图
        
        //container 这个容器视图 管理 presentedView
        
        super.containerViewWillLayoutSubviews()
        
        if newFrame == CGRectZero {
            
            //因为现在这个大小 是 给死，也可以从外面根据情况来给定
            presentedView()?.frame = CGRectMake((UIScreen.mainScreen().bounds.size.width - 200.0)/2.0, 70, 200, 300)
            
        }else{
            
            presentedView()?.frame = newFrame
            
        }
        
        
        
        //增加一个 灰色的半透明蒙板
        //点击这个蒙板，应该 模态出去
        containerView?.insertSubview(mask, atIndex: 0)
        
    }
    
    
    
    func backAction(){
        
        presentedViewController.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
    lazy var mask : UIView = {
        
        
        let mask = UIView(frame: UIScreen.mainScreen().bounds)
        
        //小于等于0.01， 视图不再接受事件
        mask.backgroundColor = UIColor(white: 0.0, alpha: 0.02)
        
        //增加手势
        let tapGes = UITapGestureRecognizer(target: self, action: "backAction")
        
        mask.addGestureRecognizer(tapGes)
        
        return mask
        
    }()
    
    
}
