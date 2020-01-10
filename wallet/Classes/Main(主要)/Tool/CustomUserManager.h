//
//  CustomUserManager.h
//  wallet
//
//  Created by 曾云 on 2019/8/18.
//  Copyright © 2019 talking　. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CustomNotificationCenterModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CustomUserManager : NSObject

+ (instancetype)customSharedManager;

- (void)loginFinish:(CustomUserModel *)model;

/**
 *  用来记录是否是登陆状态
 */
@property (nonatomic, assign) BOOL isLogin;

/**
 *  获取用户信息
 */
- (CustomUserModel *)userModel;


- (void)showWalletPassWordViewFinish:(void(^)(NSString *password))finishBlock;

- (void)pushTransferDetailsFinish:(CustomNotificationCenterItemModel *)itemModel viewController:(UIViewController *)viewController;

@end

NS_ASSUME_NONNULL_END
