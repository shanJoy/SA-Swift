//
//  GTDetailViewController.swift
//  SA-Swift
//
//  Created by 张圣俊 on 2020/7/13.
//  Copyright © 2020 张圣俊. All rights reserved.
//

import UIKit
import WebKit

class GTDetailViewController: UIViewController,WKNavigationDelegate {
    
    private var webView : WKWebView?
    private var progressView : UIProgressView?
    private var articleUrl = ""
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    public class func initWithUrlString(urlString : String)->GTDetailViewController {
        let viewController = GTDetailViewController()
        viewController.articleUrl = urlString
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.webView = WKWebView.init(frame: CGRect(x: 0, y: getStatusBarHeight() + 44, width: self.view.frame.size.width, height: self.view.frame.size.height - getStatusBarHeight() - 44))
        self.webView?.navigationDelegate = self
        self.progressView = UIProgressView.init(frame: CGRect(x: 0, y: getStatusBarHeight() + 44, width: self.view.frame.size.width, height: 20))
        self.view.addSubview(webView!)
        self.view.addSubview(progressView!)
        self.webView?.load(URLRequest.init(url: URL.init(string: articleUrl)!))
        self.webView?.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        decisionHandler(WKNavigationActionPolicy.allow)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        self.progressView!.progress = Float(self.webView!.estimatedProgress)
    }
    
}
