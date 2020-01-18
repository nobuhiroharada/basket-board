//
//  Consts.swift
//  basket-board
//
//  Created by Nobuhiro Harada on 2018/11/11.
//  Copyright © 2018 Nobuhiro Harada. All rights reserved.
//

import Foundation
import UIKit

struct Consts {
    
    static let NODE_SIZE_IPHONE: CGFloat = 35.0
    static let NODE_SIZE_IPAD: CGFloat   = 70.0
    static let DISPLAY_HEIGHT = UIScreen.main.bounds.size.height
}

enum Device {
    case IPHONE
    case IPHONEX
    case IPAD
}

enum Mode {
    case Move
    case Draw
}
