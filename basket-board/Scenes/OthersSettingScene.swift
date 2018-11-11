//
//  SettingScene.swift
//  basket-board
//
//  Created by Nobuhiro Harada on 2018/09/07.
//  Copyright © 2018年 Nobuhiro Harada. All rights reserved.
//

import Foundation
import SpriteKit

class OthersSettingScene: SKScene {
    
    let screenHeight = UIScreen.main.bounds.size.height
    
    var back:  SKSpriteNode = SKSpriteNode(imageNamed: "back")
    
    var fullcourtIcon: SettingIconNode = SettingIconNode(imageNamed: "fullcourt_icon")
    var halfcourtIcon: SettingIconNode = SettingIconNode(imageNamed: "halfcourt_icon")
    
    var smallLineIcon: SettingIconNode = SettingIconNode(imageNamed: "smallLine")
    var mediumLineIcon: SettingIconNode = SettingIconNode(imageNamed: "mediumLine")
    var largeLineIcon: SettingIconNode = SettingIconNode(imageNamed: "largeLine")
    
    var grayLineIcon:  SettingIconNode = SettingIconNode(imageNamed: "grayLine")
    var orangeLineIcon:  SettingIconNode = SettingIconNode(imageNamed: "orangeLine")
    var redLineIcon:  SettingIconNode = SettingIconNode(imageNamed: "redLine")
    
    var threePlayerIcon: SettingIconNode = SettingIconNode(imageNamed: "three_player")
    var fivePlayerIcon: SettingIconNode = SettingIconNode(imageNamed: "five_player")
    
    let userDefaults = UserDefaults.standard
    
    override func didMove(to view: SKView) {
        let SKVIEW_WIDTH  = self.size.width
        let SKVIEW_HEIGHT = self.size.height
        let background = getBackgroundNode()
        
        background.position = CGPoint(x: SKVIEW_WIDTH*0.5, y: SKVIEW_HEIGHT*0.5)
        background.size = self.size
        self.addChild(background)
        
        back.position = CGPoint(x: SKVIEW_WIDTH*0.25, y: SKVIEW_HEIGHT-50)
        back.size = CGSize(width: 100, height: 50)
        self.addChild(back)
        
        fullcourtIcon.position = CGPoint(x: SKVIEW_WIDTH*0.25, y: SKVIEW_HEIGHT-150)
        fullcourtIcon.name = "fullcourtBack"
        self.addChild(fullcourtIcon)
        
        halfcourtIcon.position = CGPoint(x: SKVIEW_WIDTH*0.50, y: SKVIEW_HEIGHT-150)
        halfcourtIcon.name = "halfcourtBack"
        self.addChild(halfcourtIcon)
        
        var tmplineThick = userDefaults.integer(forKey: "lineThick")
        
        smallLineIcon.position = CGPoint(x: SKVIEW_WIDTH*0.25, y: SKVIEW_HEIGHT-250)
        smallLineIcon.name = "smallLine"
        smallLineIcon.alpha = 0.3
        if tmplineThick == 2 {
            smallLineIcon.alpha = 1
        }
        self.addChild(smallLineIcon)
        
        mediumLineIcon.position = CGPoint(x: SKVIEW_WIDTH*0.50, y: SKVIEW_HEIGHT-250)
        mediumLineIcon.name = "mediumLine"
        mediumLineIcon.alpha = 0.3
        if tmplineThick == 4 {
            mediumLineIcon.alpha = 1
        }
        self.addChild(mediumLineIcon)
        
        largeLineIcon.position = CGPoint(x: SKVIEW_WIDTH*0.75, y: SKVIEW_HEIGHT-250)
        largeLineIcon.name = "largeLine"
        largeLineIcon.alpha = 0.3
        if tmplineThick == 6 {
            largeLineIcon.alpha = 1
        }
        self.addChild(largeLineIcon)
        
        var tmplineColor = userDefaults.colorForKey(key: "lineColor")!
        
        grayLineIcon.position = CGPoint(x: SKVIEW_WIDTH*0.25, y: SKVIEW_HEIGHT-350)
        grayLineIcon.name = "grayLine"
        self.addChild(grayLineIcon)
        
        orangeLineIcon.position = CGPoint(x: SKVIEW_WIDTH*0.50, y: SKVIEW_HEIGHT-350)
        orangeLineIcon.name = "orangeLine"
        self.addChild(orangeLineIcon)
        
        redLineIcon.position = CGPoint(x: SKVIEW_WIDTH*0.75, y: SKVIEW_HEIGHT-350)
        redLineIcon.name = "redLine"
        self.addChild(redLineIcon)
        
        threePlayerIcon.position = CGPoint(x: SKVIEW_WIDTH*0.25, y: SKVIEW_HEIGHT-450)
        threePlayerIcon.name = "threePlayer"
        self.addChild(threePlayerIcon)
        
        fivePlayerIcon.position = CGPoint(x: SKVIEW_WIDTH*0.50, y: SKVIEW_HEIGHT-450)
        fivePlayerIcon.name = "fivePlayer"
        self.addChild(fivePlayerIcon)
        
        iconOpacityControl()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        let touch:UITouch = touches.first!
        
        let location = touch.location(in: self)
        let nodes = self.nodes(at: location)
        
        if nodes.contains(back)
        {
            goBack()
        }
        else if nodes.contains(fullcourtIcon)
        {
            userDefaults.set(true, forKey: "isFullcourt")
            userDefaults.synchronize()
            iconOpacityControl()
        }
        else if nodes.contains(halfcourtIcon)
        {
            userDefaults.set(false, forKey: "isFullcourt")
            userDefaults.synchronize()
            iconOpacityControl()
        }
        else if nodes.contains(smallLineIcon)
        {
            userDefaults.set(2, forKey: "lineThick")
            userDefaults.synchronize()
            iconOpacityControl()
        }
        else if nodes.contains(mediumLineIcon)
        {
            userDefaults.set(4, forKey: "lineThick")
            userDefaults.synchronize()
            iconOpacityControl()
        }
        else if nodes.contains(largeLineIcon)
        {
            userDefaults.set(6, forKey: "lineThick")
            userDefaults.synchronize()
            iconOpacityControl()
        }
        else if nodes.contains(grayLineIcon)
        {
            userDefaults.setColor(color: UIColor.gray, forKey: "lineColor")
            userDefaults.synchronize()
            iconOpacityControl()
        }
        else if nodes.contains(orangeLineIcon)
        {
            userDefaults.setColor(color: UIColor.orange, forKey: "lineColor")
            userDefaults.synchronize()
            iconOpacityControl()
        }
        else if nodes.contains(redLineIcon)
        {
            userDefaults.setColor(color: UIColor.red, forKey: "lineColor")
            userDefaults.synchronize()
            iconOpacityControl()
        }
        else if nodes.contains(threePlayerIcon)
        {
            userDefaults.set(3, forKey: "playerNum")
            userDefaults.synchronize()
            iconOpacityControl()
        }
        else if nodes.contains(fivePlayerIcon)
        {
            userDefaults.set(5, forKey: "playerNum")
            userDefaults.synchronize()
            iconOpacityControl()
        }
    }
    
    // 初期画面に戻る
    func goBack()
    {
        self.removeAllChildren()
        
        let initScene = InitScene(size: self.size)
        
        self.view?.presentScene(initScene)
    }
    
    func iconOpacityControl()
    {
        let IsFullcourt_now = userDefaults.bool(forKey: "isFullcourt")
        let lineThick_now = userDefaults.integer(forKey: "lineThick")
        let lineColor_now = userDefaults.colorForKey(key: "lineColor")!
        let playerNum_now = userDefaults.integer(forKey: "playerNum")
        
        if IsFullcourt_now {
            fullcourtIcon.alpha = 1
            halfcourtIcon.alpha = 0.3
        } else {
            fullcourtIcon.alpha = 0.3
            halfcourtIcon.alpha = 1
        }
        
        lineThick_now == 2 ? (smallLineIcon.alpha = 1) : (smallLineIcon.alpha = 0.3)
        lineThick_now == 4 ? (mediumLineIcon.alpha = 1) : (mediumLineIcon.alpha = 0.3)
        lineThick_now == 6 ? (largeLineIcon.alpha = 1) : (largeLineIcon.alpha = 0.3)
        
        lineColor_now == UIColor.gray ? (grayLineIcon.alpha = 1) : (grayLineIcon.alpha = 0.3)
        lineColor_now == UIColor.orange ? (orangeLineIcon.alpha = 1) : (orangeLineIcon.alpha = 0.3)
        lineColor_now == UIColor.red ? (redLineIcon.alpha = 1) : (redLineIcon.alpha = 0.3)
        
        playerNum_now == 3 ? (threePlayerIcon.alpha = 1) : (threePlayerIcon.alpha = 0.3)
        playerNum_now == 5 ? (fivePlayerIcon.alpha = 1) : (fivePlayerIcon.alpha = 0.3)
        
    }
    
    func getBackgroundNode() -> SKSpriteNode{
        // determine screen size
        let background: SKSpriteNode?
        
        if screenHeight <= 736 {
            background = SKSpriteNode(imageNamed: "fullcourt_back")
        } else if screenHeight < 1024 {
            background = SKSpriteNode(imageNamed: "fullcourt_iphonex_back")
        } else {
            background = SKSpriteNode(imageNamed: "fullcourt_ipad_back")
        }
        
        return background!
    }
}
