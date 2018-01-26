//
//  UIView-Extension.swift
//  Appollo
//
//  Created by lishengbing on 2017/8/14.
//  Copyright © 2017年 shanlin. All rights reserved.
//
import UIKit
import Foundation

public extension UIView {
    
    // 删除所有子视图
    public func removeAllSubviews() {
        while subviews.count != 0 {
            subviews.last?.removeFromSuperview()
        }
    }
    
    // x
    public var x : CGFloat {
        get {
            return frame.origin.x
        }
        set(newVal) {
            var tmpFrame : CGRect = frame
            tmpFrame.origin.x = newVal
            frame = tmpFrame
        }
    }
    
    // y
    public var y : CGFloat {
        get {
            return frame.origin.y
        }
        set(newVal) {
            var tmpFrame : CGRect = frame
            tmpFrame.origin.y = newVal
            frame = tmpFrame
        }
    }
    
    // height
    public var height : CGFloat {
        get {
            return frame.size.height
        }
        set(newVal) {
            var tmpFrame : CGRect = frame
            tmpFrame.size.height  = newVal
            frame = tmpFrame
        }
    }
    
    // width
    public var width : CGFloat {
        get {
            return frame.size.width
        }
        set(newVal) {
            var tmpFrame : CGRect = frame
            tmpFrame.size.width   = newVal
            frame = tmpFrame
        }
    }
    
    // centerX
    public var centerX : CGFloat {
        get {
            return center.x
        }
        set(newVal) {
            center = CGPoint(x: newVal, y: center.y)
        }
    }
    
    // centerY
    public var centerY : CGFloat {
        get {
            return center.y
        }
        set(newVal) {
            center = CGPoint(x: center.x, y: newVal)
        }
    }
    
    /// frame.maxX
    public var maxX: CGFloat{
        get{
            return self.frame.maxX
        }
        set{
            var r = self.frame
            r.origin.x = newValue - r.size.width
            self.frame = r
        }
        
    }
    
    /// frame.maxY
    public var maxY: CGFloat{
        set{
            var r = self.frame
            r.origin.y = newValue - r.size.height
            
            self.frame = r
        }
        get{
            return self.frame.maxY
        }
    }
    
    // MARK: ----上下间距比例：相对于6 上的高度比例  375(750) - 667(1334)  公式：  h6(原型图) / H6(屏幕) = h?(计算的) / kScreenHeight
    public func paddingVerticalScaleToSixHeight(_ h: CGFloat) -> CGFloat {
        let iphone6Height = CGFloat(667)
        return kScreenHeight * h / iphone6Height
    }
    
    // 在view上获取到相应的控制器
    public func getSuperViewController() -> UIViewController? {
        //通过响应者链，取得此视图所在的视图控制器
        var nextVC = self.next
        
        while(nextVC != nil) {
            //判断响应者对象是否是视图控制器类型
            if (nextVC?.isKind(of: UIViewController.self))! {
                return nextVC as? UIViewController
            }
            
            nextVC = nextVC?.next
        }
        return nil;
    }
    
    /// 随机view及子view的颜色
    public func setRamdomColorForAllSubviews() {
        func ramdomColor() -> UIColor {
            let r = CGFloat(arc4random_uniform(255)) / 255
            let g = CGFloat(arc4random_uniform(255)) / 255
            let b = CGFloat(arc4random_uniform(255)) / 255
            let a = CGFloat(arc4random_uniform(255)) / 255
            return UIColor(red: r, green: g, blue: b, alpha: a)
        }
        backgroundColor = ramdomColor()
        for subView in subviews {
            subView.setRamdomColorForAllSubviews()
        }
    }
}
