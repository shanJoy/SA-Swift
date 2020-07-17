//
//  GTSplashView.swift
//  SA-Swift
//
//  Created by 张圣俊 on 2020/7/17.
//  Copyright © 2020 张圣俊. All rights reserved.
//

import UIKit

class GTSplashView: UIImageView {

    private var button : UIButton
    
    // 这个方法必须重写
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        button = UIButton.init(frame: UIRect(x: 330, y: 100, width: 60, height: 40))
        super.init(frame: frame)
        self.image = UIImage.init(named: "icon.bundle/splash.png")
        
        button.backgroundColor = UIColor.lightGray
        button.setTitle("跳转", for: .normal)
        button.addTarget(self, action: #selector(removeSplashView), for: .touchUpInside)
        self.addSubview(button)
        self.isUserInteractionEnabled = true
    }
    
    @objc private func removeSplashView() {
        self.removeFromSuperview()
    }
    
}
