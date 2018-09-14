//
//  AppDelegate.swift
//  basket-board
//
//  Created by Nobuhiro Harada on 2018/08/12.
//  Copyright © 2018年 Nobuhiro Harada. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    let userDefaults = UserDefaults.standard
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // lineColor がなかったら、デフォルトは灰色に設定
        if !userDefaults.contains(key: "lineColor") {
            userDefaults.setColor(color: UIColor.gray, forKey: "lineColor")
        }
        
        return true
    }
    
}

extension UserDefaults {
    
    func contains(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
    
    func setColor(color: UIColor?, forKey key: String) {
        var colorData: NSData?
        if let color = color {
            colorData = NSKeyedArchiver.archivedData(withRootObject: color) as NSData?
        }
        set(colorData, forKey: key)
    }
}
