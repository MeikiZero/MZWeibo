//
//  Status.swift
//  weibo
//
//  Created by wangfa on 2021/8/1.
//

import UIKit

class Status: NSObject {
    /// 微博的创建时间
    @objc var created_at: String?
    /// 微博的来源
    @objc var source: String?
    /// 微博的正文
    @objc var text: String?
    /// 微博的ID
    @objc var mid: Int = 0
    /// 微博的用户信息
    @objc var user: User?
    
    // MARK: - 自定义构造函数
    init(dict: [String: Any]) {
        super.init()
        
        setValuesForKeys(dict)
        
        if let userDict = dict["user"] as? [String: Any] {
            user = User(dict: userDict)
        }
        
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}

}
