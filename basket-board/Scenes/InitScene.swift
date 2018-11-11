//
//  BoardView.swift
//  basket-board
//
//  Created by Nobuhiro Harada on 2018/08/12.
//  Copyright © 2018年 Nobuhiro Harada. All rights reserved.

import Foundation
import SpriteKit

class InitScene: BaseScene {
    
    var SKVIEW_WIDTH: CGFloat?
    var SKVIEW_HEIGHT: CGFloat?
    var SKVIEW_NODE_SPACE: Int?
    
    var NODE_SIZE: CGSize?
    var NODE_SIZE_IPHONE: CGFloat = 27.0
    var NODE_SIZE_IPAD: CGFloat   = 54.0
    var NODE_SPACE: Int?
    
    override init(size: CGSize) {
        super.init(size: size)
        SKVIEW_WIDTH  = self.size.width
        SKVIEW_HEIGHT = self.size.height
        
        if screenHeight >= 1024 { // iPad
            NODE_SIZE = CGSize(width: NODE_SIZE_IPAD, height: NODE_SIZE_IPAD)
            NODE_SPACE = 80
            SKVIEW_NODE_SPACE = 50
        } else { // iPhone
            NODE_SIZE = CGSize(width: NODE_SIZE_IPHONE, height: NODE_SIZE_IPHONE)
            NODE_SPACE = 40
            SKVIEW_NODE_SPACE = 25
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        
        let playerNum = userDefaults.integer(forKey: "playerNum")
        
        if playerNum == 3 {
            playerAs = [Objects.playerA0,Objects.playerA1,Objects.playerA2]
            playerBs = [Objects.playerB0,Objects.playerB1,Objects.playerB2]
        }
        else if playerNum == 5 {
            playerAs = [Objects.playerA0,Objects.playerA1,Objects.playerA2,Objects.playerA3,Objects.playerA4]
            playerBs = [Objects.playerB0,Objects.playerB1,Objects.playerB2,Objects.playerB3,Objects.playerB4]
        }
        
        physicsWorld.gravity = .zero
        physicsWorld.contactDelegate = self
        
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        
        let background = getBackgroundNode()
        background.position = CGPoint(x: SKVIEW_WIDTH!*0.5, y: SKVIEW_HEIGHT!*0.5)
        background.size = self.size
        
        self.addChild(background)
        
        for (i,a) in playerAs.enumerated() {
            a?.position = CGPoint(x: SKVIEW_NODE_SPACE!, y: Int(SKVIEW_HEIGHT!*0.6)+NODE_SPACE!*i)
            a?.size = NODE_SIZE!
            a?.name = "playerA\(i)"
            players.append(a)
            self.addChild(a!)
        }
        
        for (i,b) in playerBs.enumerated() {
            b?.position = CGPoint(x: SKVIEW_NODE_SPACE!, y: Int(SKVIEW_HEIGHT!*0.4)-NODE_SPACE!*i)
            b?.size = NODE_SIZE!
            b?.name = "playerB\(i)"
            players.append(b)
            self.addChild(b!)
        }
        
        Objects.ball.position = CGPoint(x: SKVIEW_NODE_SPACE!, y: Int(SKVIEW_HEIGHT!*0.5))
        Objects.ball.size = NODE_SIZE!
        Objects.ball.name = "ball"
        self.addChild(Objects.ball)
        
        rewind.position = CGPoint(x: Int(SKVIEW_WIDTH!*(5/8)), y: SKVIEW_NODE_SPACE!)
        rewind.size = NODE_SIZE!
        rewind.name = "rewind"
        self.addChild(rewind)
        
        eraser.position = CGPoint(x: Int(SKVIEW_WIDTH!*(3/8)), y: SKVIEW_NODE_SPACE!)
        eraser.size = NODE_SIZE!
        eraser.name = "eraser"
        self.addChild(eraser)
        
        reset.position = CGPoint(x: Int(SKVIEW_WIDTH!*(1/8)), y: SKVIEW_NODE_SPACE!)
        reset.size = NODE_SIZE!
        reset.name = "reset"
        self.addChild(reset)

        setting.position = CGPoint(x: Int(SKVIEW_WIDTH!*(7/8)), y: SKVIEW_NODE_SPACE!)
        setting.size = NODE_SIZE!
        setting.name = "othersSetting"
        self.addChild(setting)
        
    }
    
    func getBackgroundNode() -> SKSpriteNode{
        // determine screen size
        let background: SKSpriteNode?
        
        if screenHeight <= 736 {
            if userDefaults.bool(forKey: "isFullcourt") {
                background = SKSpriteNode(imageNamed: "fullcourt")
            } else {
                background = SKSpriteNode(imageNamed: "halfcourt")
            }
        } else if screenHeight < 1024 {
            if userDefaults.bool(forKey: "isFullcourt") {
                background = SKSpriteNode(imageNamed: "fullcourt_iphonex")
            } else {
                background = SKSpriteNode(imageNamed: "halfcourt_iphonex")
            }
        } else {
            if userDefaults.bool(forKey: "isFullcourt") {
                background = SKSpriteNode(imageNamed: "fullcourt_ipad")
            } else {
                background = SKSpriteNode(imageNamed: "halfcourt_ipad")
            }
        }
        
        return background!
    }
}
