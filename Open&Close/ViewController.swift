//
//  ViewController.swift
//  Open&Close
//
//  Created by J1aDong on 2016/11/25.
//  Copyright © 2016年 J1aDong. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }

    let menuView = MenuView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.backgroundColor = ColorUtil.rgbColorByHex(hexColor: 0x21AA4A)
        

        self.view.addSubview(menuView)
        
        menuView.snp.makeConstraints { (make) in
            make.center.equalTo(self.view)
            make.width.equalTo(200)
            make.height.equalTo(200)
        }
    }
    
    @IBAction func click(_ sender: Any) {
        if menuView.menuLayer.state == .Close {
            menuView.menuLayer.state = .Open
        }else{
            menuView.menuLayer.state = .Close
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

