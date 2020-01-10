//
//  CustomWalletPassWordView.h
//  wallet
//
//  Created by 曾云 on 2019/8/17.
//  Copyright © 2019 talking　. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomWalletPassWordView : UIView

@property (nonatomic,strong) void(^buttonClickBlock)(NSString *text);
@property (nonatomic,strong) void(^CanclebuttonClickBlock)(NSString *text);
- (void)showClickButton:(void(^)(NSString *text))buttonClickBlock;
- (void)dismisss;

@end

NS_ASSUME_NONNULL_END
