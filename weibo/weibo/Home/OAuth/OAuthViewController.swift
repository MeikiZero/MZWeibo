//
//  OAuthViewController.swift
//  weibo
//
//  Created by wangfa on 2021/7/28.
//

import UIKit

class OAuthViewController: UIViewController {
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        loadWebPage()
    }

}

// MARK: - 设置UI界面
extension OAuthViewController {
    private func setupNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", style: .plain, target: self, action: #selector(closeItemClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "填充", style: .plain, target: self, action: #selector(fillItemClick))
        title = "登录"
    }
    
    private func loadWebPage() {
        let urlString = "https://www.baidu.com"
        guard let url = URL(string: urlString) else { return }
        let requst = URLRequest(url: url)
        webView.loadRequest(requst)
    }
}

// MARK: - 事件监听
extension OAuthViewController {
    @objc private func closeItemClick() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func fillItemClick() {
        
    }
    
}
