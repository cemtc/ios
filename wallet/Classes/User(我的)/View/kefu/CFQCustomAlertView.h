//
//  CFQCustomAlertView.h
//  wallet
//
//  Created by talking　 on 2019/6/23.
//  Copyright © 2019 talking　. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CFQCustomAlertView : UIView
/**
 显示
 */
- (void)show;
/**
 隐藏
 */
- (void)dismiss;

//点击后传递的信息
@property (nonatomic, copy) void (^clickBlock)(NSString *info);

//titleView
@property (nonatomic, copy) NSArray *titlesArray;
@property (nonatomic, copy) NSArray *imagesArray;

@end

NS_ASSUME_NONNULL_END
