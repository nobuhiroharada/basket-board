//
//  BoardView.swift
//  basket-board
//
//  Created by Nobuhiro Harada on 2018/08/12.
//  Copyright © 2018年 Nobuhiro Harada. All rights reserved.

import Foundation
import SpriteKit

class TopScene: BaseScene {
    
    override func didMove(to view: SKView) {
        
        let SKVIEW_WIDTH  = self.size.width
        let SKVIEW_HEIGHT = self.size.height
        let NODE_PHYSICSBODY = ball.size.width*0.5*0.55
        
        playerAs = [playerA0,playerA1,playerA2,playerA3,playerA4]
        playerBs = [playerB0,playerB1,playerB2,playerB3,playerB4]
        
        physicsWorld.gravity = .zero
        physicsWorld.contactDelegate = self
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        
        
        let background = getBackgroundNode()
        background.position = CGPoint(x: SKVIEW_WIDTH*0.5, y: SKVIEW_HEIGHT*0.5)
        background.size = self.size
        self.addChild(background)
        
        for (i,a) in playerAs.enumerated() {
            a?.position = CGPoint(x: 20, y: Int(SKVIEW_HEIGHT*0.5)-40*i)
            a?.size = nodeSize
            a?.name = "playerA\(i)"
            print(playerA0.size.width)
            a?.physicsBody = SKPhysicsBody(circleOfRadius: NODE_PHYSICSBODY)
            a?.physicsBody?.categoryBitMask = 1
            a?.physicsBody?.collisionBitMask = 1
            players.append(a)
            self.addChild(a!)
        }
        
        for (i,b) in playerBs.enumerated() {
            b?.position = CGPoint(x: Int(SKVIEW_WIDTH)-20, y: Int(SKVIEW_HEIGHT*0.5) - 40*i)
            b?.size = nodeSize
            b?.name = "playerB\(i)"
            b?.physicsBody = SKPhysicsBody(circleOfRadius: NODE_PHYSICSBODY)
            b?.physicsBody?.categoryBitMask = 1
            b?.physicsBody?.collisionBitMask = 1
            players.append(b)
            self.addChild(b!)
        }
        
        ball.position = CGPoint(x: Int(SKVIEW_WIDTH)-10, y: Int(SKVIEW_HEIGHT*0.5) + 40)
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
