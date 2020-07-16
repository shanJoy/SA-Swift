//
//  GTScreen.swift
//  SA-Swift
//
//  Created by 张圣俊 on 2020/7/13.
//  Copyright © 2020 张圣俊. All rights reserved.
//

import Foundation
import UIKit

public func UI(value: Float) -> CGFloat {
    return UIAdapter(value: value)
}

public func UIRect(x: Float, y:Float, width: Float, height: Float) -> CGRect {
    return UIRectAdapter(x: x, y: y, width: width, height: height)
}

public func isLandScape() -> Bool {
    
//   guard let orientation = UIApplication.shared.windows.first?.windowScene?.interfaceOrientation.isLandscape else {
//        #if DEBUG
//        fatalError("Could not obtain UIInterfaceOrientation from a valid windowScene")
//        #else
//        return nil
//        #endif
//    }
    return UIApplication.shared.windows.first?.windowScene?.interfaceOrientation.isLandscape ?? false
}

public func getScreenWidth() -> CGFloat {
    if (isLandScape()) {
        return UIScreen.main.bounds.size.height
    } else {
        return UIScreen.main.bounds.size.width
    }
}

public func getScreenHeight() -> CGFloat {
    if (isLandScape()) {
        return UIScreen.main.bounds.size.width
    } else {
        return UIScreen.main.bounds.size.height
    }
}

public func getStatusBarHeight() -> CGFloat {
    // 缩放因子
    let scale = UIScreen.main.scale
    let IS_IPHONE_X = ((getScreenWidth() == sizeFor58Inch().width) && (getScreenHeight() == sizeFor58Inch().height))
    let IS_IPHONE_XR = ((getScreenWidth() == sizeFor61Inch().width) && (getScreenHeight() == sizeFor61Inch().height) && (scale == 2))
    let IS_IPHONE_XSMAX = ((getScreenWidth() == sizeFor65Inch().width) && (getScreenHeight() == sizeFor65Inch().height) && (scale == 3))
    if IS_IPHONE_X || IS_IPHONE_XR || IS_IPHONE_XSMAX {
        return 44
    }else {
        return 20
    }
}


private func sizeFor58Inch() -> CGSize {
    return CGSize(width: 375, height: 812)
}

private func sizeFor61Inch() -> CGSize {
    return CGSize(width: 414, height: 896)
}

private func sizeFor65Inch() -> CGSize {
    return CGSize(width: 414, height: 896)
}

private func UIAdapter(value: Float) -> CGFloat {
    let scale = 414 / getScreenWidth()
    return CGFloat(CGFloat(value) / scale)
}

private func UIRectAdapter(x: Float, y: Float, width: Float, height: Float)-> CGRect {
    return CGRect(x: UIAdapter(value: x), y: UIAdapter(value: y), width: UIAdapter(value: width), height: UIAdapter(value: height))
}
