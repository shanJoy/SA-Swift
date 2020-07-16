//
//  GTDeleteCellView.swift
//  SA-Swift
//
//  Created by 张圣俊 on 2020/7/16.
//  Copyright © 2020 张圣俊. All rights reserved.
//

import UIKit

class GTDeleteCellView: UIView {

    private var backgroundView : UIView?
    private var deleteButton : UIButton
    private var deleteCallBack : () -> Void = {}//无参的闭包直接这么构造就行了
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        deleteButton = UIButton.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        super.init(frame: frame)
        backgroundView = UIView.init(frame: self.bounds)
        backgroundView!.backgroundColor = UIColor.black
        backgroundView!.alpha = 0.5
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(dismissDeleteView))
        backgroundView?.addGestureRecognizer(tapGesture)
        self.addSubview(backgroundView!)
        
        let tapGestureDelete = UITapGestureRecognizer.init(target: self, action: #selector(clickButton))
        deleteButton.addGestureRecognizer(tapGestureDelete)
        deleteButton.backgroundColor = UIColor.orange
        self.addSubview(deleteButton)
    }
    
    public func showDeleteViewFromPoint(point : CGPoint, clickCallback : @escaping () -> Void) {
        deleteButton.frame = CGRect(x: point.x, y: point.y, width: 0, height: 0)
        deleteCallBack = clickCallback
        UIApplication.shared.windows[1].addSubview(self)
//        UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseOut, animations: {
//            self.deleteButton.frame = CGRect(x: (self.bounds.size.width - 200) / 2, y: (self.bounds.size.height - 200) / 2, width: 200, height: 200)
//        }, completion: nil)
        UIView.animate(withDuration: 1.0, delay: 0.0, options: UIView.AnimationOptions.curveEaseOut, animations: {
         () -> Void in
            self.deleteButton.frame = CGRect(x: (self.bounds.size.width - 200) / 2, y: (self.bounds.size.height - 200) / 2, width: 200, height: 200)
        })
    }

    @objc func dismissDeleteView() {
        self.removeFromSuperview()
    }
    
    @objc func clickButton() {
        deleteCallBack()
        self.removeFromSuperview()
    }
    
}
