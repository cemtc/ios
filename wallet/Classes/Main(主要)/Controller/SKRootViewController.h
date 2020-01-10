//
//  SKRootViewController.h
//  Business
//
//  Created by talking　 on 2018/8/13.
//  Copyright © 2018年 talking　. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^SKRootViewControllerHandle)(void);


@interface SKRootViewController : UIViewController


//正常的pop
- (void)pop;

- (void)popToRootVc;

- (void)popToVc:(UIViewController *)vc;

- (void)dismiss;

- (void)dismissWithCompletion:(void(^)(void))completion;

- (void)presentVc:(UIViewController *)vc;

- (void)presentVc:(UIViewController *)vc completion:(void (^)(void))completion;

- (void)pushVc:(UIViewController *)vc;

- (void)removeChildVc:(UIViewController *)childVc;

- (void)addChildVc:(UIViewController *)childVc;

/** 加载中*/
- (void)showLoadingAnimation;

/** 停止加载*/
- (void)hideLoadingAnimation;

/** 请求数据，交给子类去实现*/
- (void)loadData;

@property (nonatomic, assign) BOOL isNetworkReachable;//判断网络是否可以用  YES是可以用 NO不可以用


//添加导航条左边按钮
- (void)leftBarButtomItemWithNormalName:(NSString*)normalName
                               highName:(NSString *)highName
                               selector:(SEL)selector
                                 target:(id)target;

//添加导航条右边按钮
- (void)rightBarButtomItemWithNormalName:(NSString*)normalName
                                highName:(NSString *)highName
                                selector:(SEL)selector
                                  target:(id)target;

- (void)rightBarButtomItemWithTitle:(NSString*)title selector:(SEL)selector target:(id)target;
@end
