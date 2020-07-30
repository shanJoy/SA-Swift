//
//  GTLogin.swift
//  SA-Swift
//
//  Created by 张圣俊 on 2020/7/30.
//  Copyright © 2020 张圣俊. All rights reserved.
//

import UIKit

class GTLogin: NSObject, TencentSessionDelegate {
    
    static let shared = GTLogin()
    
    public var nick : String=""
    public var address : String=""
    public var avatarUrl : String=""
    
    private var oauth : TencentOAuth?=nil
    private var loginCallback : (Bool) -> Void = { (islogin: Bool) -> Void in}
    private var islogin = false
    
    public func isLogin() -> Bool {
        return islogin
    }
    
    override init() {
        super.init()
        oauth = TencentOAuth.init(appId: "222222", andDelegate: self)
    }
    
    public func loginWithCallBack(callback : @escaping (Bool) -> Void) {
        loginCallback = callback
        oauth?.authMode = kAuthModeClientSideToken
        oauth?.authorize([kOPEN_PERMISSION_GET_USER_INFO,
                          kOPEN_PERMISSION_GET_SIMPLE_USER_INFO,
                          kOPEN_PERMISSION_ADD_ALBUM,
                          kOPEN_PERMISSION_ADD_ONE_BLOG,
                          kOPEN_PERMISSION_ADD_SHARE,
                          kOPEN_PERMISSION_ADD_TOPIC,
                          kOPEN_PERMISSION_CHECK_PAGE_FANS,
                          kOPEN_PERMISSION_GET_INFO,
                          kOPEN_PERMISSION_GET_OTHER_INFO,
                          kOPEN_PERMISSION_LIST_ALBUM,
                          kOPEN_PERMISSION_UPLOAD_PIC,
                          kOPEN_PERMISSION_GET_VIP_INFO,
                          kOPEN_PERMISSION_GET_VIP_RICH_INFO])
    }
    
    public func logout() {
        oauth?.logout(self)
        islogin = false
    }
    
    // delegate - tencentOAuth
    func tencentDidLogin() {
        islogin = true
        oauth?.getUserInfo()
    }
    
    func tencentDidNotLogin(_ cancelled: Bool) {
        loginCallback(false)
    }
    
    func tencentDidNotNetWork() {
        
    }
    
    func getUserInfoResponse(_ response: APIResponse!) {
        let userInfo = response.jsonResponse
        nick = userInfo?["nickname"] as! String
        address = userInfo?["city"] as! String
        avatarUrl = userInfo?["figureurl_qq_2"] as! String
        loginCallback(true)
    }
}
