//
//  Date_Extension.swift
//  swift-时间处理拓展
//
//  Created by 李胜兵 on 16/10/25.
//  Modified by 王治国 on 2017/09/15
//  Copyright © 2015年 付公司. All rights reserved.
//
import Foundation

public extension Date {
    
    // 传时间字符串
    static func createDateString(createAtStr : String) -> String {
        // 1.创建时间格式化对象
        let fmt = DateFormatter()
        fmt.dateFormat = "EEE MM dd HH:mm:ss Z yyyy"
        fmt.locale = Locale(identifier: "en")
        
        // 2.将字符串时间转化成NSDate类型
        guard let createDate =  fmt.date(from: createAtStr) else { return "" }
        
        // 3.创建当前时间
        /*
         2016-10-24 17:27:45 +0000
         2016-10-25 06:44:29 +0000 + 8小时才是当前时间，但是我们正好都是+0000，所以不需要转化为东八区
         */
        let nowDate = Date()
        
        // 4.计算创建时间和当前时间的时间差
        let interval = Int(nowDate.timeIntervalSince(createDate))
        
        // 5.根据时间差判断不同的显示
        // 5.1小于60秒，显示“刚刚”
        if interval < 60 {
            return "刚刚"
        }
        
        // 5.2小于1小时内，显示多少分钟:59分钟前
        if interval < 60 * 60 {
            return "\(interval / 60)分钟前"
        }
        
        // 5.3小于1天，显示 11小时前
        if interval < 60 * 60 * 24 {
            return "\(interval / (60 * 60))小时前"
        }
        
        // 5.4处理昨天的数据：昨天 12:23
        // 创建日历对象
        let calender =  Calendar.current
        if calender.isDateInYesterday(createDate) {
            fmt.dateFormat = "昨天 HH:mm"
            let timeStr = fmt.string(from: createDate)
            return timeStr
        }
        
        // http://nshipster.com/nsdatecomponents/
        // 5.5处理一年内时间:02-12 12:23
        let cmpt =  calender.dateComponents([.year], from: createDate, to: nowDate)
        if cmpt.year! < 1 {
            fmt.dateFormat = "MM-dd HH:mm"
            let timeStr = fmt.string(from: createDate)
            return timeStr
        }
        
        // 5.6超过1年的时间:2014-02-12 13:22
        fmt.dateFormat = "yyyy:MM:dd HH:mm"
        let timeStr = fmt.string(from: createDate)
        return timeStr
    }
    
    // 传时间戳
    static func timeStampToString(timeStamp: String) -> String {
        let str = NSString(string: timeStamp)
        let timeSta: TimeInterval = str.doubleValue
        let fmt = DateFormatter()
        fmt.dateFormat = "MM月dd日 HH:mm"
        
        let date = Date(timeIntervalSince1970: timeSta) 
        let timeStr = fmt.string(from: date)
        return timeStr
    }
    
    // 日期转换成对应格式的字符串
    static func changeDateToStr(date: Date, dateFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: date)
    }
}
