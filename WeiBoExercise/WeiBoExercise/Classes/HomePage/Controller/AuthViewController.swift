//
//  SZHomeNaviVC.swift
//  WeiBoExercise
//
//  Created by lx on 16/9/19.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

import UIKit

import AFNetworking
import SVProgressHUD


class AuthViewController: UIViewController {

    let wb_app_key = "1163889390"
    let wb_redirect_uri = "http://www.whbeiwo.cn/index"
    let wb_app_secret = "40476607b4bae73ccb071db60251b030"
    
    override func loadView() {
        
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //1.授权第一步
        //根据新浪提供的的借口，获取一个 requestToken
        let urlStr = "https://api.weibo.com/oauth2/authorize?client_id=\(wb_app_key)&redirect_uri=\(wb_redirect_uri)"

        let url = NSURL(string: urlStr)
        let request = NSURLRequest.init(URL: url!)
        //发送这个请求
        webView.loadRequest(request)
        
        //配置导航栏
        configureNavi()

    }
    
    func configureNavi()
    {
    
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "返回", style: .Plain, target: self, action: "backAction")
    }
    
    func backAction()
    {
    
        self.dismissViewControllerAnimated(true) { () -> Void in
            
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let notLoginOrLoginInterface : SZMainTabBarVC = storyBoard.instantiateInitialViewController() as! SZMainTabBarVC
            
            UIApplication.sharedApplication().keyWindow?.rootViewController = notLoginOrLoginInterface
            
        }
    }
    
    lazy var webView : UIWebView = {
    
    
        let web = UIWebView()
        web.delegate = self
    
        return web
    }()

}



//协议
extension AuthViewController : UIWebViewDelegate {
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        SVProgressHUD.showErrorWithStatus("网络加载中...", maskType: .Clear)
//        SVProgressHUD.showInfoWithStatus("网络错误", maskType: .Black)

        
        let urlStr = request.URL!.absoluteString
        

        if !urlStr.hasPrefix(wb_redirect_uri) {
            
            
            SVProgressHUD.dismiss()

            return true
            
        }

        let codeStr = "code="

        
        if request.URL!.query!.hasPrefix(codeStr) {
            

//            print("开始网络请求！！")
            SVProgressHUD.showErrorWithStatus("网络加载中...", maskType: .Clear)

            
            let code = request.URL!.query!.substringFromIndex(codeStr.endIndex)
            
//            print("---------\(code)")

            
            
            let manager = AFHTTPSessionManager()
            
            manager.responseSerializer = AFHTTPResponseSerializer()
            manager.requestSerializer = AFHTTPRequestSerializer()
//            manager.responseSerializer.acceptableContentTypes = NSSet.init(objects: "application/json", "text/json", "text/javascript", "text/plain") as! Set
            
            let params : [String : String] = ["client_id" : wb_app_key, "client_secret" : wb_app_secret, "grant_type" : "authorization_code", "code" : code,"redirect_uri" : wb_redirect_uri]
            
            manager.POST("https://api.weibo.com/oauth2/access_token", parameters: params, progress: nil, success: { (_ , JSONData) -> Void in
                
                let JSONDict : NSDictionary?
                
                do
                {
                
                    JSONDict = try NSJSONSerialization.JSONObjectWithData(JSONData as! NSData, options: .MutableContainers) as? NSDictionary
                    
//                    print(JSONDict)
                    
                    //保存令牌和用户的ID信息，用于后面请求用户的数据做准备。
                    let account =  SZAccountModel.init(dict: JSONDict as! [String : AnyObject])
                    
                    //调用account中的方法，进行用户信息请求，例如用户图片、用户名字等信息。
                    account.loadUserMoreInfo({ (userAccount) -> () in
                        
                        if userAccount != nil {
                            
                            userAccount!.saveAccount()
                            
                            
                            print(SZAccountModel.loadAccount())
                            SVProgressHUD.dismiss()
                            
                            //调用backAction，登录的模态页面消失。
                            self.backAction()

                            
                        }
                        else
                        {
                            
                            SVProgressHUD.showInfoWithStatus("网络错误", maskType: .Black)

                        }


                    })
                    
                    
                }
                catch
                {
                    
                    print("解析数据出现异常！")
                }
                


                
                
                
                
                }, failure: { (_, error) -> Void in
                    
                    
                    print(error)
                    
                    
            })
            
            
            
        }else{
            

            
            
            
        }
        
        

        
        return false
        
    }
    
    
}
