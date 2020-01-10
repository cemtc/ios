//
//  TokenRecordCell.swift
//  QYWallet
//
//  Created by 崔逢举 on 2019/5/6.
//  Copyright © 2019 崔逢举. All rights reserved.
//

import UIKit

class TokenRecordCell: UITableViewCell {
    ///币种
    @IBOutlet weak var coinType: UILabel!
    //时间
    @IBOutlet weak var moneyLB: UILabel!
    ///时间
    @IBOutlet weak var timeLB: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
