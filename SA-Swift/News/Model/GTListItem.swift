//
//  GTListItem.swift
//  SA-Swift
//
//  Created by 张圣俊 on 2020/7/12.
//  Copyright © 2020 张圣俊. All rights reserved.
//

import UIKit

class GTListItem: NSObject,NSSecureCoding {
    
    func encode(with coder: NSCoder) {
        coder.encode(self.category, forKey: "category")
        coder.encode(self.uniqueKey, forKey: "uniqueKey")
        coder.encode(self.title, forKey: "title")
        coder.encode(self.date, forKey: "date")
        coder.encode(self.author_name, forKey: "author_name")
        coder.encode(self.url, forKey: "url")
        coder.encode(self.thumbnail_pic_s, forKey: "thumbnail_pic_s")
    }
    
    required init?(coder: NSCoder) {
        self.category = coder.decodeObject(forKey: "category") as! String
        self.uniqueKey = coder.decodeObject(forKey: "uniqueKey") as! String
        self.title = coder.decodeObject(forKey: "title") as! String
        self.date = coder.decodeObject(forKey: "date") as! String
        self.author_name = coder.decodeObject(forKey: "author_name") as! String
        self.url = coder.decodeObject(forKey: "url") as! String
        self.thumbnail_pic_s = coder.decodeObject(forKey: "thumbnail_pic_s") as! String
    }
    
    
    static var supportsSecureCoding : Bool = true
    
    // 属性必须加上@objc，YYModel才能识别
    @objc var category = ""
    @objc var uniqueKey = ""
    @objc var title = ""
    @objc var date = ""
    @objc var author_name = ""
    @objc var url = ""
    @objc var thumbnail_pic_s = ""
    
    override init() {
        super.init()
    }
    
    // YYModel必须手写这些对应关系，如果只有变化的话，对应方法必须加上@objc，不然识别不了
    @objc class func modelCustomPropertyMapper() -> NSDictionary {
        return ["category":"category",
         "thumbnail_pic_s":"thumbnail_pic_s",
         "uniqueKey":"uniquekey",
         "title":"title",
         "date":"date",
         "author_name":"author_name",
         "url":"url"]
    }
}
