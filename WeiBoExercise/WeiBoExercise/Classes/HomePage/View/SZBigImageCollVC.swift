//
//  SZBigImageCollVC.swift
//  WeiBoExercise
//
//  Created by lx on 16/10/6.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class SZBigImageCollVC: UICollectionViewController {

    //回调闭包，改变图片索引label
    
    var closeBlock : ((Int) ->Void)?
    //dismiss闭包
    var backAction : ((Void) ->Void)?
    
    //判断是否是长图cell
    var isLongImage : Bool = false
    {
        
        didSet
        {
        
        }
    
    
    }
    
    
    /**
     
        保存图片URL数组
     */
    var imagesURLArr : [NSURL]?
    {
    
        didSet
        {
        
            
            collectionView?.reloadData()
            
            collectionView?.scrollToItemAtIndexPath(currentIndexPath!, atScrollPosition: .CenteredHorizontally, animated: false)
        }
    
    }
    var currentIndexPath : NSIndexPath?
        {
        
        didSet
        {
            
            
            
            
        }
        
    }
    
    
    init()
    {
    
        let flowLayout : UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        //- 60 - 10
        flowLayout.itemSize = CGSizeMake(UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height - 60)
        flowLayout.scrollDirection = .Horizontal
//        flowLayout.scrollDirection = .Vertical
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        
        super.init(collectionViewLayout: flowLayout)
        
        self.collectionView?.pagingEnabled = true
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()



        self.collectionView!.registerNib(UINib(nibName: "SZImageCell", bundle: nil), forCellWithReuseIdentifier: "imageCell")
        
        self.collectionView?.registerNib(UINib(nibName: "SZLongCollCell", bundle: nil), forCellWithReuseIdentifier: "longImageCell")
        
        
        self.collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.showsVerticalScrollIndicator = false
        
        
        
        
        
    }
    
    
    
    override func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        
        let offset = scrollView.contentOffset.x
        
        let index = Int(offset/(UIScreen.mainScreen().bounds.size.width))

        //调用闭包，设置上方lable索引
        self.closeBlock!(index)
        
    }
    
    

    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
//        print("选中cell")
        self.backAction!()

    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {

        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return (imagesURLArr?.count)! ?? 0
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
//        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("imageCell", forIndexPath: indexPath)
        
        var resueStr : String = ""
        
        if isLongImage
        {
            resueStr = "longImageCell"
        }
        else
        {
        
            resueStr = "imageCell"
            
        }
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(resueStr, forIndexPath: indexPath)
        
        if isLongImage
        {

            
            (cell as! SZLongImageCell).imgURL = imagesURLArr![indexPath.item]
            
            (cell as! SZLongImageCell).backActionClose = {
                
                () ->Void in
                
                self.backAction!()

                
            }
            
        }
        else
        {
            
            (cell as! SZImageCell).imgURL = imagesURLArr![indexPath.item]

        }
        
        
        
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
