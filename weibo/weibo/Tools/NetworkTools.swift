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
    func requst(methodType: requstType, URLString: String, parameters: [String: AnyObject], finished: @escaping (_ result: Any?, _ error: Error?) -> ()) {
        
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
