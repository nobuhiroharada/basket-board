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


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
//        let storyboard = grabStoryboard()
//        
//        // display storyboard
//        self.window?.rootViewController = storyboard.instantiateInitialViewController()
//        self.window?.makeKeyAndVisible()
        print(UIScreen.main.bounds.size.height)
        return true
    }
    
//    func grabStoryboard() -> UIStoryboard
//    {
//        // determine screen size
//        let screenHeight = UIScreen.main.bounds.size.height
//        var storyboard: UIStoryboard! = nil
//        print("screenHeight:\(screenHeight)")
//        switch (screenHeight)
//        {
//        // iPhone 4s
//        case 480:
//            storyboard = UIStoryboard(name: "Main-4s", bundle: nil)
//        // iPhone 5s
//        case 568:
//            storyboard = UIStoryboard(name: "Main-5s", bundle: nil)
//        // iPhone 6
//        case 667:
//            storyboard = UIStoryboard(name: "Main-6", bundle: nil)
//        // iPhone 6 Plus
//        case 736:
//            storyboard = UIStoryboard(name: "Main-6-Plus", bundle: nil)
//        default:
//            // it's an iPad
//            storyboard = UIStoryboard(name: "Main", bundle: nil)
//        }
//
//        return storyboard
//    }

}

