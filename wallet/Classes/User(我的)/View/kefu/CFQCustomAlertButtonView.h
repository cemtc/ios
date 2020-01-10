//
//  CFQCustomAlertButtonView.h
//  wallet
//
//  Created by talking　 on 2019/6/23.
//  Copyright © 2019 talking　. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CFQCustomAlertButtonView : UIView
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *imageString;

@property (nonatomic, copy) void (^clickBlock)(NSString *info);

@property (nonatomic, strong) UILabel *bottomL;//点击复制

@end

NS_ASSUME_NONNULL_END
