//
//  NSURL+UrlWithString.m
//  Business
//
//  Created by talking on 2017/10/1.
//  Copyright © 2017年 talking　. All rights reserved.
//

#import "NSURL+UrlWithString.h"


#import <objc/message.h>
//用runtime交换方法实现  外面的代码不变 变里面的 方法的交换 ，其实交换的方法的实现


@implementation NSURL (UrlWithString)


//加载这个类的时候就来了  做方法的交换  它比init还提前来
+(void)load{
    
    //方法的交换
    //1.获取方法的编号
    Method URLWithStr = class_getClassMethod([NSURL class], @selector(URLWithString:));
    
    Method HK_URLWithStr = class_getClassMethod([NSURL class], @selector(HK_URLWithString:));
    
    //2.交换方法
    method_exchangeImplementations(URLWithStr, HK_URLWithStr);
    
    
}


+(instancetype)HK_URLWithString:(NSString *)str{
    
    //有请提示 请写注释！！！！！！！！！！！！！！！！！！！！！
    NSURL *url = [NSURL HK_URLWithString:str];
    
    if (url == nil) {
        
        NSLog(@"##########################url路径格式不正确###################################");
        
    }
    
    return url;
}



@end
