//
//  GTVideoCoverView.swift
//  SA-Swift
//
//  Created by 张圣俊 on 2020/7/27.
//  Copyright © 2020 张圣俊. All rights reserved.
//

import UIKit

class GTVideoCoverView: UICollectionViewCell {
    
    private var coverView : UIImageView?=nil
    private var playButton : UIImageView?=nil
    private var videoUrl : String?=nil
    private var gtVideoToolBar : GTVideoToolBar? = nil
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        self.backgroundColor = UIColor.white
        
        coverView = UIImageView.init(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height - GTVideoToolbarHeight))
        self.addSubview(coverView!)
        
        playButton = UIImageView.init(frame: CGRect(x: (frame.size.width - UI(value: 50)) / 2, y: (frame.size.height - GTVideoToolbarHeight - UI(value: 50)) / 2, width: UI(value: 50), height: UI(value: 50)))
        playButton?.image = UIImage.init(named: "videoPlayer")
        coverView!.addSubview(playButton!)
        
        gtVideoToolBar = GTVideoToolBar.init(frame: CGRect(x: 0, y: coverView!.bounds.size.height, width: frame.size.width, height: GTVideoToolbarHeight))
        self.addSubview(gtVideoToolBar!)
        
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(tapToPlay))
        self.addGestureRecognizer(tapGesture)
    }
    
    public func layoutWithVideoCoverUrl(videoCoverUrl : String,videoUrl : String) {
        coverView?.image = UIImage.init(named: videoCoverUrl)
        self.videoUrl = videoUrl
        gtVideoToolBar?.layoutWithModel(any: "")
    }
    
    @objc private func tapToPlay() {
        // 在当前Item上播放视频
        GTVideoPlayer.shared.playVideoWithUrl(videoUrl: videoUrl!, attachView: coverView!)
    }
    
}
