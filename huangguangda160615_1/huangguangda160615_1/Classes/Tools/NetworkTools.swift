//
//  NetworkTools.swift
//  huangguangda160615_1
//
//  Created by apple on 17/10/12.
//  Copyright © 2017年 Student_test_0907. All rights reserved.
//

//import UIKit
import AFNetworking
class NetworkTools: AFHTTPSessionManager {
    public let appKey = "1339948314"
    public let appSecret = "6e91a8a0c652829088f50be7bc767750"
    public let redirectUrl = "http://www.baidu.com"
    
    
    
    var OAuthURL: NSURL{
        let urlString = "https://api.weibo.com/oauth2/authorize?client_id=1339948314&redirect_uri=http://www.baidu.com"
        return NSURL(string: urlString)!
        
    }
    static let sharedTools: NetworkTools = {
        let tools = NetworkTools(baseURL: nil)
        
        
        //118
        tools.responseSerializer.acceptableContentTypes?.insert("text/html")
        
        return tools
        
    }()
    //typealias HMRequestCallBack = (Any?,URLSessionDataTask?)->()
    typealias HMRequestCallBack = (Any?,Error?)->()// 新修改 
}

extension NetworkTools{
    
    func request(method:HMRequestMethod,URLString:String,
                 parameters:[String:AnyObject]?,finished:@escaping
                 HMRequestCallBack)
    {
        let success={(task:URLSessionDataTask?,result:Any?)->()
            in finished(result,nil)}
        let failure={(task:URLSessionDataTask?,error:Error?)->()
            in finished(nil,error)}//修改
        
        
        if method==HMRequestMethod.GET
        {
            get(URLString, parameters: parameters, progress: nil, success: success, failure: failure)
        }
        if method==HMRequestMethod.POST
        {
            post(URLString, parameters: parameters, progress: nil, success: success, failure: failure)
        }
    }
    //118
    func loadAccessToken(code: String, finished: @escaping HMRequestCallBack){
        let urlString = "https://api.weibo.com/oauth2/access_token"
        let params : [String:AnyObject]?=["client_id":appKey as
        AnyObject,"client_secret":appSecret as
        AnyObject,"grant_type":"authorization_code" as
        AnyObject,"code":code as AnyObject,"redirect_uri":
        redirectUrl as AnyObject]
        request(method: .POST, URLString: urlString, parameters: params, finished: finished)
        
    }
    //126
    func loadUserInfo(uid:String,/*accessToken:String,*/finished:@escaping HMRequestCallBack) {
        guard var params = tokenDict else {
            finished(nil,NSError(domain:"cn.itcast.error",code:-1001,userInfo:["message":"token is nil"]))
            return
        }
        let urlString = "https://api.weibo.com/2/users/show.json"
        params["uid"]=uid as AnyObject?
        request(method: .GET, URLString: urlString, parameters: params, finished: finished)
        
    }
    public var tokenDict:[String:AnyObject]?{
        if let token = UserAccountViewModel.sharedUserAccount.account?.access_token {
            return ["access_token": token as AnyObject]
        }
        return nil
    }
    
}
enum HMRequestMethod:String
{
  case GET="GET"
  case POST="POST"

}
