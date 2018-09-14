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
    var grayLine:  SKSpriteNode = SKSpriteNode(imageNamed: "grayLine")
    var orangeLine:  SKSpriteNode = SKSpriteNode(imageNamed: "orangeLine")
    var redLine:  SKSpriteNode = SKSpriteNode(imageNamed: "redLine")
    
    let userDefaults = UserDefaults.standard
    
    override func didMove(to view: SKView) {
        let SKVIEW_WIDTH  = self.size.width
        let SKVIEW_HEIGHT = self.size.height
        let background = getBackgroundNode()
        
        background.position = CGPoint(x: SKVIEW_WIDTH*0.5, y: SKVIEW_HEIGHT*0.5)
        background.size = self.size
        self.addChild(background)
        
        back.position = CGPoint(x: SKVIEW_WIDTH*0.5-100, y: SKVIEW_HEIGHT-50)
        back.size = CGSize(width: 100, height: 50)
        self.addChild(back)
        
        grayLine.position = CGPoint(x: SKVIEW_WIDTH*0.25, y: SKVIEW_HEIGHT-150)
        grayLine.size = CGSize(width: 70, height: 70)
        grayLine.name = "grayLine"
        self.addChild(grayLine)
        
        orangeLine.position = CGPoint(x: SKVIEW_WIDTH*0.50, y: SKVIEW_HEIGHT-150)
        orangeLine.size = CGSize(width: 70, height: 70)
        orangeLine.name = "orangeLine"
        self.addChild(orangeLine)
        
        redLine.position = CGPoint(x: SKVIEW_WIDTH*0.75, y: SKVIEW_HEIGHT-150)
        redLine.size = CGSize(width: 70, height: 70)
        redLine.name = "redLine"
        self.addChild(redLine)
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
        else if nodes.contains(grayLine)
        {
            userDefaults.setColor(color: UIColor.gray, forKey: "lineColor")
            userDefaults.synchronize()
            goBack()
        }
        else if nodes.contains(orangeLine)
        {
            userDefaults.setColor(color: UIColor.orange, forKey: "lineColor")
            userDefaults.synchronize()
            goBack()
        }
        else if nodes.contains(redLine)
        {
            userDefaults.setColor(color: UIColor.red, forKey: "lineColor")
            userDefaults.synchronize()
            goBack()
        }
        
    }
    
    // 初期画面に戻る
    func goBack()
    {
        self.removeAllChildren()
        
        let initScene = InitScene(size: self.size)
        
        self.view?.presentScene(initScene)
    }
    
    // 23の画面を開く
    func openZone23()
    {
        self.removeAllChildren()
        
        let zone23 = Zone23(size: self.size)
        //        let reveal = SKTransition.reveal(with: .up,
        //                                         duration: 0.5)
        //        let crossFade = SKTransition.crossFade(withDuration: 0.5)
        self.view?.presentScene(zone23)
    }
    
    // 32の画面を開く
    func openZone32()
    {
        self.removeAllChildren()
        
        let zone32 = Zone32(size: self.size)
        self.view?.presentScene(zone32)
    }
    
    func getBackgroundNode() -> SKSpriteNode{
        // determine screen size
        let background: SKSpriteNode?
        
        switch (screenHeight)
        {
        case 480: // iPhone 4s
            background = SKSpriteNode(imageNamed: "fullcourt_back")
        case 568: // iPhone 5s
            background = SKSpriteNode(imageNamed: "fullcourt_back")
        case 667: // iPhone 8
            background = SKSpriteNode(imageNamed: "fullcourt_back")
        case 736: // iPhone 8 Plus
            background = SKSpriteNode(imageNamed: "fullcourt_back")
        case 812: // iPhone X
            background = SKSpriteNode(imageNamed: "fullcourt_iphonex_back")
        case 1024: // iPad
            background = SKSpriteNode(imageNamed: "fullcourt_ipad_back")
        default: // iPad
            background = SKSpriteNode(imageNamed: "fullcourt_ipad_back")
        }
        
        return background!
    }
}
