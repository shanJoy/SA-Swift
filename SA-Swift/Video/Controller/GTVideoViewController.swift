//
//  GTVideoViewController.swift
//  SA-Swift
//
//  Created by 张圣俊 on 2020/7/10.
//  Copyright © 2020 张圣俊. All rights reserved.
//

import UIKit
let GTVideoToolbarHeight = UI(value: 60)
class GTVideoViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.tabBarItem.title = "视频"
        self.tabBarItem.image = UIImage.init(named: "icon.bundle/video@2x.png")
        self.tabBarItem.selectedImage = UIImage.init(named: "icon.bundle/video_selected@2x.png")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.itemSize = CGSize(width: self.view.frame.size.width, height: self.view.frame.size.width / 16 * 9 + GTVideoToolbarHeight)
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // 一些滚动的UIView，inset自动适配留海屏，在iOS 11上才有效，如果需要兼容iOS 11以下的机型，需要设置成Never，然后和其他的页面一样适配
        // collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentBehavior.never
        // class丢向用类名.self解决
        collectionView.register(GTVideoCoverView.self, forCellWithReuseIdentifier: "mark")
        self.view.addSubview(collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mark", for: indexPath)
        // 强转得用条件表达式来做
        if let temp = cell as? GTVideoCoverView {
            //-------------------------------------------------------------------http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4
            temp.layoutWithVideoCoverUrl(videoCoverUrl: "videoCover", videoUrl: "http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4")
        }
        return cell
    }
    
}
