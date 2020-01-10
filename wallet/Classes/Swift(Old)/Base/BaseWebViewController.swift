//
//  BaseWebViewController.swift
//  QYWallet
//
//  Created by 崔逢举 on 2019/4/15.
//  Copyright © 2019 崔逢举. All rights reserved.
//

import UIKit
import WebKit
class BaseWebViewController: UIViewController {
   //webwebview
    lazy var wkWebView = WKWebView()
    var wkurl : String?
    
    // 进度条
    lazy var progressView = UIProgressView()
    override func viewDidLoad() {
        super.viewDidLoad()
        initInterface(wkurl: self.wkurl ?? "")
        
    }
    func initInterface(wkurl : String) -> () {
        self.view.addSubview(self.wkWebView)
        self.wkWebView.snp.makeConstraints { make in
           make.top.left.bottom.right.equalToSuperview()
        }
        let url = URL(string: wkurl)
        let request = URLRequest(url: url!)
        self.wkWebView.navigationDelegate = self
        wkWebView.load(request)
        self.view.addSubview(self.progressView)
        self.progressView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(2)
        }
        self.wkWebView.addObserver(self, forKeyPath: "estimatedProgress", options: NSKeyValueObservingOptions.new, context: nil)
        self.view.bringSubview(toFront: self.progressView)
        progressView.progressTintColor = UIColor.themeYellow
        progressView.trackTintColor = UIColor.clear
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        wkWebView.removeObserver(self, forKeyPath: "estimatedProgress")
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
extension BaseWebViewController: WKNavigationDelegate {
// 监听网页加载进度
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        self.progressView.setProgress(Float(self.wkWebView.estimatedProgress), animated: true)
}
// 页面开始加载时调用
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        
} // 当内容开始返回时调用
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!){
        
}
// 页面加载完成之后调用
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!){
/// 获取网页title
        self.title = self.wkWebView.title
        UIView.animate(withDuration: 0.5) {
            self.progressView.isHidden = true
        }
        
}
// 页面加载失败时调用
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error){
        UIView.animate(withDuration: 0.5) {
            self.progressView.progress = 0.0
            self.progressView.isHidden = true
            
}
/// 弹出提示框点击确定返回
        let alertView = UIAlertController.init(title: "提示", message: "加载失败", preferredStyle: .alert)
        let okAction = UIAlertAction.init(title:"确定", style: .default) {okAction in
            _ = self.navigationController?.popViewController(animated: true)
            
        }
        alertView.addAction(okAction)
        self.present(alertView, animated: true, completion: nil)
    }
    
}


