//
//  WalletModel.swift
//  QYWallet
//
//  Created by 崔逢举 on 2019/5/9.
//  Copyright © 2019 崔逢举. All rights reserved.
//

import UIKit
import RealmSwift
class ETHWalletModel: Object {
    @objc dynamic var adress = ""
    @objc dynamic var balance = 0.0
    @objc dynamic var priviteKey = ""
    @objc dynamic var publiceKey = ""
    @objc dynamic var mnemonic = ""
    @objc dynamic var seedStr = ""
    @objc dynamic var name = ""
    @objc dynamic var imgurl = ""
    @objc dynamic var exchange = 0
    var token = List<TokenModel>()
    @objc public func getToken () -> Array<Any> {
        var items:Array<TokenModel> = Array<TokenModel>()
        for item in token {
            items.append(item);
        }
        return items;
    }
    
}
