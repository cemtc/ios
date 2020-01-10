//
//  AppDelegate.h
//  Business
//
//  Created by talking　 on 2018/8/10.
//  Copyright © 2018年 talking　. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SKTabBarController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


@property (strong, nonatomic) SKTabBarController *tabbarController;


//设置SKTabBarController 为rootViewController
- (void)setupTabViewController;
//设置SKLoginViewController 为rootViewController
- (void)setupLoginViewController;


//检查登录状态 以及登录后信息是否填写完整 不完整跳转信息编辑页
-(void)checkLoginFromControl:(NSString *)control;
//退出登录
-(void)exitSign;


@end

