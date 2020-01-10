//
//  AYDefine.swift
//  iVCoin
//
//  Created by Tyler.Yin on 2017/11/30.
//  Copyright © 2017年 阿勇. All rights reserved.
//

import Foundation
import UIKit

let screenWidth = UIScreen.main.bounds.size.width
let screenHeight = UIScreen.main.bounds.size.height
let BOOLFORFist = "FistWatchiOSApp"
var isIPhoneX: Bool {
    if #available(iOS 11, *) {
        guard let w = UIApplication.shared.delegate?.window, let unwrapedWindow = w else {
            return false
        }
        
        if unwrapedWindow.safeAreaInsets.left > 0 || unwrapedWindow.safeAreaInsets.bottom > 0 {
            print(unwrapedWindow.safeAreaInsets)
            return true
        }
    }
    return false
}
let navTopHeight: CGFloat = isIPhoneX ? 88 : 64

let pingFangMedium = "PingFangSC-Medium"
let pingFangBold = "PingFangSC-Semibold"

let themeFontName = pingFangMedium

let Swift_BaseUrl = "http://144.48.243.168:8080"






