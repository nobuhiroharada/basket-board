//
//  Objects.swift
//  basket-board
//
//  Created by Nobuhiro Harada on 2018/11/11.
//  Copyright © 2018 Nobuhiro Harada. All rights reserved.
//

import Foundation

struct Objects {
    
    static let ball: PlayerBallNode = PlayerBallNode(imageNamed: "ball")
    
    static let playerA0: PlayerBallNode = PlayerBallNode(imageNamed: "playerA1")
    static let playerA1: PlayerBallNode = PlayerBallNode(imageNamed: "playerA2")
    static let playerA2: PlayerBallNode = PlayerBallNode(imageNamed: "playerA3")
    static let playerA3: PlayerBallNode = PlayerBallNode(imageNamed: "playerA4")
    static let playerA4: PlayerBallNode = PlayerBallNode(imageNamed: "playerA5")
    static let playerB0: PlayerBallNode = PlayerBallNode(imageNamed: "playerB1")
    static let playerB1: PlayerBallNode = PlayerBallNode(imageNamed: "playerB2")
    static let playerB2: PlayerBallNode = PlayerBallNode(imageNamed: "playerB3")
    static let playerB3: PlayerBallNode = PlayerBallNode(imageNamed: "playerB4")
    static let playerB4: PlayerBallNode = PlayerBallNode(imageNamed: "playerB5")
 
    static let eraser:   BarItemNode = BarItemNode(imageNamed: "eraser")
    static let rewind:   BarItemNode = BarItemNode(imageNamed: "rewind")
    static let reset:    BarItemNode = BarItemNode(imageNamed: "reset")
    static let setting:  BarItemNode = BarItemNode(imageNamed: "othersSetting")
    static let drawer:   BarItemNode = BarItemNode(imageNamed: "drawer")
    
    static let fullcourtIcon: SettingIconNode = SettingIconNode(imageNamed: "fullcourt_icon")
    static let halfcourtIcon: SettingIconNode = SettingIconNode(imageNamed: "halfcourt_icon")
    
    static let smallLineIcon:  SettingIconNode = SettingIconNode(imageNamed: "smallLine")
    static let mediumLineIcon: SettingIconNode = SettingIconNode(imageNamed: "mediumLine")
    static let largeLineIcon:  SettingIconNode = SettingIconNode(imageNamed: "largeLine")
    
    static let grayLineIcon:   SettingIconNode = SettingIconNode(imageNamed: "grayLine")
    static let orangeLineIcon: SettingIconNode = SettingIconNode(imageNamed: "orangeLine")
    static let redLineIcon:    SettingIconNode = SettingIconNode(imageNamed: "redLine")
    
    static let threePlayerIcon: SettingIconNode = SettingIconNode(imageNamed: "three_player")
    static let fivePlayerIcon:  SettingIconNode = SettingIconNode(imageNamed: "five_player")
}
