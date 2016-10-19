//
//  SZAmongCell.swift
//  WeiBoExercise
//
//  Created by lx on 16/9/30.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

import UIKit

class SZAmongCell: UICollectionViewCell {
    
    
    var itemImage : UIImageView?
    
    var isGifFlag : UILabel?
    
    //定义所有存储的图片数组
    var imageUrlArr : [NSURL]?
    {
    
        didSet
        {
        

            
        }
    
    }
    
    
    override init(frame: CGRect) {
        
        
        
        super.init(frame: frame)
        
        itemImage = UIImageView.init(frame: contentView.bounds)
        
        contentView.addSubview(itemImage!)
        
        //设置GIF标识
        isGifFlag = UILabel.init(frame: CGRectMake(frame.size.width - 40, frame.size.height - 20, 40, 20))
        
        isGifFlag?.backgroundColor = UIColor.init(colorLiteralRed: 169/255.0, green: 191/255.0, blue: 223/255.0, alpha: 0.8)
        isGifFlag?.textColor = UIColor.whiteColor()
        isGifFlag?.textAlignment = .Center
        isGifFlag?.text = "GIF"
        isGifFlag?.hidden = true
        itemImage?.addSubview(isGifFlag!)
        
//        contentView.backgroundColor = UIColor.cyanColor()

        
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
