//
//  USDTTransModel.swift
//  QYWallet
//
//  Created by 崔逢举 on 2019/5/15.
//  Copyright © 2019 崔逢举. All rights reserved.
//

import UIKit
import SwiftyJSON
class USDTTransModel: NSObject {
    var amount: String!
    var block: Int = 0
    var blockhash: String!
    var blocktime: String!
    var confirmations: Int = 0
    var divisible: Bool = false
    var fee: String!
    var ismine: Bool = false
    var positioninblock: Int = 0
    var propertyid: Int = 0
    var propertyname: String!
    var referenceaddress: String!
    var sendingaddress: String!
    var txid: String!
    var type: String!
    var type_int: Int = 0
    var valid: Bool = false
    var version: Int = 0
    
    
    override init() {
        
    }
    init(jsonData: JSON) {
        txid = jsonData["txid"].stringValue
        blocktime = jsonData["blocktime"].stringValue
        amount = jsonData["amount"].stringValue
        type = jsonData["type"].stringValue
        sendingaddress = jsonData["sendingaddress"].stringValue
    }
}
