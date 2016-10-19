//
//  SZHomePageModel.swift
//  WeiBoExercise
//
//  Created by lx on 16/9/27.
//  Copyright © 2016年 BeiWo. All rights reserved.
//

import UIKit
import AFNetworking
import SVProgressHUD





//let leftOrRightMagin : CGFloat = 20

class SZUserModel : NSObject
{
    

    
    
    
    
    /**
        用户名称
    */
    var screen_name : String?
    /**
        友好显示名称
    */
    var name : String?
    
    /**
    用户个人描述
    */
//    var description : String?
    
    /**
    用户的微博统一URL地址
    */
    var profile_url  : String?
    
    /**
    用户头像地址（50*50像素）
    */
    var profile_image_url : String?
    /**
 	是否是微博认证用户，即加V用户，true：是，false：否    
    */
    var verified : Bool?
    
    /**
 	用户头像地址（大图），180×180像素 
    */
    var avatar_large :String?
    /**
    用户头像地址（高清），高清头像原图
    */
    var avatar_hd : String?


    
     //会员类型
    var mbrank : Int = 0 {
        didSet{
            
            //print("mbrank :  \(mbrank)")
            
            if mbrank > 0 && mbrank < 7 {
                
                vipImage = UIImage(named: "common_icon_membership_level\(mbrank)")
                
            }else{
                
                vipImage = nil
            }
            
        }
        
        
    }

    //会员的图片
    var vipImage : UIImage?
    
    
    //认证类型！
    var verified_type : Int = -1 {
        
        didSet{
            
            // print("认证类型 ： \(verified_type)")
            //认证的图标到底是哪一个，是由这个 认证类型来决定，所以在拿到这个值后，来做操作
            switch verified_type {
                
            case 0:
                verifiedImage = UIImage(named: "avatar_vip")
            case 2, 3, 5:
                verifiedImage = UIImage(named:"avatar_enterprise_vip")
                
            case 220:
                
                verifiedImage = UIImage(named:"avatar_grassroot")
                
            default:
                verifiedImage = nil
                
                
            }
            
        }
        
    }
    
    
    var verifiedImage : UIImage?
    
    
    
    
    init( dict : [String : AnyObject]) {
        
        super.init()
        
        
        setValuesForKeysWithDictionary(dict)
        
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
        
    }
    
    
}



class SZHomePageModel: NSObject {

    //图片宽度和高度 宽度=高度
    var imageWidth : CGFloat = 150
    //图片之间的间距
    let ImageMagin : CGFloat = 10
    
    
    
    //定义这个cell上半部分的高度
    var topContentHeight : CGFloat?
    
    //定义这个cell中间内容部分的高度
    var amongContentHeight : CGFloat?
    
    //定义cell中间内容中的集合视图的高度
    var amongCollectionWidth : CGFloat?
    
    
    //定义转发微博上的转发内容高度和集合视图的高度
    
    var retweetedTextHeight : CGFloat = 0
    var retweetedContentHeight : CGFloat = 0
    var retweetedCollectionHeight : CGFloat = 0
    var retweetedCollectionWidth : CGFloat = 0
    
    
    //中等图片
    var bmiddle_pic : String?
    //原始图
    var original_pic : String?
    
    //转发微博
    var retweeted_status : SZHomePageModel?
    {
    
        didSet
        {
        
//         print("是转发微博")

            
            

            
            
            
            let paragphStyle : NSMutableParagraphStyle=NSMutableParagraphStyle()
            
            paragphStyle.lineSpacing=0;//设置行距为0
            //设置首行缩进
            paragphStyle.firstLineHeadIndent=0.0;
            //连字属性 在iOS，唯一支持的值分别为0和1,
            //0表示没有连体，1表示有连体
            paragphStyle.hyphenationFactor=0.0;
            //段首行空白空间
            paragphStyle.paragraphSpacingBefore=0.0;
            
            let kern = 1.0
            
            //NSKernAttributeName每个字符之间的间距
            
            let dic = [NSFontAttributeName : UIFont.systemFontOfSize(16) ,NSParagraphStyleAttributeName : paragphStyle , NSKernAttributeName : kern]
            
            
            
            let rect = ((retweeted_status?.text!)! as NSString).boundingRectWithSize(CGSizeMake(UIScreen.mainScreen().bounds.size.width - 20, 10000), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: dic, context: nil)
            
            
            //            print(rect.height)
            //加10是表示下边距多出10，这样更加好看
            retweetedTextHeight = rect.height + 10
            
//----------------转发微博中的集合视图的高度-------------
            //设置转发微博中的集合视图的高度
            var count = retweeted_status?.storedImageUrlArr?.count

//            print(retweeted_status?.pic_urls?.count)
//            print(retweeted_status?.storedImageUrlArr?.count)
            
            if count == nil
            {
                return
            }
            
            
            if count == 0 {
                
                
                retweetedCollectionHeight = 0
                retweetedCollectionWidth = 0
                
                retweetedContentHeight = retweetedTextHeight + retweetedCollectionHeight

                
                return
                
            }
            
            
            if count == 4
            {
                
                imageWidth = 150.0
                
                retweetedCollectionWidth = CGFloat(count! - 1) * ImageMagin + imageWidth * 2
                
                retweetedCollectionHeight = 2 * imageWidth + CGFloat(count! - 1) * ImageMagin
                
                retweetedContentHeight = retweetedTextHeight + retweetedCollectionHeight

                
                return
            }
            
            var tempCount : Int?

            
            tempCount = count > 3 ? 3 : count
            if tempCount == nil
            {
                return
            }
            if tempCount >= 3
            {
                
                
                imageWidth = (UIScreen.mainScreen().bounds.size.width - CGFloat(tempCount!+1)*ImageMagin) / 3.0
                retweetedCollectionWidth = UIScreen.mainScreen().bounds.size.width
                
                
            }
            else
            {
                
                imageWidth = 150.0
                
                retweetedCollectionWidth = CGFloat(tempCount!+1) * ImageMagin + CGFloat(tempCount!) * imageWidth
                
                
            }
            
            
            let temp = (count! - 1) / 3 + 1
            
            
            retweetedCollectionHeight = CGFloat(temp) * imageWidth + CGFloat(temp + 1) * ImageMagin
            
//----------------转发微博中内容的总高度-------------
            retweetedContentHeight = retweetedTextHeight + retweetedCollectionHeight
            
//            print("总高度：\(retweetedTextHeight)+\(retweetedCollectionHeight)=\(retweetedContentHeight)")
            
        }
    
    }
    
    //是否有图片内容
    var pic_urls : [[String : AnyObject]]? {
        
        didSet{
            
            
            //在这个属性中，获取到了 略缩图的url， 因此给storedImageUrl这个属性赋值
            //1.先创建数组 storedImageUrl
            storedImageUrlArr = [NSURL]()
            
            //2.遍历 pic_urls数组，获取到里面的 url
            for dict in pic_urls! {
                
                if let urlStr = dict["thumbnail_pic"] {
                    
                    //解包成功
                    storedImageUrlArr?.append(NSURL(string: urlStr
                        as! String)!)
                }
                
            }
            
            
            //1.取出这个 模型中 有多少个 图片
            let count = storedImageUrlArr!.count
            
//            print("count = \(count)")

            
            //0.0 没有图片的情况
            if count == 0 {
                
    
                amongContentHeight = 0
                amongCollectionWidth = 0
//                print("temp = \(amongCollectionWidth)")
//                imageWidth = 150.0

                return
                
            }
            
            if count == 4
            {
                
                imageWidth = 150.0

                amongCollectionWidth = CGFloat(count - 1) * ImageMagin + imageWidth * 2
                
                amongContentHeight = 2 * imageWidth + CGFloat(count - 1) * ImageMagin

                
//                print("temp = \(amongCollectionWidth)")
                
                return
            }

            var tempCount : Int?
            tempCount = count > 3 ? 3 : count
            if tempCount >= 3
            {
            

                imageWidth = (UIScreen.mainScreen().bounds.size.width - CGFloat(tempCount!+1)*ImageMagin) / 3.0
                amongCollectionWidth = UIScreen.mainScreen().bounds.size.width

            }
            else
            {
                imageWidth = 150.0

                amongCollectionWidth = CGFloat(tempCount!+1) * ImageMagin + CGFloat(tempCount!) * imageWidth

            }

            
            let temp = (count - 1) / 3 + 1
            
            
            amongContentHeight = CGFloat(temp) * imageWidth + CGFloat(temp + 1) * ImageMagin
            
            
            
            
//            print("temp = \(amongCollectionWidth)")
            
        }
    }
    

    
    //用于保存图片的所有URL
    var storedImageUrlArr : [NSURL]?

    

    
    //微博发送的时间
    var created_at : String?
    {
    
        didSet{
            
            //1.转换 日期
            let createDate : NSDate = NSDate.dateFromString(created_at!)
            
            //2.日期比较，拿到对应的描述
            let timeDescr = createDate.dateDescription
            
            created_at = timeDescr
        }
        
    }
    
    //微博的ID
    var id : Int = 0
    
    //微博的文本内容
    var text : String?
    {
        
        didSet
        {
        
            /*
            
            CGRect rect = [text boundingRectWithSize:CGSizeMake(KScreenWidth - 20 - 10, 10000)
            options:NSStringDrawingUsesLineFragmentOrigin
            attributes:@{
            
            NSFontAttributeName : [UIFont systemFontOfSize:16]
            
            }
            context:nil ];
            */
            
            let paragphStyle : NSMutableParagraphStyle=NSMutableParagraphStyle()
            
            paragphStyle.lineSpacing=0;//设置行距为0
            //设置首行缩进
            paragphStyle.firstLineHeadIndent=0.0;
            //连字属性 在iOS，唯一支持的值分别为0和1,
            //0表示没有连体，1表示有连体
            paragphStyle.hyphenationFactor=0.0;
            //段首行空白空间
            paragphStyle.paragraphSpacingBefore=0.0;
            
            let kern = 1.0
            
            //NSKernAttributeName每个字符之间的间距
            
            let dic = [NSFontAttributeName : UIFont.systemFontOfSize(16) ,NSParagraphStyleAttributeName : paragphStyle , NSKernAttributeName : kern]
            
            
            
            let rect = (text! as NSString).boundingRectWithSize(CGSizeMake(UIScreen.mainScreen().bounds.size.width - 20, 10000), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: dic, context: nil)
            
            
//            print(rect.height)
            //加10是表示下边距多出10，这样更加好看
            topContentHeight = rect.height + 5

        }
    
    }
    
    //微博的 来源
    var source : String?
    {
        
        didSet
        {
        
            if let str = source {
                
                //如果不写，在某些情况有崩溃
                if str == ""{
                    
                    return
                    
                }
                
                //1.获取到要截取的字符串的位置
                let location = (str as NSString).rangeOfString(">").location + 1
                

                
                //1.2获取 需要的字符串的 长度
                let length = (str as NSString).rangeOfString("</").location - location
                
                //2.截取字符串， 拼接
                source = "来自" + (str as NSString).substringWithRange(NSMakeRange(location, length))
            }
        }
        
    }
    
    
    //内容图片
//    var pic_urls : [[String : AnyObject]]?
    
    //转发数
    var reposts_count : NSNumber?
    
    //评论数
    var comments_count : NSNumber?
    
    //点赞数
    var attitudes_count : NSNumber?

    //用户数据模型
    var user : SZUserModel?
    

    
    class func loadHomePageData(max_id: Int,since_id : Int , completion : (modelsArr : [SZHomePageModel]? , error : NSError?) -> ())
    {
    
        let tool : SZNetworkingTool = SZNetworkingTool.shareTool()
        
        let urlStr = "2/statuses/home_timeline.json"
        
        
        var parame : [String : AnyObject] = ["access_token" : SZAccountModel.loadAccount()!.access_token!]
        print("\(parame)")
        //证明是在 下拉刷新 新的数据了，所以要拼接 刷新的数据 是在哪一条数据之前的
        if since_id > 0 {
            
            parame["since_id"] = "\(since_id)"
        }
        
        //上拉加载
        if max_id > 0 {
            
            parame["max_id"] = "\(max_id)"
        }
        
        
        tool.responseSerializer = AFHTTPResponseSerializer()
        tool.requestSerializer = AFHTTPRequestSerializer()
        
        SVProgressHUD.showInfoWithStatus("内容加载中...", maskType: .Black)

        
        tool.GET(urlStr, parameters: parame, progress:
            {
                (_) -> Void in
            
            
            }, success:
            {
                (_, JSONData) -> Void in
                
                let JSONDict : NSDictionary?
                
                do
                {
                    
                    JSONDict = try NSJSONSerialization.JSONObjectWithData(JSONData as! NSData, options: .MutableContainers) as? NSDictionary
                    
//                    print(JSONDict)
                    
                    var modelsArr : [SZHomePageModel]? = [SZHomePageModel]()
                    
                    for item in JSONDict!["statuses"] as! [[String : AnyObject]]
                    {
                    
//                        print("reposts_count = \(item["reposts_count"])")
                        
                        let model : SZHomePageModel = SZHomePageModel.init(dict: item)
//                        print(model)
                        modelsArr?.append(model)
                        
//                        print("reposts_count = \(model.reposts_count!)")
                    }
                    

//                    print("modelsArr.count = \(modelsArr?.count)")
                    
                    
                    completion(modelsArr: modelsArr , error: nil)
                    
                    SVProgressHUD.dismiss()

                    
                }
                catch
                {
                    
                    print("解析数据出现异常！")
                    
                    completion(modelsArr: nil , error: nil)

                    SVProgressHUD.showInfoWithStatus("内容加载失败!", maskType: .Black)

                }
                
            })
            
            {
                (_, error) -> Void in
                
                completion(modelsArr: nil , error: error)

                
            }
        
        
        }
    
    
    init( dict : [String : AnyObject]) {
        
        super.init()
        
        
        setValuesForKeysWithDictionary(dict)
        
    }
    

    override func setValue(value: AnyObject?, forKey key: String)
    {
        
        if key == "user"
        {
            
            user = SZUserModel.init(dict: value as! [String : AnyObject])
            
            
        }
        else if key == "retweeted_status"
        {
            
            retweeted_status = SZHomePageModel.init(dict: value as! [String : AnyObject])
            
        }
        else
        {
            super.setValue(value, forKey: key)

        }

        
        
    }
    
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {

        
    }
    
}
