//
//  Zone32.swift
//  basket-board
//
//  Created by Nobuhiro Harada on 2018/09/08.
//  Copyright © 2018年 Nobuhiro Harada. All rights reserved.
//

import Foundation
import SpriteKit

class Zone32: BaseScene {
    
    override func didMove(to view: SKView) {
        
        let SKVIEW_WIDTH  = self.size.width
        let SKVIEW_HEIGHT = self.size.height
        let SKVIEW_NODE_SPACE: Int?
        
        let NODE_PHYSICSBODY_RADIUS: CGFloat?
        let NODE_SIZE: CGSize?
        let NODE_SIZE_IPHONE: CGFloat = 27.0
        let NODE_SIZE_IPAD: CGFloat   = 54.0
        let NODE_SPACE: Int?
        
        let ZONE_FRONT_HEIGHT: CGFloat?
        let ZONE_BACK_HEIGHT:  CGFloat?
        
        if screenHeight >= 1024 { // iPad
            NODE_SIZE = CGSize(width: NODE_SIZE_IPAD, height: NODE_SIZE_IPAD)
            NODE_PHYSICSBODY_RADIUS = NODE_SIZE_IPAD*0.55
            NODE_SPACE = 80
            SKVIEW_NODE_SPACE = 50
            
            ZONE_FRONT_HEIGHT = 260.0
            ZONE_BACK_HEIGHT  = 130.0
        } else { // iPhone
            NODE_SIZE = CGSize(width: NODE_SIZE_IPHONE, height: NODE_SIZE_IPHONE)
            NODE_PHYSICSBODY_RADIUS = NODE_SIZE_IPHONE*0.55
            NODE_SPACE = 40
            SKVIEW_NODE_SPACE = 25
            
            ZONE_FRONT_HEIGHT = 200.0
            ZONE_BACK_HEIGHT  = 130.0
        }
        
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
            a?.position = CGPoint(x: 80+NODE_SPACE!*i, y: Int(SKVIEW_HEIGHT*0.5+CGFloat(NODE_SPACE!)))
            a?.size = NODE_SIZE!
            a?.name = "playerA\(i)"
            a?.physicsBody = SKPhysicsBody(circleOfRadius: NODE_PHYSICSBODY_RADIUS!)
            a?.physicsBody?.categoryBitMask = 1
            a?.physicsBody?.collisionBitMask = 1
            players.append(a)
            self.addChild(a!)
        }
        
        // 選手B
        playerB0.position = CGPoint(x: SKVIEW_WIDTH*0.25, y: ZONE_FRONT_HEIGHT!)
        playerB0.size = NODE_SIZE!
        playerB0.name = "playerB0"
        playerB0.physicsBody = SKPhysicsBody(circleOfRadius: NODE_PHYSICSBODY_RADIUS!)
        playerB0.physicsBody?.categoryBitMask = 1
        playerB0.physicsBody?.collisionBitMask = 1
        players.append(playerB0)
        self.addChild(playerB0)
        
        playerB1.position = CGPoint(x: SKVIEW_WIDTH*0.5, y: ZONE_FRONT_HEIGHT!+30.0)
        playerB1.size = NODE_SIZE!
        playerB1.name = "playerB1"
        playerB1.physicsBody = SKPhysicsBody(circleOfRadius: NODE_PHYSICSBODY_RADIUS!)
        playerB1.physicsBody?.categoryBitMask = 1
        playerB1.physicsBody?.collisionBitMask = 1
        players.append(playerB1)
        self.addChild(playerB1)
        
        playerB2.position = CGPoint(x: SKVIEW_WIDTH*0.75, y: ZONE_FRONT_HEIGHT!)
        playerB2.size = NODE_SIZE!
        playerB2.name = "playerB2"
        playerB2.physicsBody = SKPhysicsBody(circleOfRadius: NODE_PHYSICSBODY_RADIUS!)
        playerB2.physicsBody?.categoryBitMask = 1
        playerB2.physicsBody?.collisionBitMask = 1
        players.append(playerB2)
        self.addChild(playerB2)
        
        playerB3.position = CGPoint(x: SKVIEW_WIDTH*0.35, y: ZONE_BACK_HEIGHT!)
        playerB3.size = NODE_SIZE!
        playerB3.name = "playerB3"
        playerB3.physicsBody = SKPhysicsBody(circleOfRadius: NODE_PHYSICSBODY_RADIUS!)
        playerB3.physicsBody?.categoryBitMask = 1
        playerB3.physicsBody?.collisionBitMask = 1
        players.append(playerB3)
        self.addChild(playerB3)
        
        playerB4.position = CGPoint(x: SKVIEW_WIDTH*0.66, y: ZONE_BACK_HEIGHT!)
        playerB4.size = NODE_SIZE!
        playerB4.name = "playerB4"
        playerB4.physicsBody = SKPhysicsBody(circleOfRadius: NODE_PHYSICSBODY_RADIUS!)
        playerB4.physicsBody?.categoryBitMask = 1
        playerB4.physicsBody?.collisionBitMask = 1
        players.append(playerB4)
        self.addChild(playerB4)
        
        // ボール
        ball.position = CGPoint(x: Int(SKVIEW_WIDTH)-SKVIEW_NODE_SPACE!, y: Int(SKVIEW_HEIGHT*0.5))
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
        rewind.physicsBody?.categoryBitMask = 1
        rewind.physicsBody?.collisionBitMask = 1
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
        zoneSetting.name = "setting"
        zoneSetting.physicsBody = SKPhysicsBody(circleOfRadius: NODE_PHYSICSBODY_RADIUS!)
        zoneSetting.physicsBody?.isDynamic = false
        self.addChild(zoneSetting)
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
            background = SKSpriteNode(imageNamed: "fullcourt_ipad")
        default: // iPad
            background = SKSpriteNode(imageNamed: "fullcourt_ipad")
        }
        
        return background!
    }
}
