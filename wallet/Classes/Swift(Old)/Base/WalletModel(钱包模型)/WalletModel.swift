//
//  WalletModel.swift
//  QYWallet
//
//  Created by 崔逢举 on 2019/5/9.
//  Copyright © 2019 崔逢举. All rights reserved.
//

import UIKit
import SwiftyJSON
class WalletModel: NSObject {
    var adress : String?
    var balance : Double?
    var priviteKey : String?
    var publiceKey : String?
    var mnemonic : String?
    var seedStr : String?
    override init() {
        
    }
    init(jsonData: JSON) {
        adress = jsonData["adress"].stringValue
        balance = jsonData["balance"].doubleValue
        priviteKey = jsonData["priviteKey"].stringValue
        publiceKey = jsonData["publiceKey"].stringValue
        mnemonic = jsonData["mnemonic"].stringValue
        seedStr = jsonData["seedStr"].stringValue
    }
}
