//
//  SZMainTabBarVC.swift
//  WeiBoExercise
//
//  Created by lx on 16/9/19.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

import UIKit



//获取到字典中的数据，然后作为全局的数据，可以在其他的控制器中使用这个数据
let tabBarFilePath : String = NSBundle.mainBundle().pathForResource("MainTabBar", ofType: "json")!


let tabBarData = NSData.init(contentsOfFile: tabBarFilePath)

var tabBarArr : [[String: String]] = []


class SZMainTabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        


//        print(tabBarFilePath)
    var tabBarArrTemp : AnyObject = ""

        do
        {
            
            tabBarArrTemp = try NSJSONSerialization.JSONObjectWithData(tabBarData!, options:.MutableContainers)
            
            tabBarArr = tabBarArrTemp as! [[String : String]]
            
            
        }
        catch
        {
            
            print("dfsaf")
            
//            tabBarArr = tabBarArrTemp as! [[String : String]]
            tabBarArr.append([
                
                "VCName" : "SZHomeNaviVC",
                
                "title" : "主页",
                "imageName" : "tabbar_home"])


            //----------------------
            tabBarArr.append(
            
                [
                    "VCName" : "SZMessageNaviVC",
                    "title" : "消息",
                    "imageName" : "tabbar_message_center"
                ]
            )
            //----------------------

            tabBarArr.append(
                
                [
                    "VCName" : "SZAddNaviVC",
                    "title" : "",
                    "imageName" : "tabbar_home"
                ]
            )
            //----------------------

            tabBarArr.append(
                
                [
                    "VCName" : "SZDiscoverNaviVC",
                    "title" : "发现",
                    "imageName" : "tabbar_discover"
                ]
            )
            //----------------------

            tabBarArr.append(
                
                [
                    "VCName" : "SZPersonalNaviVC",
                    "title" : "我",
                    "imageName" : "tabbar_profile"
                ]
            )
            
            
        }
    
    
    }

    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        
        let nameSpace : String = NSBundle.mainBundle().infoDictionary!["CFBundleExecutable"] as! String
        
        //通过tabBar中的viewControllers拿到storyBoard中所有的导航控制器
        for VC in (self.viewControllers)!
        {

            for dict in tabBarArr
            {
            
                let tabBarClass : AnyClass? = NSClassFromString("\(nameSpace)" + "." + dict["VCName"]!)


                //终于解决了。在这里==相当于是内部值的比较，两个都是AnyClass类型，直接进行值得比较。
                if VC.classForCoder == tabBarClass!
                {
                

                    let item : UITabBarItem = UITabBarItem.init(title: dict["title"]!, image: UIImage.init(named: dict["imageName"]!), selectedImage: UIImage.init(named: dict["imageName"]!+"_highlighted"))

                    VC.tabBarItem = item

                    VC.childViewControllers[0].navigationItem.title = dict["title"]
                    
                }
 
            }

        }
        
        configureAddBtn()

    }
    
//    override func viewDidAppear(animated: Bool) {
//        super.viewDidAppear(animated)
//        
//        print("tabBar视图出现了！")
//    }
    
    //设置btn 的frame
    private func configureAddBtn(){
        
        //1.添加给父视图
        self.tabBar.addSubview(addBtn)
        
        //2.设置frame
        //屏幕宽度/子控制器个数
        let width = UIScreen.mainScreen().bounds.size.width/CGFloat(tabBarArr.count)
        
        let height  : CGFloat = 44.0
        
        
        addBtn.frame = CGRectOffset(CGRectMake(0, 0, width, height), 2 * width, 2.5)
        
        
    }
    
    
    
    //MARK: - 按钮的事件处理
    func addBtnClick(){
        
        
        print("按钮被点击");
        
        
    }
    
    
    // MARK: - 懒加载创建按钮
    private lazy var addBtn : UIButton = {
        
        
        let btn = UIButton()
        
        //设置图片
        btn.setImage(UIImage.init(named: "tabbar_compose_icon_add"), forState: .Normal)
        btn.setImage(UIImage.init(named: "tabbar_compose_icon_add_highlighted"), forState: .Highlighted)
        
        
        
        //设置背景图片
        btn.setBackgroundImage(UIImage.init(named: "tabbar_compose_button"), forState: .Normal)
        btn.setBackgroundImage(UIImage.init(named: "tabbar_compose_button_highlighted"), forState: .Highlighted)
        
        
        //设置事件
        btn.addTarget(self, action: "addBtnClick", forControlEvents: .TouchUpInside)
        
        
        return btn
    }()
    
    
    
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
