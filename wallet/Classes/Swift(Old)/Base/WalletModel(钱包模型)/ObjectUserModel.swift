//
//  ObjectUserModel.swift
//  wallet
//
//  Created by 曾云 on 2019/8/18.
//  Copyright © 2019 talking　. All rights reserved.
//

import UIKit
import RealmSwift
class ObjectUserModel: Object {
    @objc dynamic var identifier = ""
    var ETHModel = List<ETHWalletModel>()

    //以太坊
    @objc dynamic var ZWETHidentifier = ""
    var ZWETHModel = List<ZWETHWallModel>()

    //比特币
    @objc dynamic var ZWBTCidentifier = ""
    var ZWBTCModel = List<BTCWalletModel>()
}
