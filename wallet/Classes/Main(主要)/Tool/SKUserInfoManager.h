//
//  SKUserInfoManager.h
//  Business
//
//  Created by talking　 on 2018/8/15.
//  Copyright © 2018年 talking　. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SKUserInfoManager : NSObject

+ (instancetype)sharedManager;

/**
 *  登录成功
 */
- (void)didLoginInWithUserInfo:(id)userInfo;

/**
 *  退出
 */
- (void)didLoginOut;

/**
 *  获取用户信息
 */
- (SKUserInfoModel *)currentUserInfo;

/**
 *  更新缓存中的用户信息
 */
- (void)resetUserInfoWithUserInfo:(SKUserInfoModel *)userInfo;

/**
 *  用来记录是否是登陆状态
 */
@property (nonatomic, assign) BOOL isLogin;



@end
