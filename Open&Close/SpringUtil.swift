//
//  SpringUtil.swift
//  Open&Close
//
//  Created by J1aDong on 2016/11/27.
//  Copyright © 2016年 J1aDong. All rights reserved.
//

import Foundation
import UIKit

struct SpringUtil {
    static func mapValueFromRangeToRange(value:CGFloat,fromLow:CGFloat,fromHigh:CGFloat,toLow:CGFloat,toHigh:CGFloat) -> CGFloat{
        let fromRangeSize = fromHigh - fromLow
        let toRangeSize = toHigh - toLow
        let valueScale = (value - fromLow) / fromRangeSize
        let result = toLow + (valueScale*toRangeSize)
        return result
    }
}
