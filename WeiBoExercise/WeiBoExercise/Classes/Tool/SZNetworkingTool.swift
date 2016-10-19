//
//  SZNetworkingTool.swift
//  WeiBoExercise
//
//  Created by lx on 16/9/23.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

import UIKit
import AFNetworking


class SZNetworkingTool: AFHTTPSessionManager {

    
    static let tool : SZNetworkingTool = {
        
        //baseURL的方式 来实现封装 这个网络请求的单例对象
        let url = NSURL(string: "https://api.weibo.com/")
        let tool = SZNetworkingTool(baseURL: url)
        
        //改变 响应序列化类 可接受的数据类型
        tool.responseSerializer.acceptableContentTypes = NSSet.init(objects: "application/json", "text/json", "text/javascript", "text/plain") as? Set
        
        return tool
    }()
    
    
    class func shareTool() -> SZNetworkingTool {
        
        
        return tool
        
    }
    
    
}
