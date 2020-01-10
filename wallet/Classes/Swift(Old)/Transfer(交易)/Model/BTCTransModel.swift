//
//  BTCTransModel.swift
//  QYWallet
//
//  Created by 崔逢举 on 2019/5/15.
//  Copyright © 2019 崔逢举. All rights reserved.
//

import UIKit
import SwiftyJSON

class BTCTransModel: NSObject {
    var ver: Int = 0
    var weight: Int = 0
    var block_height: Int = 0
    var relayed_by: String!
    var lock_time: Int = 0
    var result: Int = 0
    var size: Int = 0
    var rbf: Bool = false
    var block_index: Int = 0
    var time: String!
    var tx_index: Int = 0
    var vin_sz: Int = 0
    var hex: String!
    var vout_sz: Int = 0
    var address: String = ""
    var value: UInt32 = 0

    
    override init() {
        
    }
    init(jsonData: JSON) {
        hex = jsonData["hash"].stringValue
        time = jsonData["time"].stringValue
        result = jsonData["result"].intValue
        address = (jsonData["inputs"].arrayValue[0].dictionaryValue["prev_out"]?.dictionaryValue["addr"]!.stringValue)!
        value = UInt32((jsonData["out"].arrayValue[0].dictionaryValue["value"]?.int32Value)!)
    }
}
