//
//  SKUserInfoManager.m
//  Business
//
//  Created by talking　 on 2018/8/15.
//  Copyright © 2018年 talking　. All rights reserved.
//

#import "SKUserInfoManager.h"
#import "SKFileCacheManager.h"

static SKUserInfoManager *_singleton = nil;

@implementation SKUserInfoManager

+ (instancetype)sharedManager {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _singleton = [[SKUserInfoManager alloc]init];
    });
    return _singleton;
}

//当前用户的信息
-(SKUserInfoModel *)currentUserInfo {
    
    id obj = [SKFileCacheManager getObjectByFileName:NSStringFromClass([SKUserInfoModel class])];
    if (obj != nil) {
        return obj;
    }
    return nil;
}

// 重置用户信息
- (void)resetUserInfoWithUserInfo:(SKUserInfoModel *)userInfo {
    [userInfo archive];
}

// 登陆
- (void)didLoginInWithUserInfo:(id)userInfo {
    
    SKUserInfoModel *userinfo = [SKUserInfoModel modelWithDictionary:userInfo];
    [userinfo archive];
    
    [SKFileCacheManager saveUserData:@YES forKey:SKHasLoginFlag];
    
}

// 退出登陆
- (void)didLoginOut {
    [SKFileCacheManager removeObjectByFileName:NSStringFromClass([SKUserInfoModel class])];
    
    [SKFileCacheManager saveUserData:@NO forKey:SKHasLoginFlag];
}

// 判断是否是登陆状态
- (BOOL)isLogin {
    return [[NSUserDefaults standardUserDefaults] boolForKey:SKHasLoginFlag];
}


@end
