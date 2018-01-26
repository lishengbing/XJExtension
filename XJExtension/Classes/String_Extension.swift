//
//  String_Extension.swift
//  新增客户页
//
//  Created by lishengbing on 2017/5/23.
//  Copyright © 2017年 lishengbing. All rights reserved.
//

import UIKit

public extension String{
    
    func transformToPinYin()->String{
        let mutableString = NSMutableString(string: self)
        CFStringTransform(mutableString, nil, kCFStringTransformToLatin, false)
        CFStringTransform(mutableString, nil, kCFStringTransformStripDiacritics, false)
        let string = String(mutableString)
        return  string.replacingOccurrences(of: " ", with: "").capitalized
    }
}
