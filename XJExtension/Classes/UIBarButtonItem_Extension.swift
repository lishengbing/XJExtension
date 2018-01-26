//
//  UIBarButtonItem_Extension.swift
//  Chihiro
//
//  Created by lishengbing on 16/11/1.
//  Copyright © 2016年 chihiro. All rights reserved.
//

import UIKit


public extension UIBarButtonItem {
    
    /// 左边->图片
   public convenience init(imageNameNormalLeft : String, imageNameHighlightedLeft : String, contentEdgeInsets: UIEdgeInsets?, target : Any, action : Selector) {
        let insets: UIEdgeInsets = contentEdgeInsets == nil ? UIEdgeInsetsMake(0, -20, 0, 0) : contentEdgeInsets!
        let btn = UIButton()
        btn.setImage(UIImage(named: imageNameNormalLeft), for: .normal)
        btn.setImage(UIImage(named: imageNameHighlightedLeft), for: .highlighted)
        btn.sizeToFit()
        btn.contentEdgeInsets = insets
        btn.addTarget(target, action: action, for: .touchUpInside)
        self.init(customView: btn)
    }
    

    /// 左边->文字
    public convenience init(titleLeft : String, titleColor: UIColor?, titleFont: UIFont?, contentEdgeInsets: UIEdgeInsets?, target : Any, action : Selector) {
        let textColor: UIColor = titleColor == nil ?  UIColor.black : titleColor!
        let textFont : UIFont = titleFont == nil ? UIFont.systemFont(ofSize: 13) : titleFont!
        let insets: UIEdgeInsets = contentEdgeInsets == nil ? UIEdgeInsetsMake(0, -10, 0, 0) : contentEdgeInsets!
        
        let btn = UIButton()
        btn.setTitle(titleLeft, for: .normal)
        btn.setTitleColor(textColor, for: .normal)
        btn.titleLabel?.font = textFont
        btn.sizeToFit()
        btn.contentEdgeInsets = insets
        btn.addTarget(target, action: action, for: .touchUpInside)
        self.init(customView: btn)
    }
    
   /// 右边->图片
   public convenience init(imageNameNormalRight : String, imageNameHighlightedRight : String, contentEdgeInsets: UIEdgeInsets?, target : Any, action : Selector) {
        let insets: UIEdgeInsets = contentEdgeInsets == nil ? UIEdgeInsetsMake(0, 0, 0, -10) : contentEdgeInsets!
        let btn = UIButton()
        btn.setImage(UIImage(named: imageNameNormalRight), for: .normal)
        btn.setImage(UIImage(named: imageNameHighlightedRight), for: .highlighted)
        btn.sizeToFit()
        btn.contentEdgeInsets = insets
        btn.addTarget(target, action: action, for: .touchUpInside)
        self.init(customView: btn)
    }
    
    /// 右边->文字
    public convenience init(titleRight : String, titleColor: UIColor?, titleFont: UIFont?, contentEdgeInsets: UIEdgeInsets?, target : Any, action : Selector) {
        let textColor: UIColor = titleColor == nil ?  UIColor.black : titleColor!
        let textFont : UIFont = titleFont == nil ? UIFont.systemFont(ofSize: 13) : titleFont!
        let insets: UIEdgeInsets = contentEdgeInsets == nil ? UIEdgeInsetsMake(0, 0, 0, -10) : contentEdgeInsets!
    
        let btn = UIButton()
        btn.setTitle(titleRight, for: .normal)
        btn.setTitleColor(textColor, for: .normal)
        btn.titleLabel?.font = textFont
        btn.sizeToFit()
        btn.contentEdgeInsets = insets
        btn.addTarget(target, action: action, for: .touchUpInside)
        self.init(customView: btn)
    }
}
