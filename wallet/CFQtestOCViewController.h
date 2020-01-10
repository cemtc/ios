//
//  CFQtestOCViewController.h
//  wallet
//
//  Created by talking　 on 2019/6/16.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "SKRootViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CFQtestOCViewController : SKRootViewController
//验证交易密码
- (void)verifyisPhoneNumberPwd:(NSString *)pwd Callback:(void(^)(BOOL isLogin))callback;
@end

NS_ASSUME_NONNULL_END
