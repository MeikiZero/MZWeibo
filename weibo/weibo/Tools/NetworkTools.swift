//
//  NetworkTools.swift
//  weibo
//
//  Created by wangfa on 2021/7/28.
//

import AFNetworking

enum requstType: String {
    case GET = "GET"
    case POST = "POST"
}

class NetworkTools: AFHTTPSessionManager {
    /// 单例
    static let shareInstance: NetworkTools = {
        let tools = NetworkTools()
        tools.responseSerializer.acceptableContentTypes?.insert("text/html")
        tools.responseSerializer.acceptableContentTypes?.insert("text/plain")
        return tools
    }()
    
}

// MARK: - 网络请求
extension NetworkTools {
    func requst(methodType: requstType, URLString: String, parameters: [String: Any]?, finished: @escaping (_ result: Any?, _ error: Error?) -> Void) {
        
        if methodType == .GET {
            get(URLString, parameters: parameters, headers: nil, progress: nil) { task, result in
                finished(result, nil)
            } failure: { task, error in
                finished(nil, error)
            }
        } else {
            post(URLString, parameters: parameters, headers: nil, progress: nil) { task, result in
                finished(result, nil)
            } failure: { task, error in
                finished(nil, error)
            }

        }
    
    }
    
}

// MARK: - 请求AccessToken
extension NetworkTools {
    func loadAccessToken(code: String, finished: @escaping ([String: Any]?, Error?) -> Void) {
        let urlString = "https://api.weibo.com/oauth2/access_token"
        
        let parameters = ["client_id": app_key,
                          "client_secret": app_secret,
                          "grant_type": "authorization_code",
                          "code": code,
                          "redirect_uri": redirect_uri]
        
        requst(methodType: .POST, URLString: urlString, parameters: parameters) { result, error in
            finished(result as? [String: Any], error)
        }
    }
}

// MARK: - 请求用户信息
extension NetworkTools {
    func loadUserInfo(access_token: String, uid: String, finished: @escaping ([String: Any]?, Error?) -> Void) {
        let urlString = "https://api.weibo.com/2/users/show.json"
        
        let parameters = ["access_token": access_token, "uid": uid]
        
        requst(methodType: .GET, URLString: urlString, parameters: parameters) { result, error in
            finished(result as? [String : Any], error)
        }
    }
}

// MARK: - 请求首页的数据
extension NetworkTools {
    func loadStatuses(finished: @escaping ([[String: Any]]?, Error?) -> Void) {
        let urlString = "https://api.weibo.com/2/statuses/home_timeline.json"
        let parameters = ["access_token": (UserAccountViewModel.shareInstance.account?.access_token)!]
        
        requst(methodType: .GET, URLString: urlString, parameters: parameters) { result, error in
            // 获取字典的数据
            guard let result = result else {
                finished(nil, error)
                return
            }
            let resultDict = result as! [String: Any]
            
            finished(resultDict["statuses"] as? [[String : Any]] , error)
            
        }
    }
}

