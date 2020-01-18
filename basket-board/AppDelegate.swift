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
        if !userDefaults.contains(key: "lineColor") {
            userDefaults.setColor(color: UIColor.gray, forKey: "lineColor")
        }
        
        // lineThick がなかったら、デフォルトは medium (4)
        if !userDefaults.contains(key: "lineThick") {
            userDefaults.set(4, forKey: "lineThick")
        }
        
        // court がなかったら、デフォルトは fullcourt
        if !userDefaults.contains(key: "isFullcourt") {
            userDefaults.set(true, forKey: "isFullcourt")
        }
        
        // playerNum がなかったら、デフォルトは 5人
        if !userDefaults.contains(key: "playerNum") {
            userDefaults.set(5, forKey: "playerNum")
        }
        
        return true
    }
    
}
