//
//  SKAddressManager.h
//  Business
//
//  Created by talking　 on 2018/8/15.
//  Copyright © 2018年 talking　. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SKAddressManager : NSObject

+ (SKAddressManager *)sharedManager;
+ (NSArray *)firstLevelArray;
+ (NSDictionary *)secondLevelMap;
+ (NSArray *)secondLevelArrayInFirst:(NSString *)firstLevelName;
+ (NSNumber *)indexOfFirst:(NSString *)firstLevelName;
+ (NSNumber *)indexOfSecond:(NSString *)secondLevelName inFirst:(NSString *)firstLevelName;


@end
