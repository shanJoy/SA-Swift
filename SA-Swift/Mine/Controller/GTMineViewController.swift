//
//  GTMineViewController.swift
//  SA-Swift
//
//  Created by 张圣俊 on 2020/7/10.
//  Copyright © 2020 张圣俊. All rights reserved.
//

import UIKit

class GTMineViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private var tableView : UITableView?=nil
    private var tableViewHeaderView : UIView?=nil
    private var headerImageView : UIImageView?=nil
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.tabBarItem.title = "我的"
        self.tabBarItem.image = UIImage.init(named: "icon.bundle/home@2x.png")
        self.tabBarItem.selectedImage = UIImage.init(named: "icon.bundle/home_selected@2x.png")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        tableViewHeaderView = UIView.init(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 200))
        tableViewHeaderView?.backgroundColor = UIColor.white
        
        headerImageView = UIImageView.init(frame: CGRect(x: 0, y: 30, width: self.view.frame.size.width, height: 140))
        headerImageView?.backgroundColor = UIColor.white
        headerImageView?.contentMode = UIView.ContentMode.scaleAspectFit
        headerImageView?.clipsToBounds = true
        headerImageView?.isUserInteractionEnabled = true
        tableViewHeaderView?.addSubview(headerImageView!)
        
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(tapImage))
        tableViewHeaderView?.addGestureRecognizer(tapGesture)
        
        tableView = UITableView.init(frame: self.view.bounds, style: .grouped)
        tableView!.delegate = self
        tableView!.dataSource = self
        
        self.view.addSubview(tableView!)
    }
    
    @objc func tapImage() {
        if !GTLogin.shared.isLogin() {
            GTLogin.shared.loginWithCallBack { (islogin) in
                if(islogin) {
                    self.tableView?.reloadData()
                }
            }
        }else {
            GTLogin.shared.logout()
            self.tableView?.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mineTableViewCell") ??
            UITableViewCell.init(style: .default, reuseIdentifier: "mineTableViewCell")
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return tableViewHeaderView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if !GTLogin.shared.isLogin() {
            headerImageView!.image = UIImage.init(named: "icon.bundle/icon.png")
        }else {
            headerImageView!.sd_setImage(with: URL.init(string: GTLogin.shared.avatarUrl), completed: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            cell.textLabel?.text = GTLogin.shared.isLogin() ? GTLogin.shared.nick : "昵称"
        }else {
            cell.textLabel?.text = GTLogin.shared.isLogin() ? GTLogin.shared.address : "地区"
        }
    }
}
