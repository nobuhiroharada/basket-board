//
//  PlayerBallNode.swift
//  basket-board
//
//  Created by Nobuhiro Harada on 2018/09/29.
//  Copyright © 2018年 Nobuhiro Harada. All rights reserved.
//

import Foundation
import SpriteKit

class PlayerNode: SKSpriteNode {
    
    var radius: CGFloat?
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        
        if Consts.DISPLAY_HEIGHT >= 1024 { // iPad
            radius = Consts.NODE_SIZE_IPAD*0.55
        } else { // iPhone
            radius = Consts.NODE_SIZE_IPHONE*0.55
        }

        self.physicsBody = SKPhysicsBody(circleOfRadius: radius!)
        self.physicsBody?.categoryBitMask = 1
        self.physicsBody?.collisionBitMask = 1
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
}
