//
//  SLExtension_UIColor.swift
//  SLExtension
//
//  Created by 王治国  on 2017/9/13.
//  Copyright © 2017年 王治国 . All rights reserved.
//
import UIKit
public extension UIColor {
    
    /**
     * 传rgb、得到颜色
     */
    public convenience init(r : CGFloat, g : CGFloat, b : CGFloat, a: CGFloat = 1.0) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
    }
    
    /**
     输入16进制的字符串可以生成色值
     例子：UIColor(hexString: "#ff8942"), UIColor(hexString:"ff8942"), UIColor(hexString:"0xff8942")
     如果不能解析hex值则返回白色
     */
    public convenience init(hexString: String, alpha: Float = 1.0) {
        var hex = hexString
        
        if hex.hasPrefix("#") {
            hex = hex.substring(from: hex.index(hex.startIndex, offsetBy: 1))
        }
        if hex.hasPrefix("0x") {
            hex = hex.substring(from: hex.index(hex.startIndex, offsetBy: 2))
        }
        guard let hexVal = Int(hex, radix: 16) else {
            self.init(white: 1.0, alpha: 1.0)
            return
        }
        
        switch hex.characters.count {
        case 3:
            self.init(hex3: hexVal, alpha: alpha)
        case 6:
            self.init(hex6: hexVal, alpha: alpha)
        default:
            self.init(white: 1.0, alpha: 1.0)
        }
    }
    
    /**
     输入16进制的数值可以生成色值
     例子：UIColor(hex: 0xff8942,alpha: 1.0)
     如果不能解析hex值则返回白色
     */
    public convenience init(hex: Int, alpha: Float = 1.0) {
        if (0x000000 ... 0xFFFFFF) ~= hex {
            self.init(hex6: hex , alpha: alpha)
        } else {
            self.init(white: 1.0, alpha: 1.0)
            
        }
    }
    
    /**
     * 随即色
     */
    class func random() -> UIColor {
        return UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
    }
    
    /**
     * 颜色转图片 
     */
    public func toImage(_ frame : CGRect = CGRect(x: 0, y: 0, width: 1, height: 1)) -> UIImage {
        var image = UIImage()
        let view = UIView(frame: frame)
        view.backgroundColor = self
        UIGraphicsBeginImageContext(view.frame.size)
        guard let context = UIGraphicsGetCurrentContext() else {
            UIGraphicsEndImageContext()
            return image
        }
        view.layer.render(in: context)
        if let currentImage = UIGraphicsGetImageFromCurrentImageContext(){
            image = currentImage
        }
        
        UIGraphicsEndImageContext()
        return image
    }
    
    
    
    fileprivate convenience init(hex3: Int, alpha: Float) {
        self.init(red:   CGFloat( ((hex3 & 0xF00) >> 8).duplicate4bits() ) / 255.0,
                  green: CGFloat( ((hex3 & 0x0F0) >> 4).duplicate4bits() ) / 255.0,
                  blue:  CGFloat( ((hex3 & 0x00F) >> 0).duplicate4bits() ) / 255.0, alpha: CGFloat(alpha))
    }
    
    fileprivate convenience init(hex6: Int, alpha: Float) {
        self.init(red:   CGFloat( (hex6 & 0xFF0000) >> 16 ) / 255.0,
                  green: CGFloat( (hex6 & 0x00FF00) >> 8 ) / 255.0,
                  blue:  CGFloat( (hex6 & 0x0000FF) >> 0 ) / 255.0, alpha: CGFloat(alpha))
    }
    
}
private extension Int {
    func duplicate4bits() -> Int {
        return (self << 4) + self
    }
}
