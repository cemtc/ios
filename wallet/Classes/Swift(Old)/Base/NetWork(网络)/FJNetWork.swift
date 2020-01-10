//
//  FJNetWork.swift
//  QYWallet
//
//  Created by 崔逢举 on 2019/5/22.
//  Copyright © 2019 崔逢举. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

enum MethodType {
    case get
    case post
}
class FJNetWork: NSObject {
    //单例
    static let share = FJNetWork()
    //MARK: - 属性
    static var sharedSessionManager: Alamofire.SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10//请求超时时间
        return Alamofire.SessionManager(configuration: configuration)
    }()
    
    /// 请求方法 返回值JSON
    ///
    /// - Parameters:
    ///   - type: 请求类型
    ///   - URLString: 链接
    ///   - params: 参数
    ///   - success: 成功的回调
    ///   - failture: 失败的回调
    func request(_ type : MethodType = .post, url : String, params : [String : Any]?,success : @escaping (_ responseJson : JSON)->(), failure : ((Int?, String) ->Void)?) {
        // 1.获取类型
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        FJNetWork.sharedSessionManager.request(url, method: method, parameters: params).responseJSON { (response) in
            guard let json = response.result.value else {
                return
            }
            switch response.result {
            case let .success(response):
                do {
                    // ***********这里可以统一处理错误码，统一弹出错误 ****
                    success(JSON(json))
                }
            case let .failure(error):
                failureHandle(failure: failure, stateCode: nil, message: error.localizedDescription)
            }
        }
        
        //错误处理 - 弹出错误信息
        func failureHandle(failure: ((Int?, String) ->Void)? , stateCode: Int?, message: String) {
            failure?(stateCode ,message)
        }
    }
 
    
}
//二次封装
extension FJNetWork{
    
    /// GET 请求 返回JSON
    ///
    /// - Parameters:
    ///   - URLString: 请求链接
    ///   - params: 参数
    ///   - success: 成功的回调
    ///   - failture: 失败的回调
    func GET(url : String, params : [String : Any]?, success: @escaping (_ responseJson : JSON)->(), failure : ((Int?, String) ->Void)?) {
       self.request(.get, url: url, params: params, success: success, failure: failure)
    }
    /// POST 求情
    ///
    /// - Parameters:
    ///   - URLString: 请求链接
    ///   - params: 参数
    ///   - success: 成功的回调
    ///   - failture: 失败的回调
    func POST(url : String, params : [String : Any]?,success : @escaping (_ responseJson : JSON)->(), failure : ((Int?, String) ->Void)?) {
        self.request(.post, url: url, params: params, success: success, failure: failure)
    }
    
    
}
