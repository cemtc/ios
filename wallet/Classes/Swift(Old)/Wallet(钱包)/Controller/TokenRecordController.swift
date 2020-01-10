//
//  TokenRecordController.swift
//  QYWallet
//
//  Created by 崔逢举 on 2019/5/6.
//  Copyright © 2019 崔逢举. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import RealmSwift
class TokenRecordController: BaseTableViewController {
    var type :String!
    var coinTitle :String!
    var token :String = ""
    var adress :String!
    var index : Int = 0
    
    private var BTCWallet: Wallet?  = Wallet()
    private lazy var nodataView: UIImageView = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "no data")
        view.isHidden = true
        view.frame = CGRect.init(x: 0, y: 0, width: 101, height: 153)
        return view
    }()
    var arrayList:Array<Any> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.nodataView)
        self.nodataView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        //其他信息
        tableView.register(UINib(nibName: "TokenRecordCell", bundle: nil), forCellReuseIdentifier: "TokenRecordCell")
        tableView.separatorStyle = .none
        tableView.layer.cornerRadius = 8
        transRecord()

    }

//MARK: - 请求交易记录
    func transRecord() -> Void {

        let realm = BaseSingleton.share.realm
        switch self.coinTitle {
        case "USDT":
            try! realm.write {
                let result = realm.objects(USDTWalletModel.self)[index]
                adress = result.adress
                let url = URL(string:"https://api.omniexplorer.info/v1/address/addr/details/")!
                self.view.makeToastActivity(.center)
                weak var weakSelf = self
                Alamofire.request(url, method: .post, parameters:["addr":result.adress]).validate().responseJSON { response in
                    switch response.result.isSuccess {
                    case true:
                    if (response.result.value != nil) {
                        let base = response.result.value as! NSDictionary
                        let transactions : NSArray = base["transactions"] as! NSArray
                        for elem in transactions as! Array<Any>{
                            let model = USDTTransModel(jsonData: JSON(elem))
                            if self.type == "IN" {
                                if model.sendingaddress.uppercased() != self.adress.uppercased() {
                                    weakSelf!.arrayList.append(model)
                                }
                            } else {
                                if model.sendingaddress.uppercased() == self.adress.uppercased() {
                                    weakSelf!.arrayList.append(model)
                                }
                            }
                        }
                        weakSelf?.view.hideToastActivity()
                        weakSelf?.nodataView.isHidden = weakSelf?.arrayList.count ?? 0 > 0 ? true : false
                        weakSelf!.tableView.reloadData()
                    }
                    case false:
                        weakSelf?.view.hideToastActivity()
                        weakSelf?.nodataView.isHidden = weakSelf?.arrayList.count ?? 0 > 0 ? true : false
                        
                    }
                }
            }
        case "BTC":
            try! realm.write {
                let result = realm.objects(BTCWalletModel.self)[index]
                adress = result.adress
                weak var weakSelf = self
                //创建URL对象
                let url = URL(string:"https://blockchain.info/rawaddr/\(self.adress!)")!
                self.view.makeToastActivity(.center)
                Alamofire.request(url).validate().responseJSON { response in
                    switch response.result.isSuccess {
                    case true:
                        let resResult = response.result.value
                        if (resResult != nil) {
                            let json = resResult as! NSDictionary
                            let result = json["txs"]
                            for elem in result as! Array<Any>{
                                let model = BTCTransModel(jsonData: JSON(elem))
                                if self.type == "IN" {
                                    if model.address.uppercased() != self.adress.uppercased() {
                                        weakSelf!.arrayList.append(model)
                                    }
                                } else {
                                    if  model.address.uppercased() == self.adress.uppercased() {
                                        weakSelf!.arrayList.append(model)
                                    }
                                }
                            }
                            weakSelf?.view.hideToastActivity()
                            weakSelf?.nodataView.isHidden = weakSelf?.arrayList.count ?? 0 > 0 ? true : false
                            weakSelf!.tableView.reloadData()
                        }
                    case false:
                        weakSelf?.view.hideToastActivity()
                        weakSelf?.nodataView.isHidden = weakSelf?.arrayList.count ?? 0 > 0 ? true : false

                    }
                }
            }
        case "ETH":
            try! realm.write {
                let result =  realm.objects(ETHWalletModel.self)[index]
                adress = result.adress
                weak var weakSelf = self
                if self.token == "" {
                    //caofuqing 1.测试钱包环境 下面    上面是线上环境   写个宏定义最好
                    //创建URL对象
                    //caofuqing --线上网络
                    let url = URL(string:"http://api.etherscan.io/api?module=account&action=txlist&address=\(adress ?? "")&startblock=0&endblock=99999999&sort=asc")!
//                    let url = URL(string:"http://api-ropsten.etherscan.io/api?module=account&action=txlist&address=\(adress ?? "")&startblock=0&endblock=99999999&sort=asc")!
                    self.view.makeToastActivity(.center)
                    Alamofire.request(url).validate().responseJSON { response in
                        switch response.result.isSuccess {
                        case true:
                            let resResult = response.result.value
                            if (resResult != nil) {
                                let json = resResult as! NSDictionary
                                let result = json["result"]
                                for elem in result as! Array<Any>{
                                    let model = TransactionsModel(jsonData: JSON(elem))
                                    if self.type == "IN" {
                                        if model.from.uppercased() != self.adress.uppercased() {
                                            weakSelf!.arrayList.append(model)
                                        }
                                    } else {
                                        if model.from.uppercased() == self.adress.uppercased() {
                                            weakSelf!.arrayList.append(model)
                                        }
                                    }
                                }
                                weakSelf?.view.hideToastActivity()
                                weakSelf?.nodataView.isHidden = weakSelf?.arrayList.count ?? 0 > 0 ? true : false
                                weakSelf!.tableView.reloadData()
                            }
                        case false:
                            weakSelf?.view.hideToastActivity()
                        }
                    }
                }
                else if self.token == "BNB" {
                    //创建URL对象
                    let url = URL(string:"https://api.etherscan.io/api?module=account&action=tokentx&contractaddress=\(BNB_CONTRACT)&address=\(adress ?? "")&page=1&offset=100&sort=asc")!
                    self.view.makeToastActivity(.center)
                    Alamofire.request(url).validate().responseJSON { response in
                        switch response.result.isSuccess {
                        case true:
                            let resResult = response.result.value
                            if (resResult != nil) {
                                let json = resResult as! NSDictionary
                                let result = json["result"]
                                for elem in result as! Array<Any>{
                                    let model = TransactionsModel(jsonData: JSON(elem))
                                    if self.type == "IN" {
                                        if model.from == self.adress {
                                            weakSelf!.arrayList.append(model)
                                        }
                                    } else {
                                        if model.from != self.adress {
                                            weakSelf!.arrayList.append(model)
                                        }
                                    }
                                }
                                weakSelf?.view.hideToastActivity()
                                weakSelf?.nodataView.isHidden = weakSelf?.arrayList.count ?? 0 > 0 ? true : false
                                weakSelf!.tableView.reloadData()
                            }
                        case false:
                            weakSelf?.view.hideToastActivity()
                        }
                    }
                }
                else {
                    //创建URL对象
                    let url = URL(string:"https://api.etherscan.io/api?module=account&action=tokentx&contractaddress=\(OMG_CONTRACT)&address=\(adress ?? "")&page=1&offset=100&sort=asc")!
                    self.view.makeToastActivity(.center)
                    Alamofire.request(url).validate().responseJSON { response in
                        switch response.result.isSuccess {
                        case true:
                            let resResult = response.result.value
                            if (resResult != nil) {
                                let json = resResult as! NSDictionary
                                let result = json["result"]
                                for elem in result as! Array<Any>{
                                    let model = TransactionsModel(jsonData: JSON(elem))
                                    if self.type == "IN" {
                                        if model.from == self.adress {
                                            weakSelf!.arrayList.append(model)
                                        }
                                    } else {
                                        if model.from != self.adress {
                                            weakSelf!.arrayList.append(model)
                                        }
                                    }
                                }
                                weakSelf?.view.hideToastActivity()
                                weakSelf?.nodataView.isHidden = weakSelf?.arrayList.count ?? 0 > 0 ? true : false
                                weakSelf!.tableView.reloadData()
                            }
                        case false:
                            weakSelf?.view.hideToastActivity()
                        }
                    }
                }
                
      
            }
        default: break
        }
       

        
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arrayList.count
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = TokenHeader.loadFromNib("TokenHeader")
        header.numberLB.text = "共\(arrayList.count)笔"
        if arrayList.count > 0 {
            header.line.isHidden = false
        }
        else {
            header.line.isHidden = true
        }
        return header
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "TokenRecordCell", for: indexPath) as! TokenRecordCell
    switch coinTitle {
    case "USDT":
        let model = arrayList[indexPath.row] as! USDTTransModel
        cell.coinType.text = coinTitle
        cell.timeLB.text = coinTitle.ch_getTimeByStamp(model.blocktime, format: "yyyy-MM-dd HH:mm")
        let str = CDouble(model.amount)
        cell.moneyLB.text = String(format: "%.8f", str!)
    break
    case "BTC":
        let model = arrayList[indexPath.row] as! BTCTransModel
        cell.coinType.text = coinTitle
        cell.timeLB.text = coinTitle.ch_getTimeByStamp(model.time, format: "yyyy-MM-dd HH:mm")
        let str = CDouble(model.value) / CDouble(100_000_000)
        cell.moneyLB.text = String(format: "%.8f", str)
    case "ETH":
        let model = arrayList[arrayList.count - 1 - indexPath.row] as!TransactionsModel
        cell.coinType.text = self.token == "" ? "ETH" : self.token
        cell.timeLB.text = model.timeStamp.ch_getTimeByStamp(model.timeStamp, format: "yyyy-MM-dd HH:mm")
        let str = NSString(string: model.value).doubleValue / 1_000_000_000_000_000_000
        cell.moneyLB.text = String(format: "%.2f", str)
    default:
        break
    }

        return cell
    }
   

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*po
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
