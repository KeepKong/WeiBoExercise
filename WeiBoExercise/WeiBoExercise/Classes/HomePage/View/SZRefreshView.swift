//
//  SZRefreshView.swift
//  WeiBoExercise
//
//  Created by lx on 16/10/6.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

import UIKit

class SZRefreshView: UIView {

    
    @IBOutlet weak var arrowView: UIImageView!
    
    
    @IBOutlet weak var refreshLabel: UILabel!
    
    
    @IBOutlet weak var loadingView: UIView!
   
    
    @IBOutlet weak var cycleView: UIImageView!
    
    
    class func refreshView() -> SZRefreshView {
        
        //加载xib，返回
        
        return NSBundle.mainBundle().loadNibNamed("SZHomeRefresh", owner: nil, options: nil).last as! SZRefreshView
        
    }
    
    
    //动画
    func arrowAnimation(flag: Bool){
        
        UIView.animateWithDuration(0.25, animations: { () -> Void in
            
            
            let angle = flag ? M_PI + 0.01 : M_PI - 0.01
            
            self.arrowView.transform = CGAffineTransformRotate(self.arrowView.transform, CGFloat(angle))
            
        })
        
        
        
        //label的文字内容变换
        if flag {
            
            refreshLabel.text = "上拉释放"
            
        }else{
            
            refreshLabel.text = "下拉更新"
            
        }
        
    }
    
    
    
    func startLoadingAnimation(){
        

        loadingView.hidden = false
        

        let animation = CABasicAnimation(keyPath: "transform.rotation")

        animation.toValue = 2 * M_PI
        
        //重复
        animation.repeatCount = HUGE
        
        //时长
        animation.duration = 1.0
        
        //动画结束后 是否移除
        animation.removedOnCompletion = false
        
        //3.添加给对应的图层
        cycleView.layer.addAnimation(animation, forKey: nil)
        
        
        
        
    }
    
    
    func stopLoadingAnimation(){
        
        //隐藏
        loadingView.hidden = true
        
        
        //移除旋转动画
        cycleView.layer.removeAllAnimations()
        
    }
    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
