//
//  SZHomeTableVC.swift
//  WeiBoExercise
//
//  Created by lx on 16/9/19.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

import UIKit
import SDWebImage






class SZHomeTableVC: SZCommentTableVC {

    var titleButton : UIButton?
    
    
    
    var homePageModelsArr : [SZHomePageModel]?
    {
        
        didSet
        {
        
            tableView.reloadData()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "popoverStatusChange:", name: ClickPopoverView, object:nil)
        

        //加载首页表视图的时候就说明已经登录了，我们应该进行相关微博信息的请求了。
        
        //这里加上判断的原因是，我们在性特性页面进入未登录页面的时候，虽然我们这个类继承自SZCommentTableVC,我们在里面覆写了loadView方法，但是loadView方法走完还是会走这个方法的，所以如果没有判断的话后面的请求就拿不到用户信息中请求微博内容的有关参数，会崩溃。
        if SZAccountModel.loadAccount()?.access_token != nil
        {
            
            _loadNetworkData()

        }
        
        
        
        
        //添加刷新视图
        refreshControl = SZHomeRefresh()
        refreshControl?.addTarget(self, action: "_loadNetworkData", forControlEvents: .ValueChanged)
        
        
        
    }

    //用一个bool标记这个 是上拉 更新 还是下拉刷新
    private var isLoadMore = false
    
    //请求网络数据
    func _loadNetworkData()
    {
    
        
        var since_id = homePageModelsArr?.first?.id ?? 0

        
        
        var max_id = 0
        
        //但是如果是上拉， 这个since_id不需要了
        if isLoadMore {
            
            since_id = 0
            
            max_id = homePageModelsArr?.last?.id ?? 0
        }
        
        
        
        SZHomePageModel.loadHomePageData (max_id , since_id:since_id , completion:{
            
            (modelsArr, error) -> () in
            
            //不管有没有数据，刷新都要结束
            self.refreshControl?.endRefreshing()
            
            if error == nil && modelsArr != nil
            {
                
                if since_id > 0
                {
                
                    self.homePageModelsArr = modelsArr! + self.homePageModelsArr!
//                    print("更新了\(modelsArr?.count)")
                    
                    self.remindStatusNumber(modelsArr?.count ?? 0)

                    
                }
                else if max_id > 0 {
                    
                    //拼接数据
                    self.homePageModelsArr = self.homePageModelsArr! + modelsArr!
                    
                    self.isLoadMore = false
                    
                }
                else
                {
                    self.homePageModelsArr = modelsArr

                }

            }
            else
            {
                print("微博数据加载错误!!")
            }
            
            
        })
        
    }
    
    
    private lazy var statusNumberLabel : UILabel = {
        
        let label = UILabel()
        label.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, 30)
        
        label.backgroundColor = UIColor.orangeColor()
        label.textColor = UIColor.whiteColor()
        label.textAlignment = .Center
        
        
        //隐藏
        label.hidden = true
        
        //父视图, 因为不要让这个 label 随着表视图移动
        self.navigationController?.navigationBar.insertSubview(label, atIndex: 0)
        
        return label
        
    }()
    
    //刷新数据提醒
    func remindStatusNumber(number: Int){
        
        //显示
        statusNumberLabel.hidden = false
        
        statusNumberLabel.text = (number == 0) ? "已经是最新的啦！" : "更新了\(number)条微博数据"
        
        //动画
        
        UIView.animateWithDuration(1.5, animations: { () -> Void in
            
            //移动下来
            
            self.statusNumberLabel.transform = CGAffineTransformTranslate(self.statusNumberLabel.transform, 0, 44)
            
            
            }) { (_) -> Void in
                
                
                //移动回去，隐藏
                UIView.animateWithDuration(1.5, animations: { () -> Void in
                    
                    self.statusNumberLabel.transform = CGAffineTransformIdentity
                    
                    }, completion: { (_) -> Void in
                        
                        
                        self.statusNumberLabel.hidden = true
                })
        }
        
        
    }
    
    
    
    
    
    override func viewWillAppear(animated: Bool)
    {
        
        super.viewWillAppear(animated)
        
        
        //说明不是登录状态
        if !isLoginStatus
        {
        
            let notLoginView = view as! SZNotLoginView
            notLoginView.isHomePage = TabBarIndex.HomePage
//            print(notLoginView)
            
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: UIBarButtonItemStyle.Plain, target: self, action: "registerOrMoreBtnClicked:")
            
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style: UIBarButtonItemStyle.Plain, target: self, action: "loginBtnClicked")
            
            
        }
        else
        {
        
            //左边
            navigationItem.leftBarButtonItem = UIBarButtonItem.createBarButtonItem("navigationbar_friendattention", target: self, action: "friendsAction:")
            
            //右边
            navigationItem.rightBarButtonItem = UIBarButtonItem.createBarButtonItem("navigationbar_pop", target: self, action: "QRAction:")
            
            
            let titleBtn = TitleButton()
            titleBtn.setTitle("我的微博", forState: .Normal)
            //事件添加
            titleBtn.addTarget(self, action: "popoverViewAction:", forControlEvents: .TouchUpInside)
            
            titleButton = titleBtn
            
            navigationItem.titleView = titleButton
            
            //设置分割线颜色
            tableView.separatorColor = UIColor.clearColor()
            //注册单元格
//            tableView.registerNib(UINib.init(nibName: "SZHomePageCell", bundle: nil), forCellReuseIdentifier: "resueCellID")
            
        }
        
        
    }
    
    
    //MARK: -通知调用方法
    func popoverStatusChange(notification:NSNotification)
    {
    
        let userInfo = notification.userInfo!
        
        let isPresent  = userInfo["isPresent"]!
        
        if isPresent as! String == "true"
        {
            print("popover出现了")
            titleButton?.selected = true
            
        }
        else
        {
        
            print("popover消失了")
            titleButton?.selected = false
            
        }
    }
    
    //MARK: -移除通知
    deinit
    {
    
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    
    //MARK: -按钮点击事件
    func friendsAction(sender : UIButton)
    {
    
        print("点击了用户按钮")
    }
    
    
    
    
    func QRAction(sender : UIButton)
    {
    
        print("点击了扫描二维码按钮")
        let storyBoard : UIStoryboard = UIStoryboard(name: "QRCodeVC", bundle: NSBundle.mainBundle())
        let qrNaviVC = storyBoard.instantiateInitialViewController()
        
//        qrNaviVC?.navigationController?.navigationBar.barTintColor = UIColor.init(white: 0, alpha: 0.1)
        self.navigationController?.presentViewController(qrNaviVC!, animated: true, completion: { () -> Void in
            
        })

        
        
    }
    
    
    
    func popoverViewAction(sender : UIButton)
    {
    
        print("点击了popover按钮")
        
        print("点击了扫描二维码按钮")
        let storyBoard : UIStoryboard = UIStoryboard(name: "Popover", bundle: NSBundle.mainBundle())
        let popoverVC = storyBoard.instantiateInitialViewController()
        
        popoverVC?.modalPresentationStyle = UIModalPresentationStyle.Custom
        
        popoverVC?.transitioningDelegate = popoverHelp
        
        
        self.presentViewController(popoverVC!, animated: true) { () -> Void in
            
        }
        
        
    }
    
    
    //MARK: - 懒加载创建 
    private lazy var popoverHelp : SZPopoverHelp = {
        
        
        let popoverTool = SZPopoverHelp()
        //popoverTool.newFrame = CGRectMake()
        
        return popoverTool
        
    }()
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {

        
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return homePageModelsArr?.count ?? 0
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let model = homePageModelsArr![indexPath.row]

        let resueCellID : (id : String , index : Int) = getResueCellID(model)

        var cell = tableView.dequeueReusableCellWithIdentifier(resueCellID.id)

        
        if cell == nil
        {
        
            //这里如果没有在xib中添加复用ID，那么就会一直走这个方法，因为复用池中根本就没有这个ID的cell。
            
            let cellArr = NSBundle.mainBundle().loadNibNamed("SZHomePageCell", owner: self, options: nil)
            
            if resueCellID.index == 0
            {
                
                cell = cellArr[resueCellID.index] as! SZHomePageCell
                (cell as! SZHomePageCell).amongCollectionView.presentDelegate = self


            }
            else
            {
            
                cell = cellArr[resueCellID.index] as!SZHomeRetweetedCell
                
                (cell as! SZHomeRetweetedCell).amongCollectionView.presentDelegate = self
            }
            
            
        }

        if resueCellID.id == "resueCellID"
        {
            
            (cell as! SZHomePageCell).model = model
            
        }
        else
        {
            
            (cell as! SZHomeRetweetedCell).model = model
            
        }
        
        
        
        let count = homePageModelsArr?.count ?? 0
        
        //加载最后一个单元格了， 所以是 上拉更新
        if indexPath.row == (count - 1) {
            
            //确认是上拉
            isLoadMore = true
            
            //加载数据
            _loadNetworkData()
        }
        
        
        
        
        return cell!
        

    }

    //通过这个函数来判断是复用哪一个cell
    func getResueCellID(model : SZHomePageModel) ->(String , Int)
    {
    
        if model.retweeted_status == nil
        {
        
            return ("resueCellID" , 0)
        }
        else
        {
        
            return ("resueRetweetedCellID" , 1)
        }
        
    }
    
    
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        
        let model = homePageModelsArr![indexPath.row]
//        print(model.r)
        
        if model.retweeted_status != nil
        {
        
//            print("\(model.user?.screen_name)是转发微博!!")
//            print("内容高度 = \(model.retweetedContentHeight)")

            return 10 + (40 + 10) + (model.topContentHeight!) + (model.retweetedContentHeight) + (30 + 10)
            


        }
        else
        {
        

            return 10 + (40 + 10) + (model.topContentHeight!) + (model.amongContentHeight!) + (30 + 10)

        }
        
        //上面的间距 + （头像等用户信息的固定高度 + 头像和内容间距） + （微博内容高度+已经加上下边距）+ （中间内容高度 + 已经加上下边距） + （底部内容高度 + 底部预留间距）

        
    }
    

    override func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        
        
        
//        print("选中了\(indexPath.row)")

        
        return false
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
 
    }


}
//----------------------------------------------------
extension SZHomeTableVC : SZPresentBigImageDelegate
{
    

//    func presentBigImageDelegate() -> Void
//    func presentBigImageDelegate(indexPath : NSIndexPath , imagesURLArr : [NSURL]?) -> Void

    func presentBigImageDelegate(indexPath : NSIndexPath , imagesURLArr : [NSURL]?) ->Void
    {
    
//        print("选中了\(indexPath.row)")
        
        //开始模态出大图控制器
        let presentBigImageVC = SZPresentBgImageVC()
//        self.addChildViewController(presentBigImageVC)
//        self.navigationController?.addChildViewController(presentBigImageVC)
        
        //这里一定得在设置currentIndexPath之前赋值，因为内部取出imagesURLArr中的url进行判断。
        presentBigImageVC.imagesURLArr = imagesURLArr

        
        presentBigImageVC.currentIndexPath = indexPath
        
        
        //判断当前数组中的URL图片是否都已经加载到了本地，因为后期会对这个图片从本地取出，拿到大小，如果本地没有图片，那么会崩溃。
        
        var isLocalImage : Bool = true
        
        for url in imagesURLArr!
        {
        
            var imageStr = url.absoluteString
            
            imageStr.replaceRange((imageStr.rangeOfString("thumbnail"))!, with: "large")
            
            let image = SDWebImageManager.sharedManager().imageCache.imageFromDiskCacheForKey(imageStr)
            if image == nil
            {
                
                isLocalImage = false
                
            }
            
        }
        
        if !isLocalImage
        {
        
            return
        }
        
        self.presentViewController(presentBigImageVC, animated: true) { () -> Void in
            
            
            
        }
        
        
    }
    
    
}

