//
//  Extension-String.swift
//  ayong
//
//  Created by ayong on 2017/3/9.
//
//

import Foundation
import UIKit


// MARK: 返回String的长度length
extension String {
    var length: Int {return self.count}
}

// MARK: 计算rect
extension String {
    func boundingRect(with size: CGSize, options: NSStringDrawingOptions = [], attributes: [NSAttributedStringKey : Any]? = nil, context: NSStringDrawingContext?) -> CGRect {
        var rect = CGRect.zero
        if self.length == 0 {
            return rect
        }
        let newString = self as NSString
        rect = newString.boundingRect(with: size, options: options, attributes: attributes, context: context)
        
        return rect
    }
        /*!
         * @method 把时间戳转换为用户格式时间
         * @abstract
         * @discussion
         * @param   timestamp     时间戳
         * @param   format        格式
         * @result                时间
         */
    func ch_getTimeByStamp(_ timestamp: String, format: String) -> String {
            var time = ""
        let confromTimesp = Date(timeIntervalSince1970: TimeInterval(Double(timestamp)!))
            let formatter = DateFormatter()
            formatter.dateFormat = format
            time = formatter.string(from: confromTimesp)
            return time;
        }
}


// MARK: - 正则手机号码
extension String {
//    func isTelNumber()->Bool
//    {
//        let mobile = "^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$"
//        let  CM = "^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$"
//        let  CU = "^1(3[0-2]|5[256]|8[56])\\d{8}$"
//        let  CT = "^1((33|53|8[09])[0-9]|349)\\d{7}$"
//        let regextestmobile = NSPredicate(format: "SELF MATCHES %@",mobile)
//        let regextestcm = NSPredicate(format: "SELF MATCHES %@",CM )
//        let regextestcu = NSPredicate(format: "SELF MATCHES %@" ,CU)
//        let regextestct = NSPredicate(format: "SELF MATCHES %@" ,CT)
//        if ((regextestmobile.evaluate(with: self) == true)
//            || (regextestcm.evaluate(with: self)  == true)
//            || (regextestct.evaluate(with: self) == true)
//            || (regextestcu.evaluate(with: self) == true))
//        {
//            return true
//        } else {
//            return false
//        }
//    }
    func isTelNumber()->Bool
        
    {
        
        let mobile = "^1((3[0-9]|4[57]|5[0-35-9]|7[0678]|8[0-9])\\d{8}$)"
        
        let  CM = "(^1(3[4-9]|4[7]|5[0-27-9]|7[8]|8[2-478])\\d{8}$)|(^1705\\d{7}$)";
        
        let  CU = "(^1(3[0-2]|4[5]|5[56]|7[6]|8[56])\\d{8}$)|(^1709\\d{7}$)";
        
        let  CT = "(^1(33|53|77|8[019])\\d{8}$)|(^1700\\d{7}$)";
        
        let regextestmobile = NSPredicate(format: "SELF MATCHES %@",mobile)
        
        let regextestcm = NSPredicate(format: "SELF MATCHES %@",CM )
        
        let regextestcu = NSPredicate(format: "SELF MATCHES %@" ,CU)
        
        let regextestct = NSPredicate(format: "SELF MATCHES %@" ,CT)
        
        if ((regextestmobile.evaluate(with: self) == true)
            
            || (regextestcm.evaluate(with: self)  == true)
            
            || (regextestct.evaluate(with: self) == true)
            
            || (regextestcu.evaluate(with: self) == true))
            
        {
            
            return true
            
        }
            
        else
            
        {
            
            return false
            
        }

    }
}




// MARK: - 汉字处理
extension String {
    // MARK: 汉字 -> 拼音
    func chineseToPinyin() -> String {
        
        let stringRef = NSMutableString(string: self) as CFMutableString
        // 转换为带音标的拼音
        CFStringTransform(stringRef,nil, kCFStringTransformToLatin, false)
        // 去掉音标
        CFStringTransform(stringRef, nil, kCFStringTransformStripCombiningMarks, false)
        let pinyin = stringRef as String
        
        return pinyin
    }
    
    // MARK: 判断是否含有中文
    func isIncludeChineseIn() -> Bool {
        
        for (_, value) in self.enumerated() {
            
            if ("\u{4E00}" <= value  && value <= "\u{9FA5}") {
                return true
            }
        }
        
        return false
    }
    
    // MARK: 获取第一个字符
    func first() -> String {
        return String(self.prefix(1))
    }
    
}


extension String {
    //根据开始位置和长度截取字符串
    func subString(start:Int, length:Int = -1) -> String {
        var len = length
        if len == -1 {
            len = self.count - start
        }
        let st = self.index(startIndex, offsetBy:start)
        let en = self.index(st, offsetBy:len)
        return String(self[st ..< en])
    }
}
extension String {
    func depth(_ numScale: Int) -> String {
        guard numScale >= 0, numScale <= 20 else {
            return self
        }
        let max = "00000000000000000000"
        if !self.contains(".") {
            return self + "." + max.subString(start: 0, length: numScale)
        }
        let arr = self.components(separatedBy: ".")
        
        return arr[0] + "." + (arr[1] + max).subString(start: 0, length: numScale)
    }
}
