//
//  ObjcBaseModel.m
//  wallet
//
//  Created by 曾云 on 2019/8/17.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "ObjcBaseModel.h"

@implementation ObjcBaseModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _objc_Height = CGFLOAT_MIN;
        _objc_Identifier = @"";
    }
    return self;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

- (NSString *)modelAttribute:(id)obj {
    if ([obj isKindOfClass:[NSNull class]]) {
        return kMNullStr;
    } else {
        return obj;
    }
    
}

- (NSString *)modelAttributeString:(id)obj {
    if ([obj isKindOfClass:[NSNull class]]) {
        return kMNullStr;
    } else if (obj == nil) {
        return kMNullStr;
    } else {
        return obj;
    }
}

- (NSString *)modelAttribute:(id)obj withNullString:(NSString *)nullString {
    if ([obj isKindOfClass:[NSNull class]]) {
        return nullString;
    } else if (obj == nil) {
        return nullString;
    } else if ([obj isKindOfClass:[NSString class]]) {
        NSString * str = (NSString *)obj;
        if (str.length == 0) {
            return nullString;
        } else {
            return obj;
        }
    } else {
        return obj;
    }
}


- (NSInteger)modelAttributeInteger:(id)obj {
    if ([obj isKindOfClass:[NSNull class]]) {
        return -1;
    } else if (obj == nil) {
        return -1;
    } else {
        return [obj integerValue];
    }
}

- (double)modelAttributeDouble:(id)obj {
    if ([obj isKindOfClass:[NSNull class]]) {
        return -1.00;
    } else if (obj == nil) {
        return -1.00;
    } else if ([obj isKindOfClass:[NSString class]] && [obj length] == 0) {
        return -1.00;
    } else {
        return [obj doubleValue];
    }
}

- (BOOL)modelAttributeBool:(id)obj {
    if ([obj isKindOfClass:[NSNull class]]) {
        return NO;
    } else if (obj == nil) {
        return NO;
    } else if ([obj isKindOfClass:[NSString class]] && [obj length] == 0) {
        return NO;
    } else {
        return [obj boolValue];
    }
}


- (long long)modelAttributeLongLong:(id)obj {
    if ([obj isKindOfClass:[NSNull class]]) {
        return -1;
    } else if (obj == nil) {
        return -1;
    } else if ([obj isKindOfClass:[NSString class]] && [obj length] == 0) {
        return -1;
    } else {
        return [obj longLongValue];
    }
}

@end
