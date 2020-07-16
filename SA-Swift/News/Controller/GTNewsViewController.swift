//
//  GTNewsViewController.swift
//  SA-Swift
//
//  Created by 张圣俊 on 2020/7/10.
//  Copyright © 2020 张圣俊. All rights reserved.
//

import UIKit

class GTNewsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource, GTNormalTableViewCellDelegate {

    //延迟初始化的和kotlin的lazyinit基本类似
    private var tableView : UITableView?
    private var dataArray = Array<GTListItem>()
    private var listLoader = GTListLoader()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.tabBarItem.title = "新闻"
        self.tabBarItem.image = UIImage.init(named: "icon.bundle/page@2x.png")
        self.tabBarItem.selectedImage = UIImage.init(named: "icon.bundle/page_selected@2x.png")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.resourceTest()
        tableView = UITableView.init(frame: self.view.bounds)
        tableView?.delegate = self
        tableView?.dataSource = self
        
        self.tableView?.mj_header = MJRefreshNormalHeader.init(refreshingTarget: self, refreshingAction: #selector(reloadData))
        self.tableView?.mj_header?.beginRefreshing()
        self.tableView?.mj_footer = MJRefreshAutoNormalFooter.init(refreshingTarget: self, refreshingAction: #selector(loadMoreData))
        
        self.view.addSubview(tableView!)
        
        let searchBar = GTSearchBar.init(frame: CGRect(x: 0, y: 0, width: getScreenWidth() - UI(value: 20), height: self.navigationController!.navigationBar.bounds.size.height))
        self.tabBarController?.navigationItem.titleView = searchBar
    }
    
    @objc func reloadData() {
        self.listLoader.loadListDataWithFinishBlock { (success, data) in
            self.dataArray.removeAll()
            //以这种方式合并数组
            self.dataArray += data
            self.tableView?.reloadData()
            self.tableView?.mj_header?.endRefreshing()
        }
    }
    
    @objc func loadMoreData() {
        self.dataArray += self.dataArray
        self.tableView?.reloadData()
        self.tableView?.mj_footer?.endRefreshing()
    }
    
    //资源名称随意去 随意放
    // .app其实是一个Bundle，可以点击查看包内容查看到里面的内容 包括其他bundle都是这个bundle里面的子路径
    private func resourceTest() {
        let path = Bundle.main.path(forResource: "test", ofType: "plist")
        let username = NSDictionary.init(contentsOfFile: path!)
        print("username为：\(username!)")
        
        let filePath = Bundle.main.path(forResource: "test", ofType: nil)
        do {
            let fileContent = try String.init(contentsOfFile: filePath!)
            print("文件内容为：\(fileContent)")
        } catch let error {
            print("error >>> \(error)")
        }
    }
    
    func clickDeleteButton(cell: UITableViewCell, btn: UIButton) {
        let deleteView = GTDeleteCellView.init(frame: self.view.bounds)
        let rect = cell.convert(btn.frame, to: nil)
        deleteView.showDeleteViewFromPoint(point: rect.origin) {
            let index = self.tableView?.indexPath(for: cell)
            self.dataArray.remove(at: index!.row)
            self.tableView?.deleteRows(at: [index!], with: UITableView.RowAnimation.automatic)
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let url = self.dataArray[indexPath.row].url
        let viewController = GTDetailViewController.initWithUrlString(urlString: url)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "mark") as? GTNormalTableViewCell
        if cell == nil {
            cell = GTNormalTableViewCell.init(style: .subtitle, reuseIdentifier: "mark")
            cell?.delegate = self
        }
        cell?.layoutTableViewCellWithItem(item: self.dataArray[indexPath.row])
        return cell!
    }
    
    
}
