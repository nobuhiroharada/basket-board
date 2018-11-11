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
    
    let screenHeight = UIScreen.main.bounds.size.height
    let scaleBig = SKAction.scale(to: 1.2, duration: 0.1)
    let scaleOrigin = SKAction.scale(to: 1.0, duration: 0.1)
    
    var players:  Array = [SKSpriteNode?]()
    var playerAs: Array = [SKSpriteNode?]()
    var playerBs: Array = [SKSpriteNode?]()
    
//    var ball:     PlayerBallNode = PlayerBallNode(imageNamed: "ball")
//    var playerA0: PlayerBallNode = PlayerBallNode(imageNamed: "playerA1")
//    var playerA1: PlayerBallNode = PlayerBallNode(imageNamed: "playerA2")
//    var playerA2: PlayerBallNode = PlayerBallNode(imageNamed: "playerA3")
//    var playerA3: PlayerBallNode = PlayerBallNode(imageNamed: "playerA4")
//    var playerA4: PlayerBallNode = PlayerBallNode(imageNamed: "playerA5")
//    var playerB0: PlayerBallNode = PlayerBallNode(imageNamed: "playerB1")
//    var playerB1: PlayerBallNode = PlayerBallNode(imageNamed: "playerB2")
//    var playerB2: PlayerBallNode = PlayerBallNode(imageNamed: "playerB3")
//    var playerB3: PlayerBallNode = PlayerBallNode(imageNamed: "playerB4")
//    var playerB4: PlayerBallNode = PlayerBallNode(imageNamed: "playerB5")
    var eraser:   BarItemNode = BarItemNode(imageNamed: "eraser")
    var rewind:   BarItemNode = BarItemNode(imageNamed: "rewind")
    var reset:    BarItemNode = BarItemNode(imageNamed: "reset")
    var setting:  BarItemNode = BarItemNode(imageNamed: "othersSetting")
    
    let hide:     SKAction     = SKAction.hide()
    
    let userDefaults = UserDefaults.standard
    
    var startPoint: CGPoint?
    var lineNum: Int = 0
    var lineArray: Array = [String?]()
    var mode: Status?
    
    enum Status {
        case Node
        case Draw
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch:UITouch = touches.first!
        startPoint = touch.location(in: self)
        
        let location = touch.location(in: self)
        let nodes = self.nodes(at: location)
        
        if nodes.contains(Objects.ball)
            || nodes.contains(Objects.playerA0)
            || nodes.contains(Objects.playerA1)
            || nodes.contains(Objects.playerA2)
            || nodes.contains(Objects.playerA3)
            || nodes.contains(Objects.playerA4)
            || nodes.contains(Objects.playerB0)
            || nodes.contains(Objects.playerB1)
            || nodes.contains(Objects.playerB2)
            || nodes.contains(Objects.playerB3)
            || nodes.contains(Objects.playerB4)
        {
            let playerNum = userDefaults.integer(forKey: "playerNum")
            if playerNum == 5 {
                nodeAddAction_5player(nodes, scaleBig)
            } else if playerNum == 3 {
                nodeAddAction_3player(nodes, scaleBig)
            }
            
            mode = Status.Node
        }
        else if nodes.contains(eraser)
        {
            deleteLine()
        }
        else if nodes.contains(rewind)
        {
            goBack()
        }
        else if nodes.contains(reset)
        {
            doReset()
        }
        else if nodes.contains(setting)
        {
            openOthersSetting()
        }
        else
        {
            mode = Status.Draw
        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch:UITouch = touches.first!
        let location = touch.location(in: self)
        let nodes = self.nodes(at: location)
        let action = SKAction.move(to: location, duration: 0)
        
        if mode == Status.Node {
            if nodes.contains(Objects.ball)
                || nodes.contains(Objects.playerA0)
                || nodes.contains(Objects.playerA1)
                || nodes.contains(Objects.playerA2)
                || nodes.contains(Objects.playerA3)
                || nodes.contains(Objects.playerA4)
                || nodes.contains(Objects.playerB0)
                || nodes.contains(Objects.playerB1)
                || nodes.contains(Objects.playerB2)
                || nodes.contains(Objects.playerB3)
                || nodes.contains(Objects.playerB4)
            {
                let playerNum = userDefaults.integer(forKey: "playerNum")
                if playerNum == 5 {
                    nodeAddAction_5player(nodes, action)
                } else if playerNum == 3 {
                    nodeAddAction_3player(nodes, action)
                }
                
            }
        }
        
        if mode == Status.Draw {
            drawLines(touches: touches)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch:UITouch = touches.first!
        
        let location = touch.location(in: self)
        let nodes = self.nodes(at: location)
        
        if nodes.contains(Objects.ball)
            || nodes.contains(Objects.playerA0)
            || nodes.contains(Objects.playerA1)
            || nodes.contains(Objects.playerA2)
            || nodes.contains(Objects.playerA3)
            || nodes.contains(Objects.playerA4)
            || nodes.contains(Objects.playerB0)
            || nodes.contains(Objects.playerB1)
            || nodes.contains(Objects.playerB2)
            || nodes.contains(Objects.playerB3)
            || nodes.contains(Objects.playerB4)
        {
            let playerNum = userDefaults.integer(forKey: "playerNum")
            if playerNum == 5 {
                nodeAddAction_5player(nodes, scaleOrigin)
            } else if playerNum == 3 {
                nodeAddAction_3player(nodes, scaleOrigin)
            }
        }
        
        if mode == Status.Draw {
            lineArray.append("line\(lineNum)")
            lineNum += 1
        }
    }
    
    func nodeAddAction_5player(_ nodes: Array<SKNode>, _ action: SKAction)
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
                Objects.ball.run(action)
            }
        }
    }
    
    func nodeAddAction_3player(_ nodes: Array<SKNode>, _ action: SKAction)
    {
        for node in nodes
        {
            if node.name == "playerA0" {
                self.players[0]?.run(action)
            } else if node.name == "playerA1" {
                self.players[1]?.run(action)
            } else if node.name == "playerA2" {
                self.players[2]?.run(action)
            } else if node.name == "playerB0" {
                self.players[3]?.run(action)
            } else if node.name == "playerB1" {
                self.players[4]?.run(action)
            } else if node.name == "playerB2" {
                self.players[5]?.run(action)
            } else if node.name == "ball" {
                Objects.ball.run(action)
            }
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
        
        shape.strokeColor = userDefaults.colorForKey(key: "lineColor")!
        shape.lineWidth = CGFloat(userDefaults.integer(forKey: "lineThick"))
        
        shape.name = "line\(lineNum)"
        self.addChild(shape)
    }
    
    //MARK: 線をすべて消す
    func deleteLine() {
        for node in self.children {
            for line in lineArray {
                if node.name == line {
                    node.run(hide)
                }
            }
        }
        lineArray.removeAll()
    }
    
    //MARK: 一つ前の線を消す
    func goBack()  {
        if lineNum > 0 {
            lineNum -= 1
        }
        
        let lastLine = lineArray.last
        
        for node in self.children {
            if node.name == lastLine {
                let hide = SKAction.hide()
                node.run(hide)
            }
        }
        
        // 最新の線の名前と同じやつ以外を配列内に入れ直す(最新のやつを消す)
        lineArray = lineArray.filter { (lineNum) -> Bool in
            lineNum != lastLine
        }

        // 消去ボタンを押した時も touchesEnd は走ってるのでもう１回マイナス1
        if lineNum > 0 {
            lineNum -= 1
        }
    }
    
    //MARK: 初期画面に戻る
    func doReset() {
        self.removeAllChildren()
        
        let initScene = InitScene(size: self.size)
        
        self.view?.presentScene(initScene)
    }
    
    //MARK: その他設定画面表示
    func openOthersSetting(){
        self.removeAllChildren()
        
        let othersSettingScene = OthersSettingScene(size: self.size)
        
        self.view?.presentScene(othersSettingScene)
    }
}

extension UserDefaults {
    func colorForKey(key: String) -> UIColor? {
        var color: UIColor?
        if let colorData = data(forKey: key) {
            color = NSKeyedUnarchiver.unarchiveObject(with: colorData) as? UIColor
        }
        return color
    }
    
}
