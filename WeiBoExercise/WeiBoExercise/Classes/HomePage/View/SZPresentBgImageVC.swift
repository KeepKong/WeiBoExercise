//
//  SZPresentBgImageVC.swift
//  WeiBoExercise
//
//  Created by lx on 16/10/6.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

import UIKit
import SDWebImage





class SZPresentBgImageVC: UIViewController {

    var a : Int = 1
    
    var isLongImage : Bool = false
    
    var imagesURLArr : [NSURL]?
    {
    
    
        didSet
        {
        
//            print(imagesURLArr)
            
        }
        
    }
    
    
    
    var currentIndexPath : NSIndexPath?
    {
    
        didSet
        {
        
            let url = imagesURLArr![(currentIndexPath?.row)!]
            //处理获取到的URL，变成大图URL
            var imageStr = url.absoluteString
            
            imageStr.replaceRange((imageStr.rangeOfString("thumbnail"))!, with: "large")
            
            //从本地取出对应的图片
            let image = SDWebImageManager.sharedManager().imageCache.imageFromDiskCacheForKey(imageStr)
            
            let scale = image.size.width/image.size.height
            
            
            var height = (UIScreen.mainScreen().bounds.size.width-10)/scale
            //image.size.height
            
            if height > UIScreen.mainScreen().bounds.size.height - 60
            {
            
                print("-----------这张是长图!!")
                isLongImage = true
            }
            else
            {
            
                isLongImage = false
            }
            
        }
    
    }
    
//    override init()
//    {
//    
//        super.init()
//        
//        
//    }
    
    
//    init() {
//        
//        super.init()
//        
//        
//    }

//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    var imageCollVC : SZBigImageCollVC?
    
    let numberLabel : UILabel = UILabel()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        automaticallyAdjustsScrollViewInsets = false
        
        
        view.backgroundColor = UIColor.lightGrayColor()
        
        
        let topNumberView : UIView = UIView()
        topNumberView.frame = CGRectMake(0, 20, UIScreen.mainScreen().bounds.size.width, 40)
        view.backgroundColor = UIColor.blackColor()
        
        self.view.addSubview(topNumberView)
        
//        let numberLabel : UILabel = UILabel()
//        numberLabel.tag = 5555;
        numberLabel.frame = topNumberView.bounds
        numberLabel.text = "\(currentIndexPath!.row + 1)/\(imagesURLArr!.count)"
        numberLabel.textColor = UIColor.whiteColor()
        numberLabel.textAlignment = .Center
        topNumberView.addSubview(numberLabel)
        
        
        //添加dismiss按钮
        let dismissBtn : UIButton = UIButton()
        dismissBtn.setTitle("返回", forState: .Normal)
        dismissBtn.frame = CGRectMake(topNumberView.bounds.width - 60, 0, 40, 40)
        dismissBtn.addTarget(self, action: "dismissVC", forControlEvents: .TouchUpInside)
        dismissBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        topNumberView.addSubview(dismissBtn)
        
        
        
        let collBgView : UIView = UIView()
        collBgView.frame = CGRectMake(0, 60, UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height - 60)
        collBgView.backgroundColor = UIColor.blackColor()
        view.addSubview(collBgView)
        
        
        
        
        
        //配置视图上方的集合视图
        imageCollVC = SZBigImageCollVC()
        imageCollVC?.collectionView?.frame = collBgView.bounds
        imageCollVC?.collectionView?.backgroundColor = UIColor.blackColor()
        
        //通过判断是否是长图，来决定是否是scrollView上带有collectionView
        imageCollVC?.isLongImage = isLongImage
        
        //保证在刷新之前拿到当前选中的索引值(也就是在设置imagesURLArr之前设置)
        imageCollVC!.currentIndexPath = currentIndexPath
        
        imageCollVC?.imagesURLArr = imagesURLArr
        imageCollVC?.backAction = {
            
            () ->Void in
            
            self.dismissViewControllerAnimated(true, completion:{ () ->Void in
                
            })
            
        }
        
        imageCollVC!.closeBlock = {
            (index : Int) ->Void in
            
            
            self.numberLabel.text = "\(index + 1)/\(self.imagesURLArr!.count)"
            
            
        }
        
        
        collBgView.addSubview((imageCollVC?.collectionView!)!)
        


        
        
        
    }
    
    
    //dismiss方法
    func dismissVC() ->Void
    {
    
        self.dismissViewControllerAnimated(true) { () -> Void in
            
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


//extension SZPresentBgImageVC : SZPresentBigImageDelegate
//{
//    
//    func test() ->Void
//    {
//    
//        print(a)
//    }
//    
//    
//}



