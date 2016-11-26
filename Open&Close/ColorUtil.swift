//
//  ColorUtil.swift
//  Open&Close
//
//  Created by J1aDong on 2016/11/26.
//  Copyright © 2016年 J1aDong. All rights reserved.
//

import Foundation
import UIKit

struct ColorUtil {
    static func rgbColorByHex(hexColor:Int) -> (UIColor){
        return UIColor(red: ((CGFloat)((hexColor & 0xFF0000) >> 16)) / 255.0,
                       green: ((CGFloat)((hexColor & 0xFF00) >> 8)) / 255.0,
                       blue: ((CGFloat)(hexColor & 0xFF)) / 255.0,
                       alpha: 1.0)
    }
}
