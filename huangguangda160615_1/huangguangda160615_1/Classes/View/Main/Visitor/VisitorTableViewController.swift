//
//  VisitorTableViewController.swift
//  huangguangda160615_1
//
//  Created by Student on 17/9/20.
//  Copyright © 2017年 Student_test_0907. All rights reserved.
//

import UIKit

class VisitorTableViewController: UITableViewController {

    //用户登录标记
    private var userLogon = false
    //访客视图
    var visitorView: VisitorView?
    
    override func loadView() {
        userLogon ? super.loadView() : setupVisitorView()
    }
    //设置访客视图
    private func setupVisitorView(){
        //替换根视图
        visitorView = VisitorView()
        view = visitorView
        
        visitorView?.registerButton.addTarget(self, action: #selector(VisitorTableViewController.visitorViewDidRegister), for: UIControlEvents.touchUpInside)
        visitorView?.loginButton.addTarget(self, action: #selector(VisitorTableViewController.visitorViewDidLogin), for: UIControlEvents.touchUpInside)
    }


    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
   }
extension VisitorTableViewController{
        public func visitorViewDidRegister()
        {
            print("zuche")
        }
        public func visitorViewDidLogin()
        {
            let vc=OAuthViewController()
            let nav=UINavigationController(rootViewController: vc)
            self.present(nav, animated: true, completion: nil)
        }
}

