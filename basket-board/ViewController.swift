//
//  ViewController.swift
//  basket-board
//
//  Created by Nobuhiro Harada on 2018/08/12.
//  Copyright © 2018年 Nobuhiro Harada. All rights reserved.
//

import UIKit
import SpriteKit
import ReplayKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var skview: SKView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let initScene = InitScene(size: view.frame.size)
        skview.presentScene(initScene)
        
    }
    
}
