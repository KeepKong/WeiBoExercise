//
//  SZHomeRefresh.swift
//  WeiBoExercise
//
//  Created by lx on 16/10/6.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

import UIKit

class SZHomeRefresh: UIRefreshControl {

    
    override init() {
        super.init()
        
        
        //加载子视图
        loadSubviews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //懒加载
    private lazy var refreshView : SZRefreshView = SZRefreshView.refreshView()
    
    //刷新加载的动画是否开始了，
    private var isloadingAnimationStart = false
    
    //flag 来标记这个箭头的动画，
    var isArrowRotation = false
    
    //私有方法
    private func loadSubviews() {
        
        addSubview(refreshView)
        
        //布局这个视图
        //        refreshView.frame = CGRectMake(0, 0, 170, 60)
        //        refreshView.center = center
        
        refreshView.translatesAutoresizingMaskIntoConstraints = false
        
        let centerX = NSLayoutConstraint.init(item: refreshView, attribute: .CenterX, relatedBy: .Equal, toItem: self, attribute: .CenterX, multiplier: 1.0, constant: 0.0)
        
        let centerY = NSLayoutConstraint.init(item: refreshView, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1.0, constant: 0.0)
        
        
        let width = NSLayoutConstraint.init(item: refreshView, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .Width, multiplier: 1.0, constant: 160.0)
        
        let height = NSLayoutConstraint.init(item: refreshView, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .Height, multiplier: 1.0, constant: 60.0)
        
        addConstraints([centerX, centerY, width, height])
        
        //监听y值的变化
        addObserver(self, forKeyPath: "frame", options: .New, context: nil)
        
    }
    
    
    //2.接收到 KVO的属性变化后的 响应方法
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        
        
//        print(frame.origin.y)
        
        //过滤到前面的数据
        if frame.origin.y >= 0 {
            
            return
        }
        
        
        if frame.origin.y >= -50 && isArrowRotation{
            

            isArrowRotation = false
            

            refreshView.arrowAnimation(isArrowRotation)
            
            
            return
        }
        
        if frame.origin.y < -50 && !isArrowRotation{
            
            //print("up")
            
            isArrowRotation = true
            

            refreshView.arrowAnimation(isArrowRotation)
            
            return
            
        }
        
        //用户会释放双手，开始刷新，
        //防止 多个动画 同时添加到层上进行，加快动画效果
        if refreshing && !isloadingAnimationStart{
            
            //显示 刷新视图
//            print("正在刷新。。。")
            
            //开启一个 转圈的动画， loadingView显示，
            refreshView.startLoadingAnimation()
            
            isloadingAnimationStart = true
            
            return
            
        }
        
        
    }
    
    
    //结束刷新
    override func endRefreshing() {
        super.endRefreshing()
        
//        print("--------end")
        
        
        //复位
        isloadingAnimationStart = false
        
        //停止动画
        refreshView.stopLoadingAnimation()
        
        
    }
    
    
    
    //3.移除KVO观察
    deinit{
        
        removeObserver(self, forKeyPath: "frame")
        
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
