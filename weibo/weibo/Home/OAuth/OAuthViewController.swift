//
//  OAuthViewController.swift
//  weibo
//
//  Created by wangfa on 2021/7/28.
//

import UIKit
import SVProgressHUD

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
        title = "登录"
    }
    
    private func loadWebPage() {
        let urlString = "https://api.weibo.com/oauth2/authorize?client_id=\(app_key)&redirect_uri=\(redirect_uri)"
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
    
}

// MARK: - webView的代理方法
extension OAuthViewController: UIWebViewDelegate {
    /// webView开始加载网页
    func webViewDidStartLoad(_ webView: UIWebView) {
        SVProgressHUD.show()
    }
    
    /// webView网页加载完成
    func webViewDidFinishLoad(_ webView: UIWebView) {
        SVProgressHUD.dismiss()
    }
    
    /// webView网页加载失败
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        SVProgressHUD.dismiss()
    }
    
    /// 当准备加载某一个页面时
    /// 返回值: true -> 继续加载该页面 false -> 不会加载该页面
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebView.NavigationType) -> Bool {
        
        guard let url = request.url else { return true }
        let urlString = url.absoluteString
       
        if urlString.contains("browser?") {
            UIApplication.shared.openURL(url)
        }
        
        guard urlString.contains("www.baidu.com/?code") else {
            return true
        }
        
        let code = urlString.components(separatedBy: "code=").last!
        getAccessToken(code: code)
        
        return false
    }
}

// MARK: - 请求数据
extension OAuthViewController {
    private func getAccessToken(code: String) {
        NetworkTools.shareInstance.loadAccessToken(code: code) { result, error in
            if error != nil {
                print(error!)
                return
            }
            
            guard let accountDict = result else {
                print("没有拿到用户数据")
                return
            }
            
            print(accountDict)
            let account = UserAccount(dict: accountDict)
            self.loadUserInfo(account: account)
        }
    }
    
    private func loadUserInfo(account: UserAccount) {
        guard let access_token = account.access_token else { return }
        guard let uid = account.uid else { return }
        
        NetworkTools.shareInstance.loadUserInfo(access_token: access_token, uid: uid) { result, error in
            if error != nil {
                print(error!)
                return
            }
            
            guard let userInfoDict = result else { return }
            
            print(userInfoDict)
            
            account.screen_name = userInfoDict["screen_name"] as? String
            account.avatar_large = userInfoDict["avatar_large"] as? String
            
            // 将account对象保存
            NSKeyedArchiver.archiveRootObject(account, toFile: UserAccountViewModel.shareInstance.accountPath)
            
            // 将对象设置到单例中
            UserAccountViewModel.shareInstance.account = account

            self.dismiss(animated: false) {
                UIApplication.shared.keyWindow?.rootViewController = WelcomeViewController()
            }
        }
    }
}
