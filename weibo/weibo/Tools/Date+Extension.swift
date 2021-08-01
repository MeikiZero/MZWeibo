//
//  Date+Extension.swift
//  weibo
//
//  Created by wangfa on 2021/8/1.
//

import Foundation

extension Date {
    //"Sat Jul 31 10:01:42 +0800 2021"
    static func createDateString(creatAtString: String) -> String {
        //创建时间格式化对象
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE MM dd HH:mm:ss Z yyyy"
        formatter.locale = Locale(identifier: "en")
        
        //将字符串转换成Date类型
        guard let creatDate = formatter.date(from: creatAtString) else {
            return ""
        }
        
        //创建当前时间
        let nowDate = Date()
        
        //计算当前时间和创建时间的时间差
        let interval = Int(nowDate.timeIntervalSince(creatDate))
        
        //刚刚
        if interval < 60 {
            return "刚刚"
        }
        
        //59分钟前
        if interval < 60 * 60 {
            return "\(interval / 60)分钟前"
        }
        
        //11小时前
        if interval < 60 * 60 * 24 {
            return "\(interval / (60 * 60))小时前"
        }
        
        // 创建日历对象
        let calendar = Calendar.current
        
        // 昨天 00:19
        if calendar.isDateInYesterday(creatDate) {
            formatter.dateFormat = "昨天 HH:mm"
            return formatter.string(from: creatDate)
        }
        
        //一年之内: 02-22
        let comp = calendar.component(.year, from: creatDate)
        if comp < 1 {
            formatter.dateFormat = "MM-dd"
            return formatter.string(from: creatDate)
        }
        
        //超过一年
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: creatDate)
        
    }
    
}
