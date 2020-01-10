//
//  Extension-UIView.swift
//  iVCoin
//
//  Created by ayong on 2017/11/28.
//  Copyright © 2017年 阿勇. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

extension UIView {
    @IBInspectable var ayCornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        // also  set(newValue)
        set {
            layer.masksToBounds = true
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable var ayBorderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var ayBorderColor: UIColor? {
        get {
            return UIColor.init(cgColor: layer.borderColor ?? UIColor.clear.cgColor)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
}


// MARK: - 扩展toast功能：上面图片，下面文字
extension UIView {
    func makeToast(_ topImg: UIImage, bottomMSG: String) {
        let toast = UIView()
        toast.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        toast.ayCornerRadius = 10
        self.addSubview(toast)
        toast.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 125, height: 100))
            make.centerX.equalTo(self)
            make.centerY.equalTo(self).offset(-50)
        }
        let label = UILabel()
        label.text = bottomMSG
        //label.font = UIFont.init(name: "PingFangSC-Medium", size: 15)
        label.font = UIFont.init(name: themeFontName, size: 15)
        label.textColor = UIColor.white
        label.textAlignment = .center
        toast.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.bottom.equalTo(-15)
            make.height.equalTo(20)
        }
        
        let imgView = UIImageView()
        imgView.image = topImg
        imgView.contentMode = .center
        toast.addSubview(imgView)
        imgView.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.right.equalTo(0)
            make.bottom.equalTo(label.snp.top)
        }
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            toast.removeFromSuperview()
        }
    }
    func gradientColor()
    {
        let gradientColor = CAGradientLayer()
        gradientColor.frame = self.bounds
        let color1 = UIColor.init(hexColor: "#6071B3")
        let color2 = UIColor.init(hexColor: "#323E7D")
        gradientColor.colors = [color1.cgColor,color2.cgColor]
        //设置渲染的起始结束位置（纵向渐变）
        gradientColor.startPoint = CGPoint(x: 0, y: 0)
        gradientColor.endPoint = CGPoint(x: 1, y: 1)
        gradientColor.cornerRadius = 8
        //定义每种颜色所在的位置
        let gradientLocations:[NSNumber] = [0.0, 1.0]
        gradientColor.locations = gradientLocations
        self.layer.addSublayer(gradientColor)
    }
}



/// 自定义View定义的协议方法
protocol UI {
    
    /// 用于调整UI的接口
    func adjustUI()
    
    /// UI添加事件
    func addEvents()
    
    /// 用来添加子视图的接口
    func addSubviews()
    
    /// 用来给子视图添加约束的接口
    func addConstraints()
    
    /// 设置数据源
    func configure<T>(model: T)
}

extension UI {
    /// 用于调整UI的接口
    func adjustUI(){}
    
    /// UI添加事件
    func addEvents(){}
    
    /// 用来添加子视图的接口
    func addSubviews(){}
    
    /// 用来给子视图添加约束的接口
    func addConstraints(){}
    
    /// 设置数据源
    func configure<T>(model: T) {}
}

extension UIView {
    
    func snapshot() -> UIImage? {
        let rect = self.frame
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        self.layer.render(in: context!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    func getControllerfromview(view:UIView)->UIViewController?{
        var nextResponder: UIResponder? = self
        
        repeat {
            nextResponder = nextResponder?.next
            
            if let viewController = nextResponder as? UIViewController {
                return viewController
            }
            
        } while nextResponder != nil
        
        return nil
        
    }
    
}
