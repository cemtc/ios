//
//  UIView+Common.h
//  MyHomer
//
//  Created by JasonZhang on 15/12/15.
//  Copyright © 2015年 JasonZhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Common)
// 返回屏幕的宽
CGFloat screenWidth();

// 返回屏幕的高
CGFloat screenHeight();

// 计算视图最大的X
CGFloat maxX(UIView *view);
// 计算视图最大的Y
CGFloat maxY(UIView *view);
// 计算视图最小的X
CGFloat minX(UIView *view);
// 计算视图最小的Y
CGFloat minY(UIView *view);

// 计算当前视图的宽
CGFloat width(UIView *view);
// 计算当前视图的高
CGFloat height(UIView *view);


@end
