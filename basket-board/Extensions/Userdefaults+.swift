//
//  Userdefaults+.swift
//  basket-board
//
//  Created by Nobuhiro Harada on 2020/01/18.
//  Copyright © 2020 Nobuhiro Harada. All rights reserved.
//

import UIKit

extension UserDefaults {
    
    func contains(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
    
    func setColor(color: UIColor?, forKey key: String) {
        var colorData: NSData?
        if let color = color {
            colorData = try? NSKeyedArchiver.archivedData(withRootObject: color, requiringSecureCoding: true) as NSData
        }
        set(colorData, forKey: key)
    }
    
    func colorForKey(key: String) -> UIColor? {
        var color: UIColor?
        if let colorData = data(forKey: key) {
            color = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(colorData) as? UIColor
        }
        return color
    }
}
