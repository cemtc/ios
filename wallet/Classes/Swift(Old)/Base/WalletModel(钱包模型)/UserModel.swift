//
//  UserModel.swift
//  wallet
//
//  Created by talking　 on 2019/6/20.
//  Copyright © 2019 talking　. All rights reserved.
//

import UIKit
import RealmSwift
class UserModel: Object {
    @objc dynamic var customerId = ""

    @objc dynamic var mobile = ""
    @objc dynamic var ZWETHmobile = ""
    @objc dynamic var ZWBTCmobile = ""

    //ccm钱包
    var BTCModel = List<BTCWalletModel>()

    //比特币
    var ETHModel = List<ETHWalletModel>()

    //以太坊
    var ZWETHModel = List<ZWETHWallModel>()
    var USDTModel = List<USDTWalletModel>()
    

    
}
