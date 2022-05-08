//
//  DeviceInfo.swift
//  Mongle
//
//  Created by Yunjae Kim on 2022/05/08.
//  Copyright © 2022 이주혁. All rights reserved.
//

import UIKit

struct DeviceInfo {
    static var screenWidth: CGFloat     { return UIScreen.main.bounds.width }
    static var screenHeight: CGFloat    { return UIScreen.main.bounds.height }
    
    static var screenWidthRatio: CGFloat { return DeviceInfo.screenWidth / 375.0 }
    static var screenHeightRatio: CGFloat { return DeviceInfo.screenHeight / 812.0 }
}
