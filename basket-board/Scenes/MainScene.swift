//
//  BoardView.swift
//  basket-board
//
//  Created by Nobuhiro Harada on 2018/08/12.
//  Copyright © 2018年 Nobuhiro Harada. All rights reserved.

import Foundation
import SpriteKit

class MainScene: SKScene, SKPhysicsContactDelegate {
    
    var viewSize: CGSize?
    var viewPadding: Int?
    
    var nodeSize: CGSize?
    var nodeSpace: Int?
    
    var device: Device?
    
    var activePlayers:  Array = [PlayerBallNode]()
    var playerAs: Array = [PlayerBallNode]()
    var playerBs: Array = [PlayerBallNode]()
    
    let scaleBig    = SKAction.scale(to: 1.2, duration: 0.1)
    let scaleOrigin = SKAction.scale(to: 1.0, duration: 0.1)
    let hide        = SKAction.hide()
        
    var startPoint: CGPoint?
    var lineNum: Int = 0
    var lineArray: Array = [String?]()
    var mode: Mode?
    var playerNum: Int?
    
    var isDrawerOpen: Bool = false
    
    override init(size: CGSize) {
        super.init(size: size)
        
        viewSize = size
        
        if Consts.DISPLAY_HEIGHT <= 736 { device = .IPHONE }
        else if Consts.DISPLAY_HEIGHT < 1024 { device = .IPHONEX }
        else { device = .IPAD }
        
        switch device! {
        case .IPHONE, .IPHONEX:
            nodeSize = CGSize(width: Consts.NODE_SIZE_IPHONE, height: Consts.NODE_SIZE_IPHONE)
            nodeSpace = 40
            viewPadding = 15
        case .IPAD:
            nodeSize = CGSize(width: Consts.NODE_SIZE_IPAD, height: Consts.NODE_SIZE_IPAD)
            nodeSpace = 80
            viewPadding = 30
        }
        
        playerNum = userDefaults.integer(forKey: "playerNum")
        
        setBackground()
        setTabBarItems()
        setPlayers()
        setBall()
        
        self.physicsWorld.gravity = .zero
        self.physicsWorld.contactDelegate = self
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: CGRect(x: 0, y: 0, width: viewSize!.width, height: viewSize!.height))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Touches Methods
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch: UITouch = touches.first else {
            return
        }
        
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
            if playerNum == 5 {
                addAction_5players(nodes, scaleBig)
            } else if playerNum == 3 {
                addAction_3players(nodes, scaleBig)
            }
            
            mode = .Move
        }
//        else if nodes.contains(Objects.drawer) { openDrawer() }
        else if nodes.contains(Objects.eraser) { deleteLine() }
        else if nodes.contains(Objects.rewind) { deleteOneBeforeLine() }
        else if nodes.contains(Objects.reset) { doReset() }
        else if nodes.contains(Objects.setting) { openSettingScene() }
        else { mode = .Draw }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touch:UITouch = touches.first else {
            return
        }
        
        let location = touch.location(in: self)
        let nodes = self.nodes(at: location)
        let action = SKAction.move(to: location, duration: 0)
        
        if mode == .Move {
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
                if playerNum == 5 {
                    addAction_5players(nodes, action)
                } else if playerNum == 3 {
                    addAction_3players(nodes, action)
                }
                
            }
        }
        
        if mode == .Draw {
            drawLines(touches: touches)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touch: UITouch = touches.first else {
            return
        }
        
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
            if playerNum == 5 {
                addAction_5players(nodes, scaleOrigin)
            } else if playerNum == 3 {
                addAction_3players(nodes, scaleOrigin)
            }
        }
        
        if mode == .Draw {
            lineArray.append("line\(lineNum)")
            lineNum += 1
        }
    }
    
    func addAction_5players(_ nodes: Array<SKNode>, _ action: SKAction)
    {
        for node in nodes
        {
            if node.name == "playerA0" { self.activePlayers[0].run(action) }
            else if node.name == "playerA1" { self.activePlayers[1].run(action) }
            else if node.name == "playerA2" { self.activePlayers[2].run(action) }
            else if node.name == "playerA3" { self.activePlayers[3].run(action) }
            else if node.name == "playerA4" { self.activePlayers[4].run(action) }
            else if node.name == "playerB0" { self.activePlayers[5].run(action) }
            else if node.name == "playerB1" { self.activePlayers[6].run(action) }
            else if node.name == "playerB2" { self.activePlayers[7].run(action) }
            else if node.name == "playerB3" { self.activePlayers[8].run(action) }
            else if node.name == "playerB4" { self.activePlayers[9].run(action) }
            else if node.name == "ball" { Objects.ball.run(action) }
        }
    }
    
    func addAction_3players(_ nodes: Array<SKNode>, _ action: SKAction)
    {
        for node in nodes
        {
            if node.name == "playerA0" { self.activePlayers[0].run(action) }
            else if node.name == "playerA1" { self.activePlayers[1].run(action) }
            else if node.name == "playerA2" { self.activePlayers[2].run(action) }
            else if node.name == "playerB0" { self.activePlayers[3].run(action) }
            else if node.name == "playerB1" { self.activePlayers[4].run(action) }
            else if node.name == "playerB2" { self.activePlayers[5].run(action) }
            else if node.name == "ball" { Objects.ball.run(action) }
        }
    }
    
    func drawLines(touches: Set<UITouch>) {
        
        guard let touch: UITouch = touches.first else {
            return
        }
        
        let pointInDrawing = touch.location(in: self)
        
        let path = CGMutablePath()
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
    
//    func openDrawer() {
//
//        if isDrawerOpen {
//            let hideAction = SKAction.moveBy(x: CGFloat(viewPadding!+Int((nodeSize?.height)!)), y: 0, duration: 0.3)
//            Objects.reset.run(hideAction)
//            Objects.eraser.run(hideAction)
//            Objects.rewind.run(hideAction)
//            Objects.setting.run(hideAction)
//
//            let rotate = SKAction.rotate(byAngle: CGFloat(.pi / 180 * Double(180)), duration: 0.3)
//            Objects.drawer.run(rotate)
//            isDrawerOpen.toggle()
//        } else {
//            let openAction = SKAction.moveBy(x: -CGFloat(viewPadding!+Int((nodeSize?.height)!)), y: 0, duration: 0.3)
//            Objects.reset.run(openAction)
//            Objects.eraser.run(openAction)
//            Objects.rewind.run(openAction)
//            Objects.setting.run(openAction)
//
//            let rotate = SKAction.rotate(byAngle: CGFloat(.pi / 180 * Double(180)), duration: 0.3)
//            Objects.drawer.run(rotate)
//            isDrawerOpen.toggle()
//        }
//
//    }
    
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
    
    func deleteOneBeforeLine()  {
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
    
    func doReset() {
        if isDrawerOpen {
            let rotate = SKAction.rotate(byAngle: CGFloat(.pi / 180 * Double(180)), duration: 0)
            Objects.drawer.run(rotate)
        }
        self.removeAllChildren()
        let mainScene = MainScene(size: self.size)
        self.view?.presentScene(mainScene)
    }
    
    func openSettingScene(){
        if isDrawerOpen {
            let rotate = SKAction.rotate(byAngle: CGFloat(.pi / 180 * Double(180)), duration: 0)
            Objects.drawer.run(rotate)
        }
        self.removeAllChildren()
        let settingScene = SettingScene(size: self.size)
        self.view?.presentScene(settingScene)
    }
    
    // MARK: - Set Objects
    func setBackground() {
        
        var background: SKSpriteNode?
        let isFullCourt = userDefaults.bool(forKey: "isFullcourt")
        
        switch device! {
        case .IPHONE:
            if isFullCourt {
                background = SKSpriteNode(imageNamed: "fullcourt")
            } else {
                background = SKSpriteNode(imageNamed: "halfcourt")
            }
        case .IPHONEX:
            if isFullCourt {
                background = SKSpriteNode(imageNamed: "fullcourt_iphonex")
            } else {
                background = SKSpriteNode(imageNamed: "halfcourt_iphonex")
            }
        case .IPAD:
            if isFullCourt {
                background = SKSpriteNode(imageNamed: "fullcourt_ipad")
            } else {
                background = SKSpriteNode(imageNamed: "halfcourt_ipad")
            }
        }
        
        if let background = background {
            background.position = CGPoint(x: viewSize!.width*0.5, y: viewSize!.height*0.5)
            background.size = viewSize!
            self.addChild(background)
        }
        
    }
    
    func setTabBarItems() {
        
//        Objects.drawer.position = CGPoint(x: Int(viewSize!.width-((nodeSize?.width)!)), y: viewPadding!)
//        Objects.drawer.size = nodeSize!
//        Objects.drawer.name = "drawer"
//        self.addChild(Objects.drawer)
        
//        Objects.rewind.position = CGPoint(x: Int(viewSize!.width+((nodeSize?.width)!)), y: viewPadding!+(viewPadding!+Int((nodeSize?.height)!))*3)
//        Objects.rewind.size = nodeSize!
//        Objects.rewind.name = "rewind"
//        self.addChild(Objects.rewind)
        
        switch device! {
        case .IPHONE, .IPHONEX:
            Objects.eraser.position = CGPoint(x: Int(viewSize!.width-((nodeSize?.width)!)*5), y: viewPadding!+10)
            Objects.eraser.size = nodeSize!
            Objects.eraser.name = "eraser"
            self.addChild(Objects.eraser)
            
            Objects.reset.position = CGPoint(x: Int(viewSize!.width-((nodeSize?.width)!)*3), y:viewPadding!+10)
            Objects.reset.size = nodeSize!
            Objects.reset.name = "reset"
            self.addChild(Objects.reset)
            
            Objects.setting.position = CGPoint(x: Int(viewSize!.width-((nodeSize?.width)!)), y: viewPadding!+10)
            Objects.setting.size = nodeSize!
            Objects.setting.name = "othersSetting"
            self.addChild(Objects.setting)
            
        case .IPAD:
            Objects.eraser.position = CGPoint(x: Int(viewSize!.width-((nodeSize?.width)!)), y: viewPadding!+(viewPadding!+Int((nodeSize?.height)!))*2)
            Objects.eraser.size = nodeSize!
            Objects.eraser.name = "eraser"
            self.addChild(Objects.eraser)
            
            Objects.reset.position = CGPoint(x: Int(viewSize!.width-((nodeSize?.width)!)), y:viewPadding!+(viewPadding!+Int((nodeSize?.height)!)))
            Objects.reset.size = nodeSize!
            Objects.reset.name = "reset"
            self.addChild(Objects.reset)
            
            Objects.setting.position = CGPoint(x: Int(viewSize!.width-((nodeSize?.width)!)), y: viewPadding!+10)
            Objects.setting.size = nodeSize!
            Objects.setting.name = "othersSetting"
            self.addChild(Objects.setting)
            
        }
        
        
    }
    
    func setPlayers() {
        
        let playerNum = userDefaults.integer(forKey: "playerNum")
        
        if playerNum == 3 {
            playerAs = [Objects.playerA0,Objects.playerA1,Objects.playerA2]
            playerBs = [Objects.playerB0,Objects.playerB1,Objects.playerB2]
        }
        else if playerNum == 5 {
            playerAs = [Objects.playerA0,Objects.playerA1,Objects.playerA2,Objects.playerA3,Objects.playerA4]
            playerBs = [Objects.playerB0,Objects.playerB1,Objects.playerB2,Objects.playerB3,Objects.playerB4]
        }
        
        for (i, a) in playerAs.enumerated() {
            a.position = CGPoint(x: viewPadding!, y: Int(viewSize!.height*0.6)+nodeSpace!*i)
            a.size = nodeSize!
            a.name = "playerA\(i)"
            activePlayers.append(a)
            self.addChild(a)
        }
        
        for (i,b) in playerBs.enumerated() {
            b.position = CGPoint(x: viewPadding!, y: Int(viewSize!.height*0.4)-nodeSpace!*i)
            b.size = nodeSize!
            b.name = "playerB\(i)"
            activePlayers.append(b)
            self.addChild(b)
        }
    }
    
    func setBall() {
        
        Objects.ball.position = CGPoint(x: viewPadding!, y: Int(viewSize!.height*0.5))
        Objects.ball.size = nodeSize!
        Objects.ball.name = "ball"
        self.addChild(Objects.ball)
        
    }

}
