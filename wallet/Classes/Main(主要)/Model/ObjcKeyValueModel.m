//
//  ObjcKeyValueModel.m
//  wallet
//
//  Created by 曾云 on 2019/8/22.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "ObjcKeyValueModel.h"

@implementation ObjcKeyValueModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        _key= @"";
        _value= @"";
    }
    return self;
}

- (instancetype)initWithKey:(NSString *)key value:(NSString *)value
{
    self = [self init];
    if (self) {
        self.key = key;
        self.value= value;
    }
    return self;
}

@end
