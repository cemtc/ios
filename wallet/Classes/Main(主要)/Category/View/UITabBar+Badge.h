//
//  UITabBar+Badge.h
//  Business
//
//  Created by talking on 2017/12/21.
//  Copyright © 2017年 talking　. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (Badge)
- (void)showBadgeOnItemIndex:(int)index;   //显示小红点

- (void)hideBadgeOnItemIndex:(int)index; //隐藏小红点

@end


/*
 //用法
 //显示
 [self.tabBarController.tabBar showBadgeOnItemIndex:2];
 
 //隐藏
 [self.tabBarController.tabBar hideBadgeOnItemIndex:2]
 
 */
