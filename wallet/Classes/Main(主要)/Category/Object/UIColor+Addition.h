//
//  UIColor+Addition.h
//  Business
//
//  Created by talking on 2017/10/2.
//  Copyright © 2017年 talking　. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Addition)

//设置RGB颜色
+ (UIColor *)red:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue alpha:(CGFloat)alpha;
//将颜色转换成RGB
+ (NSArray *)convertColorToRGB:(UIColor *)color;
//设置十六进制颜色
+ (UIColor *)colorWithHex:(NSInteger)hex;
+ (UIColor*)colorWithHexString:(NSString *)hexString;

//作者：楚简约
//链接：http://www.jianshu.com/p/5921a20ae908
//來源：简书
//著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。

@end
