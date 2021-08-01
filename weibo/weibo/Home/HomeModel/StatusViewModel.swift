//
//  StatusViewModel.swift
//  weibo
//
//  Created by wangfa on 2021/8/1.
//

import UIKit

class StatusViewModel: NSObject {
    /// 存储Status模型数据
    var status: Status?
    /// 处理来源
    var sourceText: String?
    /// 处理创建时间
    var createAtText: String?
    /// 处理用户认证的图标
    var verifiedImage: UIImage?
    /// 处理用户的会员等级
    var vipImage: UIImage?
    /// 处理用户头像的地址
    var profileURL: NSURL?
    
    
    // MARK: - 自定义构造函数
    init(status: Status) {
        self.status = status
        //来源数据处理 "<a href=\"http://weibo.com/\" rel=\"nofollow\">iPhone客户端</a>"
        if let source = status.source, status.source != "" {
            let startIndex = (source as NSString).range(of: ">").location + 1
            let length = (source as NSString).range(of: "</").location - startIndex
            sourceText = (source as NSString).substring(with: NSRange(location: startIndex, length: length))
            print(sourceText as Any)
        }
        
        //创建时间处理
        if let createdAt = status.created_at {
            createAtText = Date.createDateString(creatAtString: createdAt)
        }
        
        //处理用户认证
        let verifiedType = status.user?.verified_type ?? -1
        switch verifiedType {
        case 0:
            verifiedImage = UIImage(named: "avatar_vip")
        case 2,3,5:
            verifiedImage = UIImage(named: "avatar_enterprise_vip")
        case 200:
            verifiedImage = UIImage(named: "avatar_grassroot")
        default:
            verifiedImage = nil
        }
        
        //处理用户的会员等级
        let mbrank = status.user?.mbrank ?? 0
        if mbrank > 0 && mbrank < 7 {
            vipImage = UIImage(named: "common_icon_membership_level\(mbrank)")
        }
        
        //处理用户头像
        let urlString = status.user?.profile_image_url ?? ""
        profileURL = NSURL(string: urlString)
        
    }

}

