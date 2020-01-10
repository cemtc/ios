//
//  CFQtestSwift.swift
//  wallet
//
//  Created by talking　 on 2019/6/15.
//  Copyright © 2019 talking　. All rights reserved.




import UIKit

import Toast_Swift//导入swift的第三方库

import web3swift
import Web3

import IQKeyboardManagerSwift

import Alamofire

import RealmSwift

import BigInt


class CFQtestSwift: NSObject {
    //注词
    private var listArray: Array<String>?
    private var seedStr : String?
    
    @objc public var items:[TokenModel] = []
    @objc public var it:NSMutableArray?
    //BTC 属性
    private var BTClistArray: Array<String>?
    private var BTCseedStr : String?
    @objc public var BTCitems:[TokenModel] = []
    
    //ETH 属性
    private var ETHlistArray: Array<String>?
    private var ETHseedStr : String?
    @objc public var ETHitems:[TokenModel] = []
    
    //转账参数
    private var utxos: [UnspentTransaction] = []
    
    @objc public var privateKey:String?
    
    @objc public func testPro() {
        let usdtHex = "6a146f6d6e69000000000000001f00000000000003e8"
        let dataHex = Script(hex: usdtHex)
        print(dataHex!)
        print(dataHex!.data.count)//输出的还是全部的 如下 118 0x76  172 0xac
        let pubkeyHash: Data = Script.getPublicKeyHash(from: dataHex!.data)
        print(pubkeyHash)
    }
    
    
    @objc public func erweima(address: String) -> UIImage? {
        let parameters: [String : Any] = [
            "inputMessage": address.data(using: .utf8)!,
            "inputCorrectionLevel": "L"
        ]
        let filter = CIFilter(name: "CIQRCodeGenerator", withInputParameters: parameters)
        
        guard let outputImage = filter?.outputImage else {
            return nil
        }
        
        let scaledImage = outputImage.transformed(by: CGAffineTransform(scaleX: 6, y: 6))
        guard let cgImage = CIContext().createCGImage(scaledImage, from: scaledImage.extent) else {
            return nil
        }
        
        return UIImage(cgImage: cgImage)
        
    }
    
    @objc public func methodprintOC(){
        
        let a = SKUserInfoManager.shared()?.currentUserInfo()?.customerName
        print("swift文件获取OC的个人名字:\(String(describing: a!))")
        
    }
    
    
    @objc public func canshu(str:String){
        let window = UIApplication.shared.keyWindow
        window?.makeToast(str,duration: 0.3,position: .center)
        NSLog("这是一swift文件的log:%@", str)
    }
   
    //0.创建数据库模型 数据库初始化  appdelegate
    @objc public func creatDataBase(){
        
        // MARK: - 创建数据库
        // MARK: 获取 Realm 文件的父目录
        let folderPath = BaseSingleton.share.realm.configuration.fileURL!.deletingLastPathComponent().path
        print(folderPath)
        // MARK: 禁用此目录的文件保护
        try! FileManager.default.setAttributes([FileAttributeKey.protectionKey : FileProtectionType.none], ofItemAtPath: folderPath)
    }
    
    //0.判断是否已经存在当前账号下的钱包????
    @objc public func isHasWalletHandle(mobileA:String) -> Bool{
        //默认是不能
        var isHasWallet = false
        let realm = BaseSingleton.share.realm
        //当前电话号码
        let mobile = mobileA
        try! realm.write {
            let userModelA = realm.objects(UserModel.self).filter("mobile == %@", mobile as Any)
            if userModelA.count > 0 {
                print("钱包已存在,ccccccmmmmmmmm不能创建新的了")
                isHasWallet = true
            }else{
                isHasWallet = false
            }
        }
        return isHasWallet
    }
    @objc public func customCreateWallet(key_ETH:String,mnemonic:String,projectName:String) -> Bool{
        var isSuccess = false
        // 生成助记词
        var mnemonics = Mnemonics(entropySize:.b128 , language: .english)
        // 生成种子
        var seed = mnemonics.seed()
        //生成助记词数组
        var keystore = try! BIP32Keystore(seed: seed, password: "QYWALLET")
        if (mnemonic.length > 0) {
            mnemonics = try! Mnemonics(mnemonic)
            seed = mnemonics.seed()
            keystore =  try! BIP32Keystore(mnemonics: mnemonics,password: "QYWALLET")
            listArray = mnemonics.string.components(separatedBy: " ")
        }
        
        
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
        if (key_ETH.length >= 1){
            if let ethK = Data.init(hex: key_ETH){
                if let publicKeyImportKey = try? Web3Utils.privateToPublic(ethK, compressed: true){
                    if let adressImportKey = try? Web3Utils.publicToAddress(publicKeyImportKey){
                        BaseSingleton.share.adress = adressImportKey.address
                        BaseSingleton.share.privateKey = key_ETH
                        BaseSingleton.share.publicKey = publicKeyImportKey.string
                    }
                }
            }
        }
        
        
        //开始创建钱包
        let realm = BaseSingleton.share.realm
        //当前电话号码
        let identifier = projectName
        //add UserModel
        let user = ObjectUserModel()
        user.identifier = identifier
        
        
        let ETH  = ETHWalletModel()
        ETH.adress = BaseSingleton.share.adress!
        if (mnemonic.length > 0) {
            ETH.mnemonic = (BaseSingleton.share.mnemonic?.joined(separator: " "))!
        }
        print("ETH.mnemonic========",ETH.mnemonic)
        ETH.priviteKey = BaseSingleton.share.privateKey!
        ETH.publiceKey = BaseSingleton.share.publicKey!
        ETH.balance = 0.000000
        ETH.name = "EMTC"
        ETH.imgurl = "https://raw.githubusercontent.com/iozhaq/image/master/EMTC.png"
        
        let eth = TokenModel()
        eth.adress = ETH.adress
        eth.balance = ETH.balance
        eth.priviteKey = ETH.priviteKey
        eth.publiceKey = ETH.publiceKey
        eth.name = ETH.name
        eth.seedStr = ETH.seedStr;
        eth.imgUrl = ETH.imgurl;
        self.items.append(eth)
       
//        let names:[String] = ["SAR", "SAR-ASI", "CCM-ISR","SAR-SAN","HKDD",
//                              "SAR-S","ISR-S","CCM-S","SAR-ES","HKDD-S"]
//        let contract:[String] = [SAR_CONTRACT,
//                                 SAR_ASI_CONTRACT,
//                                 CCM_ISR_CONTRACT,
//                                 SAR_SAN_CONTRACT,
//                                 HKDD_CONTRACT,
//                                 SAR_S_CONTRACT,
//                                 ISR_S_CONTRACT,
//                                 CCM_S_CONTRACT,
//                                 SAR_ES_CONTRACT,
//                                 HKDD_S_CONTRACT]
//
//        let imgUrl:[String] = [
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
//
//        for (idx,item) in names.enumerated() {
//            print("111下标：\(idx)")
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
//
//        }
        user.ETHModel.append(ETH);
        print("xxxxxxxx%@",ETH)
        
        try! realm.write {
            let userModelA = realm.objects(ObjectUserModel.self).filter("identifier == %@", identifier as Any)
            if userModelA.count > 0 {
                print("钱包已存在,xxxxxxxxx不能创建新的了")
                isSuccess = false
            }else{
                realm.add(user)
                isSuccess = true
            }
        }
        return isSuccess;
    }
  

    @objc public func saveCCMWalletCoinInfo(projectName:String){
         let realm = BaseSingleton.share.realm
        print("fileURL9999=========",realm.configuration.fileURL as Any)

//        let realm = BaseSingleton.share.realm
//        let userModel = realm.objects(ObjectUserModel.self).filter("identifier == %@", projectName as Any)
//        let names:[String] = ["SAN-0301","SAN-0306","SAN-0502","SAN-3105","SAN-3301","SAN-2101","SAN-2105","SAN-2406","SAN-410101"]
//        let contract:[String] = [SAN_0301_CONTRACT,SAN_0306_CONTRACT,SAN_0502_CONTRACT,
//                                 SAN_3105_CONTRACT,SAN_3301_CONTRACT,SAN_2101_CONTRACT,
//                                 SAN_2105_CONTRACT,SAN_2406_CONTRACT,SAN_410101_CONTRACT]
//        let imgUrl:[String] = [
//
//            "https://raw.githubusercontent.com/iozhaq/image/master/SAN-0301.png",
//            "https://raw.githubusercontent.com/iozhaq/image/master/SAN-0306.png",
//            "https://raw.githubusercontent.com/iozhaq/image/master/SAN-0502.png",
//            "https://raw.githubusercontent.com/iozhaq/image/master/SAN-3105.png",
//            "https://raw.githubusercontent.com/iozhaq/image/master/SAN-3301.png",
//            "https://raw.githubusercontent.com/iozhaq/image/master/SAN-2101.png",
//            "https://raw.githubusercontent.com/iozhaq/image/master/SAN-2105.png",
//            "https://raw.githubusercontent.com/iozhaq/image/master/SAN-2406.png",
//            "https://raw.githubusercontent.com/iozhaq/image/master/SAN_410101.png"]
//
//        for (idx,item) in names.enumerated() {
//            print("111下标：\(idx)")
//            let objc = TokenModel()
//            objc.adress = (userModel[0].ETHModel[0].adress)
//            objc.balance = 0.000000
//            objc.priviteKey = (userModel[0].ETHModel[0].priviteKey)
//            objc.publiceKey = (userModel[0].ETHModel[0].publiceKey)
//            objc.name = item
//            objc.seedStr = contract[idx];
//            objc.imgUrl = imgUrl[idx];
//            self.items.append(objc)
//
//
//        }
//        return nil;
//        let userModelB = userModelA.realm?.objects(TokenModel.self)
//        if userModelB?.count == 10 {
//            try! realm.write {
//                realm.add(self.items)
//                UserInfo = user1.self;
////                realm.add(user1)
////                realm.delete(user1.ETHModel[0])
//                print("fileURL9999=========",realm.configuration.fileURL as Any)
//            }
//        }
    }
    
    
   
    @objc public func customCurrentETHModel() -> ETHWalletModel{
        let realm = BaseSingleton.share.realm
        /****/
        let projectName = CustomUserManager.customShared().userModel().projectName
        let userModel = realm.objects(ObjectUserModel.self).filter("identifier == %@", projectName as Any)
        if userModel.count > 0 {
            return ETHWalletModel(value: userModel[0].ETHModel[0]);
        }else{
            return ETHWalletModel(value: "");
        }
    }
    
    //====================================
    @objc public func customCurrentZWETHModel() -> ZWETHWallModel{
        let realm = BaseSingleton.share.realm
        let userModel = realm.objects(UserModel.self).filter("ZWETHmobile == %@", "ETH" as Any)
        if userModel.count > 0 {
            return ZWETHWallModel(value: userModel[0].ZWETHModel[0]);
        }else{
            return ZWETHWallModel(value: "");
        }
    }
    
    //获取比特币钱包模型=====================================
    @objc public func customCurrentZWBTCModel() -> BTCWalletModel{
        let realm = BaseSingleton.share.realm
        let userModel = realm.objects(UserModel.self).filter("ZWBTCmobile == %@", "BTC" as Any)
        if userModel.count > 0 {
            return BTCWalletModel(value: userModel[0].BTCModel[0]);
        }else{
            return BTCWalletModel(value: "");
        }
    }
    
    //创建BTC钱包方法
    //BTCImPrKey  私钥 导入
    //  Mnemonic  助记词导入
    // 新创建的钱包
    // mobileA  手机号  或者 唯一识别钱包号..在s数据库里面  可以写死,
    //存储的是钱包名字mobileA.传递过来钱包类型,分别创建 比特币和以太坊钱包
    //创建以太坊钱包.和创建ccm的一样.获取余额和转账,修改节点
    //需要在这里获取 余额
    @objc public func creatgenerateMnemonicWordBTCandETHWithWallName(BTCImPrKey:String,mobileA:String,Mnemonicstr:String,WallType:String) -> Bool{
        var isSuccess = false
        print("将要创建或者导入的钱包名字=\(WallType)")
        if WallType == "BTC" {
            print("开始创建xxxxxBTC钱包")
            // 生成助记词
            let mnemonic = Mnemonics(entropySize:.b128 , language: .english)
            // 生成种子
            let seed = mnemonic.seed()
            //生成助记词数组
            BTClistArray = mnemonic.string.components(separatedBy: " ")
            BTCseedStr = seed.string
            
            let keystore = try! BIP32Keystore(seed: seed, password: "QYWALLET")
            let keystoreManager = KeystoreManager([keystore])
            let account = keystoreManager.addresses[0]
            //加密得到私钥
            let privateKey1 = try! keystore.UNSAFE_getPrivateKeyData(password: "QYWALLET", account: account)
            //私钥得到公钥
            let publicKey1 = try! Web3Utils.privateToPublic(privateKey1, compressed: true)
            //助词赋值
            BaseSingleton.share.adress = account.address
            BaseSingleton.share.privateKey = privateKey1.string
            BaseSingleton.share.publicKey = publicKey1.string
            BaseSingleton.share.mnemonic = BTClistArray
            
            //开始创建钱包
            let realm = BaseSingleton.share.realm
            //当前钱包名字
            let mobile = WallType
            //add UserModel 添加用户和钱包的唯一标示
            let USER = UserModel()
            USER.ZWBTCmobile = mobile
            //将当前钱包名字赋值给用户b类,在使用的时候,取出当前钱包名字,即可拿到钱包模型
            
            
            var btcAdress = ""
            var changeAdress = ""
            var priviteKey = ""
            var publiceKey = ""
            var Balance = 0.00
            var BTCMnemonic = ""
            
            if ((BTCImPrKey.length >= 1)){//输入的是私钥.进行的是导入钱包.没有助记词
                let kkk:String = BTCImPrKey
                let BTCWalletPrKey = Wallet.init(wif: kkk)//使用第三方.传过去私钥,开始创建钱包
                let btcAdressPrKey =  BTCWalletPrKey?.address.base58
                let priviteKeyPrKey =  BTCWalletPrKey?.privateKey.description
                let publiceKeyPrKey =  BTCWalletPrKey?.publicKey
                let changeAdressPrKey = publiceKeyPrKey?.toCashaddr().description
                
                //                Balance = [self.wangluoqingqiuBalance(type: "BTC")];
                //                print("<#T##items: Any...##Any#>")
                btcAdress = btcAdressPrKey!
                changeAdress = changeAdressPrKey!
                priviteKey = priviteKeyPrKey!
                publiceKey = publiceKeyPrKey!.description
            }else if((Mnemonicstr.length >= 1)){//这里是助记词导入钱包
                print("助记词创建xxxxBTC钱包")
                //将传递过来的字符串 助记词,转成12个元素的数组
                BaseSingleton.share.loginer.mnemonic = Mnemonicstr
                let BTCWallet = HDWallet(seed: Mnemonic.seed(mnemonic: BaseSingleton.share.mnemonic!), network: Network.mainnetBTC)
                btcAdress = try! BTCWallet.receiveAddress().base58
                changeAdress = try! BTCWallet.changeAddress().base58
                priviteKey = try! BTCWallet.privateKey(index: 0).description
                publiceKey = try! BTCWallet.publicKey(index: 0).description
                BTCMnemonic = Mnemonicstr
            }else{//什么也没有,j第一次j创建钱包    ==根据传递过来的私钥进行判断  ==这里,可以进行导入助记词
                print("直接手动创建xxxxBTC钱包")
                //随机生成的助记词,创建钱包
                let BTCWallet = HDWallet(seed: Mnemonic.seed(mnemonic: BTClistArray!), network: Network.mainnetBTC)
                btcAdress = try! BTCWallet.receiveAddress().base58
                changeAdress = try! BTCWallet.changeAddress().base58//转账用的地质
                priviteKey = try! BTCWallet.privateKey(index: 0).description
                publiceKey = try! BTCWallet.publicKey(index: 0).description
                BTCMnemonic = mnemonic.string
            }
            let BTC  = BTCWalletModel()
            BTC.adress = btcAdress
            BTC.balance = Balance//余额是根据地质来取出来的
            BTC.changeAdress = changeAdress
            BTC.priviteKey = priviteKey
            BTC.publiceKey = publiceKey
            BTC.name = mobileA
            BTC.mnemonic = BTCMnemonic
            BTC.seedStr = BTCseedStr!
            BTC.ImageURl = "https://raw.githubusercontent.com/iozhaq/image/master/BTC.png"
            //将创建的钱包,存在user下面
            USER.BTCModel.append(BTC)
            print("========创建的BTC钱包=\n%@",BTC)
            
            //存进数据库
            try! realm.write {//根据当前钱包的唯一号,取出数据库的本地钱包
                let userModelA = realm.objects(UserModel.self).filter("ZWBTCmobile == %@", mobile as Any)
                if userModelA.count > 0 {
                    print("钱包已存在,不能创建新的了")
                    isSuccess = false
                }else{
                    realm.add(USER)
                    isSuccess = true
                }
            }
            return isSuccess
        }else{
            print("开始创建ETH钱包")
            // 生成助记词
            var mnemonic = Mnemonics(entropySize:.b128 , language: .english)
            // 生成种子
            var seed = mnemonic.seed()
            //生成助记词数组
            var keystore = try! BIP32Keystore(seed: seed, password: "QYWALLET")
            if (Mnemonicstr.length > 0) {//助记词   此时,会生成助记词,
                mnemonic = try! Mnemonics(Mnemonicstr)
                seed = mnemonic.seed()
                keystore =  try! BIP32Keystore(mnemonics: Mnemonicstr,password: "QYWALLET")
                ETHlistArray = mnemonic.string.components(separatedBy: " ")
            }
            ETHseedStr = seed.string
            let keystoreManager = KeystoreManager([keystore])
            let account = keystoreManager.addresses[0]
            //加密得到私钥
            let privateKey1 = try! keystore.UNSAFE_getPrivateKeyData(password: "QYWALLET", account: account)
            privateKey = privateKey1.string;
            //私钥得到公钥
            let publicKey1 = try! Web3Utils.privateToPublic(privateKey1, compressed: true)
            //助词赋值  助记词 导入钱包
            BaseSingleton.share.adress = account.address
            BaseSingleton.share.privateKey = privateKey1.string
            BaseSingleton.share.publicKey = publicKey1.string
            BaseSingleton.share.mnemonic = ETHlistArray
            if (BTCImPrKey.length >= 1){//私钥 导入钱包  没有助记词
                if let ethK = Data.init(hex: BTCImPrKey){
                    if let publicKeyImportKey = try? Web3Utils.privateToPublic(ethK, compressed: true){
                        if let adressImportKey = try? Web3Utils.publicToAddress(publicKeyImportKey){
                            BaseSingleton.share.adress = adressImportKey.address
                            BaseSingleton.share.privateKey = BTCImPrKey
                            BaseSingleton.share.publicKey = publicKeyImportKey.string
                        }
                    }
                }
            }
            
            //开始创建钱包
            let realm = BaseSingleton.share.realm
            //当前电话号码
            let identifier = WallType
            //add UserModel
            let user = ObjectUserModel()
            user.ZWETHidentifier = identifier
            let ETH  = ZWETHWallModel()
            ETH.adress = BaseSingleton.share.adress!
            if (Mnemonicstr.length > 0) {
                ETH.mnemonic = (BaseSingleton.share.mnemonic?.joined(separator: " "))!
            }
            ETH.priviteKey = BaseSingleton.share.privateKey!
            ETH.publiceKey = BaseSingleton.share.publicKey!
            //ETH.mnemonic = BaseSingleton.share.mnemonic
            ETH.balance = 0.000000
            ETH.name = mobileA //钱包名字
            ETH.seedStr = ETHseedStr!
            ETH.imgurl = "https://raw.githubusercontent.com/iozhaq/image/master/ETH.png"
            user.ZWETHModel.append(ETH);
            print("====创建的TETH钱包=\n %@",ETH)
            print("====创建的TETH钱包=\n %@",user.ZWETHModel)
            print("====创建的identifier钱包=\n %@",identifier)
            //开始存储模型
            let userDefault = UserDefaults.standard
            userDefault.set(ETH.adress, forKey: "adress")
            userDefault.set(ETH.mnemonic, forKey: "mnemonic")
            userDefault.set(ETH.priviteKey, forKey: "priviteKey")
            userDefault.set(ETH.publiceKey, forKey: "publiceKey")
            userDefault.set(ETH.name, forKey: "name")
            userDefault.set(ETH.imgurl, forKey: "imgurl")
            userDefault.set("1", forKey: "ishaveETH")
            userDefault.synchronize()
            
            //存储在数据库中
            try! realm.write {
                let userModelA = realm.objects(UserModel.self).filter("ZWETHmobile == %@", identifier as Any)
                if userModelA.count > 0 {
                    print("钱包已存在,xxxxxxx不能创建新的了")
                    isSuccess = false
                }else{
                    print("添加到数据库 ETH")
                    realm.add(user)
                    isSuccess = true
                }
            }
            return isSuccess
        }
    }
    
    public func creatNames () -> Array<String> {
        return ["ETH"]
    }
    
    public func creatContract () -> Array<String> {
        return [SAR_CONTRACT]
    }
    
    public func creatImageURLString () -> Array<String> {
        return [
            "https://raw.githubusercontent.com/iozhaq/image/master/ETH.png"]
    }
    
    
    /**
     创建助记词
     */
    
    public func creatMnemonics(mnemonic:String) -> Mnemonics {
        var mnemonics = Mnemonics(entropySize:.b128 , language: .english)
        if (mnemonic.length > 0) {
            mnemonics = try! Mnemonics(mnemonic)
        }
        return mnemonics;
    }
    
    
    //1.生成助记词
    @objc public func creatgenerateMnemonicWord(ETHImPrKey:String,BTCImPrKey:String,USDTImPrKey:String,mobileA:String) -> Bool{
        var isSuccess = false
        //caofuqing
        // 生成助记词
        let mnemonic = Mnemonics(entropySize:.b128 , language: .english)
        // 生成种子
        let seed = mnemonic.seed()
        //生成助记词数组
        listArray = mnemonic.string.components(separatedBy: " ")
        seedStr = seed.string
        
        let keystore = try! BIP32Keystore(seed: seed, password: "QYWALLET")
        let keystoreManager = KeystoreManager([keystore])
        let account = keystoreManager.addresses[0]
        //加密得到私钥
        let privateKey1 = try! keystore.UNSAFE_getPrivateKeyData(password: "QYWALLET", account: account)
        //私钥得到公钥
        let publicKey1 = try! Web3Utils.privateToPublic(privateKey1, compressed: true)
        
        
        //助词赋值
        BaseSingleton.share.adress = account.address
        BaseSingleton.share.privateKey = privateKey1.string
        BaseSingleton.share.publicKey = publicKey1.string
        BaseSingleton.share.mnemonic = listArray
        //caofuqing
        if (ETHImPrKey.length >= 1){
            if let ethK = Data.init(hex: ETHImPrKey){
                if let publicKeyImportKey = try? Web3Utils.privateToPublic(ethK, compressed: true){
                    if let adressImportKey = try? Web3Utils.publicToAddress(publicKeyImportKey){
                        BaseSingleton.share.adress = adressImportKey.address
                        BaseSingleton.share.privateKey = ETHImPrKey
                        BaseSingleton.share.publicKey = publicKeyImportKey.string
                    }
                }
            }
        }
        
        
        
        
        
        //开始创建钱包
        let realm = BaseSingleton.share.realm
        //当前电话号码
        let mobile = mobileA
        //add UserModel
        let USER = UserModel()
        USER.mobile = mobile
        
        var btcAdress = ""
        var changeAdress = ""
        var priviteKey = ""
        var publiceKey = ""
        
        var btcAdressUSDT = ""
        var changeAdressUSDT = ""
        var priviteKeyUSDT = ""
        var publiceKeyUSDT = ""
        
        
        if ((BTCImPrKey.length >= 1)){//导入比特币
            let kkk:String = BTCImPrKey
            let BTCWalletPrKey = Wallet.init(wif: kkk)
            let btcAdressPrKey =  BTCWalletPrKey?.address.base58
            let priviteKeyPrKey =  BTCWalletPrKey?.privateKey.description
            let publiceKeyPrKey =  BTCWalletPrKey?.publicKey
            let changeAdressPrKey = publiceKeyPrKey?.toCashaddr().description
            
            btcAdress = btcAdressPrKey!
            changeAdress = changeAdressPrKey!
            priviteKey = priviteKeyPrKey!
            publiceKey = publiceKeyPrKey!.description
        }else{//创建
            let BTCWallet = HDWallet(seed: Mnemonic.seed(mnemonic: BaseSingleton.share.mnemonic!), network: Network.mainnetBTC)
            btcAdress = try! BTCWallet.receiveAddress().base58
            changeAdress = try! BTCWallet.changeAddress().base58
            priviteKey = try! BTCWallet.privateKey(index: 0).description
            publiceKey = try! BTCWallet.publicKey(index: 0).description
        }
        
        if ((USDTImPrKey.length >= 1)){
            let kkk:String = USDTImPrKey
            let BTCWalletPrKey = Wallet.init(wif: kkk)
            let btcAdressPrKey =  BTCWalletPrKey?.address.base58
            let priviteKeyPrKey =  BTCWalletPrKey?.privateKey.description
            let publiceKeyPrKey =  BTCWalletPrKey?.publicKey
            let changeAdressPrKey = publiceKeyPrKey?.toCashaddr().description
            
            btcAdressUSDT = btcAdressPrKey!
            changeAdressUSDT = changeAdressPrKey!
            priviteKeyUSDT = priviteKeyPrKey!
            publiceKeyUSDT = publiceKeyPrKey!.description
        }else{
            let BTCWallet = HDWallet(seed: Mnemonic.seed(mnemonic: BaseSingleton.share.mnemonic!), network: Network.mainnetBTC)
            btcAdressUSDT = try! BTCWallet.receiveAddress().base58
            changeAdressUSDT = try! BTCWallet.changeAddress().base58
            priviteKeyUSDT = try! BTCWallet.privateKey(index: 0).description
            publiceKeyUSDT = try! BTCWallet.publicKey(index: 0).description
        }
        let ETH  = ETHWalletModel()
        ETH.adress = BaseSingleton.share.adress!
        ETH.mnemonic = (BaseSingleton.share.mnemonic?.joined(separator: " "))!
        ETH.priviteKey = BaseSingleton.share.privateKey!
        ETH.publiceKey = BaseSingleton.share.publicKey!
        ETH.balance = 0.000000
        
        let BNB = TokenModel()
        BNB.adress = BaseSingleton.share.adress!
        BNB.balance = 0.000000
        BNB.priviteKey = BaseSingleton.share.privateKey!
        BNB.publiceKey = BaseSingleton.share.publicKey!
        BNB.name = "BNB"
        
        ETH.token.append(BNB)
        
        let OMG = TokenModel()
        OMG.adress = BaseSingleton.share.adress!
        OMG.balance = 0.000000
        OMG.priviteKey = BaseSingleton.share.privateKey!
        OMG.publiceKey = BaseSingleton.share.publicKey!
        OMG.name = "OMG"
        ETH.token.append(OMG)
        
        let BTC  = BTCWalletModel()
        BTC.adress = btcAdress
        BTC.balance = 0.000000
        BTC.changeAdress = publiceKey
        BTC.priviteKey = priviteKey
        BTC.publiceKey = publiceKey
        
        let USDT  = USDTWalletModel()
        USDT.adress = btcAdressUSDT
        USDT.changeAdress = changeAdressUSDT
        USDT.balance = 0.000000
        USDT.priviteKey = priviteKeyUSDT
        USDT.publiceKey = publiceKeyUSDT
        
        
        USER.ETHModel.append(ETH)
        USER.BTCModel.append(BTC)
        USER.USDTModel.append(USDT)
        
        
        //caofuqing
        //        //删
        //        try! realm.write {
        //            realm.deleteAll()
        //        }
        //增
        try! realm.write {
            let userModelA = realm.objects(UserModel.self).filter("mobile == %@", mobile as Any)
            if userModelA.count > 0 {
                print("钱包已存在,yyyyyyyy不能创建新的了")
                isSuccess = false
            }else{
                //            realm.add(ETH)
                //            realm.add(BTC)
                //            realm.add(USDT)
                realm.add(USER)
                isSuccess = true
            }
        }
        return isSuccess
    }
    
    //获取当前用户的模型
    @objc public func currentUserModel() -> UserModel{
        let realm = BaseSingleton.share.realm
        //当前电话号码
        let mobile = SKUserInfoManager.shared()?.currentUserInfo()?.mobile
        let userModelA = realm.objects(UserModel.self).filter("mobile == %@", mobile as Any)
        if userModelA.count > 0 {
            return UserModel(value: userModelA[0]);
        }else{
            return UserModel(value: "");
        }
    }
    @objc public func currentETHModel() -> ETHWalletModel{
        let realm = BaseSingleton.share.realm
        //当前电话号码
        let mobile = SKUserInfoManager.shared()?.currentUserInfo()?.mobile
        let userModelA = realm.objects(UserModel.self).filter("mobile == %@", mobile as Any)
        if userModelA.count > 0 {
            return ETHWalletModel(value: userModelA[0].ETHModel[0]);
        }else{
            return ETHWalletModel(value: "");
        }
    }
    @objc public func currentBTCModel() -> BTCWalletModel{
        let realm = BaseSingleton.share.realm
        //当前电话号码
        let mobile = SKUserInfoManager.shared()?.currentUserInfo()?.mobile
        let userModelA = realm.objects(UserModel.self).filter("mobile == %@", mobile as Any)
        if userModelA.count > 0 {
            return BTCWalletModel(value: userModelA[0].BTCModel[0]);
        }else{
            return BTCWalletModel(value: "");
        }
    }
    @objc public func currentUSDTModel() -> USDTWalletModel{
        let realm = BaseSingleton.share.realm
        //当前电话号码
        let mobile = SKUserInfoManager.shared()?.currentUserInfo()?.mobile
        let userModelA = realm.objects(UserModel.self).filter("mobile == %@", mobile as Any)
        if userModelA.count > 0 {
            return USDTWalletModel(value: userModelA[0].USDTModel[0]);
        }else{
            return USDTWalletModel(value: "");
        }
    }
    
    
    //根据手机号 返回当前数据库里面的index
    @objc public func currentUserModelIndex(mobileA:String) -> NSInteger{
        let realm = BaseSingleton.share.realm
        //当前电话号码
        let mobile = mobileA
        let userModelA = realm.objects(UserModel.self).filter("mobile == %@", mobile as Any)
        let index = realm.objects(UserModel.self).index(of: userModelA[0]);
        return index!
    }
    
    
    //首页 cell 点击事件
    @objc public func cellPush(type:String,indexRow:NSInteger,owner:UIViewController){
        
        let vc = TokendEtailViewController()
        vc.coinTitle = type
        /*   if type == "ETH" {
         if indexRow == 1 {
         vc.token = "BNB"
         }
         if indexRow == 2 {
         vc.token = "OMG"
         }
         }
         */
        //        vc.index = indexRow
        //caofuqing 因为就一个cell 不是之前钱包项目 这个传值为0
        let index = SKUserInfoManager.shared()?.currentUserInfo()?.indexString
        vc.index = 0;//Int(index!)!
        vc.hidesBottomBarWhenPushed = true;
        vc.navigationItem.title = type;
        owner.show(vc, sender: nil)
    }
    
    //获取余额
    @objc public func GetYuEBTC(address:String)->(Double){
        var balabce = 0.00
        let url = URL(string:"https://blockchain.info/balance")!
        Alamofire.request(url, method: .get, parameters:["active":address]).validate().responseJSON { response in
            if (response.result.value != nil) {
                let base = response.result.value as! NSDictionary
                let a:NSDictionary = base.allValues[0] as!NSDictionary
                let c:NSNumber = a.object(forKey: "final_balance") as!NSNumber
                let btcNumber = c.doubleValue / Double(100_000_000)
                balabce = btcNumber
                print("获取BTC钱包余额成功==\n \(balabce)")
            }else {
                print("获取BTC钱包余额失败")
            }
        }
        return balabce
    }
    
    
    //ETH //需要修改节点
    @objc public func GetYueETH(address:String)->(Double){
        print("开始获取ETH钱包的余额")
        var balabce1 = 0.00
        
        let url = URL(string: "https://mainnet.infura.io/v3/41980faa601547009c2630accddfc479")
        let web3 = Web3.new(url!)
        web3?.provider.network = nil
        //web3?.addKeystoreManager(keystoreManager)
        let balanceResult = try? web3?.eth.getBalance(address: EthereumAddress(address))
        print("网络获取以太坊钱包余额成功\(balanceResult)")
        let balance = Double(balanceResult!!) / Double(1_000_000_000_000_000_000)
        //        guard case .success(let balance)? = balanceResult else {
        //            return
        //        }
        balabce1 = balance
        print("网络获取以太坊钱包余额成功\(balabce1)")
        //print(Web3.Utils.formatToEthereumUnits(balanceResult) ?? "")
        return balabce1
    }
    @objc public func GetERC20TokenInfo(address:String)->(String){
        print("开始获取ERC20代币")
        //        let url = URL(string: "https://mainnet.infura.io/v3/41980faa601547009c2630accddfc479")
        let web3 = Web3.InfuraMainnetWeb3()
        web3.provider.network = nil
        let tokenResult = try! web3.contract(Web3Utils.erc20ABI, at: EthereumAddress(address)).method(options: nil)
        do {
            let result = try tokenResult.call(options: nil,onBlock: address)
            print("网络获取ERC20代币成功\(result)")
            return try result.string()
        } catch  {
            
        }
        return ""
    }
    /*
     @objc public func GetYueETH(address:String)->(Double){
     print("开始获取ETH钱包的余额")
     let web3 = BaseSingleton.share.QYWeb3
     //let web3 = Web3(rpcURL: "https://ropsten.infura.io/v3/41980faa601547009c2630accddfc479")
     var balabce1 = 0.00
     if let balanceResult = try? web3.eth.getBalance(address:EthereumAddress(address)){
     let balance = Double(balanceResult) / Double(1_000_000_000_000_000_000)
     balabce1 = balance
     print("网络获取以太坊钱包余额成功\(balabce1)")
     
     }
     return balabce1
     }
     
     
     
     */
    //网络请求余额函数
    @objc public func wangluoqingqiuBalance(type:String){
        let web3 = BaseSingleton.share.QYWeb3
        let realm = BaseSingleton.share.realm
        
        var index = SKUserInfoManager.shared()?.currentUserInfo()?.indexString
        if index == nil {
            index = "0";
        }
        
        switch type {
        case "USDT":
            let result = realm.objects(USDTWalletModel.self)[Int(index!)!]
            let url = URL(string:"https://api.omniexplorer.info/v1/address/addr/details/")!
            Alamofire.request(url, method: .post, parameters:["addr":result.adress]).validate().responseJSON { response in
                if (response.result.value != nil) {
                    let base = response.result.value as! NSDictionary
                    let balance : NSArray = base["balance"] as! NSArray
                    
                    var ubNUm : NSString = ""
                    for elem:NSDictionary in balance as! Array{
                        let symbol:NSString = elem["symbol"] as! NSString;
                        if symbol == "SP31"{
                            ubNUm = elem["value"] as! NSString
                            break
                        }
                    }
                    let usdtbanlace : NSString = ubNUm
                    
                    //                        let usdtIdc : NSDictionary = balance[0] as! NSDictionary
                    //                        let usdtbanlace : NSString = usdtIdc["value"] as! NSString
                    let usdtNumber = usdtbanlace.doubleValue / Double(100_000_000)
                    try! realm.write {
                        let model = realm.objects(USDTWalletModel.self)[Int(index!)!]
                        model.balance = usdtNumber
                        
                        let dictionary1 = ["success": "1", "type": type,"balance" : String(format: "%.6f", model.balance)]
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: QYLICAIYUE), object: dictionary1)
                    }
                }else{
                    CFQCommonServer.usdtChaxunyueAdress(result.adress, callback: { (value) in
                        
                        if value != ""{
                            try! realm.write {
                                let model = realm.objects(USDTWalletModel.self)[Int(index!)!]
                                model.balance = Double(value)!
                                let dictionary1 = ["success": "1", "type": type,"balance" : String(format: "%.6f", model.balance)]
                                NotificationCenter.default.post(name: NSNotification.Name(rawValue: QYLICAIYUE), object: dictionary1)
                            }
                            
                        }
                    })
                    //                        let dictionary1 = ["success": "0", "type": type,"balance" : ""]
                    //                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: QYLICAIYUE), object: dictionary1)
                }
            }
        case "BTC":
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
                        let dictionary1 = ["success": "1", "type": type,"balance" : String(format: "%.6f", model.balance)]
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: QYLICAIYUE), object: dictionary1)
                    }
                }else {
                    //                        let dictionary1 = ["success": "0", "type": type,"balance" : ""]
                    //                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: QYLICAIYUE), object: dictionary1)
                }
            }
            
        case "ETH":///ccm 一样的获取方法
            print("ccm 一样的获取方法")
            let result = realm.objects(ETHWalletModel.self)[Int(index!)!]
            if let balanceResult = try? web3.eth.getBalance(address:EthereumAddress(result.adress)){
                let balance = Double(balanceResult) / Double(1_000_000_000_000_000_000)
                try! realm.write {
                    let model = realm.objects(ETHWalletModel.self)[Int(index!)!]
                    model.balance = balance
                    
                    let dictionary1 = ["success": "1", "type": type,"balance" : String(format: "%f", model.balance)]
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: QYLICAIYUE), object: dictionary1)
                }
            }
            
        default:
            break
        }
        
    }
    @objc public func QueryWalletAddressData(type:String) -> String{
        var addr = ""
        let realm = BaseSingleton.share.realm
        let index = SKUserInfoManager.shared()?.currentUserInfo()?.indexString
        switch type {
        case "BTC":
            try! realm.write {
                let result = realm.objects(BTCWalletModel.self)[Int(index!)!]
                addr = result.adress
            }
            
        case "ETH":
            try! realm.write {
                let result = realm.objects(ETHWalletModel.self)[0]
                addr = result.adress
            }
        default: break
          
        }
        return addr
    }
    @objc public func shujukuBalance(type:String) -> String{
        
        var num = "0"
        //        let web3 = BaseSingleton.share.QYWeb3
        let realm = BaseSingleton.share.realm
        
        let index = SKUserInfoManager.shared()?.currentUserInfo()?.indexString
        
        //        if index == nil {
        //            return num;
        //        }
        
        switch type {
        case "USDT":
            try! realm.write {
                //使用本地数据库
                let result = realm.objects(USDTWalletModel.self)[Int(index!)!]
                num = BaseSingleton.share.getStringFrom(double: result.balance)
            }
        case "BTC":
            try! realm.write {
                //使用本地数据库
                let result = realm.objects(BTCWalletModel.self)[Int(index!)!]
                CustomUserManager.customShared().userModel().btCethAddress = result.adress
                num = BaseSingleton.share.getStringFrom(double: result.balance)
            }
        case "ETH":
            try! realm.write {
                //使用本地数据库
                
                print(realm.objects(ETHWalletModel.self));
                
                let result = realm.objects(ETHWalletModel.self)[0]
                CustomUserManager.customShared().userModel().ethAddress = result.adress
                num = BaseSingleton.share.getStringFrom(double: result.balance)
                /*
                 //使用网络请求 最新的 caofuqing
                 let result = realm.objects(ETHWalletModel.self)[Int(index!)!]
                 let balanceResult = try! web3.eth.getBalance(address:EthereumAddress(result.adress))
                 let balance = Double(balanceResult) / Double(1_000_000_000_000_000_000)
                 num = String(format: "%.6f", balance)
                 */
            }
            
        default: num = "0"
        }
        
        return num;
    }
    
    
    //indexStr 0  理财    1 众筹
    @objc public func zhuanzhang(type:String,adress:String,money:String,pwd:String,indexStr:String){
        let index = SKUserInfoManager.shared()?.currentUserInfo()?.indexString
        if type == "ETH"{
            let web3 = BaseSingleton.share.QYWeb3
            let realm = try! Realm(configuration: BaseSingleton.share.sharedConfiguration())
            var result = ETHWalletModel()
            try! realm.write {
                result =  realm.objects(ETHWalletModel.self)[Int(index!)!]
            }
            //助记词转账
            //            let mnemonics = try! Mnemonics(result.mnemonic)
            //            let keystore = try! BIP32Keystore(mnemonics: mnemonics,password: "QYWALLET")
            
            //私钥转账
            let priviteData:Data = SKUtils.convertHexStr(toData: result.priviteKey)
            guard let keystore = try! EthereumKeystoreV3(privateKey: priviteData, password: "QYWALLET")
                else {
                    return
            }
            
            let keystoreManager = KeystoreManager([keystore])
            web3.addKeystoreManager(keystoreManager) // attach a keystore if you want to sign locally. Otherwise unsigned request will be sent to remote node
            var options = Web3Options.default
            options.from = web3.wallet.getAccounts()[0] // specify from what address you want to send it
            //字符串
            let str = money
            //返回的是个可选值，不一定有值，也可能是nill
            let double = Double(str)
            //返回的double是个可选值，所以需要给个默认值或者用!强制解包
            //之前项目写的有问题 计算方式  这个项目从新更改了下caofuqing
            let float = double! * Double(1_000_000_000_000_000_000)
            
            
            //            let gasprice = Double(self.feeSlider.value) * Double(1_000_000_000_000_000_000)
            let gasprice = Double(QYETHGASPRICE) * Double(1_000_000_000_000_000_000)
            options.gasPrice = (BigUInt(gasprice))/(BigUInt(21000))
            options.value = BigUInt(float)
            options.gasLimit = BigUInt(21000)
            
            let intermediateSend = try! web3.contract(Web3Utils.coldWalletABI, at: EthereumAddress(adress)).method(options: options) // an address with a private key attached in not different from any other address, just has very simple ABI
            do {
                let transResult = try intermediateSend.send(password: "QYWALLET")
                //                let  VC = TransferDetailController()
                //                VC.transhash = transResult.hash
                //                VC.transhType = "ETH"
                //                self.navigationController?.cw_push(VC)
                let dictionary1 = ["success": "1", "type": type, "adress": adress, "money": money, "pwd": pwd, "hash": transResult.hash, "indexStr": indexStr]
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: QYLICAIZHUANZHANG), object: dictionary1)
            }
            catch {
                
                let window  = UIApplication.shared.keyWindow
                window!.makeToast(error.localizedDescription, duration: 1.0, position: .center)
                print(error.localizedDescription)
                
                let dictionary1 = ["success": "0", "type": type, "adress": adress, "money": money, "pwd": pwd, "hash": "", "indexStr": indexStr]
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: QYLICAIZHUANZHANG), object: dictionary1)
            }
        }
        
        
        
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
}
