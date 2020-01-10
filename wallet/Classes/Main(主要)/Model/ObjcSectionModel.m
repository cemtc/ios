//
//  ObjcSectionModel.m
//  wallet
//
//  Created by 曾云 on 2019/8/17.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "ObjcSectionModel.h"

@implementation ObjcSectionModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _header_Height = CGFLOAT_MIN;
        _footer_Height = CGFLOAT_MIN;
        _itemArray = [NSMutableArray array];
    }
    return self;
}

- (NSString *)verifyPassWord:(NSString *)value {
    if ( value == nil || value.length == 0 ) {
        return @"密码不能为空";
    }
    
    if ( value.length < 8 || value.length > 32 ) {
        return @"密码长度为8-32位";
    }
    
    NSString *pattern = @"^\\d{8,32}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:value];
    if ( isMatch ) {
        return @"密码不能全为数字";
    }
    
    pattern = @"^[a-zA-Z]{8,32}";
    pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    isMatch = [pred evaluateWithObject:value];
    if ( isMatch ) {
        return @"密码不能全为字母";
    }
    
    pattern = @"^[-`=\\\[\\];',./~!@#$%^&*()_+|{}:\"<>?]{8,32}";
    pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    isMatch = [pred evaluateWithObject:value];
    if ( isMatch ) {
        return @"密码不能全为特殊符号";
    }
    
    // 特殊字符包含`、-、=、\、[、]、;、'、,、.、/、~、!、@、#、$、%、^、&、*、(、)、_、+、|、?、>、<、"、:、{、}
    // 必须包含数字和字母，可以包含上述特殊字符。
    // 依次为（如果包含特殊字符）
    // 数字 字母 特殊
    // 字母 数字 特殊
    // 数字 特殊 字母
    // 字母 特殊 数字
    // 特殊 数字 字母
    // 特殊 字母 数字
    pattern = @"(?=.*[0-9])(?=.*[a-zA-Z]).{8,32}";
    pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    isMatch = [pred evaluateWithObject:value];
    if ( isMatch ) {
        return @"";
    } else {
        return @"8-32位数字字母组合";
    }
}


@end
