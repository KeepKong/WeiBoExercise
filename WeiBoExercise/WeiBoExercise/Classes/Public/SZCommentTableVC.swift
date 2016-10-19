//
//  SZCommentTableVC.swift
//  WeiBoExercise
//
//  Created by lx on 16/9/20.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

import UIKit

/**
标记是否登录了微博账号!!

*/
var isLoginStatus : Bool = false




enum TabBarIndex : Int
{
    
    case HomePage = 0 , MessagePage, PersonalPage
}


class SZCommentTableVC: UITableViewController,RegisterOrLoginOrFollowActionDelegate {

    
    
    var tabBarIndex : TabBarIndex = .HomePage
    
    var notLoginView :SZNotLoginView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func loadView() {

        
//        let model : SZAccountModel = SZAccountModel.loadAccount()
        
        isLoginStatus = SZAccountModel.userLoginState()
        
        if !isLoginStatus
        {
        
            notLoginView = SZNotLoginView.init(frame: CGRectMake(0, 64, UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height - 64 - 49))
            
            notLoginView?.delegate = self
            
            view = notLoginView
            
        }
        else
        {
            
            super.loadView()
            
        }
        
        
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
        
//        print(notLoginView?.isHomePage)
        
    }
    
    
    //MARK: -注册、登录、关注代理方法
    
    //登录事件
    func loginBtnClicked()
    {
    
        print("点击了登录按钮")
        
        let authVC = AuthViewController()
        
        let navig = UINavigationController.init(rootViewController: authVC)
        
        presentViewController(navig, animated: true, completion: nil)

    }
    
    //注册事件
    func registerBtnClicked()
    {
        print("点击了注册按钮")

    }
    
    //去关注事件
    func followBtnClicked()
    {
    
        print("点击了去关注按钮")

    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
