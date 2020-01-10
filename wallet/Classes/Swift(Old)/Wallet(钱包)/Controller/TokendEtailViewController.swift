//
//  TokendEtailViewController.swift
//  QYWallet
//
//  Created by 崔逢举 on 2019/5/6.
//  Copyright © 2019 崔逢举. All rights reserved.
//

import UIKit
import RealmSwift
import web3swift
//import Web3
import Alamofire
import SwiftyJSON
import MJRefresh
class TokendEtailViewController: BaseViewController,UITableViewDataSource,UITableViewDelegate {
 
    
    
    
    @IBOutlet weak var headerBGview: UIView!
    //标题
    var coinTitle: String?
    //余量
    var banlance: String?
    //价格
    var price: String?
    //公钥
    var publickey: String?
    //私钥
    var privatekey: String?
    
    var walletModel : WalletModel?
    var index : Int = 0
    var token : String = ""
    
    var tokenModel :TokenModel?
    var etail: TokendEtailModel?
    var page: Int = 1
    
    
    //币种名称
    @IBOutlet weak var cionLB: UILabel!
    //余额
    @IBOutlet weak var balanceLB: UILabel!
    //折合人民币
    @IBOutlet weak var CNNLB: UILabel!
    
    @IBOutlet weak var address: UILabel!
    
    @IBOutlet weak var mainTableView: UITableView!
    
    
    
    
    
    
    
    var segmentedDataSource: JXSegmentedBaseDataSource?
    let segmentedView = JXSegmentedView()
    lazy var listContainerView: JXSegmentedListContainerView! = {
        return JXSegmentedListContainerView(dataSource: self as JXSegmentedListContainerViewDataSource)
    }()
    
    @objc func back() {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func erweima(_ sender: UIButton) {
        UIPasteboard.general.string = self.tokenModel?.adress
        let window = UIApplication.shared.keyWindow
        window?.makeToast(UIImage.init(named: "ico_assets_copyed")!, bottomMSG: "Copy success")
//        let  vc = CollectionController()
//        vc.token = self.tokenModel
//        self.navigationController?.cw_push(vc)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.etail = TokendEtailModel.init()
        self.leftBarButtomItem(withNormalName: "icon_return_black", highName: "icon_return_black", selector: #selector(back), target: self)
        self.cionLB.text = String(format: "%f %@",self.tokenModel!.balance,self.tokenModel!.name);
        self.balanceLB.text = String(format: "≈￥ %f", self.tokenModel!.balance * Double.init(self.tokenModel!.exchange))
        self.address.text = self.tokenModel?.adress;
        
        self.mainTableView.register(UINib.init(nibName: "TokenEtailTableViewCell", bundle: nil), forCellReuseIdentifier: "Identifier_TokenEtail")
        // Do any additional setup after loading the view.
        
        
//        configureListView()
        
        
        self.mainTableView.mj_header = MJRefreshNormalHeader.init(refreshingTarget: self, refreshingAction: #selector(requestData))
        self.mainTableView.mj_footer = MJRefreshAutoNormalFooter.init(refreshingTarget: self, refreshingAction: #selector(requestMoreData))
        self.mainTableView.mj_header.beginRefreshing()
        self.mainTableView.mj_footer.endRefreshing()
        
    }
    
    @objc func requestData () {
        self.page = 1;
        request()
    }
    @objc func requestMoreData () {
        self.page  = (self.page)+1
        request()
    }
    
   func request()  {
        
//        CFQCommonServer.getCcmTransRecordPage(1, address: self.tokenModel!.adress, complete: );
    //http://103.215.83.104:8080
    //Swift_BaseUrl
    //http://192.168.1.121:8080
    //查询EMTC交易记录
    var url:String = String(format: "%@/Web/mobile/common/getCcmTransRecord",Swift_BaseUrl)
    var parameter = Dictionary<String, Any>()
    parameter.updateValue(self.page, forKey: "pageNo")
    parameter.updateValue(20, forKey: "pageSize")
    parameter.updateValue(self.tokenModel!.adress, forKey: "address")
    if self.tokenModel?.name != "EMTC" {
        parameter.updateValue(self.tokenModel!.seedStr, forKey: "contractAddress")
     url = String(format: "%@/Web/mobile/common/getTokenTransRecord",Swift_BaseUrl)
        //查询代币交易记录
    }
    
    
    Alamofire.request(URL(string:url)!, method: .get, parameters:parameter).validate().responseJSON { response in
            self.mainTableView.mj_header.endRefreshing()
            self.mainTableView.mj_footer.endRefreshing()
        
            print(response)
            switch response.result.isSuccess {
            case true:
                if (response.result.value != nil) {
                    print(response.result.value ?? "")
                    let result  = response.result.value as! NSDictionary
                    let infoStr = result["info"] as! String
                    let info = SKUtils.convertJSON(toDict:infoStr)
                    print(info?["obj"] as Any)
                    let obj = info?["obj"]
                    print("-------444444-----------",obj as Any)
                    if (self.page == 1) {
                        self.etail?.itemArray.removeAll()
                        
                    }
                    
                    for objc in obj as! Array<Any> {
                        let itemModel = TokendEtailItemModel.init(jsonData: JSON(objc) )
                        self.etail?.itemArray.append(itemModel)
                    }
                    
                    let sum:Int = (self.page)*20
                    if ((self.etail?.itemArray.count)! < sum) {
                        self.mainTableView.mj_footer.endRefreshingWithNoMoreData()
                    }
                    
                    self.mainTableView.reloadData()
                    
                }
              
                break;
            case false: break
                
            }
            
        }

    }
    
    
    private func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.etail?.itemArray.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier:String = "Identifier_TokenEtail"
        let itemModel:TokendEtailItemModel = (self.etail?.itemArray[indexPath.row])!
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath as IndexPath) as! TokenEtailTableViewCell
//        cell.itemModelData(item:itemModel)
        cell.item = itemModel
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat.init(60.0)
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print("didSelectRowAt\(indexPath)")  张威威   张威威
        let itemModel:TokendEtailItemModel = (self.etail?.itemArray[indexPath.row])!
        let http = "https://www.elemental-core.com/blockChain/#/hashsearch?id="
        let hash_k = itemModel.hash_K as String
        let url = http + hash_k
        let vc = SKCustomWebViewController(url:url)
        self.navigationController?.cw_push(vc)


//
//  SKCustomWebViewController
//        //张威威威威

//        model.hash_k = itemModel.hash_K as String

    }
    
    
   
    

    //布局listView
    func configureListView()
    {//segmentedViewDataSource一定要通过属性强持有！！！！！！！！！
        segmentedView.dataSource = segmentedDataSource
        segmentedView.delegate = self as JXSegmentedViewDelegate
        view.addSubview(segmentedView)
        
        segmentedView.contentScrollView = listContainerView.scrollView
        listContainerView.didAppearPercent = 0.01
        view.addSubview(listContainerView)
        
        for indicaotr in segmentedView.indicators {
            if (indicaotr as? JXSegmentedIndicatorLineView) != nil ||
                (indicaotr as? JXSegmentedIndicatorDotLineView) != nil ||
                (indicaotr as? JXSegmentedIndicatorDoubleLineView) != nil ||
                (indicaotr as? JXSegmentedIndicatorRainbowLineView) != nil ||
                (indicaotr as? JXSegmentedIndicatorImageView) != nil ||
                (indicaotr as? JXSegmentedIndicatorTriangleView) != nil {
                break
            }
        }
        let totalItemWidth = UIScreen.main.bounds.size.width - 100*2
        let titles = ["支出", "收入"]
        let titleDataSource = JXSegmentedTitleDataSource()
        titleDataSource.itemContentWidth = totalItemWidth/CGFloat(titles.count)
        titleDataSource.titles = titles
        titleDataSource.isTitleMaskEnabled = true
        titleDataSource.titleNormalColor = UIColor.white.withAlphaComponent(0.3)
        titleDataSource.titleSelectedColor = UIColor.white
        titleDataSource.itemSpacing = 0
        titleDataSource.reloadData(selectedIndex: 0)
        segmentedDataSource = titleDataSource
        
        segmentedView.dataSource = titleDataSource
        segmentedView.frame = CGRect(x: 100, y: 0, width: totalItemWidth, height: 0)
        segmentedView.layer.masksToBounds = true
        segmentedView.layer.cornerRadius = 15
        segmentedView.backgroundColor = UIColor.init(hexColor: "#20284F")
        
        
        let indicator = JXSegmentedIndicatorBackgroundView()
        indicator.indicatorHeight = 30
        indicator.indicatorWidth = (screenWidth - 200) / 2.0
        indicator.backgroundWidthIncrement = 0
        indicator.indicatorColor = UIColor.init(hexColor: "#464F82")
        segmentedView.indicators = [indicator]
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
            segmentedView.frame = CGRect(x: 100, y: self.headerBGview.frame.maxY + 30, width: view.bounds.size.width - 200, height: 30)
            listContainerView.frame = CGRect(x: 15, y: self.headerBGview.frame.maxY + 70, width: view.bounds.size.width - 30, height: view.bounds.size.height - self.headerBGview.frame.maxY - 210)
    }
    ///收款
    @IBAction func collectionAction(_ sender: UIButton) {
//        print("caofuqing收款!!!!!!!!!!!!!!!!!!!!!!!")
        let  vc = CollectionController()
        vc.token = self.tokenModel
        self.navigationController?.cw_push(vc)
    }
    //转账
    @IBAction func transferAction(_ sender: UIButton) {
        let vc = TransferController()
        //caofuqing 这个为空 token 用不到
        vc.tokenModel = self.tokenModel
        self.navigationController?.cw_push(vc)
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
extension TokendEtailViewController: JXSegmentedViewDelegate {
    func segmentedView(_ segmentedView: JXSegmentedView, didSelectedItemAt index: Int) {
        if let dotDataSource = segmentedDataSource as? JXSegmentedDotDataSource {
            //先更新数据源的数据
            dotDataSource.dotStates[index] = false
            //再调用reloadItem(at: index)
            segmentedView.reloadItem(at: index)
        }
        
        //        navigationController?.interactivePopGestureRecognizer?.isEnabled = (segmentedView.selectedIndex == 0)
    }
    //点击选中标题时响应
    func segmentedView(_ segmentedView: JXSegmentedView, didClickSelectedItemAt index: Int) {
        //传递didClickSelectedItemAt事件给listContainerView，必须调用！！！
        listContainerView.didClickSelectedItem(at: index)
    }
    
    func segmentedView(_ segmentedView: JXSegmentedView, scrollingFrom leftIndex: Int, to rightIndex: Int, percent: CGFloat) {
        //传递scrollingFrom事件给listContainerView，必须调用！！！
        listContainerView.segmentedViewScrolling(from: leftIndex, to: rightIndex, percent: percent, selectedIndex: segmentedView.selectedIndex)
        
    }
    func segmentedView(_ segmentedView: JXSegmentedView, didScrollSelectedItemAt index: Int) {
    }
}

extension TokendEtailViewController: JXSegmentedListContainerViewDataSource {
    func numberOfLists(in listContainerView: JXSegmentedListContainerView) -> Int {
        if let titleDataSource = segmentedView.dataSource as? JXSegmentedBaseDataSource {
            return titleDataSource.dataSource.count
        }
        return 0
    }
    
    func listContainerView(_ listContainerView: JXSegmentedListContainerView, initListAt index: Int) -> JXSegmentedListContainerViewListDelegate {
        let vc = TokenRecordController()
        vc.type = index == 0 ? "OUT" : "IN"
        vc.coinTitle = coinTitle
        vc.index = self.index
        vc.token = self.token
        return vc
    }
}
