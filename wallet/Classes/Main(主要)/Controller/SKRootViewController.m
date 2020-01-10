//
//  SKRootViewController.m
//  Business
//
//  Created by talking　 on 2018/8/13.
//  Copyright © 2018年 talking　. All rights reserved.
//

#import "SKRootViewController.h"
#import "SKCustomLoadingAnimationView.h"
#import "NSNotificationCenter+Addition.h"
#import "SKCustomNoNetworkEmptyView.h"
#import "AFNetworkReachabilityManager.h"  //判断有没有网络
//#import "YYWebImageManager.h"
//#import "YYDiskCache.h"
//#import "YYMemoryCache.h"

#import <YYWebImage/YYWebImage.h>


@interface SKRootViewController ()

@property (nonatomic, weak) SKCustomLoadingAnimationView *animationView;
@property (nonatomic, weak) SKCustomNoNetworkEmptyView *noNetworkEmptyView;

@end

@implementation SKRootViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIView setAnimationsEnabled:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    //
    //    // 在自定义leftBarButtonItem后添加下面代码就可以完美解决返回手势无效的情况
    //    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
    //        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    //    }
    NSArray *gestureArray = self.navigationController.view.gestureRecognizers;
    //当是侧滑手势的时候设置scrollview需要此手势失效才生效即可
    for (UIGestureRecognizer *gesture in gestureArray) {
        if ([gesture isKindOfClass:[UIScreenEdgePanGestureRecognizer class]]) {
            
            for (UIView *sub in self.view.subviews) {
                if ([sub isKindOfClass:[UIScrollView class]]) {
                    UIScrollView *sc = (UIScrollView *)sub;
                    [sc.panGestureRecognizer requireGestureRecognizerToFail:gesture];
                }
            }
        }
    }
}

//状态栏为白色
//- (UIStatusBarStyle)preferredStatusBarStyle{
//    
//    return UIStatusBarStyleLightContent;
//}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [UIView setAnimationsEnabled:YES];
    
    self.view.backgroundColor = SKCommonBgColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    self.edgesForExtendedLayout = UIRectEdgeAll;
    //UIRectEdgeAll的时候会让tableView从导航栏下移44px，设置为UIRectEdgeNone的时候，刚刚在导航栏下面。
    
    [NSNotificationCenter addObserver:self action:@selector(requestSuccessNotification) name:SKRequestSuccessNotification];
    
    //    [self.view addSubview:self.noNetworkEmptyView];   //用法  交给子类实现
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];//开启网络检测功能
    
    
    CGFloat height ;
    if (SKIsIphoneX) {
        height = 88;
    }else {
        height = 64;
    }
    //设置全局导航渐变色
//    [self.navigationController.navigationBar.layer insertSublayer:[SKUtils gradientLayerFrame:CGRectMake(0, -(height - 44), SKScreenWidth, height) color1:[UIColor colorWithHexString:@"#1b98f8"] color2:[UIColor colorWithHexString:@"#283ae7"] isHorizontal:YES] atIndex:1];

}

//一开始的时候 网络请求成功  停止动画加载
- (void)requestSuccessNotification {
    [self hideLoadingAnimation];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



- (void)hideLoadingAnimation {
    [_animationView dismiss];
    _animationView = nil;
}

- (void)pop {
    if (self.navigationController == nil) return ;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)popToRootVc {
    if (self.navigationController == nil) return ;
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)popToVc:(UIViewController *)vc {
    if ([vc isKindOfClass:[UIViewController class]] == NO) return ;
    if (self.navigationController == nil) return ;
    [self.navigationController popToViewController:vc animated:YES];
}

- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dismissWithCompletion:(void(^)(void))completion {
    [self dismissViewControllerAnimated:YES completion:completion];
}

- (void)presentVc:(UIViewController *)vc {
    if ([vc isKindOfClass:[UIViewController class]] == NO) return ;
    [self presentVc:vc completion:nil];
}

- (void)presentVc:(UIViewController *)vc completion:(void (^)(void))completion {
    if ([vc isKindOfClass:[UIViewController class]] == NO) return ;
    [self presentViewController:vc animated:YES completion:completion];
}

//正常的push
- (void)pushVc:(UIViewController *)vc {
    if ([vc isKindOfClass:[UIViewController class]] == NO) return ;
    if (self.navigationController == nil) return ;
    if (vc.hidesBottomBarWhenPushed == NO) {
        vc.hidesBottomBarWhenPushed = YES;
    }
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)removeChildVc:(UIViewController *)childVc {
    if ([childVc isKindOfClass:[UIViewController class]] == NO) {
        return ;
    }
    [childVc.view removeFromSuperview];
    [childVc willMoveToParentViewController:nil];
    [childVc removeFromParentViewController];
}

- (void)addChildVc:(UIViewController *)childVc {
    if ([childVc isKindOfClass:[UIViewController class]] == NO) {
        return ;
    }
    [childVc willMoveToParentViewController:self];
    [self addChildViewController:childVc];
    [self.view addSubview:childVc.view];
    childVc.view.frame = self.view.bounds;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}



//这个是空的界面！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！
////    [self.view addSubview:self.noNetworkEmptyView];   用法  交给子类实现
- (SKCustomNoNetworkEmptyView *)noNetworkEmptyView {
    if (!_noNetworkEmptyView) {
        SKCustomNoNetworkEmptyView *empty = [[SKCustomNoNetworkEmptyView alloc] init];
        [self.view addSubview:empty];
        
        _noNetworkEmptyView = empty;
        
        SKDefineWeakSelf;
        [empty mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(weakSelf.view);
        }];
        empty.customNoNetworkEmptyViewDidClickRetryHandle = ^(SKCustomNoNetworkEmptyView *emptyView) {
            [weakSelf loadData];
            
        };
    }
    return _noNetworkEmptyView;
}

- (void)showLoadingAnimation {
    SKCustomLoadingAnimationView *animation = [[SKCustomLoadingAnimationView alloc] init];
    [animation showInView:self.view];
    _animationView = animation;
    [self.view bringSubviewToFront:animation];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self.view bringSubviewToFront:self.animationView];
}

- (void)loadData {
    
    //    NSLog(@"点击重试按钮");
    
    
    //    [self showLoadingAnimation];
    //
    //
    //    // 网络不可用
    //    if ([AFNetworkReachabilityManager sharedManager].reachable == NO) {
    //
    //        [self hideLoadingAnimation];
    ////        self.noNetworkEmptyView.hidden = NO;
    //
    //
    //        NSLog(@"网络不可以用");
    //
    //
    //    } else { // 网络可用
    //
    //        NSLog(@"网络可以用");
    //
    //        [self.noNetworkEmptyView removeFromSuperview];
    //        _noNetworkEmptyView = nil;
    //
    //    }
    //
    
}


//
////网络是否可以用  NO 不可以用     YES可以用
- (BOOL)isNetworkReachable {
    return [AFNetworkReachabilityManager sharedManager].reachable;
}



- (void)leftBarButtomItemWithNormalName:(NSString*)normalName
                               highName:(NSString *)highName
                               selector:(SEL)selector
                                 target:(id)target {
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *normalImage = [UIImage imageNamed:normalName];
    leftButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    double top = SKIsIphoneX?44.0f:20.0f;
    leftButton.frame = CGRectMake(0, top, 50, 44.0f);
    leftButton.backgroundColor = [UIColor clearColor];
    [leftButton setImage:normalImage forState:UIControlStateNormal];
    [leftButton setImage:[UIImage imageNamed:highName] forState:UIControlStateHighlighted];
    [leftButton addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
//    [self.navigationBar setLeftButton:leftButton];
}

//添加导航条右边按钮
- (void)rightBarButtomItemWithNormalName:(NSString*)normalName
                                highName:(NSString *)highName
                                selector:(SEL)selector
                                  target:(id)target {
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *normalImage = [UIImage imageNamed:normalName];
    rightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    double top = SKIsIphoneX?44.0f:20.0f;
    rightButton.frame = CGRectMake(0, top, 50, 44.0f);
    [rightButton setImage:normalImage forState:UIControlStateNormal];
    //    rightButton.backgroundColor = [UIColor redColor];
    [rightButton setImage:[UIImage imageNamed:highName] forState:UIControlStateHighlighted];
    [rightButton setImage:[UIImage imageNamed:highName] forState:UIControlStateSelected];
    [rightButton addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    
}


// 添加导航栏右边标题
- (void)rightBarButtomItemWithTitle:(NSString*)title selector:(SEL)selector target:(id)target {
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    rightButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    rightButton.titleLabel.textAlignment = NSTextAlignmentRight;
    CGSize size = [title boundingRectWithSize:CGSizeMake(SKScreenWidth, 44.0f)
                                      options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                   attributes:@{ NSFontAttributeName:rightButton.titleLabel.font }
                                      context:nil].size;
    [rightButton setTitle:title forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    rightButton.backgroundColor = [UIColor clearColor];
//    rightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    double top = SKIsIphoneX?44.0f:20.0f;
    rightButton.frame = CGRectMake(0, top, size.width, 44.0f);
    [rightButton addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
     self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];
    [[[YYWebImageManager sharedManager] cache].diskCache removeAllObjects];
    [[[YYWebImageManager sharedManager] cache].memoryCache removeAllObjects];
}




@end
