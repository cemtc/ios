//
//  CustomUserManager.m
//  wallet
//
//  Created by 曾云 on 2019/8/18.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "CustomUserManager.h"
#import "SKFileCacheManager.h"
#import "CustomNotificationCenterDetailsViewController.h"

static CustomUserManager *_singleton = nil;

@implementation CustomUserManager

+ (instancetype)customSharedManager {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _singleton = [[CustomUserManager alloc]init];
    });
    return _singleton;
}
- (void)loginFinish:(CustomUserModel *)model {
    [model archive];
    [SKFileCacheManager saveUserData:@YES forKey:SKHasLoginFlag];
}



//当前用户的信息
- (CustomUserModel *)userModel {
    
    id obj = [SKFileCacheManager getObjectByFileName:NSStringFromClass([CustomUserModel class])];
    if (obj != nil) {
        return obj;
    }
    return nil;
}

// 判断是否是登陆状态
- (BOOL)isLogin {
    return [[NSUserDefaults standardUserDefaults] boolForKey:SKHasLoginFlag];
}

- (void)showWalletPassWordViewFinish:(void(^)(NSString *password))finishBlock {
    CustomWalletPassWordView *password = [CustomWalletPassWordView initViewWithXibIndex:0];
    [password showClickButton:^(NSString * _Nonnull text) {
        if (finishBlock) {
            finishBlock(text);
        }
    }];
}


- (void)pushTransferDetailsFinish:(CustomNotificationCenterItemModel *)itemModel viewController:(UIViewController *)viewController {
    
    CustomNotificationCenterDetailsModel *detailsModel = [[CustomNotificationCenterDetailsModel alloc]initWithITransfertemModel:itemModel];
    
    CustomNotificationCenterDetailsViewController *detailsViewController = [[UIStoryboard storyboardWithName:@"Mine" bundle:nil] instantiateViewControllerWithIdentifier:@"CustomNotificationCenterDetails"];
    
    detailsViewController.detailsModel = detailsModel;
    [viewController.navigationController pushViewController:detailsViewController animated:YES];
}


@end
