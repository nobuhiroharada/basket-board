//
//  TwoThreeScene.swift
//  basket-board
//
//  Created by Nobuhiro Harada on 2018/08/18.
//  Copyright © 2018年 Nobuhiro Harada. All rights reserved.
//

import Foundation
import SpriteKit

class TwoThreeScene: BaseScene {
    
    override func didMove(to view: SKView) {
        
        let SKVIEW_WIDTH  = self.size.width
        let SKVIEW_HEIGHT = self.size.height
        let NODE_PHYSICSBODY = ball.size.width*0.5*0.55
        
        playerAs = [playerA0,playerA1,playerA2,playerA3,playerA4]
        playerBs = [playerB0,playerB1,playerB2,playerB3,playerB4]
        
        physicsWorld.gravity = .zero
        physicsWorld.contactDelegate = self
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        
        // 背景のコート
        let background = getBackgroundNode()
        background.position = CGPoint(x: SKVIEW_WIDTH*0.5, y: SKVIEW_HEIGHT*0.5)
        background.size = self.size
        self.addChild(background)
        
        // 選手A
        for (i,a) in playerAs.enumerated() {
            a?.position = CGPoint(x: 80+40*i, y: Int(SKVIEW_HEIGHT*0.5+40))
            a?.size = nodeSize
            a?.name = "playerA\(i)"
            a?.physicsBody = SKPhysicsBody(circleOfRadius: NODE_PHYSICSBODY)
            a?.physicsBody?.categoryBitMask = 1
            a?.physicsBody?.collisionBitMask = 1
            players.append(a)
            self.addChild(a!)
        }
        
        // 選手B
        playerB0.position = CGPoint(x: Int(SKVIEW_WIDTH*0.35), y: Int(SKVIEW_HEIGHT*0.5)-120)
        playerB0.size = nodeSize
        playerB0.name = "playerB0"
        playerB0.physicsBody = SKPhysicsBody(circleOfRadius: NODE_PHYSICSBODY)
        playerB0.physicsBody?.categoryBitMask = 1
        playerB0.physicsBody?.collisionBitMask = 1
        players.append(playerB0)
        self.addChild(playerB0)
        
        playerB1.position = CGPoint(x: Int(SKVIEW_WIDTH*0.65), y: Int(SKVIEW_HEIGHT*0.5)-120)
        playerB1.size = nodeSize
        playerB1.name = "playerB1"
        playerB1.physicsBody = SKPhysicsBody(circleOfRadius: NODE_PHYSICSBODY)
        playerB1.physicsBody?.categoryBitMask = 1
        playerB1.physicsBody?.collisionBitMask = 1
        players.append(playerB1)
        self.addChild(playerB1)
        
        playerB2.position = CGPoint(x: Int(SKVIEW_WIDTH*0.25), y: Int(SKVIEW_HEIGHT*0.5)-200)
        playerB2.size = nodeSize
        playerB2.name = "playerB2"
        playerB2.physicsBody = SKPhysicsBody(circleOfRadius: NODE_PHYSICSBODY)
        playerB2.physicsBody?.categoryBitMask = 1
        playerB2.physicsBody?.collisionBitMask = 1
        players.append(playerB2)
        self.addChild(playerB2)
        
        playerB3.position = CGPoint(x: Int(SKVIEW_WIDTH*0.5), y: Int(SKVIEW_HEIGHT*0.5)-200)
        playerB3.size = nodeSize
        playerB3.name = "playerB3"
        playerB3.physicsBody = SKPhysicsBody(circleOfRadius: NODE_PHYSICSBODY)
        playerB3.physicsBody?.categoryBitMask = 1
        playerB3.physicsBody?.collisionBitMask = 1
        players.append(playerB3)
        self.addChild(playerB3)
        
        playerB4.position = CGPoint(x: Int(SKVIEW_WIDTH*0.75), y: Int(SKVIEW_HEIGHT*0.5)-200)
        playerB4.size = nodeSize
        playerB4.name = "playerB4"
        playerB4.physicsBody = SKPhysicsBody(circleOfRadius: NODE_PHYSICSBODY)
        playerB4.physicsBody?.categoryBitMask = 1
        playerB4.physicsBody?.collisionBitMask = 1
        players.append(playerB4)
        self.addChild(playerB4)
        
        // ボール
        ball.position = CGPoint(x: Int(SKVIEW_WIDTH)-10, y: Int(SKVIEW_HEIGHT*0.5))
        ball.size = nodeSize
        ball.name = "ball"
        ball.physicsBody = SKPhysicsBody(circleOfRadius: NODE_PHYSICSBODY)
        ball.physicsBody?.categoryBitMask = 1
        ball.physicsBody?.collisionBitMask = 1
        self.addChild(ball)
    }
    
    func getBackgroundNode() -> SKSpriteNode{
        // determine screen size
        let screenHeight = UIScreen.main.bounds.size.height
        let background: SKSpriteNode?
        
        switch (screenHeight)
        {
        case 480: // iPhone 4s
            background = SKSpriteNode(imageNamed: "fullcourt")
        case 568: // iPhone 5s
            background = SKSpriteNode(imageNamed: "fullcourt")
        case 667: // iPhone 8
            background = SKSpriteNode(imageNamed: "fullcourt")
        case 736: // iPhone 8 Plus
            background = SKSpriteNode(imageNamed: "fullcourt")
        case 812: // iPhone X
            background = SKSpriteNode(imageNamed: "fullcourt_iphonex")
        case 1024: // iPad
            background = SKSpriteNode(imageNamed: "fullcourt")
        default: // iPad
            background = SKSpriteNode(imageNamed: "fullcourt")
        }
        
        return background!
    }
}
