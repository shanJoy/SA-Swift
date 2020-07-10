//
//  GTRecommendController.swift
//  SA-Swift
//
//  Created by 张圣俊 on 2020/7/10.
//  Copyright © 2020 张圣俊. All rights reserved.
//

import UIKit

class GTRecommendController: UIViewController {
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.tabBarItem.title = "推荐"
        self.tabBarItem.image = UIImage.init(named: "icon.bundle/like@2x.png")
        self.tabBarItem.selectedImage = UIImage.init(named: "icon.bundle/like_selected@2x.png")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.randomColor
    }
    

}