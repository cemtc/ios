//
//  NSObject+AppInfo.h
//  Business
//
//  Created by talking on 2017/10/1.
//  Copyright © 2017年 talking　. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (AppInfo)
+ (NSString *)ai_version;
+ (NSInteger)ai_build;
+ (NSString *)ai_identifier;
+ (NSString *)ai_currentLanguage;
+ (NSString *)ai_deviceModel;

+ (NSString *)ai_deviceName;

@end
