//
//  UILabel+Addition.h
//  Business
//
//  Created by talking on 2017/10/1.
//  Copyright © 2017年 talking　. All rights reserved.
//快速创建lable  可再扩展

#import <UIKit/UIKit.h>

@interface UILabel (Addition)

- (instancetype)initWithFont:(UIFont *)font
                   textColor:(UIColor *)textColor
                     bgColor:(UIColor *)bgColor
               textAlignment:(NSTextAlignment)textAlignment;

+ (instancetype)labelWithFont:(UIFont *)font
                    textColor:(UIColor *)textColor
                      bgColor:(UIColor *)bgColor
                textAlignment:(NSTextAlignment)textAlignment;



@end
