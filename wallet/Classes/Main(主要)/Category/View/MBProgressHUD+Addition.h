//
//  MBProgressHUD+Addition.h
//  Business
//
//  Created by talking on 2017/10/1.
//  Copyright © 2017年 talking　. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

@interface MBProgressHUD (Addition)

+ (void)showError:(NSString *)error
           toView:(UIView *)view;

+ (void)showSuccess:(NSString *)success
             toView:(UIView *)view;
/**
 *  尽量都使用这个
 */
+ (void)showLoading:(UIView *)view;
+ (void)showLoading:(NSString *)text
             toView:(UIView *)view;

/**
 *  尽量都使用这个
 */
+ (void)showMessage:(NSString *)message;
+ (void)showMessage:(NSString *)message
             toView:(UIView *)view;

+ (void)showMessage:(NSString *)message
      detailMessage:(NSString*)detailMessage
             toView:(UIView *)view;

+ (void)hideAllHUDsInView:(UIView *)view;


@end
