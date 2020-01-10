//
//  CollectionController.swift
//  QYWallet
//  收款
//  Created by 崔逢举 on 2019/5/6.
//  Copyright © 2019 崔逢举. All rights reserved.
//

import UIKit
import web3swift
//import Web3
import BigInt
import Foundation

class CollectionController: BaseViewController {
    @IBOutlet weak var adressLB: UILabel!
    @IBOutlet weak var QRimg: UIImageView!
    @IBOutlet weak var moneyLB: UILabel!
    @IBOutlet weak var moneyTF: UITextField!
    
    
    
    var token:TokenModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let placeholserAttributes = [NSAttributedStringKey.foregroundColor : UIColor.init(hexColor: "#333333").withAlphaComponent(0.3),NSAttributedStringKey.font : UIFont.systemFont(ofSize: 14)]
        moneyTF.attributedPlaceholder = NSAttributedString(string: "input balance",attributes: placeholserAttributes)
        adressLB.text = self.token?.adress
        let queue = OperationQueue()
        queue.addOperation {
                DispatchQueue.main.async {
                    self.QRimg.layer.shouldRasterize = true
                    self.QRimg.contentMode = .scaleAspectFit
                    
                    self.QRimg.image = SKUtils.createQrCodeSize(CGSize.init(width: 180, height: 180), dataString: self.token!.adress)
                        //self.generateVisualCode(address: self.token!.adress)
                    self.moneyLB.text = "balance" + String(format:"%f",self.token!.balance) + self.token!.name
                }
            }
        }
    private func generateVisualCode(address: String) -> UIImage? {
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
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    //复制地址
    @IBAction func copyAction(_ sender: UIButton) {
        UIPasteboard.general.string = self.token?.adress
        let window = UIApplication.shared.keyWindow
        window?.makeToast(UIImage.init(named: "ico_assets_copyed")!, bottomMSG: "Copy Success")
    }
    //保存图片
    @IBAction func copyIMG(_ sender: UIButton) {
    }
    //确认输入金额
    @IBAction func sureMoney(_ sender: Any) {
        self.moneyLB.text = "balance" + self.moneyTF.text! + self.token!.name
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
