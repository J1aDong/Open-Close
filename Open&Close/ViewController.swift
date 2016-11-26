//
//  ViewController.swift
//  Open&Close
//
//  Created by J1aDong on 2016/11/25.
//  Copyright © 2016年 J1aDong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.backgroundColor = ColorUtil.rgbColorByHex(hexColor: 0x21AA4A)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

