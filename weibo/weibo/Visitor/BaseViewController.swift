//
//  BaseViewController.swift
//  weibo
//
//  Created by wangfa on 2021/7/27.
//

import UIKit

class BaseViewController: UITableViewController {
    lazy var vistorView = VistorView.vistorView()
    
    var isLogin = false
    
    override func loadView() {
        isLogin ? super.loadView() : setVistorView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationItems()
        
    }

}

// MARK: - 设置UI界面
extension BaseViewController {
    
    private func setVistorView() {
        view = vistorView
        
        /// 监听访客视图的按钮点击
        vistorView.registerBtn.addTarget(self, action: #selector(registerBtnClick), for: .touchUpInside)
        vistorView.loginBtn.addTarget(self, action: #selector(loginBtnClick), for: .touchUpInside)
    }
    
    private func setupNavigationItems() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: .plain, target: self, action: #selector(registerBtnClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style: .plain, target: self, action: #selector(loginBtnClick))
    }
}

// MARK: - 事件监听
extension BaseViewController {
    @objc private func registerBtnClick() {
        print("registerBtnClick")
    }
    
    @objc private func loginBtnClick() {
        let oauthVc = OAuthViewController()
        let oauthNav = UINavigationController(rootViewController: oauthVc)
        present(oauthNav, animated: true, completion: nil)
        
    }
}
