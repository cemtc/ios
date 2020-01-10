//
//  TransferDetailController.swift
//  QYWallet
//
//  Created by 崔逢举 on 2019/5/6.
//  Copyright © 2019 崔逢举. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import web3swift

class TransferDetailController: BaseViewController {
    var transhash : String!
    var transhType: String?
    var coinType: String?
    var model: TransDetailModel?
    @IBOutlet weak var transAcount: UILabel!
    @IBOutlet weak var banlanceLB: UILabel!
    @IBOutlet weak var transhexLB: UILabel!
//    @IBOutlet weak var blockLB: UILabel!
    @IBOutlet weak var timeLB: UILabel!
    @IBOutlet weak var fromLB: UILabel!
    @IBOutlet weak var toLB: UILabel!
    @IBOutlet weak var amountLB: UILabel!
    @IBOutlet weak var feeLB: UILabel!
    @IBOutlet weak var noticeLB: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        transRecorddetail()
    }
    //MARK: - 请求交易记录
    func transRecorddetail() -> Void {
        //创建URL对象
        let web31 = BaseSingleton.share.QYWeb3
        let json = try? web31.eth.getTransactionDetails(self.transhash)
        
        self.transhexLB.text = self.transhash
        let newStr = String(data: (json?.blockHash)!, encoding: String.Encoding.utf8)
//        self.blockLB.text = newStr
        let date = Date(timeIntervalSinceNow: 0)
        let a = date.timeIntervalSince1970
        let timeStamp = String.init(format: "%.f", a)
        self.timeLB.text = timeStamp.ch_getTimeByStamp(timeStamp, format: "yyyy-MM-dd HH:mm")
        let sender = json?.transaction.sender?.address
        self.fromLB.text = sender
        let to = json?.transaction.to.address;
        self.toLB.text = to
        let mm = Double((json?.transaction.value)!)
        let amount = mm/Double(1_000_000_000_000_000_000)
        self.amountLB.text = String(format: "%f", amount)
        let nn = Double((json?.transaction.gasPrice)!)
        let feel = nn*(21000)/Double(1_000_000_000_000_000_000)
        self.feeLB.text = String(format: "%f", feel)

     /*
    let url = URL(string:"https://api-ropsten.etherscan.io/api?module=account&action=txlistinternal&txhash=\(self.transhash!)")

//        let url = URL(string:"https://api.etherscan.io/api?module=account&action=txlistinternal&txhash=\(self.transhash!)")
        Alamofire.request(url!).validate().responseJSON { response in
            switch response.result.isSuccess {
            case true:
                if let result = response.result.value {
                    let json = result as! NSDictionary
                    let result = json["result"]
                    for elem in result as! Array<Any>{
                        self.model = TransDetailModel(jsonData: JSON(elem))
                        self.transhexLB.text = self.transhash
                        self.blockLB.text = self.model?.blockNumber
                        self.timeLB.text = self.model?.timeStamp.ch_getTimeByStamp(self.model?.timeStamp ?? "", format: "yyyy-MM-dd HH:mm")
                        self.fromLB.text = self.model?.from
                        self.toLB.text = self.model?.to
                        self.amountLB.text = self.model?.value
                        self.feeLB.text = self.model?.gasUsed
                        }
                }
            case false:
                print(response.result.error as Any)
            }
        }

        */
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
    }
    // MARK: - 返回上页
    @IBAction func popTolast(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
