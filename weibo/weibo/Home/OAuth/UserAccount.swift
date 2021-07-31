//
//  UserAccount.swift
//  weibo
//
//  Created by wangfa on 2021/7/31.
//
///["uid": 7472383191, "remind_in": 157679999, "expires_in": 157679999, "isRealName": true, "access_token": 2.00XN3hJIZbA6HC793d4ef5370frACE]

import UIKit

class UserAccount: NSObject, NSCoding {
    /// 授权token
    @objc var access_token: String?
    /// token的过期时间
    @objc var expires_in: TimeInterval = 0.0 {
        didSet {
            expires_date = Date(timeIntervalSinceNow: expires_in)
        }
    }
    /// 用户id
    @objc var uid: String?
    /// 过期日期
    @objc var expires_date: Date?
    /// 昵称
    @objc var screen_name: String?
    /// 用户的头像地址
    @objc var avatar_large: String?
    
    
    // MARK: - 自定义的构造函数
    init(dict: [String: Any]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    

    // MARK:- 重写description属性
    override var description : String {
        return dictionaryWithValues(forKeys: ["access_token", "expires_date", "uid", "screen_name", "avatar_large"]).description
    }
    
    
    // MARK: - 解档
    required init?(coder: NSCoder) {
        access_token = coder.decodeObject(forKey: "access_token") as? String
        expires_date = coder.decodeObject(forKey: "expires_date") as? Date
        uid = coder.decodeObject(forKey: "uid") as? String
        screen_name = coder.decodeObject(forKey: "screen_name") as? String
        avatar_large = coder.decodeObject(forKey: "avatar_large") as? String

    }
    
    // MARK: - 归档
    func encode(with coder: NSCoder) {
        coder.encode(access_token, forKey: "access_token")
        coder.encode(expires_date, forKey: "expires_date")
        coder.encode(uid, forKey: "uid")
        coder.encode(screen_name, forKey: "screen_name")
        coder.encode(avatar_large, forKey: "avatar_large")

    }
    
    
}
