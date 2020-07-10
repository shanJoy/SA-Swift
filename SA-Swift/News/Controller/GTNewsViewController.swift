//
//  GTNewsViewController.swift
//  SA-Swift
//
//  Created by 张圣俊 on 2020/7/10.
//  Copyright © 2020 张圣俊. All rights reserved.
//

import UIKit

class GTNewsViewController: UIViewController {
    
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

        view.backgroundColor = UIColor.randomColor
    }
    
}
