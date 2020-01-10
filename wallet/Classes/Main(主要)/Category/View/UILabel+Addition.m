//
//  UILabel+Addition.m
//  Business
//
//  Created by talking on 2017/10/1.
//  Copyright © 2017年 talking　. All rights reserved.
//

#import "UILabel+Addition.h"

@implementation UILabel (Addition)


- (instancetype)initWithFont:(UIFont *)font
                   textColor:(UIColor *)textColor
                     bgColor:(UIColor *)bgColor
               textAlignment:(NSTextAlignment)textAlignment {
    if (self = [super init]) {
        self.font = font;
        self.textAlignment = textAlignment ? textAlignment : NSTextAlignmentLeft;
        self.textColor = textColor;
        self.backgroundColor = bgColor;
    }
    return self;
}

+ (instancetype)labelWithFont:(UIFont *)font
                    textColor:(UIColor *)textColor
                      bgColor:(UIColor *)bgColor
                textAlignment:(NSTextAlignment)textAlignment {
    return [[UILabel alloc] initWithFont:font textColor:textColor bgColor:bgColor textAlignment:textAlignment];
}

@end
