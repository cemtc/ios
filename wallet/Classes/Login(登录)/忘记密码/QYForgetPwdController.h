//
//  QYForgetPwdController.h
//  wallet
//
//  Created by talking　 on 2019/7/19.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "SKRootViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface QYForgetPwdController : SKRootViewController
@property (nonatomic, copy) void (^NextViewControllerBlock)(NSString *tfText);

@end

NS_ASSUME_NONNULL_END
