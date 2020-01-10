//
//  NSURL+UrlWithString.h
//  Business
//
//  Created by talking on 2017/10/1.
//  Copyright © 2017年 talking　. All rights reserved.
// runtime 替换 UrlWithString  方法 当url有中文或报错时  进行相应的处理

#import <Foundation/Foundation.h>

@interface NSURL (UrlWithString)

+(instancetype)HK_URLWithString:(NSString *)str;


@end
