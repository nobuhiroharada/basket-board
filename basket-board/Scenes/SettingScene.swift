//
//  SettingScene.swift
//  basket-board
//
//  Created by Nobuhiro Harada on 2018/09/07.
//  Copyright © 2018年 Nobuhiro Harada. All rights reserved.
//

import Foundation
import SpriteKit

class SettingScene: SKScene {
    
    let screenHeight = UIScreen.main.bounds.size.height
    
    var backButton: SKSpriteNode = SKSpriteNode(imageNamed: "back")
        
    var viewSize: CGSize?
        
    override init(size: CGSize) {
        super.init(size: size)
        
        viewSize = size
        setBackgroundNode()
        setCourtIcon()
        setLineIcon()
        setColorIcon()
        setPlayerNumIcon()
        
        backButton.position = CGPoint(x: viewSize!.width*0.25, y: viewSize!.height-50)
        backButton.size = CGSize(width: 100, height: 50)
        self.addChild(backButton)
        
        
        iconOpacityControl()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        guard let touch:UITouch = touches.first else {
            return
        }
        
        let location = touch.location(in: self)
        let nodes = self.nodes(at: location)
        
        if nodes.contains(backButton)
        {
            goBack()
        }
        else if nodes.contains(Objects.fullcourtIcon)
        {
            userDefaults.set(true, forKey: "isFullcourt")
            userDefaults.synchronize()
            iconOpacityControl()
        }
        else if nodes.contains(Objects.halfcourtIcon)
        {
            userDefaults.set(false, forKey: "isFullcourt")
            userDefaults.synchronize()
            iconOpacityControl()
        }
        else if nodes.contains(Objects.smallLineIcon)
        {
            userDefaults.set(2, forKey: "lineThick")
            userDefaults.synchronize()
            iconOpacityControl()
        }
        else if nodes.contains(Objects.mediumLineIcon)
        {
            userDefaults.set(4, forKey: "lineThick")
            userDefaults.synchronize()
            iconOpacityControl()
        }
        else if nodes.contains(Objects.largeLineIcon)
        {
            userDefaults.set(6, forKey: "lineThick")
            userDefaults.synchronize()
            iconOpacityControl()
        }
        else if nodes.contains(Objects.grayLineIcon)
        {
            userDefaults.setColor(color: UIColor.gray, forKey: "lineColor")
            userDefaults.synchronize()
            iconOpacityControl()
        }
        else if nodes.contains(Objects.orangeLineIcon)
        {
            userDefaults.setColor(color: UIColor.orange, forKey: "lineColor")
            userDefaults.synchronize()
            iconOpacityControl()
        }
        else if nodes.contains(Objects.redLineIcon)
        {
            userDefaults.setColor(color: UIColor.red, forKey: "lineColor")
            userDefaults.synchronize()
            iconOpacityControl()
        }
        else if nodes.contains(Objects.threePlayerIcon)
        {
            userDefaults.set(3, forKey: "playerNum")
            userDefaults.synchronize()
            iconOpacityControl()
        }
        else if nodes.contains(Objects.fivePlayerIcon)
        {
            userDefaults.set(5, forKey: "playerNum")
            userDefaults.synchronize()
            iconOpacityControl()
        }
    }
    
    func goBack()
    {
        self.removeAllChildren()
        
        let mainScene = MainScene(size: self.size)
        
        self.view?.presentScene(mainScene)
    }
    
    func iconOpacityControl()
    {
        let currentCourtType = userDefaults.bool(forKey: "isFullcourt")
        let currentLineThick = userDefaults.integer(forKey: "lineThick")
        let currentlineColor = userDefaults.colorForKey(key: "lineColor")!
        let currentPlayerNum = userDefaults.integer(forKey: "playerNum")
        
        if currentCourtType {
            Objects.fullcourtIcon.alpha = 1
            Objects.halfcourtIcon.alpha = 0.3
        } else {
            Objects.fullcourtIcon.alpha = 0.3
            Objects.halfcourtIcon.alpha = 1
        }
        
        currentLineThick == 2 ? (Objects.smallLineIcon.alpha = 1) : (Objects.smallLineIcon.alpha = 0.3)
        currentLineThick == 4 ? (Objects.mediumLineIcon.alpha = 1) : (Objects.mediumLineIcon.alpha = 0.3)
        currentLineThick == 6 ? (Objects.largeLineIcon.alpha = 1) : (Objects.largeLineIcon.alpha = 0.3)
        
        currentlineColor == UIColor.gray ? (Objects.grayLineIcon.alpha = 1) : (Objects.grayLineIcon.alpha = 0.3)
        currentlineColor == UIColor.orange ? (Objects.orangeLineIcon.alpha = 1) : (Objects.orangeLineIcon.alpha = 0.3)
        currentlineColor == UIColor.red ? (Objects.redLineIcon.alpha = 1) : (Objects.redLineIcon.alpha = 0.3)
        
        currentPlayerNum == 3 ? (Objects.threePlayerIcon.alpha = 1) : (Objects.threePlayerIcon.alpha = 0.3)
        currentPlayerNum == 5 ? (Objects.fivePlayerIcon.alpha = 1) : (Objects.fivePlayerIcon.alpha = 0.3)
        
    }
    
    func setBackgroundNode() {
        
        let background: SKSpriteNode?
        
        if Consts.DISPLAY_HEIGHT <= 736 {
            background = SKSpriteNode(imageNamed: "fullcourt_back")
        } else if Consts.DISPLAY_HEIGHT < 1024 {
            background = SKSpriteNode(imageNamed: "fullcourt_iphonex_back")
        } else {
            background = SKSpriteNode(imageNamed: "fullcourt_ipad_back")
        }
        
        if let background = background {
            background.position = CGPoint(x: viewSize!.width*0.5, y: viewSize!.height*0.5)
            background.size = CGSize(width: size.width, height: size.height*2)
            self.addChild(background)
        }
    }
    
    func setCourtIcon() {
        
        Objects.fullcourtIcon.position = CGPoint(x: viewSize!.width*0.25, y: viewSize!.height-150)
        Objects.fullcourtIcon.name = "fullcourtBack"
        self.addChild(Objects.fullcourtIcon)
        
        Objects.halfcourtIcon.position = CGPoint(x: viewSize!.width*0.50, y: viewSize!.height-150)
        Objects.halfcourtIcon.name = "halfcourtBack"
        self.addChild(Objects.halfcourtIcon)
    }
    
    func setLineIcon() {
        
        let lineThick = userDefaults.integer(forKey: "lineThick")
        
        Objects.smallLineIcon.position = CGPoint(x: viewSize!.width*0.25, y: viewSize!.height-250)
        Objects.smallLineIcon.name = "smallLine"
        Objects.smallLineIcon.alpha = 0.3
        if lineThick == 2 {
            Objects.smallLineIcon.alpha = 1
        }
        self.addChild(Objects.smallLineIcon)
        
        Objects.mediumLineIcon.position = CGPoint(x: viewSize!.width*0.50, y: viewSize!.height-250)
        Objects.mediumLineIcon.name = "mediumLine"
        Objects.mediumLineIcon.alpha = 0.3
        if lineThick == 4 {
            Objects.mediumLineIcon.alpha = 1
        }
        self.addChild(Objects.mediumLineIcon)
        
        Objects.largeLineIcon.position = CGPoint(x: viewSize!.width*0.75, y: viewSize!.height-250)
        Objects.largeLineIcon.name = "largeLine"
        Objects.largeLineIcon.alpha = 0.3
        if lineThick == 6 {
            Objects.largeLineIcon.alpha = 1
        }
        self.addChild(Objects.largeLineIcon)
    }
    
    func setColorIcon() {
        
        Objects.grayLineIcon.position = CGPoint(x: viewSize!.width*0.25, y: viewSize!.height-350)
        Objects.grayLineIcon.name = "grayLine"
        self.addChild(Objects.grayLineIcon)
        
        Objects.orangeLineIcon.position = CGPoint(x: viewSize!.width*0.50, y: viewSize!.height-350)
        Objects.orangeLineIcon.name = "orangeLine"
        self.addChild(Objects.orangeLineIcon)
        
        Objects.redLineIcon.position = CGPoint(x: viewSize!.width*0.75, y: viewSize!.height-350)
        Objects.redLineIcon.name = "redLine"
        self.addChild(Objects.redLineIcon)
    }
    
    func setPlayerNumIcon() {
        
        Objects.threePlayerIcon.position = CGPoint(x: viewSize!.width*0.25, y: viewSize!.height-450)
        Objects.threePlayerIcon.name = "threePlayer"
        self.addChild(Objects.threePlayerIcon)
        
        Objects.fivePlayerIcon.position = CGPoint(x: viewSize!.width*0.50, y: viewSize!.height-450)
        Objects.fivePlayerIcon.name = "fivePlayer"
        self.addChild(Objects.fivePlayerIcon)
    }
}
