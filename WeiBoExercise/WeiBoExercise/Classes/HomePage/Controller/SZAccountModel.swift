//
//  SZAccountModel.swift
//  WeiBoExercise
//
//  Created by lx on 16/9/23.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

import UIKit



class SZAccountModel: NSObject , NSCoding {

    
    /// 用户授权信息的 令牌
    var access_token : String?
    
    /// 用户授权的终止时间间隔（时间戳）
    var expires_in : NSNumber? {
        
        // setter
        didSet{
            
            //把时间戳 转换为 日期对象
            expires_date = NSDate(timeIntervalSinceNow: expires_in!.doubleValue)
            
            
            print(expires_date)
            
        }
        
    }
    
    //保存用户授权过期时间 的 日期
    //用来保存过期日期，例如到期日期是2016.12.12
    var expires_date : NSDate?
    

    var uid : String?
    
    //用户的头像
    var avatar_large : String?
    //用户的微博名
    var screen_name  : String?
    
    
    //提供一个 初始化方法 ，来进行模型数据转换
    init(dict : [String : AnyObject]) {
        
        access_token = dict["access_token"] as? String
        expires_in = dict["expires_in"] as? NSNumber
        uid = dict["uid"] as? String
        
    }
    
    //重写一下原本的init，否则init()以及 对应的类方法就没了
    override init() {
        
        super.init()
        
        
    }
    
    
    //重写 这个类的 描述方法
    override var description : String {
        
        //把属性转为 字典，只是为了输出，看这个属性的值 有没有 转换成功
        
        let keysPropertyName = ["access_token", "expires_in", "uid", "avatar_large", "screen_name"]
        let dict = self.dictionaryWithValuesForKeys(keysPropertyName)
        
        return "\(dict)"
        
    }
    
    
    
    //MARK: -存入 和 取出这个类
    //加载用户 更多信息，并且加载完成后 保存用户信息到沙盒
    func loadUserMoreInfo(completionAction : (userAccount : SZAccountModel?) -> ()){
        
        //判断，用户有没有授权登录， 如果没有授权，不继续
        //如果access_token != nil条件不成立，那么走后面的"...."
        assert(access_token != nil, "没有获取到授权信息")
        
        
        let url = "2/users/show.json"
        
        let params : [String : String] = ["access_token" : access_token!, "uid" : uid!]
        
        SZNetworkingTool.shareTool().GET(url, parameters: params, progress: nil, success: { (_, jsonDict) -> Void in
            
            //AnyObject?  --> as? Dict
            
            //可选绑定
            if let json = jsonDict as? [String : AnyObject] {
                
                //把值存储到 对应的属性上
                self.avatar_large = json["avatar_large"] as? String
                
                self.screen_name = json["screen_name"] as? String
                
                
                //回调外部的闭包，用于在本地保存用户信息
                completionAction(userAccount: self)
                
            }
            else
            {
            
                completionAction(userAccount: nil)
            }

            }) { (_, error) -> Void in
                
                print(error)
                
                completionAction(userAccount: nil)
                
        }
        
        
        
    }
    
    
    //保存到沙盒
    func saveAccount(){
        
        
        //拼接一个文件名字
        //xml 属性列表（字符串，number，array， dict， date， data）
        let filePath = "account.plist".cachesDir()
        
        //用 序列化对象 把 这个对象 存入到这个路径
        NSKeyedArchiver.archiveRootObject(self, toFile: filePath)
    }
    
    //获取这个数据, 类方法中 没有实例变量，没有self，
    //保存一个数据，应该用实例，因为要把自己存进去
    //获取一个数据，只是从指定的路径获取，因此不需要拿到属性
    
    static var account : SZAccountModel?
    
    class func loadAccount() -> SZAccountModel?{
        
        
        //先判断静态存储区，有没有存储 用户模型，
        if account != nil{
            
            return account
        }
        
        
        
        //如果没有 从沙盒中 取出这个对象，那么就取出来，放到静态存储区
        let filePath = "account.plist".cachesDir()
        
        account = NSKeyedUnarchiver.unarchiveObjectWithFile(filePath) as? SZAccountModel


        if account?.expires_date?.compare(NSDate()) == .OrderedAscending{
            
            return nil
            
        }
        
        
        return account
    }
    
    
    //提供一个方法，来判断这个用户是登录了，还是没登录
    class func userLoginState() -> Bool {
        
        return SZAccountModel.loadAccount() != nil
        
    }
    
    
    //MARK: - 实现归档与解档的协议方法
    //归档进入沙盒
    func encodeWithCoder(aCoder: NSCoder) {
        
        aCoder.encodeObject(access_token, forKey: "access_token")
        aCoder.encodeObject(expires_in, forKey: "expires_in")
        aCoder.encodeObject(uid, forKey: "uid")
        
        aCoder.encodeObject(expires_date, forKey: "expires_date")
        
        aCoder.encodeObject(avatar_large, forKey: "avatar_large")
        
        aCoder.encodeObject(screen_name, forKey: "screen_name")
        
    }
    
    //从沙盒 解档出来
    required init?(coder aDecoder: NSCoder) {
        access_token = aDecoder.decodeObjectForKey("access_token") as? String
        expires_in =  aDecoder.decodeObjectForKey("expires_in") as? NSNumber
        uid = aDecoder.decodeObjectForKey("uid") as? String
        
        
        expires_date = aDecoder.decodeObjectForKey("expires_date") as? NSDate
        
        avatar_large = aDecoder.decodeObjectForKey("avatar_large") as? String
        
        screen_name = aDecoder.decodeObjectForKey("screen_name") as? String
        
    }
    
    
}
