//
//  SZAmongCollectionV.swift
//  WeiBoExercise
//
//  Created by lx on 16/9/29.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

import UIKit
import SDWebImage

let amongResueID = "resueID"


protocol SZPresentBigImageDelegate
{

    func presentBigImageDelegate(indexPath : NSIndexPath , imagesURLArr : [NSURL]?) -> Void
    
}



class SZAmongCollectionV: UICollectionView , UICollectionViewDelegate , UICollectionViewDataSource {

    var flow  : UICollectionViewFlowLayout?

    
    //设置弹出控制器的代理
    var presentDelegate : SZHomeTableVC?
    
    
    
    //图片宽度和高度 宽度=高度
    var imageWidth : CGFloat = 150.0
    {
    
        didSet
        {
        
            
//            flow = UICollectionViewFlowLayout.init()
            print(imageWidth)
            
            flow!.itemSize = CGSizeMake(imageWidth, imageWidth)
            
            
//            flow!.itemSize = CGSizeMake(imageWidth, imageWidth)
            
            flow!.minimumInteritemSpacing = ImageMagin
            
            flow!.minimumLineSpacing = ImageMagin
            
            flow!.sectionInset = UIEdgeInsetsMake(ImageMagin, ImageMagin, ImageMagin, ImageMagin)

//            layoutIfNeeded()
            
            reloadData()

        }
    }
    
    var ImageMagin : CGFloat = 10
    
    //用于保存图片的所有URL
    var storedImageUrlArr : [NSURL]?





    
    
    override func awakeFromNib() {
        
//        print("集合视图被唤醒!!")
        
//        backgroundColor = UIColor.lightGrayColor()
        
        
        flow = UICollectionViewFlowLayout.init()
        
        flow!.itemSize = CGSizeMake(imageWidth, imageWidth)
        
        flow!.minimumInteritemSpacing = ImageMagin
        
        flow!.minimumLineSpacing = ImageMagin
        
        flow!.sectionInset = UIEdgeInsetsMake(ImageMagin, ImageMagin, ImageMagin, ImageMagin)
        
        collectionViewLayout = flow!
        
        
        delegate = self
        dataSource = self
        
        registerClass(SZAmongCell.self, forCellWithReuseIdentifier: amongResueID)
        
        
        
        
    }
    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        
        return 1
        
    }

    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
    
        return storedImageUrlArr?.count ?? 0
    }

    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(amongResueID, forIndexPath: indexPath)
        
        cell.backgroundColor = UIColor.blackColor()
        
        let url = storedImageUrlArr![indexPath.row]
    
        
//        (cell as! SZAmongCell).imageUrlArr = storedImageUrlArr

        
        //处理获取到的URL，变成大图URL
        var imageStr = url.absoluteString
        
        imageStr.replaceRange((imageStr.rangeOfString("thumbnail"))!, with: "large")
        
        (cell as! SZAmongCell).itemImage?.sd_setImageWithURL(NSURL.init(string: imageStr), placeholderImage: UIImage(named: "tableview_loading@2x副本"))
        
        //重新设置cell上imageView的尺寸，防止复用到了之前150*150大小的图片。
        
        
        (cell as! SZAmongCell).itemImage?.frame = CGRectMake(0, 0, imageWidth, imageWidth)
        
        let recet  = (cell as! SZAmongCell).itemImage?.frame
        
        (cell as! SZAmongCell).isGifFlag?.frame = CGRectMake(recet!.size.width - 40, recet!.size.height - 20, 40, 20)
        if imageStr.containsString(".gif")
        {
        
            (cell as! SZAmongCell).isGifFlag?.hidden = false
        }
        else
        {
            (cell as! SZAmongCell).isGifFlag?.hidden = true
        }
        
        
        return cell
        
        
        
    }
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        
//        print("选中了集合视图\(indexPath.item)")

        
        self.presentDelegate!.presentBigImageDelegate(indexPath , imagesURLArr : storedImageUrlArr)
        
        
        
        
    }
    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
