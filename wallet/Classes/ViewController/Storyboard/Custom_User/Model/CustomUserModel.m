//
//  CustomUserModel.m
//  wallet
//
//  Created by 曾云 on 2019/8/18.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "CustomUserModel.h"

@implementation CustomUserModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _projectName = @"EMTCWALLET";
        _name = @"";
        _passwrod = @"";
        _privateKey = @"";
        _serverVerson = APP_VERSION;
        _ethAddress = @"";
        _ethMnemonic = @"";
    }
    return self;
}

@end
