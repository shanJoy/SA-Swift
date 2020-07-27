//
//  GTVideoToolBar.swift
//  SA-Swift
//
//  Created by 张圣俊 on 2020/7/27.
//  Copyright © 2020 张圣俊. All rights reserved.
//

import UIKit

class GTVideoToolBar: UIView {

    private var avatarImageView : UIImageView
    private var nickLabel : UILabel
    private var commentImageView : UIImageView
    private var commentLabel : UILabel
    private var likeImageView : UIImageView
    private var likeLabel : UILabel
    private var shareImageView : UIImageView
    private var shareLabel : UILabel
    
    override init(frame: CGRect) {
        avatarImageView = UIImageView.init(frame: CGRect.zero)
        nickLabel = UILabel()
        commentImageView = UIImageView.init(frame: CGRect.zero)
        commentLabel = UILabel()
        likeImageView = UIImageView.init(frame: CGRect.zero)
        likeLabel = UILabel()
        shareImageView = UIImageView.init(frame: CGRect.zero)
        shareLabel = UILabel()
        super.init(frame: frame)
        
        avatarImageView.layer.masksToBounds = true
        avatarImageView.layer.cornerRadius = 15
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(avatarImageView)
        
        nickLabel.font = UIFont.systemFont(ofSize: 15)
        nickLabel.textColor = UIColor.lightGray
        nickLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(nickLabel)
        
        commentImageView.layer.masksToBounds = true
        commentImageView.layer.cornerRadius = 15
        commentImageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(commentImageView)
        
        commentLabel.font = UIFont.systemFont(ofSize: 15)
        commentLabel.textColor = UIColor.lightGray
        commentLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(commentLabel)
        
        likeImageView.layer.masksToBounds = true
        likeImageView.layer.cornerRadius = 15
        likeImageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(likeImageView)
        
        likeLabel.font = UIFont.systemFont(ofSize: 15)
        likeLabel.textColor = UIColor.lightGray
        likeLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(likeLabel)
        
        shareImageView.layer.masksToBounds = true
        shareImageView.layer.cornerRadius = 15
        shareImageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(shareImageView)
        
        shareLabel.font = UIFont.systemFont(ofSize: 15)
        shareLabel.textColor = UIColor.lightGray
        shareLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(shareLabel)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func layoutWithModel(any: Any) {
        
        avatarImageView.image = UIImage.init(named: "icon.bundle/icon.png")
        nickLabel.text = "极客时间"
        
        commentImageView.image = UIImage.init(named: "comment")
        commentLabel.text = "100"
        
        likeImageView.image = UIImage.init(named: "praise")
        likeLabel.text = "25"
        
        shareImageView.image = UIImage.init(named: "share")
        shareLabel.text = "分享"
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint.init(item: avatarImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0),
            NSLayoutConstraint.init(item: avatarImageView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 15),
            NSLayoutConstraint.init(item: avatarImageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 30),
            NSLayoutConstraint.init(item: avatarImageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 30),
            NSLayoutConstraint.init(item: nickLabel, attribute: .centerY, relatedBy: .equal, toItem: avatarImageView, attribute: .centerY, multiplier: 1, constant: 0),
            NSLayoutConstraint.init(item: nickLabel, attribute: .left, relatedBy: .equal, toItem: avatarImageView, attribute: .right, multiplier: 1, constant: 0)
        ])
        
        let vflString = "H:|-15-[avatorImageView]-0-[nickLabel]-(>=0)-[commentImageView(==avatorImageView)]-0-[commentLabel]-15-[likeImageView(==avatorImageView)]-0-[likeLabel]-15-[shareImageView(==avatorImageView)]-0-[shareLabel]-15-|"
        
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: vflString, options: .alignAllCenterY, metrics: nil, views: ["avatorImageView":avatarImageView, "nickLabel":nickLabel, "commentImageView":commentImageView, "commentLabel":commentLabel, "likeImageView" : likeImageView, "likeLabel":likeLabel, "shareImageView" : shareImageView, "shareLabel" : shareLabel]))
    }
}
