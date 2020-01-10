//
//  SKCircleTabBar.h
//  Business
//
//  Created by talking　 on 2018/8/14.
//  Copyright © 2018年 talking　. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SKCircleTabBar;

@protocol SKCircleTabBarDelegate <NSObject>
@optional
- (void)sktabBarCircleBtnClick:(SKCircleTabBar *)tabBar;
@end

@interface SKCircleTabBar : UITabBar
/** tabbar的代理 */
@property (nonatomic, weak) id<SKCircleTabBarDelegate> myDelegate;

@end
