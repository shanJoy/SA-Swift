//
//  GTListLoader.swift
//  SA-Swift
//
//  Created by 张圣俊 on 2020/7/12.
//  Copyright © 2020 张圣俊. All rights reserved.
//

import UIKit
import Foundation

class GTListLoader: NSObject {
    
    //NSArray转Array，主要是Array这边没有完整的泛型
    func loadListDataWithFinishBlock(callback:(Bool,Array<GTListItem>) -> Void) {
        let listdata = readDataFromLocal()
        if listdata.count > 0 {
            print("本地有缓存数据")
            callback(true, listdata)
        }
        let urlString = "https://static001.geekbang.org/univer/classes/ios_dev/lession/45/toutiao.json"
        AFHTTPSessionManager.init().get(urlString, parameters: nil, headers: nil, progress: nil, success: { (task, responObj) in
            let result = (responObj as! NSDictionary)["result"]
            let dataArray = ((result as! NSDictionary)["data"]) as! NSArray
            let array = NSArray.yy_modelArray(with: GTListItem.self, json: dataArray) as! Array<GTListItem>
            self.archiveListDataWithArray(array: array)
            
        }) { (task, error) in
            print("网络访问出错")
        }
        
    }
    
    //新闻数据缓存本地，归档API变动很大
    private func readDataFromLocal() -> Array<GTListItem> {
        // 注意：这边Swift和Objective-c的api不一样
        let pathArray = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let cachePath = pathArray.first
        let listdataPath = NSURL(fileURLWithPath: cachePath!).appendingPathComponent("GTData/list")
        let readListData = FileManager.default.contents(atPath: listdataPath!.path)
        // 这边接口没有泛型 得用强转
        if (readListData == nil) {
            return Array<GTListItem>()
        }
        //let unarchiveObj = try! NSKeyedUnarchiver.unarchivedObject(ofClass: NSArray.self, from: readListData!)
        let unarchiveObj = NSKeyedUnarchiver.unarchiveObject(with: readListData!)
        return unarchiveObj as! Array<GTListItem>
    }
    
    private func archiveListDataWithArray(array : Array<GTListItem>) {
        let pathArray = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let cachePath = pathArray.first
        
        //创建文件夹
        do{
            let dataPath = NSURL(fileURLWithPath: cachePath!).appendingPathComponent("GTData")
            try FileManager.default.createDirectory(at: dataPath!, withIntermediateDirectories: true, attributes: nil)
            let listdataPath = NSURL(fileURLWithPath: dataPath!.path).appendingPathComponent("list")
            let listdata = try NSKeyedArchiver.archivedData(withRootObject: array, requiringSecureCoding: true)
            FileManager.default.createFile(atPath: listdataPath!.path, contents: listdata, attributes: nil)
        }catch let error {
            print("GTListLoader - error >>> \(error)")
        }
    }

}
