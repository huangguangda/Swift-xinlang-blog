//
//  OAuthViewController.swift
//  huangguangda160615_1
//
//  Created by apple on 17/10/19.
//  Copyright © 2017年 Student_test_0907. All rights reserved.
//

import UIKit

class OAuthViewController: UIViewController {
    private lazy var webView = UIWebView()
    
    @objc
    private func close(){
        dismiss(animated: true, completion: nil)
    }
    override func loadView() {
        view = webView
        //授权码
        webView.delegate=self
        title = "登录新浪微博"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", style:  .plain, target: self, action: #selector(OAuthViewController.close))
        //super.viewDidLoad()

    }
    override func viewDidLoad() {
        super.viewDidLoad()
                
        webView.loadRequest(URLRequest(url:NetworkTools.sharedTools.OAuthURL as URL))
        
        
        navigationItem.rightBarButtonItem=UIBarButtonItem(title:"自动填充",style:.plain,target:self,action:#selector(OAuthViewController.autoFill))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func autoFill()
    {
        let
           js = "document.getElementById('userId').value ='13049028950';"+"document.getElementById('passwd').value ='daguanghuang';"
        webView.stringByEvaluatingJavaScript(from: js)
    }
}

extension OAuthViewController:UIWebViewDelegate
{
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool
    {
        guard let url=request.url,url.host == "www.baidu.com" else
        {
            return true
        }
        guard let query=url.query , query.hasPrefix("code=") else
        {
            print("取消授权")
            return false
        }
        let code=query.substring(from: "code=".endIndex)
        print("授权码是"+code)
        
        //118
//        NetworkTools.sharedTools.loadAssessToken(code: code){
//            (result, error) in
//            if error?.error != nil{
//                print("出错了")
//                return
//            }
//            print(result!)
//            
//            let test=result as! [String:Any]
//            let account=UserAccount(dict: result as! [String:Any])
//            print(account.description)
//            self.loadUserInfo(account: account)
//        }
        UserAccountViewModel.sharedUserAccount.loadAccessToken(code: code){
            (isSuccessed)->() in
            if isSuccessed
            {
                print("成功了")
                print(UserAccountViewModel.sharedUserAccount.account)
            }else
            {
                print("失败了")
            }
        }
        return false
    }
//    private func loadUserInfo(account: UserAccount){
//        NetworkTools.sharedTools.loadUserInfo(uid: account.uid!, accessToken:
//        account.access_token!){ (result, error) -> () in
//            if error != nil {
//                print("加载用户出错了")
//                return
//            }
//            guard let dict = result as? [String: Any] else{
//                print("格式错误")
//                return
//            }
//            account.screen_name = (dict["screen_name"] as? String)!
//            account.avatar_large = (dict["avatar_large"] as? String)!
//            print(account)
//    }
//    }
    
}
