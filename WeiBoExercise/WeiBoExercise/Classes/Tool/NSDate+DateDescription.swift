//
//  File.swift
//  BeiwoWeibo
//
//  Created by JingYang on 16/9/28.
//  Copyright © 2016年 贝沃汇力IT. All rights reserved.
//

import Foundation

extension NSDate {
    
    //1.转换 字符串为日期
    class func dateFromString(timeStr : String) -> NSDate {
        
        
        //Wed Sep 28 09:28:30 +0008 2016
        
        //1.先把服务器返回的时间字符串 转换为NSDate
        
        //1.1 先创建 日期格式化类
        let formatter = NSDateFormatter()
        
        //1.2 指定出 你要转换的 日期字符串 对应的格式
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z yyyy"
        
        //1.3 如果是真机，必须要设置这个时间的 区域， 如果真机不设置，时间转换不成功
        formatter.locale = NSLocale(localeIdentifier: "en")
        
        //1.4 将这个字符串转换为 对应的 日期，
        let createdDate = formatter.dateFromString(timeStr)!

        return createdDate
        
    }
    
    //2.根据日期 进行比较， 返回对应的描述
    var dateDescription : String {
        
        //实际上比较  createdDate  和 当前这个日期的时间
        //2.通过 日历对象 以及时间组件对象，来 对这个时间进行描述
        // 一分钟内， --》 刚刚
        // 一小时内  --》 XX分钟前
        //当天      --》 多少小时前
        
        //昨天  --》 昨天 HH:mm
        //今年的某一天 -》 MM-dd HH:mm
        //不是今年 -》 yyyy-MM-dd
        /*
        if 今天 {
        
        
        } else if 昨天 {
        
        //昨天 HH:mm
        
        } else if 今年 {
        
        //MM-dd HH:mm
        
        
        } else { //其他年份
        //yyyy-MM-dd
        
        }
        */
        
        //1.获取日历对象
        let calendar = NSCalendar.currentCalendar()
        
        //2.对比当前日期 和 创建日期
        //2.1 判断是否是今天
        if calendar.isDateInToday(self) {
            
            
            //2.1.1 拿到 创建时间self 跟 当前时间的 时间间隔
            let timeInterval = Int(NSDate().timeIntervalSinceDate(self))
            
            
            if timeInterval < 60 {
                
                return "刚刚"
        
            }else if timeInterval < 60 * 60 {
                
                //XX分钟前
                return "\(timeInterval/60)分钟前"
                
            }else{
                
                //多少小时前
                return "\(timeInterval / (60 * 60))小时前"
            }
            

            
            
        }
        
        
        //判断昨天
        
        //时间格式字符串
        var formatterStr = "HH:mm"
        if calendar.isDateInYesterday(self) {
          
            formatterStr = "昨天 " + formatterStr
            
        }else {
            
            // 2016年
            //2015年
            let compon = calendar.components(NSCalendarUnit.Year, fromDate: self, toDate: NSDate(), options: NSCalendarOptions(rawValue: 0))
            
            
            
            //不是今年
            if compon.year >= 1 {
                
                //MM-dd HH:mm
                formatterStr = "yyyy-MM-dd"
                
            }else {
                
                //今年的
                
                formatterStr = "MM-dd HH:mm"
            }
            
            
            
            
        }
        

        //创建日期格式化对象
        let formatter = NSDateFormatter()
        

        //设置  对应的 格式化日期 给 日期格式化对象
        formatter.dateFormat = formatterStr
        
        //设置真机
        formatter.locale = NSLocale(localeIdentifier: "en")
        
        //昨天 09:23
        //
        //把当前日期转换为对应 格式的 字符串
        return  formatter.stringFromDate(self)
        
        
        
    }
    
    
    
    
}