//
//  SZAddNaviVC.swift
//  WeiBoExercise
//
//  Created by lx on 16/9/19.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

import UIKit

class SZAddNaviVC: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        var tabBar : [String :String] = tabBarArr[2] as! [String : String]
//        
//        
//        self.tabBarItem.title = tabBar["title"]!
//        self.tabBarItem.image = UIImage.init(named: tabBar["imageName"]!)
        
        
        
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
        configureAddBtn()

        
    }
    
    
    //设置btn 的frame
    private func configureAddBtn(){
        
        //1.添加给父视图
        self.tabBarController?.tabBar.addSubview(addBtn)
        
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
