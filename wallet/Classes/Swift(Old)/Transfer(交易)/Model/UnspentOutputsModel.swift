//
//  UnspentOutputsModel.swift
//  QYWallet
//
//  Created by 崔逢举 on 2019/5/15.
//  Copyright © 2019 崔逢举. All rights reserved.
//

import UIKit
import SwiftyJSON
class UnspentOutputsModel: NSObject {
    var tx_hash: String!
    var tx_hash_big_endian: String!
    var tx_output_n: Int = 0
    var script: String!
    var value: Int = 0
    var value_hex: String!
    var confirmations: Int = 0
    var tx_index: Int = 0
    override init() {
        
    }
    init(jsonData: JSON) {
        script = jsonData["script"].stringValue
        value = jsonData["value"].intValue
        tx_hash = jsonData["tx_hash"].stringValue

    }
}
