//
//  BaseNavigationController.swift
//  QYWallet
//
//  Created by 崔逢举 on 2019/4/8.
//  Copyright © 2019 崔逢举. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.barTintColor = UIColor.red
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.isTranslucent = false
        self.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
//        self.navigationBar.tintColor = UIColor.white
        
//        init(hexColor: "#2E303B")
        self.navigationBar.tintColor = UIColor.init(hexColor: "#2E303B")
        let isTrue = self.navigationController?.responds(to: #selector(getter: interactivePopGestureRecognizer));
        var isMore:Int = 0;
        if ((self.navigationController?.viewControllers.count) != nil) {
            isMore = (self.navigationController?.viewControllers.count)!;
        }
        if isMore > 1 {
            if isTrue! {
                self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true;
            }else{
                self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false;
            }
        }else{
            self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false;
        }
        // Do any additional setup after loading the view.
    }
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: true)
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
