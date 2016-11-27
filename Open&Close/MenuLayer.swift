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
    
    let mPadding:CGFloat = 60.0
    
    var isFirst = true
    
    var line1Point1 = CGPoint()
    var line1Point2 = CGPoint()
    var line2Point1 = CGPoint()
    var line2Point2 = CGPoint()
    
    let line3Layer = CAShapeLayer()
    
    var mLine3StrokeStart:CGFloat = 1.0
    var mLine3StrokeEnd:CGFloat = 0.95
    
    var animatableValue:CGFloat = 0.0{
        didSet{
            print("vale-->\(animatableValue)")
            line1Point1.y = SpringUtil.mapValueFromRangeToRange(value: animatableValue, fromLow: 0, fromHigh: 1, toLow: mPadding, toHigh: self.frame.height - mPadding)
            line1Point2.x = SpringUtil.mapValueFromRangeToRange(value: animatableValue, fromLow: 0, fromHigh: 1, toLow: self.frame.width - mPadding, toHigh: self.frame.width - mPadding*1.1)
            line2Point1.y = SpringUtil.mapValueFromRangeToRange(value: animatableValue, fromLow: 0, fromHigh: 1, toLow: self.frame.height - mPadding, toHigh: mPadding)
            line2Point2.x = SpringUtil.mapValueFromRangeToRange(value: animatableValue, fromLow: 0, fromHigh: 1, toLow: self.frame.width - mPadding, toHigh: self.frame.width - mPadding*1.1)
            
            //这里的参数需要实机慢慢调，没有好办法
            mLine3StrokeStart = SpringUtil.mapValueFromRangeToRange(value: animatableValue, fromLow: 0, fromHigh: 1, toLow: 0, toHigh: 0.32)
            mLine3StrokeEnd = SpringUtil.mapValueFromRangeToRange(value: animatableValue, fromLow: 0, fromHigh: 1, toLow: 0.095, toHigh: 1)
            setNeedsDisplay()
        }
    }
    
    var state: MenuState = MenuState.Close {
        didSet {
            var anim:POPSpringAnimation? = self.pop_animation(forKey: "popAnimation") as? POPSpringAnimation
            if anim == nil {
                anim = POPSpringAnimation()
                anim?.springBounciness = 15
                anim?.springSpeed = 6
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
            line1Point1.x = mPadding
            line1Point1.y = mPadding
            line1Point2.y = mPadding
            line1Point2.x = self.frame.width - mPadding
            
            line2Point1.x = mPadding
            line2Point1.y = self.frame.height - mPadding
            line2Point2.x = self.frame.width - mPadding
            line2Point2.y = self.frame.height - mPadding
            
            let mLine3Padding:CGFloat = 10
            
            
            let line3Point1 = CGPoint(x: mPadding, y: self.frame.height / 2)
            let line3Point2 = CGPoint(x: self.frame.width - mPadding, y: self.frame.height / 2)
            let line3Point3 = CGPoint(x: self.frame.width - mLine3Padding, y: self.frame.height / 2)
            let line3Point4 = CGPoint(x: self.frame.width - mLine3Padding, y: (self.frame.height / 2 - mLine3Padding)/2)
            let line3Point5 = CGPoint(x: self.frame.width - mLine3Padding, y: mLine3Padding)
            let line3Point6 = CGPoint(x: self.frame.width / 2, y: mLine3Padding)
            let line3Point7 = CGPoint(x: mLine3Padding, y: mLine3Padding)
            let line3Point8 = CGPoint(x: mLine3Padding, y: self.frame.height / 2)
            let line3Point9 = CGPoint(x: mLine3Padding, y: self.frame.height - mLine3Padding)
            let line3Point10 = CGPoint(x: self.frame.width / 2, y: self.frame.height - mLine3Padding)
            let line3Point11 = CGPoint(x: self.frame.width - mLine3Padding, y: self.frame.height - mLine3Padding)
            
            let line3 = UIBezierPath()
            line3.move(to: line3Point1)
            line3.addLine(to: line3Point2)
            line3.addQuadCurve(to: line3Point4, controlPoint: line3Point3)
            line3.addQuadCurve(to: line3Point6, controlPoint: line3Point5)
            line3.addQuadCurve(to: line3Point8, controlPoint: line3Point7)
            line3.addQuadCurve(to: line3Point10, controlPoint: line3Point9)
            line3.addQuadCurve(to: line3Point3, controlPoint: line3Point11)
            line3.addQuadCurve(to: line3Point6, controlPoint: line3Point5)
            
            line3Layer.path = line3.cgPath
            line3Layer.frame = CGRect(x: 0, y: 0, width: self.frame.height, height: self.frame.height)
            line3Layer.strokeColor = UIColor.white.cgColor
            line3Layer.fillColor = nil
            line3Layer.lineWidth = 10
            line3Layer.lineCap = kCALineCapRound // 圆头
            line3Layer.strokeEnd = 0.095
            
            addSublayer(line3Layer)
            
            isFirst = false
        }else{
            line3Layer.strokeStart = mLine3StrokeStart
            line3Layer.strokeEnd = mLine3StrokeEnd
        }
        
        let line1 = UIBezierPath()
        line1.move(to: line1Point1)
        line1.addLine(to: line1Point2)
        
        ctx.setStrokeColor(UIColor.white.cgColor)
        ctx.setLineWidth(10)
        ctx.setLineCap(.round)
        ctx.addPath(line1.cgPath)
//        ctx.strokePath()
        
        let line2 = UIBezierPath()
        line2.move(to: line2Point1)
        line2.addLine(to: line2Point2)
        ctx.addPath(line2.cgPath)
        
        ctx.strokePath()

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
