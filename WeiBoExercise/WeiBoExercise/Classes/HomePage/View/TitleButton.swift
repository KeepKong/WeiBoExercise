//
//  TitleButton.swift
//  BeiwoWeibo
//
//  Created by JingYang on 16/9/20.
//  Copyright © 2016年 贝沃汇力IT. All rights reserved.
//

import UIKit

class TitleButton: UIButton {

    override init(frame : CGRect){
        
        super.init(frame: frame)
        
        //属性的设置
        setImage(UIImage(named: "navigationbar_arrow_up"), forState: .Normal)

        setImage(UIImage(named: "navigationbar_arrow_down"), forState: .Selected)
        
        //文本的字体
        setTitleColor(UIColor.darkGrayColor(), forState: .Normal)
        
        //自适应
        sizeToFit()
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //在布局子视图方法 中改变 文字和 图片的位置
    
    override func layoutSubviews() {
        
        super.layoutSubviews()

        
        //图文
        //文图
        titleLabel?.frame.origin.x = 0.0
        
        imageView?.frame.origin.x = titleLabel!.frame.size.width + 5.0
    }
    
    
    
    
}
