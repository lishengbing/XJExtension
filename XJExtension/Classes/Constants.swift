//
//  Common.swift
//  Mortgage
//
//  Created by 李胜兵 on 2017/5/16.
//  Copyright © 2017年 善林(中国)金融信息服务有限公司. All rights reserved.
//

import UIKit
import Foundation


//============================================================
//       Check 1 - 定义一些常量?
//============================================================
public let kScreenWidth =  UIScreen.main.bounds.size.width
public let kScreenHeight = UIScreen.main.bounds.size.height
public let kNavBarH : CGFloat = 64
public let kTabBarH : CGFloat = 49

public var autoScreenW: CGFloat {
    switch UIApplication.shared.statusBarOrientation {
    case .landscapeLeft, .landscapeRight:
        return max(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height)
    default:
        return min(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height)
    }
}


//============================================================
//       Check 1 - 打印设置?
//============================================================
public func XJPrint<T>(_ message: T,_ file:String = #file,_ methodName: String = #function,_ lineNumber: Int = #line) {
    #if DEBUG
        print("\(message)")
    #endif
}



//============================================================
//       Check 1 - 获取版本号?
//============================================================
public func getCurrentVersion() -> String {
    let infoDict = Bundle.main.infoDictionary
    var majorVersion: String = "1.0.0"
    if let infoDict = infoDict {
        majorVersion = infoDict["CFBundleShortVersionString"] as? String ?? "1.0.0"
    }
    return majorVersion
}



//============================================================
//       Check 1 - appstore下载链接?
//============================================================
public func getDownLoadUrl(_ appid: String) -> String {
    // 1262984086
    return "https://itunes.apple.com/cn/app/id\(appid)?l=zh&ls=1&mt=8"
}




