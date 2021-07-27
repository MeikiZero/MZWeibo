//
//  UIButton+Extension.swift
//  weibo
//
//  Created by wangfa on 2021/7/27.
//

import UIKit

extension UIButton {
    /// 便利构造函数
    convenience init(imageName: String, bgImageName: String) {
        self.init()
        
        setImage(UIImage(named: imageName), for: .normal)
        setImage(UIImage(named: imageName + "_highlighted"), for: .highlighted)
        setBackgroundImage(UIImage(named: bgImageName), for: .normal)
        setBackgroundImage(UIImage(named: bgImageName + "_highlighted"), for: .highlighted)
        sizeToFit()
    }
}
