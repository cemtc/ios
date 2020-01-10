//
//  CFQLabelBgView.h
//  mishuwork
//
//  Created by iMac on 2019/3/21.
//  Copyright © 2019 iMac. All rights reserved.
//
//圆角镂空
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CFQLabelBgView : UIView

@property (nonatomic, copy)NSString *title;

@property (nonatomic, assign) UIColor *titleColor;

@property (nonatomic, assign) UIColor *bgColor;


@property (nonatomic, assign) UIFont *font;


@property (nonatomic, assign) NSTextAlignment textAlignment;

@end

NS_ASSUME_NONNULL_END
