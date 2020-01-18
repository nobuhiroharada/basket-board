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
    
    let fullcourtIcon: SettingIconNode = SettingIconNode(imageNamed: "fullcourt_icon")
    let halfcourtIcon: SettingIconNode = SettingIconNode(imageNamed: "halfcourt_icon")
    
    let smallLineIcon:  SettingIconNode = SettingIconNode(imageNamed: "smallLine")
    let mediumLineIcon: SettingIconNode = SettingIconNode(imageNamed: "mediumLine")
    let largeLineIcon:  SettingIconNode = SettingIconNode(imageNamed: "largeLine")
    
    let grayLineIcon:   SettingIconNode = SettingIconNode(imageNamed: "grayLine")
    let orangeLineIcon: SettingIconNode = SettingIconNode(imageNamed: "orangeLine")
    let redLineIcon:    SettingIconNode = SettingIconNode(imageNamed: "redLine")
    
    let threePlayerIcon: SettingIconNode = SettingIconNode(imageNamed: "three_player")
    let fivePlayerIcon:  SettingIconNode = SettingIconNode(imageNamed: "five_player")
        
    override init(size: CGSize) {
        super.init(size: size)
        
        setBackgroundNode()
        setCourtIcon()
        setLineIcon()
        setColorIcon()
        setPlayerNumIcon()
        
        backButton.position = CGPoint(x: self.size.width*0.25, y: self.size.height-50)
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
        else if nodes.contains(fullcourtIcon)
        {
            userDefaults.set(1, forKey: Consts.COURT_TYPE)
            userDefaults.synchronize()
            iconOpacityControl()
        }
        else if nodes.contains(halfcourtIcon)
        {
            userDefaults.set(2, forKey: Consts.COURT_TYPE)
            userDefaults.synchronize()
            iconOpacityControl()
        }
        else if nodes.contains(smallLineIcon)
        {
            userDefaults.set(2, forKey: Consts.LINE_THICK)
            userDefaults.synchronize()
            iconOpacityControl()
        }
        else if nodes.contains(mediumLineIcon)
        {
            userDefaults.set(4, forKey: Consts.LINE_THICK)
            userDefaults.synchronize()
            iconOpacityControl()
        }
        else if nodes.contains(largeLineIcon)
        {
            userDefaults.set(6, forKey: Consts.LINE_THICK)
            userDefaults.synchronize()
            iconOpacityControl()
        }
        else if nodes.contains(grayLineIcon)
        {
            userDefaults.setColor(color: UIColor.gray, forKey: Consts.LINE_COLOR)
            userDefaults.synchronize()
            iconOpacityControl()
        }
        else if nodes.contains(orangeLineIcon)
        {
            userDefaults.setColor(color: UIColor.orange, forKey: Consts.LINE_COLOR)
            userDefaults.synchronize()
            iconOpacityControl()
        }
        else if nodes.contains(redLineIcon)
        {
            userDefaults.setColor(color: UIColor.red, forKey: Consts.LINE_COLOR)
            userDefaults.synchronize()
            iconOpacityControl()
        }
        else if nodes.contains(threePlayerIcon)
        {
            userDefaults.set(3, forKey: Consts.PLAYER_NUM)
            userDefaults.synchronize()
            iconOpacityControl()
        }
        else if nodes.contains(fivePlayerIcon)
        {
            userDefaults.set(5, forKey: Consts.PLAYER_NUM)
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
        let currentCourtType = userDefaults.integer(forKey: Consts.COURT_TYPE)
        let currentLineThick = userDefaults.integer(forKey: Consts.LINE_THICK)
        let currentlineColor = userDefaults.colorForKey(key: Consts.LINE_COLOR)
        let currentPlayerNum = userDefaults.integer(forKey: "playerNum")
        
        if currentCourtType == 1 {
            fullcourtIcon.alpha = 1
            halfcourtIcon.alpha = 0.3
        }
        else if currentCourtType == 2 {
            fullcourtIcon.alpha = 0.3
            halfcourtIcon.alpha = 1
        }
        
        currentLineThick == 2 ? (smallLineIcon.alpha = 1) : (smallLineIcon.alpha = 0.3)
        currentLineThick == 4 ? (mediumLineIcon.alpha = 1) : (mediumLineIcon.alpha = 0.3)
        currentLineThick == 6 ? (largeLineIcon.alpha = 1) : (largeLineIcon.alpha = 0.3)
        
        currentlineColor == UIColor.gray ? (grayLineIcon.alpha = 1) : (grayLineIcon.alpha = 0.3)
        currentlineColor == UIColor.orange ? (orangeLineIcon.alpha = 1) : (orangeLineIcon.alpha = 0.3)
        currentlineColor == UIColor.red ? (redLineIcon.alpha = 1) : (redLineIcon.alpha = 0.3)
        
        currentPlayerNum == 3 ? (threePlayerIcon.alpha = 1) : (threePlayerIcon.alpha = 0.3)
        currentPlayerNum == 5 ? (fivePlayerIcon.alpha = 1) : (fivePlayerIcon.alpha = 0.3)
        
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
            background.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.5)
            background.size = CGSize(width: self.size.width, height: self.size.height*2)
            self.addChild(background)
        }
    }
    
    func setCourtIcon() {
        
        fullcourtIcon.position = CGPoint(x: self.size.width*0.25, y: self.size.height-150)
        fullcourtIcon.name = "fullcourtBack"
        self.addChild(fullcourtIcon)
        
        halfcourtIcon.position = CGPoint(x: self.size.width*0.50, y: self.size.height-150)
        halfcourtIcon.name = "halfcourtBack"
        self.addChild(halfcourtIcon)
    }
    
    func setLineIcon() {
        
        let lineThick = userDefaults.integer(forKey: Consts.LINE_THICK)
        
        smallLineIcon.position = CGPoint(x: self.size.width*0.25, y: self.size.height-250)
        smallLineIcon.name = "smallLine"
        smallLineIcon.alpha = 0.3
        if lineThick == 2 {
            smallLineIcon.alpha = 1
        }
        self.addChild(smallLineIcon)
        
        mediumLineIcon.position = CGPoint(x: self.size.width*0.50, y: self.size.height-250)
        mediumLineIcon.name = "mediumLine"
        mediumLineIcon.alpha = 0.3
        if lineThick == 4 {
            mediumLineIcon.alpha = 1
        }
        self.addChild(mediumLineIcon)
        
        largeLineIcon.position = CGPoint(x: self.size.width*0.75, y: self.size.height-250)
        largeLineIcon.name = "largeLine"
        largeLineIcon.alpha = 0.3
        if lineThick == 6 {
            largeLineIcon.alpha = 1
        }
        self.addChild(largeLineIcon)
    }
    
    func setColorIcon() {
        
        grayLineIcon.position = CGPoint(x: self.size.width*0.25, y: self.size.height-350)
        grayLineIcon.name = "grayLine"
        self.addChild(grayLineIcon)
        
        orangeLineIcon.position = CGPoint(x: self.size.width*0.50, y: self.size.height-350)
        orangeLineIcon.name = "orangeLine"
        self.addChild(orangeLineIcon)
        
        redLineIcon.position = CGPoint(x: self.size.width*0.75, y: self.size.height-350)
        redLineIcon.name = "redLine"
        self.addChild(redLineIcon)
    }
    
    func setPlayerNumIcon() {
        
        threePlayerIcon.position = CGPoint(x: self.size.width*0.25, y: self.size.height-450)
        threePlayerIcon.name = "threePlayer"
        self.addChild(threePlayerIcon)
        
        fivePlayerIcon.position = CGPoint(x: self.size.width*0.50, y: self.size.height-450)
        fivePlayerIcon.name = "fivePlayer"
        self.addChild(fivePlayerIcon)
    }
}
