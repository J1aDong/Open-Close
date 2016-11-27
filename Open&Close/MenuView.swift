//
//  MenuView.swift
//  Open&Close
//
//  Created by J1aDong on 2016/11/26.
//  Copyright © 2016年 J1aDong. All rights reserved.
//

import UIKit

class MenuView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    let menuLayer = MenuLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        menuLayer.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
        menuLayer.contentsScale = UIScreen.main.scale
        
//        self.backgroundColor = UIColor.gray
        
        menuLayer.setNeedsDisplay()
        layer.addSublayer(menuLayer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
