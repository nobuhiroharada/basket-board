//
//  AppDelegate.swift
//  basket-board
//
//  Created by Nobuhiro Harada on 2018/08/12.
//  Copyright © 2018年 Nobuhiro Harada. All rights reserved.
//

import UIKit

let userDefaults = UserDefaults.standard

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // lineColor がなかったら、デフォルトは灰色に設定
        if !userDefaults.contains(key: Consts.LINE_COLOR) {
            userDefaults.setColor(color: UIColor.gray, forKey: Consts.LINE_COLOR)
        }
        
        // lineThick がなかったら、デフォルトは medium (4)
        if !userDefaults.contains(key: Consts.LINE_THICK) {
            userDefaults.set(4, forKey: Consts.LINE_THICK)
        }
        
        // court がなかったら、デフォルトは fullcourt
        if !userDefaults.contains(key: Consts.COURT_TYPE) {
            userDefaults.set(1, forKey: Consts.COURT_TYPE)
        }
        
        // playerNum がなかったら、デフォルトは 5人
        if !userDefaults.contains(key: Consts.PLAYER_NUM) {
            userDefaults.set(5, forKey: Consts.PLAYER_NUM)
        }
        
        return true
    }
    
}
