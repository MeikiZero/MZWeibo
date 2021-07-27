//
//  UIBarButtonItem+Extension.swift
//  weibo
//
//  Created by wangfa on 2021/7/27.
//

import UIKit

extension UIBarButtonItem {
    convenience init(imageName: String) {
        self.init();
        
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), for: .normal)
        btn.setImage(UIImage(named: imageName + "_highlighted"), for: .highlighted)
        btn.sizeToFit()
        customView = btn;
    }
}
