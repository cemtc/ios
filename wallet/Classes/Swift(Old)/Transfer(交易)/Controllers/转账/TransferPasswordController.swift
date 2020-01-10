//
//  TransferPasswordController.swift
//  QYWallet
//  设置交易密码
//  Created by 崔逢举 on 2019/5/6.
//  Copyright © 2019 崔逢举. All rights reserved.
//

import UIKit
import BigInt
import RealmSwift
class TransferPasswordController: BaseViewController {
    var passwordInputView: CLPasswordInputView!
    var passwordInputViewAgain: CLPasswordInputView!
    @IBOutlet weak var bgone: UIView!
    @IBOutlet weak var bgtwo: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "设置交易密码"
        self.view.backgroundColor = UIColor.themeBlue
        passwordInputView = CLPasswordInputView()
        passwordInputView.delegate = self
        bgone.addSubview(passwordInputView)
        passwordInputViewAgain = CLPasswordInputView()
        passwordInputViewAgain.delegate = self
        bgtwo.addSubview(passwordInputViewAgain)
        passwordInputView.snp.makeConstraints { (make) in
                make.left.centerY.right.equalTo(bgone)
                make.height.equalTo(50)
        }
        passwordInputViewAgain.snp.makeConstraints { (make) in
            make.left.centerY.right.equalTo(bgtwo)
            make.height.equalTo(50)
        }
        passwordInputView.updateWithConfigure { (configure) in

        }
        passwordInputViewAgain.updateWithConfigure { (configure) in
//            print("我不会循环引用\(self)")
//            configure.spaceMultiple = 1000
            //            configure.threePartyKeyboard = true
        }
    }
    //确认交易密码
    @IBAction func surePayPassword(_ sender: UIButton) {
        guard passwordInputView.text != "" else {
            self.view.makeToast("请输入交易密码", duration: 0.3, position: .center)
            return
        }
        guard passwordInputView.text != "" else {
            self.view.makeToast("请确认交易密码", duration: 0.3, position: .center)
            return
        }
        guard passwordInputView.text == passwordInputViewAgain.text else {
            self.view.makeToast("两次输入的交易密码不同", duration: 0.3, position: .center)
            return
        }
        if  BaseSingleton.share.loginer.isLogin == false {
            BaseSingleton.share.loginer.adress = BaseSingleton.share.adress
            BaseSingleton.share.loginer.pwdMD5 = BaseSingleton.share.pwdMD5
            BaseSingleton.share.loginer.mnemonic = BaseSingleton.share.mnemonic?.joined(separator: " ")
            BaseSingleton.share.loginer.payPassword = passwordInputView.text as String
            BaseSingleton.share.loginer.isLogin = true
            BaseSingleton.share.loginer.saveSharedInstance()
            //生成BTC/USDT地址
            let BTCWallet = HDWallet(seed: Mnemonic.seed(mnemonic: BaseSingleton.share.mnemonic!), network: Network.mainnetBTC)
            let btcAdress = try! BTCWallet.receiveAddress().base58
            let changeAdress = try! BTCWallet.changeAddress().base58
            let priviteKey = try! BTCWallet.privateKey(index: 0).description
            let publiceKey = try! BTCWallet.publicKey(index: 0).description
            let realm = BaseSingleton.share.realm
            let ETH  = ETHWalletModel()
            ETH.adress = BaseSingleton.share.adress!
            ETH.mnemonic = BaseSingleton.share.loginer.mnemonic!
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
            USDT.adress = btcAdress
            USDT.changeAdress = changeAdress
            USDT.balance = 0.000000
            USDT.priviteKey = priviteKey
            USDT.publiceKey = publiceKey

            //删
            try! realm.write {
                realm.deleteAll()
            }
            //增
            try! realm.write {
                realm.add(ETH)
                realm.add(BTC)
                realm.add(USDT)
            }
            NotificationCenter.default.post(name: NSNotification.Name("ChangeRoot"), object: nil)
        }
        else {
            BaseSingleton.share.loginer.payPassword = passwordInputView.text as String
                self.navigationController?.popViewController(animated: true)
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    deinit {
        print("自定义密码输入框Swift控制器销毁了")
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
extension TransferPasswordController: CLPasswordInputViewDelegate {
    ///输入改变
    func passwordInputViewDidChange(passwordInputView:CLPasswordInputView) -> Void {

    }
    ///点击删除
    func passwordInputViewDidDeleteBackward(passwordInputView:CLPasswordInputView) -> Void {
    }
    ///输入完成
    func passwordInputViewCompleteInput(passwordInputView:CLPasswordInputView) -> Void {
    }
    ///开始输入
    func passwordInputViewBeginInput(passwordInputView:CLPasswordInputView) -> Void {
    }
    ///结束输入
    func passwordInputViewEndInput(passwordInputView:CLPasswordInputView) -> Void {
    }
}
