//
//  SZImageCell.swift
//  WeiBoExercise
//
//  Created by lx on 16/10/6.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

import UIKit
import SDWebImage



class SZImageCell: UICollectionViewCell {

    

    @IBOutlet weak var imgView: UIImageView!
    
    

    
    @IBOutlet weak var imgHeight: NSLayoutConstraint!
    
    

    
//    var resultName2 = usernames.sort { (s1: String, s2: String) -> Bool in
//        return s1 < s2
//    }
    
    let group = dispatch_group_create()

    var imgURL : NSURL?
    {
    
        didSet
        {
        
            //处理获取到的URL，变成大图URL
            var imageStr = imgURL?.absoluteString
            
        imageStr?.replaceRange((imageStr?.rangeOfString("thumbnail"))!, with: "large")
            
//            print(imageStr)
            
            
            //下次进来设置图片的时候先通过图片URL判断这个图片是否被加载过了，也就是说本地是否有这张图片
            var image = SDWebImageManager.sharedManager().imageCache.imageFromDiskCacheForKey(imageStr)
            
            if image == nil
            {
                
                print("本地没有这张图片，加载这张图片!!")

                //表明本地没有这张图片，那么就加载图片到本地
                
                dispatch_group_enter(group)
                SDWebImageManager.sharedManager().downloadImageWithURL(NSURL.init(string: imageStr!), options: SDWebImageOptions(rawValue: 0), progress: nil, completed: nil)
                
                dispatch_group_leave(group)
                
                
                dispatch_group_notify(group, dispatch_get_main_queue()) { () -> Void in
                    
                    
                    //SDWebImage做缓存，是以url 的字符串作为key，
                    let key = imageStr
                    //1.1 取出这张图片
                    image = SDWebImageManager.sharedManager().imageCache.imageFromDiskCacheForKey(key)
                    
//                    print(image.size)
                    
                    self.imgView.image = image
                    
                    
                }
            
            }
            else
            {
            
                let key = imageStr

                print("本地存有这张图片!!")
                
                //1.1 取出这张图片
                image = SDWebImageManager.sharedManager().imageCache.imageFromDiskCacheForKey(key)
                
//                print(image.size)
                
                self.imgView.image = image
            }
            


            //获取到了图片，开始改变屏幕上的imageView的尺寸约束
            
            let scale = image.size.width/image.size.height
            
            
            
            imgHeight.constant = (UIScreen.mainScreen().bounds.size.width-10)/scale
            
            
            
        }
    
    
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
