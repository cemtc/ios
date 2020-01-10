//
//  TransferController.swift
//  QYWallet
//  转账
//  Created by 崔逢举 on 2019/5/6.
//  Copyright © 2019 崔逢举. All rights reserved.
//

import UIKit
import web3swift
import BigInt
import RealmSwift
import Alamofire
import Web3

class TransferController: BaseViewController,UITextFieldDelegate,QRReaderVCDelegate {
    @IBOutlet weak var BalanceLabel: UILabel!
    @IBOutlet weak var adressTF: UITextField!
    @IBOutlet weak var moneyTF: UITextField!
    @IBOutlet weak var feeLB: UILabel!
    @IBOutlet weak var feeSlider: UISlider!
    @IBOutlet weak var slowLB: UILabel!
    @IBOutlet weak var fastLB: UILabel!
    @IBOutlet weak var BZTextView: UITextView!
    
    @IBOutlet weak var MinLB: UILabel!
    
    @IBOutlet weak var MaxLB: UILabel!
    var type : String!
    var token : String = ""
    var index : Int = 0
    var  utxos: [UnspentTransaction] = []
    
    var tokenModel :TokenModel?
    
    var itemModel:CustomNotificationCenterItemModel?
    
    var BGLayer:CALayer!
    
    var balancePushNumber : String = ""
    
    
    func isiPhoneX() ->Bool {
        let screenHeight = UIScreen.main.nativeBounds.size.height;
        if screenHeight == 2436 || screenHeight == 1792 || screenHeight == 2688 || screenHeight == 1624 {
            return true
        }
        return false
    }
    
    @objc func back() {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.itemModel =  CustomNotificationCenterItemModel.init()
        self.itemModel!.tokenName = self.tokenModel!.name
        self.itemModel!.from = self.tokenModel!.adress
        self.navigationItem.title = self.tokenModel!.name
        self.leftBarButtomItem(withNormalName: "icon_return_black", highName: "icon_return_black", selector: #selector(back), target: self)
        //caofuqing
        var height = 0.0
        if (isiPhoneX()) {
            height = 88
        }else {
            height = 64
        }
        let placeholserAttributes = [NSAttributedStringKey.foregroundColor : UIColor.init(hexColor: "#333333").withAlphaComponent(0.3),NSAttributedStringKey.font : UIFont.systemFont(ofSize: 14)]
        adressTF.attributedPlaceholder = NSAttributedString(string: "input account address",attributes: placeholserAttributes)
        moneyTF.attributedPlaceholder = NSAttributedString(string: "input account balance",attributes: placeholserAttributes)
        
        
        self.BalanceLabel.text = String(format: "balance: %f \(self.tokenModel!.name)", self.tokenModel!.balance)
        
        self.moneyTF.rac_textSignal().subscribeNext { (money) in
            
            self.BalanceLabel.text = String(format: "balance: %f \(self.tokenModel!.name)", self.tokenModel!.balance - money!.doubleValue)
        }
        
        
        if self.tokenModel!.name == "BTC" {
            feeLB.text = "0.000033 BTC"
            self.feeSlider.minimumValue = Float(0.00011)
            self.feeSlider.maximumValue =  Float(0.00045)
            self.feeSlider.value =  Float(0.00033)
            self.MinLB.text = "0.00011 BTC"
            self.MaxLB.text = "0.00033 BTC"
        }else if self.tokenModel!.name == "ETH"{
            feeLB.text = "0.000021 ETH"
            self.feeSlider.minimumValue = Float(0.00008)
            self.feeSlider.maximumValue =  Float(0.00042)
            self.feeSlider.value =  Float(0.00021)
            self.MinLB.text = "0.00008 ETH"
            self.MaxLB.text = "0.00042 ETH"
        }else{
            self.feeLB.text = "0.00021 EMTC"
            self.feeSlider.minimumValue = Float(0.00008)
            self.feeSlider.maximumValue =  Float(0.00042)
            self.feeSlider.value =  Float(0.00021)
        }
        
        
        self.feeSlider.addTarget(self, action: #selector(self.valueChanged(slieder:)), for:.valueChanged)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        let window  = UIApplication.shared.keyWindow
        window!.hideToastActivity()
        guard let chilrenviews = self.navigationController?.navigationBar.layer.sublayers else { return  }
        for chilren in chilrenviews {
            if chilren.name == "hehe"{
                chilren.removeFromSuperlayer()
                break;
            }
        }
    }
    ///MARK 扫描代理
    func didScan(_ result:String) {
        self.adressTF.text = result
    }
    
    //监听滑块变化
    @objc func valueChanged(slieder feeslider : UISlider) -> Void {
        let str = String(format: "%.6f", feeslider.value)
        if self.tokenModel!.name == "BTC" {
            feeLB.text = "\(str) BTC"
        }else if self.tokenModel!.name == "ETH"{
            feeLB.text = "\(str) ETH"
        }else{
            feeLB.text = "\(str) EMTC"
        }
    }
    @IBAction func QRScan(_ sender: Any) {
        let vc = QRReaderVC()
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
    }
    
    func heyue() {//转账======
        MBProgressHUD.showMessage("Transfer...");
        let web3 = Web3(rpcURL: "http://47.74.242.199:7575/")
        //        let web3 = Web3(rpcURL: "http://47.245.25.24:7575/")
        let privateKey = try! EthereumPrivateKey(hexPrivateKey: self.tokenModel!.priviteKey)
        print(self.tokenModel?.seedStr as Any)
        
        let contract = web3.eth.Contract(type: GenericERC20Contract.self, address: EthereumAddress(hexString: self.tokenModel!.seedStr))
        firstly {
            web3.eth.getTransactionCount(address: privateKey.address, block: .latest)
            }.then { nonce -> Promise<EthereumSignedTransaction>  in
                var float = 0.000
                //                if (self.tokenModel?.exchange == 0) {
                //                    float = CFStringGetDoubleValue(self.moneyTF!.text as CFString?)
                //                } else {
                //
                //                }
                
                if (self.tokenModel?.seedStr == HKDD_S_CONTRACT ||
                    self.tokenModel?.seedStr == SAR_S_CONTRACT) {
                    float = CFStringGetDoubleValue(self.moneyTF!.text as CFString?)
                    
                } else {
                    float = CFStringGetDoubleValue(self.moneyTF!.text as CFString?) * Double(1_000_000_00)
                }
                
                
                let gasprice =  Double(self.feeSlider.value) * Double(1_000_000_000_000_000_000)/21000
                
                self.itemModel!.gas = CFStringGetDoubleValue(self.moneyTF!.text as CFString?)
                self.itemModel!.gasPrice = Double(self.feeSlider.value)
                self.itemModel!.to = self.adressTF.text!
                //                 self.itemModel?.value = gasprice
                let tx = contract.transfer(to: try EthereumAddress(hex:self.adressTF.text!, eip55: true), value: BigUInt(float)).createTransaction(
                    nonce: nonce,
                    from:  privateKey.address,
                    value: 0,
                    gas: 100000,
                    gasPrice: EthereumQuantity(quantity: BigUInt(gasprice))
                )
                
                print(tx as Any)
                return try tx!.sign(with: privateKey, chainId: 10).promise
                
            }.then { tx in
                web3.eth.sendRawTransaction(transaction: tx)
            }.done { txHash in
                print(txHash.hex())
                if (!txHash.hex().hasPrefix("0x")) {
                    self.view.makeToast("Transfer fail", duration: 0.3, position: .center)
                    return
                }
                self.itemModel!.hash_K = txHash.hex()
                self.transferFinish(hash: txHash.hex())
                
                //                let VC = TransferDetailController()
                //                VC.transhash = txHash.hex()
                //                VC.transhType = self.tokenModel?.name
                //                self.navigationController?.cw_push(VC)
            }.catch { error in
                self.view.makeToast("Insufficient balance", duration: 0.3, position: .center)
                print(error)
        }
    }
    //BTC 转账
    func zhuanzhangBTC(){
        let realm = try! Realm(configuration: BaseSingleton.share.sharedConfiguration())
        do {
            self.utxos.removeAll()
            let privateKey = try PrivateKey(wif: self.tokenModel!.priviteKey)
            let BTCWallet = Wallet(privateKey: privateKey)
            do {
                let ss: NSString = self.moneyTF!.text! as NSString
                let ll: Float = Float(ss.floatValue)
                let number = ll * Float(100_000_000)
                let btcAddress: Address = try AddressFactory.create(self.adressTF.text!)
                let fee = self.feeSlider.value * 100_000_000
                let url = URL(string:"https://blockchain.info/unspent?active=\(self.tokenModel!.adress)")!
                weak var weakSelf = self
                Alamofire.request(url).validate().responseJSON { response in
                    switch response.result.isSuccess {
                    case true:
                        let resResult = response.result.value
                        let json = resResult as! NSDictionary
                        let arrar : NSArray = json.object(forKey: "unspent_outputs") as! NSArray
                        for dic in arrar.reversed() {
                            let undic:NSDictionary = dic as! NSDictionary
                            let script = undic.object(forKey: "script") as! String
                            let amount = undic.object(forKey: "value") as! Int
                            let tx_hash = undic.object(forKey: "tx_hash_big_endian") as! String
                            let tx_output_n = undic.object(forKey: "tx_output_n") as! UInt32
                            
                            self.utxos.append(BTCTransHelper.createUtxo(lockScript: Script(hex: script)!, value: UInt64(amount),txhash: tx_hash,outindex:tx_output_n))
                        }
                        do {
                            print("============\(btcAddress)")
                            //print("============\(btcAddress)")
                            try  BTCWallet.send(to: btcAddress, amount: UInt64(number), fee: UInt64(fee), utxos: self.utxos, completion: { (json) in
                                if json == "Error" {
                                    self.view.makeToast("Transfer fail", duration: 1.0, position: .center)
                                }
                                else {
                                    self.view.makeToast("Transfer success", duration: 1.0, position: .center)
                                    
                                    
                                    //跳转到成功界面
                                    let  VC = TransferDetailController()
                                    VC.transhash = json
                                    VC.transhType = "BTC"
                                    self.navigationController?.cw_push(VC)
                                    
                                }
                                
                            })
                            
                        }
                        catch {
                            self.view.makeToast(error.localizedDescription, duration: 1.0, position: .center)
                            
                        }
                    case false:
                        weakSelf?.view.hideToastActivity()
                    }
                }
            }
            catch {
                self.view.makeToast(error.localizedDescription, duration: 1.0, position: .center)
            }
        }
        catch {
            self.view.makeToast(error.localizedDescription, duration: 1.0, position: .center)
        }
    }
    
    func zhuanzhangBTH() {
        print("开始转账,开始转账,转账======")
        //let web3 = Web3(rpcURL: "http://47.74.242.199:7575/")
        //https://mainnet.infura.io/v3/41980faa601547009c2630accddfc479
        //let web3 = Web3(rpcURL: "https://mainnet.infura.io/v3/41980faa601547009c2630accddfc479")
        //https://ropsten.infura.io/v3/41980faa601547009c2630accddfc479
        let web3 = Web3(rpcURL: "https://mainnet.infura.io/v3/41980faa601547009c2630accddfc479")
        let privateKey = try! EthereumPrivateKey(hexPrivateKey: self.tokenModel!.priviteKey)///获取到当前钱包的私钥
        MBProgressHUD.showMessage("Transfer...");
        firstly {
            web3.eth.getethTransactionCount(address: privateKey.address, block:.latest)
            }.then { nonce -> Promise<EthereumSignedTransaction> in
                let float = CFStringGetDoubleValue(self.moneyTF!.text as CFString?)  * Double(1_000_000_000_000_000_000)
                let gasprice = Double(self.feeSlider.value) * Double(1_000_000_000_000_000_000)/21000
                self.itemModel!.gas = CFStringGetDoubleValue(self.moneyTF!.text as CFString?)
                self.itemModel!.gasPrice = Double(self.feeSlider.value)
                self.itemModel!.to = self.adressTF.text!
                //                self.itemModel?.value = gasprice
                let tx = try EthereumTransaction(
                    nonce: nonce,
                    gasPrice: EthereumQuantity(quantity: BigUInt(gasprice)),
                    gas: 21000,
                    to: EthereumAddress(hex: self.adressTF.text!, eip55: true),
                    value: EthereumQuantity(quantity: BigUInt(float))
                )
                return try! tx.sign(with: privateKey, chainId: 1).promise
            }.then { tx in
                web3.eth.sendethRawTransaction(transaction: tx)
            }.done { hash in
                print("hash\(hash.hex())")
                if (!hash.hex().hasPrefix("0x")) {
                    self.view.makeToast("Transfer fail", duration: 0.3, position: .center)
                    return
                }
                
                self.itemModel!.hash_K = hash.hex()
                self.transferFinish(hash: hash.hex())
            }.catch { error in
                self.view.makeToast("Insufficient balance", duration: 0.3, position: .center)
                print(error)
        }
    }
    func zhuanzhangCCM() {
        print("开始转账,开始转账,转账======")
        let web3 = Web3(rpcURL: "http://47.56.149.244:43135/")
        let privateKey = try! EthereumPrivateKey(hexPrivateKey: self.tokenModel!.priviteKey)///获取到当前钱包的私钥
        MBProgressHUD.showMessage("Transfer...");
        firstly {
            web3.eth.getTransactionCount(address: privateKey.address, block:.pending)
            }.then { nonce -> Promise<EthereumSignedTransaction> in
                let float = CFStringGetDoubleValue(self.moneyTF!.text as CFString?)  * Double(1_000_000_000_000_000_000)
                let gasprice = Double(self.feeSlider.value) * Double(1_000_000_000_000_000_000)/21000
                self.itemModel!.gas = CFStringGetDoubleValue(self.moneyTF!.text as CFString?)
                self.itemModel!.gasPrice = Double(self.feeSlider.value)
                self.itemModel!.to = self.adressTF.text!
                //                self.itemModel?.value = gasprice
                print("====addr00000======",self.adressTF.text?.length as Any)
                print("====addr11111======",try! EthereumAddress(hex: self.adressTF.text!, eip55: false))
                let tx = try EthereumTransaction(
                    type: 0,
                    nonce: nonce,
                    gasPrice: EthereumQuantity(quantity: BigUInt(gasprice)),
                    gas: 21000,
                    to: EthereumAddress(hex: self.adressTF.text!, eip55: false),
                    value: EthereumQuantity(quantity: BigUInt(float))
                )
                
                return try! tx.sign(with: privateKey, chainId: 10).promise
            }.then { tx in
                web3.eth.sendRawTransaction(transaction: tx)
            }.done { hash in
                print("hash\(hash.hex())")
                
                if (!hash.hex().hasPrefix("0x")) {
                    self.view.makeToast("Transfer fail", duration: 0.3, position: .center)
                    return
                }
                
                self.itemModel!.hash_K = hash.hex()
                self.transferFinish(hash: hash.hex())
            }.catch { error in
                self.view.makeToast("Insufficient balance", duration: 0.3, position: .center)
                print(error)
        }
    }
    
    
    
    //MARK:确认转账
    @IBAction func sureTransfer(_ sender: UIButton) {
        guard adressTF.text != "" else {
            self.view.makeToast("input account", duration: 0.3, position: .center)
            return
        }
        guard moneyTF.text != "" else {
            self.view.makeToast("input transfer balance", duration: 0.3, position: .center)
            return
        }
        
        let password = CustomUserManager.customShared().userModel().passwrod;
        CustomUserManager.customShared().showWalletPassWordViewFinish { (input_Text) in
            if (password == input_Text) {
                if (self.tokenModel!.name == "EMTC") {
                    print("------emtc-------",self.tokenModel!.name)
                    self.zhuanzhangCCM()
                } else if(self.tokenModel!.name == "BTC") {
                    self.zhuanzhangBTC()
                }else if(self.tokenModel!.name == "ETH"){
                    self.zhuanzhangBTH()
                }else{
                    self.heyue()
                }
            } else {
                self.view.makeToast("input password error", duration: 0.3, position: .center)
            }
        }
        
        //        if (self.tokenModel!.name == "CCM") {
        //            self.zhuanzhangCCM1()
        //        } else {
        //            self.heyue()
        //        }
        
        //        let input = Inputview.loadFromNib("Inputview")
        //        self.view.addSubview(input)
        
        
        //        input.snp.makeConstraints { (make) in
        //            make.top.left.bottom.right.equalToSuperview()
        //        }
        //        weak var weakSelf = self
        //        input.sureHandler = {()->() in
        //
        //
        ////            self.zhuanzhangCCM()
        //
        //            switch weakSelf?.tokenModel?.name {
        //
        //
        //            case "CCM":
        //                let web3 = BaseSingleton.share.QYWeb3
        //                let realm = try! Realm(configuration: BaseSingleton.share.sharedConfiguration())
        //                var result = ETHWalletModel()
        //                try! realm.write {
        //                    result =  realm.objects(ETHWalletModel.self)[self.index]
        //                }
        //                if self.token == "" {
        ////                    let mnemonics = try! Mnemonics(result.mnemonic)
        ////                    let keystore = try! BIP32Keystore(mnemonics: mnemonics,password: "QYWALLET")
        //                    //私钥转账
        //                    let priviteData:Data = SKUtils.convertHexStr(toData: result.priviteKey)
        //                    guard let keystore = try! EthereumKeystoreV3(privateKey: priviteData, password: "QYWALLET")
        //                        else {
        //                            return
        //                    }
        //
        //                    let keystoreManager = KeystoreManager([keystore])
        //                    web3.addKeystoreManager(keystoreManager) // attach a keystore if you want to sign locally. Otherwise unsigned request will be sent to remote node
        //                    var options = Web3Options.default
        //                    options.from = web3.wallet.getAccounts()[0] // specify from what address you want to send it
        //                    //字符串
        //                    let str = self.moneyTF.text!
        //                    //返回的是个可选值，不一定有值，也可能是nill
        //                    let double = Double(str)
        //                    //返回的double是个可选值，所以需要给个默认值或者用!强制解包
        //                    //之前项目写的有问题 计算方式  这个项目从新更改了下caofuqing
        //                    let float = double! * Double(1_000_000_000_000_000_000)
        //                    let gasprice = Double(self.feeSlider.value) * Double(1_000_000_000_000_000_000)
        //                    options.gasPrice = (BigUInt(gasprice))/(BigUInt(21000))
        //                    options.value = BigUInt(float)
        //                    options.gasLimit = BigUInt(21000)
        //
        //                    let intermediateSend = try! web3.contract(Web3Utils.coldWalletABI, at: EthereumAddress(self.adressTF.text!)).method(options: options) // an address with a private key attached in not different from any other address, just has very simple ABI
        //                    do {
        //                        let transResult = try intermediateSend.send(password: "QYWALLET")
        //                        let  VC = TransferDetailController()
        //                        VC.transhash = transResult.hash
        //                        VC.transhType = "CCM"
        //                        self.navigationController?.cw_push(VC)
        //                    }
        //                    catch {
        //                        self.view.makeToast(error.localizedDescription, duration: 1.0, position: .center)
        //                    }
        //                }
        //                else if self.token == "BNB" {
        //                    let token = ERC20(EthereumAddress(BNB_CONTRACT))
        //                    let from = EthereumAddress(result.adress)
        //                    let to = EthereumAddress(self.adressTF.text!)
        //                    let amount = try! NaturalUnits(self.moneyTF.text!)
        //                    token.options.from = from
        //                    do {
        //                        let transaction = try token.transfer(to: to, amount: amount)
        //                        let  VC = TransferDetailController()
        //                        VC.transhash = transaction.hash
        //                        VC.transhType = "ETH"
        //
        //                        self.navigationController?.cw_push(VC)
        //                    }
        //                    catch {
        //                        self.view.makeToast(error.localizedDescription, duration: 1.0, position: .center)
        //                    }
        //                }
        //                else {
        //                    let token = ERC20(EthereumAddress(OMG_CONTRACT))
        //                    let from = EthereumAddress(result.adress)
        //                    let to = EthereumAddress(self.adressTF.text!)
        //                    let amount = try! NaturalUnits(self.moneyTF.text!)
        //                    token.options.from = from
        //                    do {
        //                        let transaction = try token.transfer(to: to, amount: amount)
        //                        let  VC = TransferDetailController()
        //                        VC.transhash = transaction.hash
        //                        VC.transhType = "ETH"
        //
        //                        self.navigationController?.cw_push(VC)
        //                    }
        //                    catch {
        //                        self.view.makeToast(error.localizedDescription, duration: 1.0, position: .center)
        //                    }
        //                }
        //                break
        //
        //            default:
        //                break
        //            }
        //        }
        
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    
    func transferFinish(hash:String) {
        
        //        let web31 = BaseSingleton.share.QYWeb3
        //        let json = try? web31.eth.getTransactionDetails(hash)
        //        let json1 = try? Web3.default.eth.getTransactionReceipt(hash)
        //        self.itemModel!.blockNumbe = Int(BigUInt((json?.blockNumber)!))
        
        //        let newStr = String(data: (json?.blockHash)!, encoding: String.Encoding.utf8)
        let date = Date(timeIntervalSinceNow: 0)
        let a = date.timeIntervalSince1970
        self.itemModel!.timestamp = Int(a)
        //        let sender = json?.transaction.sender?.address
        //        itemModel.from = sender!
        //        let to = json?.transaction.to.address;
        //        itemModel.to = to!
        //        let mm = Double((json?.transaction.value)!)
        //        let amount = mm/Double(1_000_000_000_000_000_000)
        ////        self.itemModel?.value = self.tokenModel.f
        //        let nn = Double((json?.transaction.gasPrice)!)
        //        let feel = nn*(21000)/Double(1_000_000_000_000_000_000)
        //        self.itemModel!.gasPrice = feel
        //        self.itemModel!.input = String((json?.transaction.inferedChainID)!.rawValue)
        MBProgressHUD .showMessage("Transfer success");
        CustomUserManager.customShared().pushTransferDetailsFinish(self.itemModel!, viewController: self)
    }
    
    
    
}

