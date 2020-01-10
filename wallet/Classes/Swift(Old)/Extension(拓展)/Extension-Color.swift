//
//  Extension-Color.swift
//  BelifData
//
//  Created by ayong on 2017/2/14.
//  Copyright © 2017年 ayong. All rights reserved.
//

import Foundation
import UIKit


//MARK: 第一种方式是给String添加扩展
extension String {
    /// 将十六进制颜色转换为UIColor
    func uiColor() -> UIColor {
        
        var hexColorString = self
        
        if hexColorString.contains("#") {
            hexColorString = hexColorString[1..<7]
        }
        
        // 存储转换后的数值
        var red:UInt32 = 0, green:UInt32 = 0, blue:UInt32 = 0
        
        // 分别转换进行转换
        Scanner(string: hexColorString[0..<2]).scanHexInt32(&red)
        
        Scanner(string: hexColorString[2..<4]).scanHexInt32(&green)
        
        Scanner(string: hexColorString[4..<6]).scanHexInt32(&blue)
        
        return UIColor(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: 1.0)
    }
    
}


//MARK: 第二种方式是给UIColor添加扩展
extension UIColor {
    
    /// 用十六进制颜色创建UIColor
    ///
    /// - Parameter hexColor: 十六进制颜色 (0F0F0F)
    convenience init(hexColor: String) {
        
        var hexColorString = hexColor
        
        if hexColorString.contains("#") {
            hexColorString = hexColorString[1..<7]
        }
        
        // 存储转换后的数值
        var red:UInt32 = 0, green:UInt32 = 0, blue:UInt32 = 0
        
        // 分别转换进行转换
        Scanner(string: hexColorString[0..<2]).scanHexInt32(&red)
        
        Scanner(string: hexColorString[2..<4]).scanHexInt32(&green)
        
        Scanner(string: hexColorString[4..<6]).scanHexInt32(&blue)
        
        self.init(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: 1.0)
    }
}

//MARK: 两种方式都需要用到的扩展

extension String {
    
    /// String使用下标截取字符串
    /// 例: "示例字符串"[0..<2] 结果是 "示例"
    subscript (r: Range<Int>) -> String {
        get {
            let startIndex = self.index(self.startIndex, offsetBy: r.lowerBound)
            let endIndex = self.index(self.startIndex, offsetBy: r.upperBound)
            
            return String(self[startIndex..<endIndex])
        }
    }
}



// MARK: 随机颜色
extension UIColor {
    class func randColor() -> UIColor {
        return UIColor.init(red: CGFloat(arc4random()%(256-124)+124)/255.0, green: CGFloat(arc4random()%(256-124)+124)/255.0, blue: CGFloat(arc4random()%(256-124)+124)/255.0, alpha: 1)
    }
}


// MARK: - iVCoin
extension UIColor {
    //FJ定义
    static let tabBlue = "#32395E".uiColor()//底部导航蓝
    static let tabTitleBlue = "#5864A6".uiColor()///底部导航字体
    static let themeBlue = "#161935".uiColor()//背景蓝
    static let itemBlue = "#32395E".uiColor()//列表蓝
    static let themeYellow = "#FFD500".uiColor()//主题黄
    static let themeGreen = "#41C977".uiColor()//跌幅绿
    static let themeRed = "#FB4848".uiColor()//涨幅红

    static let theme = themeBlue//主题色
}


extension UIColor {
    func image() -> UIImage? {
        let rect = CGRect.init(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(self.cgColor)
        context?.fill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }

}
extension UIColor {
    
    
    struct QRReader {
        static let successColor = UIColor(hexColor: "03B221")
        static let errorColor = UIColor(hexColor:"FF3B30")
        static let defaultColor = UIColor(hexColor:"E0E0E0")
    }
    
    static func setColorForTextViewPlaceholder() -> UIColor  {
        return UIColor.gray.withAlphaComponent(0.5)
    }
}
