//
//  UIViewController+Loading.h
//  Business
//
//  Created by talking on 2017/10/1.
//  Copyright © 2017年 talking　. All rights reserved.
//网络请求前小菊花加载 iOS系统的 UIActivityIndicatorView

#import <UIKit/UIKit.h>

@interface UIViewController (Loading)

- (UIView *)loadingView;

- (void)showLoadingViewWithFrame:(CGRect)frame;

- (void)showLoadingView;

- (void)hideLoadingView;



@end
