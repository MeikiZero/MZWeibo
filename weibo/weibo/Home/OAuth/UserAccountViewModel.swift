//
//  UserAccountViewModel.swift
//  weibo
//
//  Created by wangfa on 2021/7/31.
//

import UIKit

class UserAccountViewModel {
    /// 视图模型类设计成单例模式
    static let shareInstance = UserAccountViewModel()
    
    /// 存储属性 保存用户的信息
    var account: UserAccount?
    
    /// 计算属性 获取accout.plist的沙盒路径
    var accountPath: String {
        var accountPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        accountPath.append("/accout.plist")
        return accountPath
    }
    
    /// 计算属性 判断是否登录
    var isLogin: Bool {
        if account == nil {
            return false
        }
        guard let expiresDate = account?.expires_date else { return false }
        
        return expiresDate.compare(Date()) == ComparisonResult.orderedDescending
    }
    
    // MARK: - 重写init()方法
    init() {
        account = NSKeyedUnarchiver.unarchiveObject(withFile: accountPath) as? UserAccount
    }
    
    

}
