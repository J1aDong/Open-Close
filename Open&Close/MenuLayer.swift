//
//  MenuLayer.swift
//  Open&Close
//
//  Created by J1aDong on 2016/11/26.
//  Copyright © 2016年 J1aDong. All rights reserved.
//

import UIKit
import QuartzCore
import pop

enum MenuState {
    case Open
    case Close
}

class MenuLayer: CALayer {
    
    var isFirst = true
    
    var line1Point1 = CGPoint()
    var line1Point2 = CGPoint()
    
    var animatableValue:CGFloat = 0.0{
        didSet{
            line1Point1.y = SpringUtil.mapValueFromRangeToRange(value: animatableValue, fromLow: 0, fromHigh: 1, toLow: 10, toHigh: self.frame.height - 40)
            let value = SpringUtil.mapValueFromRangeToRange(value: animatableValue, fromLow: 0, fromHigh: 1, toLow: self.frame.width - 10, toHigh: self.frame.width - 20)
            print("vale-->\(value)")
            line1Point2.x = value
            setNeedsDisplay()
        }
    }
    
    var state: MenuState = MenuState.Close {
        didSet {
            var anim:POPSpringAnimation? = self.pop_animation(forKey: "popAnimation") as? POPSpringAnimation
            if anim == nil {
                anim = POPSpringAnimation()
                anim?.springBounciness = 10
                anim?.springSpeed = 10
                anim?.property = POPAnimatableProperty.property(withName: "Custom", initializer: { (props) in
                    props?.writeBlock = {(obj,values) -> Void in
                        let myProp = obj as! MenuLayer
                        myProp.animatableValue = (values?[0])!
                        //                        print("values-->\(values?[0])")
                    }
                    
                    props?.readBlock = {(obj,values) -> Void in
                        let myProp = obj as! MenuLayer
                        values?[0] = myProp.animatableValue
                        print("values-->\(values?[0])")
                    }
                    
                    props?.threshold = 0.0001
                }) as! POPAnimatableProperty!
                self.pop_add(anim, forKey: "popAnimation")
            }
            if state == .Open {
                anim?.fromValue = 0
                anim?.toValue = 1
            } else if state == .Close {
                anim?.fromValue = 1
                anim?.toValue = 0
            }
        }
    }
    
    override init() {
        super.init()
    }
    
    override init(layer: Any) {
        super.init(layer: layer)
    }
    
    override func draw(in ctx: CGContext) {
        
        if isFirst {
            line1Point1.x = 10
            line1Point1.y = 10
            line1Point2.y = 10
            line1Point2.x = self.frame.width - 10
            isFirst = false
        }
        
        let line1 = UIBezierPath()
        line1.move(to: line1Point1)
        line1.addLine(to: line1Point2)
        
        ctx.setStrokeColor(UIColor.white.cgColor)
        ctx.setLineWidth(10)
        ctx.setLineCap(.round)
        ctx.addPath(line1.cgPath)
        ctx.strokePath()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
