//
//  CustomBaseViewController.h
//  wallet
//
//  Created by 曾云 on 2019/8/17.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "SKRootViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CustomBaseViewController : SKRootViewController
/** statusBar风格*/
@property (nonatomic, assign) UIStatusBarStyle barStyle;

- (void)back;

@end

NS_ASSUME_NONNULL_END
