//
//  TokenModel.swift
//  QYWallet
//
//  Created by 崔逢举 on 2019/5/18.
//  Copyright © 2019 崔逢举. All rights reserved.
//

import UIKit
import RealmSwift
class TokenModel: Object {
    @objc dynamic var adress = ""
    @objc dynamic var changeAdress = ""
    @objc dynamic var balance = 0.0
    @objc dynamic var priviteKey = ""
    @objc dynamic var publiceKey = ""
    @objc dynamic var mnemonic = ""
    @objc dynamic var seedStr = ""
    @objc dynamic var name = ""
    @objc dynamic var imgUrl = ""
    @objc dynamic var exchange = 0.00
}
