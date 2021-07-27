//
//  MainController.swift
//  weibo
//
//  Created by wangfa on 2021/7/27.
//

import UIKit

class MainController: UITabBarController {
    
    /// 懒加载属性
    private lazy var composeBtn = UIButton(imageName: "tabbar_compose_icon_add", bgImageName: "tabbar_compose_button")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setComposeBtn()
    }
    

}

// MARK: - 设置UI界面
extension MainController {
    private func setComposeBtn() {
        tabBar.addSubview(composeBtn)
        composeBtn.center = CGPoint(x: tabBar.center.x, y: tabBar.bounds.height * 0.5)
        composeBtn.addTarget(self, action: #selector(composeBtnClick), for: .touchUpInside)
    }
}

// MARK: - 事件监听
extension MainController {
    @objc private func composeBtnClick() {
        print("composeBtnClick")
    }
}
