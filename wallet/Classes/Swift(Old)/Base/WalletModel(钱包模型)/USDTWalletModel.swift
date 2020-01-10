//
//  USDTWalletModel.swift
//  QYWallet
//
//  Created by 崔逢举 on 2019/5/9.
//  Copyright © 2019 崔逢举. All rights reserved.
//

import UIKit
import RealmSwift
class USDTWalletModel: Object {
    @objc dynamic var adress = ""
    @objc dynamic var changeAdress = ""
    @objc dynamic var balance = 0.0
    @objc dynamic var priviteKey = ""
    @objc dynamic var publiceKey = ""
    @objc dynamic var mnemonic = ""
    @objc dynamic var seedStr = ""
    @objc dynamic var token =  USDTWalletModel._rlmArray()
}
