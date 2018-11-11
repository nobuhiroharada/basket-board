//
//  BarItemNode.swift
//  basket-board
//
//  Created by Nobuhiro Harada on 2018/09/29.
//  Copyright © 2018年 Nobuhiro Harada. All rights reserved.
//

import Foundation
import SpriteKit

class BarItemNode: SKSpriteNode {
    
    let screenHeight = UIScreen.main.bounds.size.height
    
    var NODE_PHYSICSBODY_RADIUS: CGFloat?
    var NODE_SIZE_IPHONE: CGFloat = 27.0
    var NODE_SIZE_IPAD: CGFloat   = 54.0
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        
        if screenHeight >= 1024 { // iPad
            NODE_PHYSICSBODY_RADIUS = NODE_SIZE_IPAD*0.55
        } else { // iPhone
            NODE_PHYSICSBODY_RADIUS = NODE_SIZE_IPHONE*0.55
        }

        self.physicsBody = SKPhysicsBody(circleOfRadius: NODE_PHYSICSBODY_RADIUS!)
        self.physicsBody?.isDynamic = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
    }
}
