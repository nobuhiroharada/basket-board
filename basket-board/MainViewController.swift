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

class MainViewController: UIViewController {
    
    @IBOutlet weak var skview: SKView!
    
    var mainScene: MainScene!
    var currentScale:CGFloat = 1.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainScene = MainScene(size: view.frame.size)
        
        let pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(pinched))
        self.skview.addGestureRecognizer(pinchGestureRecognizer)
        
        self.skview.presentScene(mainScene)
        
    }
    
    @objc func pinched(recognizer: UIPinchGestureRecognizer) {
        for node in mainScene.children {
            switch recognizer.state {
            case .changed:
                if recognizer.scale > currentScale {
                    node.run(SKAction.scale(by: 1.01, duration: 0))
                }
                
                if recognizer.scale < currentScale {
                    node.run(SKAction.scale(by: 0.99, duration: 0))
                }
                
            default:
                break
            }
        }
    }
}
