//
//  BoardView.swift
//  basket-board
//
//  Created by Nobuhiro Harada on 2018/08/12.
//  Copyright © 2018年 Nobuhiro Harada. All rights reserved.

import Foundation
import SpriteKit

class InitScene: BaseScene {
    
    override func didMove(to view: SKView) {
        let SKVIEW_WIDTH  = self.size.width
        let SKVIEW_HEIGHT = self.size.height
        let SKVIEW_NODE_SPACE: Int?
        
        let NODE_PHYSICSBODY_RADIUS: CGFloat?
        let NODE_SIZE: CGSize?
        let NODE_SIZE_IPHONE: CGFloat = 27.0
        let NODE_SIZE_IPAD: CGFloat   = 54.0
        let NODE_SPACE: Int?
        
        
        if screenHeight >= 1024 { // iPad
            NODE_SIZE = CGSize(width: NODE_SIZE_IPAD, height: NODE_SIZE_IPAD)
            NODE_PHYSICSBODY_RADIUS = NODE_SIZE_IPAD*0.55
            NODE_SPACE = 80
            SKVIEW_NODE_SPACE = 50
        } else { // iPhone
            NODE_SIZE = CGSize(width: NODE_SIZE_IPHONE, height: NODE_SIZE_IPHONE)
            NODE_PHYSICSBODY_RADIUS = NODE_SIZE_IPHONE*0.55
            NODE_SPACE = 40
            SKVIEW_NODE_SPACE = 25
        }
        
        playerAs = [playerA0,playerA1,playerA2,playerA3,playerA4]
        playerBs = [playerB0,playerB1,playerB2,playerB3,playerB4]
        
        physicsWorld.gravity = .zero
        physicsWorld.contactDelegate = self
        
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        
        
        let background = getBackgroundNode()
        background.position = CGPoint(x: SKVIEW_WIDTH*0.5, y: SKVIEW_HEIGHT*0.5)
        background.size = self.size
        
        self.addChild(background)
        
        for (i,a) in playerAs.enumerated() {
            a?.position = CGPoint(x: SKVIEW_NODE_SPACE!, y: Int(SKVIEW_HEIGHT*0.8)-NODE_SPACE!*i)
            a?.size = NODE_SIZE!
            a?.name = "playerA\(i)"
            a?.physicsBody = SKPhysicsBody(circleOfRadius: NODE_PHYSICSBODY_RADIUS!)
            a?.physicsBody?.categoryBitMask = 1
            a?.physicsBody?.collisionBitMask = 1
            players.append(a)
            self.addChild(a!)
        }
        
        for (i,b) in playerBs.enumerated() {
            b?.position = CGPoint(x: Int(SKVIEW_WIDTH)-SKVIEW_NODE_SPACE!, y: Int(SKVIEW_HEIGHT*0.5) - NODE_SPACE!*i)
            b?.size = NODE_SIZE!
            b?.name = "playerB\(i)"
            b?.physicsBody = SKPhysicsBody(circleOfRadius: NODE_PHYSICSBODY_RADIUS!)
            b?.physicsBody?.categoryBitMask = 1
            b?.physicsBody?.collisionBitMask = 1
            players.append(b)
            self.addChild(b!)
        }
        
        ball.position = CGPoint(x: Int(SKVIEW_WIDTH)-SKVIEW_NODE_SPACE!, y: Int(SKVIEW_HEIGHT*0.5) + NODE_SPACE!)
        ball.size = NODE_SIZE!
        ball.name = "ball"
        ball.physicsBody = SKPhysicsBody(circleOfRadius: NODE_PHYSICSBODY_RADIUS!)
        ball.physicsBody?.categoryBitMask = 1
        ball.physicsBody?.collisionBitMask = 1
        self.addChild(ball)
        
        rewind.position = CGPoint(x: SKVIEW_NODE_SPACE!, y: SKVIEW_NODE_SPACE!+NODE_SPACE!*2)
        rewind.size = NODE_SIZE!
        rewind.name = "rewind"
        rewind.physicsBody = SKPhysicsBody(circleOfRadius: NODE_PHYSICSBODY_RADIUS!)
        rewind.physicsBody?.isDynamic = false
        self.addChild(rewind)
        
        eraser.position = CGPoint(x: SKVIEW_NODE_SPACE!, y: SKVIEW_NODE_SPACE!+NODE_SPACE!)
        eraser.size = NODE_SIZE!
        eraser.name = "eraser"
        eraser.physicsBody = SKPhysicsBody(circleOfRadius: NODE_PHYSICSBODY_RADIUS!)
        eraser.physicsBody?.isDynamic = false
        self.addChild(eraser)
        
        reset.position = CGPoint(x: SKVIEW_NODE_SPACE!, y: SKVIEW_NODE_SPACE!)
        reset.size = NODE_SIZE!
        reset.name = "reset"
        reset.physicsBody = SKPhysicsBody(circleOfRadius: NODE_PHYSICSBODY_RADIUS!)
        reset.physicsBody?.isDynamic = false
        self.addChild(reset)
        
        othersSetting.position = CGPoint(x: Int(SKVIEW_WIDTH)-SKVIEW_NODE_SPACE!, y: SKVIEW_NODE_SPACE!+NODE_SPACE!)
        othersSetting.size = NODE_SIZE!
        othersSetting.name = "othersSetting"
        othersSetting.physicsBody = SKPhysicsBody(circleOfRadius: NODE_PHYSICSBODY_RADIUS!)
        othersSetting.physicsBody?.isDynamic = false
        self.addChild(othersSetting)
        
        zoneSetting.position = CGPoint(x: Int(SKVIEW_WIDTH)-SKVIEW_NODE_SPACE!, y: SKVIEW_NODE_SPACE!)
        zoneSetting.size = NODE_SIZE!
        zoneSetting.name = "zoneSetting"
        zoneSetting.physicsBody = SKPhysicsBody(circleOfRadius: NODE_PHYSICSBODY_RADIUS!)
        zoneSetting.physicsBody?.isDynamic = false
        self.addChild(zoneSetting)
    }
    
    
    func setControlNodes() {
        
    }
    
    func getBackgroundNode() -> SKSpriteNode{
        // determine screen size
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
            background = SKSpriteNode(imageNamed: "fullcourt_ipad")
        default: // iPad
            background = SKSpriteNode(imageNamed: "fullcourt_ipad")
        }
        
        return background!
    }
}
