//
//  SZLongImageCell.swift
//  WeiBoExercise
//
//  Created by lx on 16/10/6.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

import UIKit
import SDWebImage


class SZLongImageCell: UICollectionViewCell , UIScrollViewDelegate{
    
    
    @IBOutlet weak var longImageScrollV: UIScrollView!
    
    //dismiss闭包
    var backActionClose : ((Void) ->Void)?
    
//    let contentImageV : UIImageView?

    
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

                    
                    
                }
                
            }
            else
            {
                
                let key = imageStr
                
//                print("本地存有这张图片!!")
                
                //1.1 取出这张图片
                image = SDWebImageManager.sharedManager().imageCache.imageFromDiskCacheForKey(key)
                

                
            }
            
            
            
            //获取到了图片，开始改变屏幕上的imageView的尺寸约束
            
            
            let height = image.size.height
            
            
//            longImageScrollV.subviews.removeAll()
            for view in longImageScrollV.subviews
            {
            
                view.removeFromSuperview()
            }
            
            //获取到图片的高度之后开始设置滑动视图上的图片高度和宽度
            longImageScrollV.contentSize = CGSizeMake(UIScreen.mainScreen().bounds.size.width - 10, height)
                
            let imageV = UIImageView.init(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width - 10, height))
            imageV.image = image
            imageV.userInteractionEnabled = true
            
            
            let tap : UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: "backAction")
            imageV.addGestureRecognizer(tap)
            
            
            longImageScrollV.addSubview(imageV)
            
            
            //让scrollView在最上方显示

            longImageScrollV.setContentOffset(CGPointMake(0, 0), animated: false)

//            longImageScrollV.scrollsToTop = true
        }
        
        
    }
    
    
    func backAction() ->Void
    {
    
//        print("点击了长图!!")
        backActionClose!()
        
    }
    
    override func awakeFromNib() {
        
        
        longImageScrollV.showsVerticalScrollIndicator = false

        //设置代理
        longImageScrollV.delegate = self
        
        
//        longImageScrollV.contentSize = CGSizeMake(UIScreen.mainScreen().bounds.size.width - 10, (UIScreen.mainScreen().bounds.size.height - 60 - 10) * 2)
//        let testImageV : UIImageView = UIImageView.init(frame: CGRectMake(0, 0, longImageScrollV.bounds.size.width, longImageScrollV.bounds.size.height))
//        testImageV.image = UIImage.init(named: "1")
//        longImageScrollV.addSubview(testImageV)
        
    }
    
    
    
    
    
    
}
