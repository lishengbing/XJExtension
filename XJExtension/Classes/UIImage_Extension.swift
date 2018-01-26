//
//  UIImage-Extension.swift
//  Appollo
//
//  Created by lishengbing on 2017/8/30.
//  Copyright © 2017年 shanlin. All rights reserved.
//

import Foundation
import UIKit

public extension UIImage {
    
    /*
    public func qxScale(_ limit: CGFloat) -> UIImage {
        if limit != 0 {
            var size = self.size
            let _limit = size.height * size.width
            let rate = sqrt(CGFloat(limit) / CGFloat(_limit))
            if rate < 1 {
                size = CGSize(width: size.width * rate, height: size.height * rate)
                return qxScale(toSize: size)
            }
        }
        return self
    }
    
    public func qxScale(_ toSize: CGSize) -> UIImage {
        if toSize.width * toSize.height >= self.size.width * self.size.height {
            return self
        }
        let intSize = CGSize(width: Int(toSize.width), height: Int(toSize.height))
        UIGraphicsBeginImageContext(intSize)
        let rect = CGRect(x: 0, y: 0, width: intSize.width, height: intSize.height)
        self.draw(in: rect)
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return scaledImage!;
    }*/
    
    /// 之前遇到一个坑、下载微信图片按照0.5压缩永远不行、结果发现是0.55才可以、擦！！！
    public class func resizigImageWithName(_ imageName: String, scale: CGFloat? = 0.55) -> UIImage {
        let newScale = scale == nil ? 0.55 : scale!
        let normalImage = UIImage(named: imageName)!
        let w = normalImage.size.width * newScale
        let h = normalImage.size.height * newScale
        return (normalImage.resizableImage(withCapInsets: UIEdgeInsetsMake(h, w, h, w)))
        
    }
    
    /// 对拍照图片进行旋转
    func rotate(_ aImage:UIImage) -> UIImage {
        // No-op if the orientation is already correct
        if aImage.imageOrientation == .up {
            return aImage
        }
        // We need to calculate the proper transformation to make the image upright.
        // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
        var transform: CGAffineTransform = CGAffineTransform.identity
        switch aImage.imageOrientation {
        case .down, .downMirrored:
            transform = transform.translatedBy(x: aImage.size.width, y: aImage.size.height)
            transform = transform.rotated(by: CGFloat(Double.pi))
        case .left, .leftMirrored:
            transform = transform.translatedBy(x: aImage.size.width, y: 0)
            transform = transform.rotated(by: CGFloat(Double.pi / 2))
        case .right, .rightMirrored:
            transform = transform.translatedBy(x: 0, y: aImage.size.height)
            transform = transform.rotated(by: CGFloat(-Double.pi / 2))
        default:
            break
        }
        
        switch aImage.imageOrientation {
        case .upMirrored, .downMirrored:
            transform = transform.translatedBy(x: aImage.size.width, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
        case .leftMirrored, .rightMirrored:
            transform = transform.translatedBy(x: aImage.size.height, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
        default:
            break
        }
        
        // Now we draw the underlying CGImage into a new context, applying the transform
        // calculated above.
        
        let ctx: CGContext = CGContext(data: nil, width: Int(aImage.size.width), height: Int(aImage.size.height), bitsPerComponent: aImage.cgImage!.bitsPerComponent, bytesPerRow: 0, space: aImage.cgImage!.colorSpace!, bitmapInfo: aImage.cgImage!.bitmapInfo.rawValue)!
        ctx.concatenate(transform)
        switch aImage.imageOrientation {
        case .left, .leftMirrored, .right, .rightMirrored:
            // Grr...
            ctx.draw(aImage.cgImage!, in: CGRect(x: 0, y: 0, width: aImage.size.height, height: aImage.size.width))
        default:
            ctx.draw(aImage.cgImage!, in: CGRect(x: 0, y: 0, width: aImage.size.width, height: aImage.size.height))
        }
        
        // And now we just create a new UIImage from the drawing context
        let cgimg: CGImage = ctx.makeImage()!
        let img: UIImage = UIImage(cgImage: cgimg)
        return img
    }
}
