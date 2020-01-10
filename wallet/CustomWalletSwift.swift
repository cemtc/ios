//
//  CustomWalletSwift.swift
//  wallet
//
//  Created by 曾云 on 2019/8/18.
//  Copyright © 2019 talking　. All rights reserved.
//

import UIKit

import Toast_Swift//导入swift的第三方库

import web3swift
//import Web3
//import Keystore

import IQKeyboardManagerSwift

import Alamofire

import RealmSwift

import BigInt



class CustomWalletSwift: NSObject {
    
    enum CustomWalletType: String {
        case ETH = "CustomWallet_ETH"
        case GZ = "guangzhou"
        case SZ = "shenzhen"
    }
    
    //注词
    private var listArray: Array<String>?
    private var seedStr : String?
    
    @objc public var items:[TokenModel] = []
    @objc public var it:NSMutableArray?
    
    
    //转账参数
    private var utxos: [UnspentTransaction] = []
    
    @objc public var privateKey:String?
    @objc public var address:String?
    @objc public var ethMnemonic:String?
    
    
    
    @objc public func creatDataBase () {
        // MARK: - 创建数据库
        // MARK: 获取 Realm 文件的父目录
        let folderPath = BaseSingleton.share.realm.configuration.fileURL!.deletingLastPathComponent().path
        print(folderPath)
        // MARK: 禁用此目录的文件保护
        try! FileManager.default.setAttributes([FileAttributeKey.protectionKey : FileProtectionType.none], ofItemAtPath: folderPath)
    }
    
    
    //0.判断是否已经存在当前账号下的钱包????
    @objc public func isWalletAccount(wallet_Identifier:String) -> Bool{
        //默认是不能
        var isHasWallet = false
        let realm = BaseSingleton.share.realm
        //当前电话号码
        let identifier = wallet_Identifier
        try! realm.write {
            let userModel = realm.objects(ObjectUserModel.self).filter("identifier == %@", identifier as Any)
            if userModel.count > 0 {
                print("钱包已存在,不能创建新的了")
                isHasWallet = true
            }else{
                isHasWallet = false
            }
        }
        return isHasWallet
    }
    /**
     创建钱包账号======登录界面创建钱包
     */
    @objc public func creatWalletAccount(key_eth:String,mnemonic:String,wallet_Identifier:String) -> Bool {
        var isSuccess = self.isWalletAccount(wallet_Identifier: wallet_Identifier)
        
        if (isSuccess) {
            return isSuccess;
        }
        // 生成助记词
//        let mnemonics = self.creatMnemonics(mnemonic: mnemonic)
        let mnemonics = Mnemonics(entropySize:.b128 , language: .english)
        print("mnemonics1212121====",mnemonics)
        // 生成种子
        let seed = mnemonics.seed()
        print("seed9999====",seed)

        //生成助记词数组
        var keystore = try! BIP32Keystore(seed: seed, password: "QYWALLET")
        print("keystore====",keystore)
        
        print("length====",mnemonics.description)
        print("length33333====",mnemonics.description.length)

        if (mnemonics.description.length > 0) {
            keystore =  try! BIP32Keystore(mnemonics: mnemonics,password: "QYWALLET")
            listArray = mnemonics.string.components(separatedBy: " ")
        }
        print("mnemonic9999====",listArray as Any)

        
        seedStr = seed.string
        
        let keystoreManager = KeystoreManager([keystore])
        let account = keystoreManager.addresses[0]
        //加密得到私钥
        let privateKey1 = try! keystore.UNSAFE_getPrivateKeyData(password: "QYWALLET", account: account)
        privateKey = privateKey1.string;
        //私钥得到公钥
        let publicKey1 = try! Web3Utils.privateToPublic(privateKey1, compressed: true)
        
        //助词赋值
        BaseSingleton.share.adress = account.address
        BaseSingleton.share.privateKey = privateKey1.string
        BaseSingleton.share.publicKey = publicKey1.string
        BaseSingleton.share.mnemonic = listArray
        
        //caofuqing
        if (key_eth.length >= 1){
            if let ethK = Data.init(hex: key_eth){
                if let publicKeyImportKey = try? Web3Utils.privateToPublic(ethK, compressed: true){
                    if let adressImportKey = try? Web3Utils.publicToAddress(publicKeyImportKey){
                        BaseSingleton.share.adress = adressImportKey.address
                        BaseSingleton.share.privateKey = key_eth
                        BaseSingleton.share.publicKey = publicKeyImportKey.string
                    }
                }
            }
        }
        
        //开始创建钱包
        let realm = BaseSingleton.share.realm
        //当前电话号码
        let identifier = wallet_Identifier
        //add UserModel
        let user = ObjectUserModel()
        user.identifier = identifier
        
        
        let ETH  = ETHWalletModel()
        ETH.adress = BaseSingleton.share.adress!
        if (mnemonics.description.length > 0) {
            ETH.mnemonic = (BaseSingleton.share.mnemonic?.joined(separator: " "))!
        }
        
        ETH.priviteKey = BaseSingleton.share.privateKey!
        ETH.publiceKey = BaseSingleton.share.publicKey!
        ETH.balance = 0.000000
        ETH.name = "EMTC"
        ETH.seedStr = seedStr!
        ETH.imgurl = "https://raw.githubusercontent.com/iozhaq/image/master/EMTC.png"
        
        self.address = ETH.adress;
        self.privateKey = ETH.priviteKey;
        self.ethMnemonic = ETH.mnemonic
        //创建一个CCM TokenModel()
        let eth = TokenModel()
        eth.adress = ETH.adress
        eth.balance = ETH.balance
        eth.priviteKey = ETH.priviteKey
        eth.publiceKey = ETH.publiceKey
        eth.name = ETH.name
        eth.seedStr = ETH.seedStr;
        eth.imgUrl = ETH.imgurl;
        //        ETH.token.append(eth)
        self.items.append(eth)
//        let names:[String] = self.creatNames() //名称
//        let contract:[String] = self.creatContract()//唯一标示
//        let imgUrl:[String] =  self.creatImageURLString()//图片
//        for (idx,item) in names.enumerated() {
//            print("==下标：\(idx)")
//            let objc = TokenModel()
//            objc.adress = BaseSingleton.share.adress!
//            objc.balance = 0.000000
//            objc.priviteKey = BaseSingleton.share.privateKey!
//            objc.publiceKey = BaseSingleton.share.publicKey!
//            objc.name = item
//            objc.seedStr = contract[idx];
//            objc.imgUrl = imgUrl[idx];
//            self.items.append(objc)
//            ETH.token.append(objc)
//        }
        user.ETHModel.append(ETH);
        print("初次登录,创建的ccm 钱包=\n%@",ETH)
        try! realm.write {
            let userModelA = realm.objects(ObjectUserModel.self).filter("identifier == %@", identifier as Any)
            if userModelA.count > 0 {
                print("钱包已存在,不能创建新的了")
                isSuccess = false
            }else{
                realm.add(user)
                isSuccess = true
            }
        }
        return isSuccess;
    }
    
//    public func creatNames () -> Array<String> {
//        return ["SAR", "SAR-ASI", "CCM-ISR","SAR-SAN","HKDD",
//                "SAR-S","ISR-S","CCM-S","SAR-ES","HKDD-S"]
//    }
//
//    public func creatContract () -> Array<String> {
//        return [SAR_CONTRACT,SAR_ASI_CONTRACT,CCM_ISR_CONTRACT,SAR_SAN_CONTRACT,
//                HKDD_CONTRACT,SAR_S_CONTRACT,ISR_S_CONTRACT,
//                CCM_S_CONTRACT,SAR_ES_CONTRACT,HKDD_S_CONTRACT]
//    }
//
//    public func creatImageURLString () -> Array<String> {
//        return [
//            "https://raw.githubusercontent.com/iozhaq/image/master/SAR.png",
//            "https://raw.githubusercontent.com/iozhaq/image/master/SAR-ASI.png",
//            "https://raw.githubusercontent.com/iozhaq/image/master/CCM-ISR.png",
//            "https://raw.githubusercontent.com/iozhaq/image/master/SAR-SAN.png",
//            "https://raw.githubusercontent.com/iozhaq/image/master/HKDD.png",
//            "https://raw.githubusercontent.com/iozhaq/image/master/SAR-S.png",
//            "https://raw.githubusercontent.com/iozhaq/image/master/ISR-S.png",
//            "https://raw.githubusercontent.com/iozhaq/image/master/CCM-S.png",
//            "https://raw.githubusercontent.com/iozhaq/image/master/SAR-ES.png",
//            "https://raw.githubusercontent.com/iozhaq/image/master/HKDD-S.png"]
//    }

    /**
     创建助记词
     */
    
    public func creatMnemonics(mnemonic:String) -> Mnemonics {
        var mnemonics = Mnemonics(entropySize:.b128 , language: .english)
//        print("mnemonics00000=====",mnemonics)
//        print("mnemonics5555555=====",mnemonic.length)

        if (mnemonic.length > 0) {
            mnemonics = try! Mnemonics(mnemonic)
        }
//        print("mnemonics3333333=====",mnemonics)
        return mnemonics;
    }
    
    //获取到当前钱包模型
    @objc public func getCustomCurrentWallet_ETHModel () -> ETHWalletModel {
        //钱包唯一
        //获取本地数据库的当前钱包模型=  钱包模型是在进行登录的时候,就已经创建好的,存储在数据库中
        //所以,需要在添加钱包的时候,看是从数据库否可以获取到当前钱包的模型.如有,提示已经有钱包.无需创建
        //如果没有,就进行创建钱包或者导入钱包操作  (助记词,私钥)导入钱包
        let identifier = CustomUserManager.customShared().userModel().projectName
        let isWallet  = self.isWalletAccount(wallet_Identifier: identifier)
        if (isWallet) {
            let realm = BaseSingleton.share.realm
            let userModel = realm.objects(ObjectUserModel.self).filter("identifier == %@", identifier as Any)
            if userModel.count > 0 {
                return ETHWalletModel(value: userModel[0].ETHModel[0]);
            }else{
                return ETHWalletModel(value: "");
            }
            
        } else {
            return ETHWalletModel(value: "");
        }
    }
    
    @objc public func getRequestWalletBalabce (contract:String) -> Double  {
        let realm = BaseSingleton.share.realm
        let result = realm.objects(ETHWalletModel.self)[0]
        var balance = 0.0000;
        //        let token = ERC20.init(EthereumAddress(contract), from: EthereumAddress(result.adress), password: "QYWALLET")
        let token = ERC20.init(EthereumAddress(contract), from: EthereumAddress(result.adress), password: "QYWALLET")
        token.options.to = EthereumAddress(contract)
        let sar_balance = try? token.balance(of: EthereumAddress(result.adress))
        
        //        let sar_balance = try? token.naturalBalance(of: EthereumAddress(result.adress))
        
        if (sar_balance != nil) {
            if (contract == HKDD_S_CONTRACT ||
                contract == SAR_S_CONTRACT) {
                balance = Double(sar_balance ?? BigUInt(0.000000))
            } else {
                balance = Double(sar_balance ?? BigUInt(0.000000)) / Double(1_000_000_00)
            }
        }
        return balance
    }
    
    @objc public func getETHRequestWalletBalance (type: String) -> Double {
        let web3 = BaseSingleton.share.QYWeb3
        let realm = BaseSingleton.share.realm
        let result = realm.objects(ETHWalletModel.self)[0]
        var balance = 0.0000
        if type  == "ETH" {
            print("请求====ETH余额")
            let balanceResult = try? web3.eth.getBalance(address:EthereumAddress(result.adress))
            if (balanceResult != nil) {
                balance = Double(balanceResult ?? BigUInt(0.000000)) / Double(1_000_000_000_000_000_000)
            }
        }else{
            print("请求CCM余额")
            let balanceResult = try? web3.eth.getccmBalance(address:EthereumAddress(result.adress))
            if (balanceResult != nil) {
                balance = Double(balanceResult ?? BigUInt(0.000000)) / Double(1_000_000_000_000_000_000)
            }
            
        }
        //        let balanceResult = try? web3.eth.getBalance(address:EthereumAddress(result.adress))
        //        if (balanceResult != nil) {
        //            balance = Double(balanceResult ?? BigUInt(0.000000)) / Double(1_000_000_000_000_000_000)
        //        }
        
        return balance;
    }
    
    
    //生成二维码
    @objc public func qrcodePush (token:TokenModel,owner:UIViewController) {
        let  vc = CollectionController()
        vc.token = token
        vc.hidesBottomBarWhenPushed = true;
        owner.show(vc, sender: nil)
    }
    
    @objc public func cellClick(token:TokenModel,owner:UIViewController) {
        let vc = TokendEtailViewController()
        vc.tokenModel = token;
        vc.hidesBottomBarWhenPushed = true;
        vc.navigationItem.title = token.name;
        owner.show(vc, sender: nil)
    }
    
    //    @objc public func creatgenerateMnemonicWord(BTCImPrKey:String,mobileA:String,Mnemonicstr:String) -> Bool{
    //        var isSuccess = false
    //        //btc
    //        // 生成助记词
    //        let mnemonic = Mnemonics(entropySize:.b128 , language: .english)
    //        // 生成种子
    //        let seed = mnemonic.seed()
    //        //生成助记词数组
    //        listArray = mnemonic.string.components(separatedBy: " ")
    //        seedStr = seed.string
    //
    //        let keystore = try! BIP32Keystore(seed: seed, password: "QYWALLET")
    //        let keystoreManager = KeystoreManager([keystore])
    //        let account = keystoreManager.addresses[0]
    //        //加密得到私钥
    //        let privateKey1 = try! keystore.UNSAFE_getPrivateKeyData(password: "QYWALLET", account: account)
    //        //私钥得到公钥
    //        let publicKey1 = try! Web3Utils.privateToPublic(privateKey1, compressed: true)
    //
    //
    //        //助词赋值
    //        BaseSingleton.share.adress = account.address
    //        BaseSingleton.share.privateKey = privateKey1.string
    //        BaseSingleton.share.publicKey = publicKey1.string
    //        BaseSingleton.share.mnemonic = listArray
    //
    //        //开始创建钱包
    //        let realm = BaseSingleton.share.realm
    //        //当前电话号码
    //        let mobile = mobileA
    //        //add UserModel 添加用户和钱包的唯一标示
    //        let USER = UserModel()
    //        USER.mobile = mobile
    //
    //
    //        var btcAdress = ""
    //        var changeAdress = ""
    //        var priviteKey = ""
    //        var publiceKey = ""
    //
    //        if ((BTCImPrKey.length >= 1)){//输入的是私钥.进行的是导入钱包
    //            let kkk:String = BTCImPrKey
    //            let BTCWalletPrKey = Wallet.init(wif: kkk)//使用第三方.传过去私钥,开始创建钱包
    //            let btcAdressPrKey =  BTCWalletPrKey?.address.base58
    //            let priviteKeyPrKey =  BTCWalletPrKey?.privateKey.description
    //            let publiceKeyPrKey =  BTCWalletPrKey?.publicKey
    //            let changeAdressPrKey = publiceKeyPrKey?.toCashaddr().description
    //
    //            btcAdress = btcAdressPrKey!
    //            changeAdress = changeAdressPrKey!
    //            priviteKey = priviteKeyPrKey!
    //            publiceKey = publiceKeyPrKey!.description
    //        }else if((Mnemonicstr.length >= 1)){//这里是助记词导入钱包
    //            print("助记词创建BTC钱包")
    //            //将传递过来的字符串 助记词,转成12个元素的数组
    //            //let mnemonicarr[String] = Mnemonicstr.components(separatedBy: " ")
    //            BaseSingleton.share.loginer.mnemonic = Mnemonicstr
    //            //BaseSingleton.share.loginer.mnemonic = BaseSingleton.share.mnemonic?.joined(separator: " ")
    //            let BTCWallet = HDWallet(seed: Mnemonic.seed(mnemonic: BaseSingleton.share.mnemonic!), network: Network.mainnetBTC)
    //            btcAdress = try! BTCWallet.receiveAddress().base58
    //            changeAdress = try! BTCWallet.changeAddress().base58
    //            priviteKey = try! BTCWallet.privateKey(index: 0).description
    //            publiceKey = try! BTCWallet.publicKey(index: 0).description
    //        }else{//什么也没有,j第一次j创建钱包    ==根据传递过来的私钥进行判断  ==这里,可以进行导入助记词
    //            print("直接手动创建BTC钱包")
    //            //随机生成的助记词,创建钱包
    //            let BTCWallet = HDWallet(seed: Mnemonic.seed(mnemonic: listArray!), network: Network.mainnetBTC)
    //            btcAdress = try! BTCWallet.receiveAddress().base58
    //            changeAdress = try! BTCWallet.changeAddress().base58//转账用的地质
    //            priviteKey = try! BTCWallet.privateKey(index: 0).description
    //            publiceKey = try! BTCWallet.publicKey(index: 0).description
    //        }
    //
    //        let BTC  = BTCWalletModel()
    //        BTC.adress = btcAdress
    //        BTC.balance = 0.000000//余额是根据地质来取出来的
    //        BTC.changeAdress = publiceKey
    //        BTC.priviteKey = priviteKey
    //        BTC.publiceKey = publiceKey
    //        BTC.ImageURl = "https://raw.githubusercontent.com/iozhaq/image/master/BTC.png";
    //
    //        //将创建的钱包,存在user下面
    //        USER.BTCModel.append(BTC)
    //
    //        //存进数据库
    //        try! realm.write {//根据当前钱包的唯一号,取出数据库的本地钱包
    //            let userModelA = realm.objects(UserModel.self).filter("mobile == %@", mobile as Any)
    //            if userModelA.count > 0 {
    //                print("钱包已存在,不能创建新的了")
    //                isSuccess = false
    //            }else{
    //                realm.add(USER)
    //                isSuccess = true
    //            }
    //        }
    //        return isSuccess
    //    }
    
    //获取BTC ETH  钱包余额  网络获取到余额之后,存进本地数据库
    @objc public func getBTCandETHRequestWalletBalance (type:String){
        let web3 = BaseSingleton.share.QYWeb3
        let realm = BaseSingleton.share.realm
        let index = SKUserInfoManager.shared()?.currentUserInfo()?.indexString
        switch type {
        case "BTC":///获取比特币余额  比特币获取余额
            let result = realm.objects(BTCWalletModel.self)[Int(index!)!]
            let url = URL(string:"https://blockchain.info/balance")!
            Alamofire.request(url, method: .get, parameters:["active":result.adress]).validate().responseJSON { response in
                if (response.result.value != nil) {
                    let base = response.result.value as! NSDictionary
                    let a:NSDictionary = base.allValues[0] as!NSDictionary
                    let c:NSNumber = a.object(forKey: "final_balance") as!NSNumber
                    let btcNumber = c.doubleValue / Double(100_000_000)
                    try! realm.write {
                        let model = realm.objects(BTCWalletModel.self)[Int(index!)!]
                        model.balance = btcNumber
                        //                        let dictionary1 = ["success": "1", "type": type,"balance" : String(format: "%.6f", model.balance)]
                        //                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: QYLICAIYUE), object: dictionary1)
                        print("网络获取比特币余额成功,发送通知传递出去")
                        
                    }
                }else {
                    print("网络获取比特币余额失败")
                }
            }
        case "ETH"://获取以太坊钱包余额
            let result = realm.objects(ETHWalletModel.self)[Int(index!)!]
            if let balanceResult = try? web3.eth.getBalance(address:EthereumAddress(result.adress)){
                let balance = Double(balanceResult) / Double(1_000_000_000_000_000_000)
                try! realm.write {
                    let model = realm.objects(ETHWalletModel.self)[Int(index!)!]
                    model.balance = balance
                    //                    let dictionary1 = ["success": "1", "type": type,"balance" : String(format: "%.6f", model.balance)]
                    //                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: QYLICAIYUE), object: dictionary1)
                    print("网络获取以太坊钱包余额成功")
                }
            }
            
        default:
            break
        }
    }
    
    
    //判断是否有当前钱包账号
    //0.根据创建钱包的唯一标识===根据唯一标示   名字
    @objc public func isHasWalletHandle(mobileA:String) -> Bool{
        //默认是不能
        var isHasWallet = false
        let realm = BaseSingleton.share.realm
        //当前电话号码
        let mobile = mobileA
        if mobileA == "BTC" {
            print("检查本地有没有BTC钱包")
            try! realm.write {
                let userModelA = realm.objects(UserModel.self).filter("ZWBTCmobile == %@", mobile as Any)
                if userModelA.count > 0 {
                    print("有BTC钱包,不能创建新的了")
                    isHasWallet = true
                }else{
                    isHasWallet = false
                }
            }
            return isHasWallet
        }else{
            print("检查本地有xxxxx没有ETH钱包???")
            print("检查本地有xxxxx没有ETH钱包\(mobileA)")
            try! realm.write {
                let userModelA = realm.objects(UserModel.self).filter("ZWETHmobile == %@", mobileA as Any)
                if userModelA.count > 0 {
                    print("有ETH,不能创建新的了")
                    isHasWallet = true
                }else{
                    isHasWallet = false
                }
            }
            return isHasWallet
            
        }
        
    }
    
    
    
    
    
    
}
