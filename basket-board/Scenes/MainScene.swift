//
//  BoardView.swift
//  basket-board
//
//  Created by Nobuhiro Harada on 2018/08/12.
//  Copyright © 2018年 Nobuhiro Harada. All rights reserved.

import Foundation
import SpriteKit

class MainScene: SKScene, SKPhysicsContactDelegate {
        
    var activePlayers:  Array = [PlayerNode]()
    var playerAs: Array = [PlayerNode]()
    var playerBs: Array = [PlayerNode]()
    
    let scaleBig    = SKAction.scale(to: 1.2, duration: 0.1)
    let scaleOrigin = SKAction.scale(to: 1.0, duration: 0.1)
    let hide        = SKAction.hide()
        
    var startPoint: CGPoint?
    var lineNum: Int = 0
    var lineArray: Array = [String?]()
    var mode: Mode?
    var playerNum: Int = 5
    
    var isDrawerOpen: Bool = false
    
    let ball: BallNode = BallNode(imageNamed: "ball")
    
    let playerA0: PlayerNode = PlayerNode(imageNamed: "playerA1")
    let playerA1: PlayerNode = PlayerNode(imageNamed: "playerA2")
    let playerA2: PlayerNode = PlayerNode(imageNamed: "playerA3")
    let playerA3: PlayerNode = PlayerNode(imageNamed: "playerA4")
    let playerA4: PlayerNode = PlayerNode(imageNamed: "playerA5")
    let playerB0: PlayerNode = PlayerNode(imageNamed: "playerB1")
    let playerB1: PlayerNode = PlayerNode(imageNamed: "playerB2")
    let playerB2: PlayerNode = PlayerNode(imageNamed: "playerB3")
    let playerB3: PlayerNode = PlayerNode(imageNamed: "playerB4")
    let playerB4: PlayerNode = PlayerNode(imageNamed: "playerB5")
    
    let eraser:   BarItemNode = BarItemNode(imageNamed: "eraser")
    let rewind:   BarItemNode = BarItemNode(imageNamed: "rewind")
    let reset:    BarItemNode = BarItemNode(imageNamed: "reset")
    let setting:  BarItemNode = BarItemNode(imageNamed: "othersSetting")
    let drawer:   BarItemNode = BarItemNode(imageNamed: "drawer")
    
    override init(size: CGSize) {
        super.init(size: size)
        
        let currentDevice :Device = getDeviceType()
        
        // iPhoneの場合のサイズ
        var nodeSize: CGSize = CGSize(width: Consts.NODE_SIZE_IPHONE, height: Consts.NODE_SIZE_IPHONE)
        var viewPadding: Int = 15
        var nodeSpace: Int = 40
        
        switch currentDevice {
        case .IPAD:
            nodeSize = CGSize(width: Consts.NODE_SIZE_IPAD, height: Consts.NODE_SIZE_IPAD)
            nodeSpace = 80
            viewPadding = 30
        case .IPHONE, .IPHONEX: break
        }
        
        playerNum = userDefaults.integer(forKey: Consts.PLAYER_NUM)
        
        setBackground()
        setTabBarItems(nodeSize, viewPadding)
        setPlayers(playerNum, nodeSize, nodeSpace, viewPadding)
        setBall(nodeSize, viewPadding)
        
        self.physicsWorld.gravity = .zero
        self.physicsWorld.contactDelegate = self
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
        
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
            if playerNum == 5 {
                addAction5players(nodes, scaleBig)
            } else if playerNum == 3 {
                addAction3players(nodes, scaleBig)
            }
            
            mode = .Move
        }
//        else if nodes.contains(drawer) { openDrawer() }
        else if nodes.contains(eraser) { deleteLine() }
        else if nodes.contains(rewind) { deleteOneBeforeLine() }
        else if nodes.contains(reset) { doReset() }
        else if nodes.contains(setting) { openSettingScene() }
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
                if playerNum == 5 {
                    addAction5players(nodes, action)
                } else if playerNum == 3 {
                    addAction3players(nodes, action)
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
            if playerNum == 5 {
                addAction5players(nodes, scaleOrigin)
            } else if playerNum == 3 {
                addAction3players(nodes, scaleOrigin)
            }
        }
        
        if mode == .Draw {
            lineArray.append("line\(lineNum)")
            lineNum += 1
        }
    }
    
    func addAction5players(_ nodes: Array<SKNode>, _ action: SKAction)
    {
        for node in nodes
        {
            if node.name == Consts.PLAYER_A0 { self.activePlayers[0].run(action) }
            else if node.name == Consts.PLAYER_A1 { self.activePlayers[1].run(action) }
            else if node.name == Consts.PLAYER_A2 { self.activePlayers[2].run(action) }
            else if node.name == Consts.PLAYER_A3 { self.activePlayers[3].run(action) }
            else if node.name == Consts.PLAYER_A4 { self.activePlayers[4].run(action) }
            else if node.name == Consts.PLAYER_B0 { self.activePlayers[5].run(action) }
            else if node.name == Consts.PLAYER_B1 { self.activePlayers[6].run(action) }
            else if node.name == Consts.PLAYER_B2 { self.activePlayers[7].run(action) }
            else if node.name == Consts.PLAYER_B3 { self.activePlayers[8].run(action) }
            else if node.name == Consts.PLAYER_B4 { self.activePlayers[9].run(action) }
            else if node.name == Consts.BALL { ball.run(action) }
        }
    }
    
    func addAction3players(_ nodes: Array<SKNode>, _ action: SKAction)
    {
        for node in nodes
        {
            if node.name == Consts.PLAYER_A0 { self.activePlayers[0].run(action) }
            else if node.name == Consts.PLAYER_A1 { self.activePlayers[1].run(action) }
            else if node.name == Consts.PLAYER_A2 { self.activePlayers[2].run(action) }
            else if node.name == Consts.PLAYER_B0 { self.activePlayers[3].run(action) }
            else if node.name == Consts.PLAYER_B1 { self.activePlayers[4].run(action) }
            else if node.name == Consts.PLAYER_B2 { self.activePlayers[5].run(action) }
            else if node.name == Consts.BALL { ball.run(action) }
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
        shape.strokeColor = userDefaults.colorForKey(key: Consts.LINE_COLOR)
        shape.lineWidth = CGFloat(userDefaults.integer(forKey: Consts.LINE_THICK))
        shape.name = "line\(lineNum)"
        self.addChild(shape)
    }
    
//    func openDrawer() {
//
//        if isDrawerOpen {
//            let hideAction = SKAction.moveBy(x: CGFloat(viewPadding!+Int((nodeSize?.height)!)), y: 0, duration: 0.3)
//            reset.run(hideAction)
//            eraser.run(hideAction)
//            rewind.run(hideAction)
//            setting.run(hideAction)
//
//            let rotate = SKAction.rotate(byAngle: CGFloat(.pi / 180 * Double(180)), duration: 0.3)
//            drawer.run(rotate)
//            isDrawerOpen.toggle()
//        } else {
//            let openAction = SKAction.moveBy(x: -CGFloat(viewPadding!+Int((nodeSize?.height)!)), y: 0, duration: 0.3)
//            reset.run(openAction)
//            eraser.run(openAction)
//            rewind.run(openAction)
//            setting.run(openAction)
//
//            let rotate = SKAction.rotate(byAngle: CGFloat(.pi / 180 * Double(180)), duration: 0.3)
//            drawer.run(rotate)
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
            drawer.run(rotate)
        }
        self.removeAllChildren()
        let mainScene = MainScene(size: self.size)
        self.view?.presentScene(mainScene)
    }
    
    func openSettingScene(){
        if isDrawerOpen {
            let rotate = SKAction.rotate(byAngle: CGFloat(.pi / 180 * Double(180)), duration: 0)
            drawer.run(rotate)
        }
        self.removeAllChildren()
        let settingScene = SettingScene(size: self.size)
        self.view?.presentScene(settingScene)
    }
    
    // MARK: - Set Objects
    func setBackground() {
        
        var background: SKSpriteNode?
        let courtType = userDefaults.integer(forKey: Consts.COURT_TYPE)
        let currentDevice :Device = getDeviceType()
        
        switch currentDevice {
        case .IPHONE:
            if courtType == 1 {
                background = SKSpriteNode(imageNamed: "fullcourt")
            }
            else if courtType == 2 {
                background = SKSpriteNode(imageNamed: "halfcourt")
            }
        case .IPHONEX:
            if courtType == 1 {
                background = SKSpriteNode(imageNamed: "fullcourt_iphonex")
            }
            else if courtType == 2 {
                background = SKSpriteNode(imageNamed: "halfcourt_iphonex")
            }
        case .IPAD:
            if courtType == 1 {
                background = SKSpriteNode(imageNamed: "fullcourt_ipad")
            }
            else if courtType == 2 {
                background = SKSpriteNode(imageNamed: "halfcourt_ipad")
            }
        }
        
        if let background = background {
            background.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.5)
            background.size = self.size
            self.addChild(background)
        }
        
    }
    
    func setTabBarItems(_ nodeSize: CGSize, _ viewPadding: Int) {
        
//        drawer.position = CGPoint(x: Int(self.size.width-((nodeSize?.width)!)), y: viewPadding!)
//        drawer.size = nodeSize!
//        drawer.name = "drawer"
//        self.addChild(drawer)
        
//        rewind.position = CGPoint(x: Int(self.size.width+((nodeSize?.width)!)), y: viewPadding!+(viewPadding!+Int((nodeSize?.height)!))*3)
//        rewind.size = nodeSize!
//        rewind.name = "rewind"
//        self.addChild(rewind)
        
        let currentDevice :Device = getDeviceType()
        
        switch currentDevice {
        case .IPHONE, .IPHONEX:
            eraser.position = CGPoint(x: Int(self.size.width-(nodeSize.width)*5), y: viewPadding+10)
            eraser.size = nodeSize
            eraser.name = "eraser"
            self.addChild(eraser)
            
            reset.position = CGPoint(x: Int(self.size.width-(nodeSize.width)*3), y:viewPadding+10)
            reset.size = nodeSize
            reset.name = "reset"
            self.addChild(reset)
            
            setting.position = CGPoint(x: Int(self.size.width-nodeSize.width), y: viewPadding+10)
            setting.size = nodeSize
            setting.name = "othersSetting"
            self.addChild(setting)
            
        case .IPAD:
            eraser.position = CGPoint(x: Int(self.size.width-nodeSize.width), y: viewPadding+(viewPadding+Int(nodeSize.height))*2)
            eraser.size = nodeSize
            eraser.name = "eraser"
            self.addChild(eraser)
            
            reset.position = CGPoint(x: Int(self.size.width-nodeSize.width), y:viewPadding+(viewPadding+Int(nodeSize.height)))
            reset.size = nodeSize
            reset.name = "reset"
            self.addChild(reset)
            
            setting.position = CGPoint(x: Int(self.size.width-nodeSize.width), y: viewPadding+10)
            setting.size = nodeSize
            setting.name = "othersSetting"
            self.addChild(setting)
            
        }
        
        
    }
    
    func setPlayers(_ playerNum: Int, _ nodeSize: CGSize, _ nodeSpace: Int, _ viewPadding: Int) {
                
        if playerNum == 3 {
            playerAs = [playerA0,playerA1,playerA2]
            playerBs = [playerB0,playerB1,playerB2]
        }
        else if playerNum == 5 {
            playerAs = [playerA0,playerA1,playerA2,playerA3,playerA4]
            playerBs = [playerB0,playerB1,playerB2,playerB3,playerB4]
        }
        
        for (i, a) in playerAs.enumerated() {
            a.position = CGPoint(x: viewPadding, y: Int(self.size.height*0.6)+nodeSpace*i)
            a.size = nodeSize
            a.name = "playerA\(i)"
            activePlayers.append(a)
            self.addChild(a)
        }
        
        for (i,b) in playerBs.enumerated() {
            b.position = CGPoint(x: viewPadding, y: Int(self.size.height*0.4)-nodeSpace*i)
            b.size = nodeSize
            b.name = "playerB\(i)"
            activePlayers.append(b)
            self.addChild(b)
        }
    }
    
    func setBall(_ nodeSize: CGSize, _ viewPadding: Int) {
        
        ball.position = CGPoint(x: viewPadding, y: Int(self.size.height*0.5))
        ball.size = nodeSize
        ball.name = Consts.BALL
        self.addChild(ball)
        
    }

    func getDeviceType() -> Device {
        
        var device: Device = .IPHONE
        
        if Consts.DISPLAY_HEIGHT <= 736 { device = .IPHONE }
        else if Consts.DISPLAY_HEIGHT < 1024 { device = .IPHONEX }
        else { device = .IPAD }
        
        return device
    }
}
