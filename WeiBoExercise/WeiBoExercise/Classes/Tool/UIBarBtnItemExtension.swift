//
//  UIBarBtnItemExtension.swift
//  BeiwoWeibo
//
//  Created by JingYang on 16/9/20.
//  Copyright © 2016年 贝沃汇力IT. All rights reserved.
//

import UIKit

//延展使用关键字 extension
/*
extension 哪一个类的类目 {
    
    //扩展的 方法
    
    
}
*/

extension UIBarButtonItem {
    
    //扩展一个类方法
    class func createBarButtonItem(imageName : String, target : AnyObject? , action : Selector) -> UIBarButtonItem {
        
        
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), forState: .Normal)
        btn.setImage(UIImage(named: imageName + "_highlighted"), forState: .Highlighted)
        
        btn.addTarget(target, action: action, forControlEvents: .TouchUpInside)
        
        //自适应大小
        btn.sizeToFit()
        
        return UIBarButtonItem(customView: btn)
        
    }
    
    
    
}