//
//  ZWETHWallModel.swift
//  wallet
//
//  Created by 张威威 on 2019/9/26.
//  Copyright © 2019 talking　. All rights reserved.
//

import UIKit
import RealmSwift
class ZWETHWallModel: Object {
    @objc dynamic var adress = ""
    @objc dynamic var balance = 0.0
    @objc dynamic var priviteKey = ""
    @objc dynamic var publiceKey = ""
    @objc dynamic var mnemonic = ""
    @objc dynamic var seedStr = ""
    @objc dynamic var name = ""
    @objc dynamic var imgurl = ""
    @objc dynamic var exchange = 0.00
    @objc dynamic var token =  ZWETHWallModel._rlmArray()



}
