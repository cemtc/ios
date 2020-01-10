//
//  TransDetailModel.swift
//  QYWallet
//
//  Created by 崔逢举 on 2019/5/12.
//  Copyright © 2019 崔逢举. All rights reserved.
//

import UIKit
import SwiftyJSON
class TransDetailModel  : NSObject {
    var blockNumber: String!
    var timeStamp: String!
    var from: String!
    var to: String!
    var value: String!
    var contractAddress: String!
    var input: String!
    var type: String!
    var gas: String!
    var gasUsed: String!
    var isError: String!
    var errCode: String!
    override init() {
        
    }
    init(jsonData: JSON) {
        blockNumber = jsonData["blockNumber"].stringValue
        timeStamp = jsonData["timeStamp"].stringValue
        input = jsonData["input"].stringValue
        type = jsonData["type"].stringValue
        from = jsonData["from"].stringValue
        to = jsonData["to"].stringValue
        value = jsonData["value"].stringValue
        gas = jsonData["gas"].stringValue
        gasUsed = jsonData["gasPrice"].stringValue
        contractAddress = jsonData["contractAddress"].stringValue

    }
}

