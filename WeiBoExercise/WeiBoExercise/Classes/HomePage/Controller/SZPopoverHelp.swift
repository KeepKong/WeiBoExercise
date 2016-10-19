//
//  SZPopoverTool.swift
//  WeiBoExercise
//
//  Created by lx on 16/9/20.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

import UIKit


let ClickPopoverView = "ClickPopoverView"



class SZPopoverHelp: NSObject , UIViewControllerTransitioningDelegate , UIViewControllerAnimatedTransitioning{
    
    
    //声明一个 变量， 来记录现在 这个动画 是应该 出现 ，还是应该做消失
    var isPresent : Bool = false
    
    //接收外部 对 弹出视图大小的控制， 这个类把 值 传给presentation控制器类
    var newFrame : CGRect = CGRectZero
    
    
    
    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController? {

        
        let presentation =  SZPresentationC(presentedViewController: presented,  presentingViewController : presenting)
        

        
        return presentation
        
    }
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        

        
        isPresent = true
        
        //发通知
//        NSNotificationCenter.defaultCenter().postNotificationName(PopoverViewWillPresented, object: self)
        NSNotificationCenter.defaultCenter().postNotificationName(ClickPopoverView, object: self, userInfo: ["isPresent" : "true"])
        
        
        return self
        
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        isPresent = false
        
        //发通知

        
        NSNotificationCenter.defaultCenter().postNotificationName(ClickPopoverView, object: self, userInfo: ["isPresent" : "false"])


        return self
        
    }
    
    //返回你自定义的动画的时长
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        
        return 0.5
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        //1.通过key去获取控制器
        //2.通过key可以去获取视图
        
        
        
        if isPresent {  //出现的动画
            
            
            //要被呈现的视图

//            let fromView =  transitionContext.viewForKey(UITransitionContextFromViewKey)
            

            let toView = transitionContext.viewForKey(UITransitionContextToViewKey)
            
//            print("to : \(toView), from : \(fromView)")

            toView?.alpha = 0.01
            

            transitionContext.containerView()?.addSubview(toView!)
            
            //通过动画来显示
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                
                //动画产生
                toView?.alpha = 1.0
                
                
                }) { (_) -> Void in
                    

                    transitionContext.completeTransition(true)
                    
            }
            
            
            
        }else { 
            

            let fromView =  transitionContext.viewForKey(UITransitionContextFromViewKey)
            

            
            //通过动画来显示
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                
                //动画产生
                fromView?.alpha = 0.01
                
                
                }) { (_) -> Void in
                    

                    transitionContext.completeTransition(true)
                    
            }
            
            
            
            
            
        }
        
        
        
    }
    

}
