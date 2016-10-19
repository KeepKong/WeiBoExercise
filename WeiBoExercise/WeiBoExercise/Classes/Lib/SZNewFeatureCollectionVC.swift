//
//  SZNewFeatureCollectionVC.swift
//  WeiBoExercise
//
//  Created by lx on 16/9/23.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

import UIKit



let reuseID = "newfeature"



class SZNewFeatureCollectionVC: UICollectionViewController {

    //记录页面的个数
    var pagesCount : Int = 4
    
    //需要一个layout属性
    var flowLayout : UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    //分页指示器
    var pagesIndicator : UIPageControl?
    
    
    //重写init方法，
    //
    init(){
        
        super.init(collectionViewLayout: flowLayout)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    override func viewDidLoad() {
        
        //collectionView 已经创建
        super.viewDidLoad()
        
        flowLayout.itemSize = UIScreen.mainScreen().bounds.size
        flowLayout.minimumInteritemSpacing = 0.0
        flowLayout.minimumLineSpacing = 0.0
        flowLayout.scrollDirection = .Horizontal
        
        //设置分页效果
        collectionView?.pagingEnabled = true
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.showsVerticalScrollIndicator = false
        
        collectionView?.bounces = false
        
        //注册单元格
        collectionView?.registerClass(NewFeatureCell.classForCoder(), forCellWithReuseIdentifier: reuseID)
        
        //设置分页控制器
        pagesIndicator = UIPageControl.init()
        
        pagesIndicator?.numberOfPages = 4
        pagesIndicator?.center.x = (collectionView?.center.x)!
        pagesIndicator?.center.y = (collectionView?.center.y)! * 1.8
        
        pagesIndicator?.currentPageIndicatorTintColor = UIColor.blackColor()
        pagesIndicator?.pageIndicatorTintColor = UIColor.lightGrayColor()
        
        
        
        view.addSubview(pagesIndicator!)
        
        
        
    }
    
    
    
    //MARK: - collectionView的协议
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return pagesCount
    }
    
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        
        
        let cell  : NewFeatureCell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseID, forIndexPath: indexPath) as! NewFeatureCell
        
        cell.startBtn.hidden = true

        cell.pageIndex = indexPath.item
        
        return cell
    }
    
    
    override func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        
        let contentOff = scrollView.contentOffset.x
        
        let width = UIScreen.mainScreen().bounds.size.width
        
        let offset : CGFloat = contentOff / width
        
        
        let page : Int = Int(offset)
        
        pagesIndicator?.currentPage = page
        
        let nextCell : NewFeatureCell = self.collectionView?.cellForItemAtIndexPath(NSIndexPath.init(forItem: page, inSection: 0)) as! NewFeatureCell

        
        if page == 3
        {
        
            
            
            nextCell.startBtn.hidden = false
            nextCell.startBtnAnimation()
        }
        
        
        
    }
    
    
    //协议方法 是在 单元格 已经 结束展示（在界面上展示）
    
    //只要某一个单元格移出了屏幕，那么就会对移出的那个单元格调用此方法。
//    override func collectionView(collectionView: UICollectionView, didEndDisplayingCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
//        
//        
//        if indexPath.item == (pagesCount - 2)
//        {
//        
//            let nextCell : NewFeatureCell = collectionView.cellForItemAtIndexPath(NSIndexPath.init(forRow: pagesCount - 1, inSection: 0)) as! NewFeatureCell
//            
//            
//            
//            
//            nextCell.startBtn.hidden = false
//            nextCell.startBtnAnimation()
//        }
//        
// 
//        
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


//这里如果设置成private的话，那么cell上面的button就不能调用相应方法了，估计是self调用不到对应的类中的方法。
class NewFeatureCell :UICollectionViewCell {
        
        
        var pageIndex : Int? {
            
            //重写设置器方法，设置值
            didSet{
                
                //"new_feature_\(pageIndex + 1)"
                imgView.image = UIImage(named: "new_feature_\(pageIndex! + 1)")!
                
            }
            
            
        }
        
        
        override init(frame: CGRect) {
            
            super.init(frame: frame)
            
            
            //加载子视图
            loadSubviews()
            
            
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
        //开始按钮动画
    func startBtnAnimation()
    {
        self.startBtn.transform = CGAffineTransformMakeScale(0.6, 0.6)

        
        UIView.animateWithDuration(1, delay: 0.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 5, options: .CurveEaseInOut, animations: { () -> Void in
            
            self.startBtn.transform = CGAffineTransformIdentity

            }) { (_) -> Void in
                
                
        }
        
        
    }
    
        
        //私有方法
        func loadSubviews(){
            
            contentView.addSubview(imgView)
            contentView.addSubview(startBtn)
            
            
            //设置frame
            imgView.frame = contentView.bounds
            
            //startBtn.frame.origin = CGPointMake(0, 0)
            
            startBtn.center = CGPointMake(imgView.bounds.size.width/2.0, imgView.bounds.size.height/2.0 + 200.0)
            startBtn.bounds.size.height = 50
            startBtn.bounds.size.width = 150
            
        }
        
        
        //懒加载
        lazy var imgView = UIImageView()
        
        //懒加载创建btn
        lazy var startBtn : UIButton = {
            
            let btn = UIButton()
            
            //按钮一开始 是隐藏的，只有在 最后这个cell的时候 才出现
            btn.hidden = true
            
            btn.setBackgroundImage(UIImage(named: "new_feature_button"), forState: .Normal)
            
            btn.setBackgroundImage(UIImage(named: "new_feature_button_highlighted"), forState: .Highlighted)
            
            btn.addTarget(self, action: "startBtnAction:", forControlEvents: .TouchUpInside)
            
            return btn
            
        }()
        
    func startBtnAction(sender : UIButton)
    {
        
        print("点击进入微博")
        
        //发送通知给AppDelegate，更换根视图控制器。
        NSNotificationCenter.defaultCenter().postNotificationName(FeatrueToNotLoginInterface, object: self)
        
    }
    
    
    
    }
    
    
    



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
