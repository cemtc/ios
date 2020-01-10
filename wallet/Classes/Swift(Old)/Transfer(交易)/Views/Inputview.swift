//
//  Inputview.swift
//  QYWallet
//
//  Created by 崔逢举 on 2019/5/6.
//  Copyright © 2019 崔逢举. All rights reserved.
//

import UIKit

class Inputview: UIView,NibLoadable,CLPasswordInputViewDelegate{
    //MARK:切换到交易列表
    typealias clickBlock = ()->()
    @IBOutlet weak var inputBgview: UIView!
    var sureHandler : clickBlock?
    var passwordInputView: CLPasswordInputView!
    override func awakeFromNib() {
        super .awakeFromNib()
        passwordInputView = CLPasswordInputView()
        passwordInputView.delegate = self
        inputBgview.addSubview(passwordInputView)

    }
    override func layoutSubviews() {
        passwordInputView.snp.makeConstraints { (make) in
            make.left.centerY.right.equalTo(inputBgview)
            make.height.equalTo(50)
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.endEditing(true)
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    @IBAction func close(_ sender: Any) {
        self.removeFromSuperview()
    }
    ///输入改变
    func passwordInputViewDidChange(passwordInputView:CLPasswordInputView) -> Void {
        
    }
    ///点击删除
    func passwordInputViewDidDeleteBackward(passwordInputView:CLPasswordInputView) -> Void {
    }
    ///输入完成
    func passwordInputViewCompleteInput(passwordInputView:CLPasswordInputView) -> Void {
        
//        let payWord = SKUserInfoManager.shared()?.currentUserInfo()?.talkingPayPassword!
        //caofuqing 这个需要网络去请求验证 caofuqing!!!!!!!交易密码
//        let payWord = ""
        let a = CFQtestOCViewController.init()
//        weak var weakSelf = self
//        a.verifyisPhoneNumberPwd(passwordInputView.text as String) { (la) in
//
//            if la == true {
//                weakSelf!.aaaa()
//            }else{
//                weakSelf!.makeToast("支付密码错误", duration: 0.5, position: .center)
//            }
//        }
        
        self.aaaa();
        
        
        }
    ///开始输入
    func passwordInputViewBeginInput(passwordInputView:CLPasswordInputView) -> Void {
    }
    ///结束输入
    func passwordInputViewEndInput(passwordInputView:CLPasswordInputView) -> Void {
    }
    
    func aaaa() -> Void{
        //完成时执行交易
        if (sureHandler != nil) {
            DispatchQueue.main.async {
                self.sureHandler?()
                self.sureHandler = nil
                self.removeFromSuperview()                }
        }
    }
    
}
