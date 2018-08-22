//
//  BaseScene.swift
//  basket-board
//
//  Created by Nobuhiro Harada on 2018/08/22.
//  Copyright © 2018年 Nobuhiro Harada. All rights reserved.
//

import Foundation
import SpriteKit

class BaseScene: SKScene, SKPhysicsContactDelegate {
    
    var players:  Array = [SKSpriteNode?]()
    var playerAs: Array = [SKSpriteNode?]()
    var playerBs: Array = [SKSpriteNode?]()
    
    let nodeSize: CGSize               = CGSize(width: 35, height: 35)
//    let nodePhysicsBody: SKPhysicsBody = SKPhysicsBody(circleOfRadius: 35.0)
    var ball:     SKSpriteNode         = SKSpriteNode(imageNamed: "ball")
    var playerA0: SKSpriteNode         = SKSpriteNode(imageNamed: "playerA")
    var playerA1: SKSpriteNode         = SKSpriteNode(imageNamed: "playerA")
    var playerA2: SKSpriteNode         = SKSpriteNode(imageNamed: "playerA")
    var playerA3: SKSpriteNode         = SKSpriteNode(imageNamed: "playerA")
    var playerA4: SKSpriteNode         = SKSpriteNode(imageNamed: "playerA")
    var playerB0: SKSpriteNode         = SKSpriteNode(imageNamed: "playerB")
    var playerB1: SKSpriteNode         = SKSpriteNode(imageNamed: "playerB")
    var playerB2: SKSpriteNode         = SKSpriteNode(imageNamed: "playerB")
    var playerB3: SKSpriteNode         = SKSpriteNode(imageNamed: "playerB")
    var playerB4: SKSpriteNode         = SKSpriteNode(imageNamed: "playerB")
    
    var startPoint: CGPoint?
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch:UITouch = touches.first!
        startPoint = touch.location(in: self)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch:UITouch = touches.first!
        let location = touch.location(in: self)
        let nodes = self.nodes(at: location)
        let action = SKAction.move(to: location, duration: 0)
        
        if nodes.contains(ball)
            || nodes.contains(playerA0)
            || nodes.contains(playerA1)
            || nodes.contains(playerA2)
            || nodes.contains(playerA3)
            || nodes.contains(playerA4)
            || nodes.contains(playerB0)
            || nodes.contains(playerB1)
            || nodes.contains(playerB2)
            || nodes.contains(playerB3)
            || nodes.contains(playerB4)
        {
            for node in nodes
            {
                if node.name == "playerA0" {
                    self.players[0]?.run(action)
                } else if node.name == "playerA1" {
                    self.players[1]?.run(action)
                } else if node.name == "playerA2" {
                    self.players[2]?.run(action)
                } else if node.name == "playerA3" {
                    self.players[3]?.run(action)
                } else if node.name == "playerA4" {
                    self.players[4]?.run(action)
                } else if node.name == "playerB0" {
                    self.players[5]?.run(action)
                } else if node.name == "playerB1" {
                    self.players[6]?.run(action)
                } else if node.name == "playerB2" {
                    self.players[7]?.run(action)
                } else if node.name == "playerB3" {
                    self.players[8]?.run(action)
                } else if node.name == "playerB4" {
                    self.players[9]?.run(action)
                } else if node.name == "ball" {
                    self.ball.run(action)
                }
            }
        } else {
            drawLines(touches: touches)
        }
    }
    
    
    func drawLines(touches: Set<UITouch>) {
        
        let touch:UITouch = touches.first!
        var pointInDrawing = touch.location(in: self)
        
        var path = CGMutablePath()
        path.move(to: CGPoint(x:startPoint!.x, y:startPoint!.y))
        path.addLine(to: CGPoint(x:pointInDrawing.x, y:pointInDrawing.y))
        startPoint = pointInDrawing
        let shape = SKShapeNode()
        shape.path = path
        shape.strokeColor = UIColor.gray
        shape.lineWidth = 4
        addChild(shape)
    }
}
