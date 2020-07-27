//
//  GTVideoPlayer.swift
//  SA-Swift
//
//  Created by 张圣俊 on 2020/7/27.
//  Copyright © 2020 张圣俊. All rights reserved.
//

import UIKit
import AVFoundation

class GTVideoPlayer: NSObject {
    
    static let shared = GTVideoPlayer()
    
    private var videoItem: AVPlayerItem?=nil
    private var avPlayer: AVPlayer?=nil
    private var playerLayer: AVPlayerLayer?=nil
    
    public func playVideoWithUrl(videoUrl: String, attachView: UIView) {
        stopPlay()
        
        // 这边初始化要注意和OC的区别
        let videoUrl = URL.init(string: videoUrl)
        let asset = AVAsset.init(url: videoUrl!)
        videoItem = AVPlayerItem.init(asset: asset)
        // 监听资源状态
        videoItem?.addObserver(self, forKeyPath: "status", options: .new, context: nil)
        videoItem?.addObserver(self, forKeyPath: "loadedTimeRanges", options: .new, context: nil)
        
        // 需要注意状态变化后获取时间
        let duration = videoItem!.duration
        let videoDuration = CMTimeGetSeconds(duration)
        
        avPlayer = AVPlayer.init(playerItem: videoItem)
        // 闭包写法
        avPlayer?.addPeriodicTimeObserver(forInterval: CMTime(value: 1, timescale: 1), queue: .main, using: { (cmtime) in
            print("播放进度：\(CMTimeGetSeconds(cmtime))")
        })
        playerLayer = AVPlayerLayer.init(player: avPlayer)
        playerLayer?.frame = attachView.frame
        attachView.layer.addSublayer(playerLayer!)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handlePlayEnd), name: .AVPlayerItemDidPlayToEndTime, object: nil)
    }
    
    private func stopPlay() {
        // 移除监听
        NotificationCenter.default.removeObserver(self)
        videoItem?.removeObserver(self, forKeyPath: "status")
        videoItem?.removeObserver(self, forKeyPath: "loadedTimeRanges")
        
        // 销毁播放器
        playerLayer?.removeFromSuperlayer()
        // swift 中的 nil 和 OC 中的 nil 不一样
        // 所以不能这样赋值  videoItem = nil  avPlayer = nil
    }
    
    @objc func handlePlayEnd() {
        avPlayer?.seek(to: CMTime(value: 0, timescale: 1))
        avPlayer?.play()
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "status" {
            if let temp = change![NSKeyValueChangeKey.newKey] as? Int {
                if (temp == AVPlayerItem.Status.readyToPlay.rawValue) {
                    avPlayer?.play()
                }else {
                    // 监控错误
                }
            }
        }else if(keyPath == "loadedTimeRanges") {
            // 缓冲进度监听，nslog不能打印swift包装类型的对象，只能用print打印
            print("缓冲：%s", change![NSKeyValueChangeKey.newKey]!)
        }
    }
}
