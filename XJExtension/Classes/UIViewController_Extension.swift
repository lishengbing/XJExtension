//
//  UIViewController_Extension.swift
//  ShanlinIM
//
//  Created by lishengbing on 2017/7/30.
//  Copyright © 2017年 善林(中国)金融信息服务有限公司. All rights reserved.
//
/*
 SVProgressHUDMaskType 介绍：
 1. SVProgressHUDMaskTypeNone : 当提示显示的时间，用户仍然可以做其他操作，比如View 上面的输入等
 2. SVProgressHUDMaskTypeClear : 用户不可以做其他操作
 3. SVProgressHUDMaskTypeBlack :　用户不可以做其他操作，并且背景色是黑色
 4. SVProgressHUDMaskTypeGradient : 用户不可以做其他操作，并且背景色是渐变的
 */



import Foundation
import SVProgressHUD


public let kNormalDuringTime: TimeInterval = 1.5
public extension UIViewController {
    
    /**
     * 1: 默认只显示加载圈
     */
    func hudShow() {
        
        DispatchQueue.main.asyncAfter(deadline: .now()+0.15) {
           self.loadBaseSetting(self.view, title: "")
        }
    }

    /**
     * 2: 显示加载圈圈和文字
     */
    func hudShowWithText(_ superView: UIView, title: String) {
        self.loadBaseSetting(superView, title: title)
     }

    
    /**
     * 3: 隐藏所有加载
     */
    func hudDismiss() {
        SVProgressHUD.dismiss()
     }
    
    /**
     * 4: 显示提示语
     */
    func hudText(_ text: String,during: TimeInterval? = kNormalDuringTime) {
        SVProgressHUD.dismiss {
            var duringTime: TimeInterval
            if during == nil {
                duringTime = kNormalDuringTime
            }else {
                duringTime = during!
            }
            SVProgressHUD.setImageViewSize(CGSize(width: 0, height: -1))
            SVProgressHUD.setCornerRadius(8)
            SVProgressHUD.setBackgroundColor(UIColor.black)
            SVProgressHUD.setForegroundColor(UIColor.white)
            SVProgressHUD.setDefaultMaskType(.clear)
            SVProgressHUD.setContainerView(self.view)

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                SVProgressHUD.showInfo(withStatus: text)
                SVProgressHUD.dismiss(withDelay: duringTime)
            }
        }
    }
    
    /**
     * 5: 显示提示语--带回调的
     */
     func hudTextCallBack(_ text: String,during: TimeInterval? = kNormalDuringTime, completeBack: @escaping () -> Swift.Void) {
        
        var duringTime: TimeInterval
        if during == nil {
            duringTime = kNormalDuringTime
        }else {
            duringTime = during!
        }
        /// 设置为-1，自动居中
        SVProgressHUD.setImageViewSize(CGSize(width: 0, height: -1))
        SVProgressHUD.setCornerRadius(8)
        SVProgressHUD.setBackgroundColor(UIColor.black)
        SVProgressHUD.setForegroundColor(UIColor.white)
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.setContainerView(self.view)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            SVProgressHUD.showInfo(withStatus: text)
            SVProgressHUD.dismiss(withDelay: duringTime, completion: completeBack)
        }
    }
    
    /**
     * 6: 显示图片
     */
      func hudImage(_ imageName: String, title: String) {
        SVProgressHUD.setCornerRadius(8)
        SVProgressHUD.setBackgroundColor(UIColor.black)
        SVProgressHUD.setForegroundColor(UIColor.white)
        SVProgressHUD.setDefaultMaskType(.gradient)
        SVProgressHUD.setContainerView(self.view)
        SVProgressHUD.show(UIImage(named: imageName)!, status: title)
    }
    
    /**
     * 7: 传一个对象、转成JSONString、再转成 -> string
     */
      func getJSONStringFromOther(_ obj: NSObject) -> String {
        if (!JSONSerialization.isValidJSONObject(obj)) {
            print("无法解析出JSONString")
            return ""
        }
        let data : Data! = try? JSONSerialization.data(withJSONObject: obj, options: []) as NSData! as Data!
        let JSONString = NSString(data:data as Data,encoding: String.Encoding.utf8.rawValue)
        return JSONString! as String
    }
}


extension UIViewController {
    
    fileprivate func loadBaseSetting(_ superView: UIView, title: String) {
        /// 0. 先移除加载
        self.hudDismiss()
        
        /// 背景颜色
        SVProgressHUD.setBackgroundColor(UIColor.black)
        /// 字体颜色
        SVProgressHUD.setForegroundColor(UIColor.white)
        /// 用户是否操作
        SVProgressHUD.setDefaultMaskType(.gradient)
        /// 圆角大小
        SVProgressHUD.setCornerRadius(8)
        /// 圆环大小
        SVProgressHUD.setRingNoTextRadius(20)
        /// 圆环宽度
        SVProgressHUD.setRingThickness(2.5)
        /// 加载哪一个view上
        SVProgressHUD.setContainerView(superView)
        
        // 开始加载
        if title.isEmpty {
            SVProgressHUD.show()
        }else {
            SVProgressHUD.show(withStatus: title)
        }
    }
}



