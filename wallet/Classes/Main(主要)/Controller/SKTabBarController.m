//
//  SKTabBarController.m
//  Business
//
//  Created by talking　 on 2018/8/15.
//  Copyright © 2018年 talking　. All rights reserved.
//

#import "SKTabBarController.h"

#import "SKBaseNavigationController.h"
#import "SKHomeViewController.h"
#import "SKUserViewController.h"
#import "QYFinancialController.h"//理财
#import "QYApplicationController.h"//应用
#import "QYMarketViewController.h"
#import "QYFoundController.h"//发现

#import "CustomHomeViewController.h"
#import "CustomMineViewController.h"
#import "SKCustomWebViewController.h"


@interface SKTabBarController ()

@end

@implementation SKTabBarController


#pragma mark - 第一次使用当前类的时候对设置UITabBarItem的主题
+ (void)initialize {
    
    // 设置为不透明
    [[UITabBar appearance] setTranslucent:NO];
    // 设置背景颜色 底部的背景颜色
    [UITabBar appearance].barTintColor = QYThemeColor;
    [UITabBar appearance].barTintColor = [UIColor whiteColor];
    
    // 拿到整个导航控制器的外观
    UITabBarItem * item = [UITabBarItem appearance];
    item.titlePositionAdjustment = UIOffsetMake(0, 1.5);
    
    // 普通状态 字体颜色
    NSMutableDictionary * normalAtts = [NSMutableDictionary dictionary];
    normalAtts[NSFontAttributeName] = SKFont(12.0f);
    normalAtts[NSForegroundColorAttributeName] = SKItemNormalColor;
    [item setTitleTextAttributes:normalAtts forState:UIControlStateNormal];
    
    // 选中状态 字体颜色
    NSMutableDictionary *selectAtts = [NSMutableDictionary dictionary];
    selectAtts[NSFontAttributeName] = SKFont(12.0f);
    selectAtts[NSForegroundColorAttributeName] = [UIColor colorWithHexString:@"#1186CE"]; //SKColor(198, 167, 113, 1.0);
    [item setTitleTextAttributes:selectAtts forState:UIControlStateSelected];
    

    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = SKWhiteColor;
    
    //加载视图 初始化tabBar
//    [self loadSubView];
    [self storyboardSubView];
    
    
    
}

- (void)storyboardSubView {
    CustomHomeViewController *home = [[UIStoryboard storyboardWithName:@"Home" bundle:nil] instantiateViewControllerWithIdentifier:@"CustomHome"];
     [self addChildViewController:home imagename:@"icon_wallet" title:@"Wallet"];

    [self addChildViewController:[[QYMarketViewController alloc]init] imagename:@"icon_market" title:@"Market"];
//    [self addChildViewController:[[QYFoundController alloc]init] imagename:@"icon_found" title:@"Find"];
//    [self addChildViewController:[[QYFoundController alloc]init] imagename:@"icon_market" title:@"行情"];
//
//    [self addChildViewController:[[SKCustomWebViewController alloc]initWithUrl:QYAPI_getStarmoney_Url] imagename:@"icon_found" title:@"发现"];

    
    CustomMineViewController *mine = [[UIStoryboard storyboardWithName:@"Mine" bundle:nil] instantiateViewControllerWithIdentifier:@"CustomMine"];
    [self addChildViewController:mine imagename:@"icon_user" title:@"Mine"];
//    [self addChildViewController:[[SKUserViewController  alloc]init] imagename:@"icon_user" title:@"我的"];
}

//- (void)loadSubView {
//
//
//
//    [self addChildViewControllerWithClassname:[SKHomeViewController description] imagename:@"icon_wallet" title:@"钱包"];
//
////    [self addChildViewControllerWithClassname:[QYFinancialController description] imagename:@"AI收益" title:@"AI收益"];
//    [self addChildViewControllerWithClassname:[QYApplicationController description] imagename:@"icon_market" title:@"应用"];
//    [self addChildViewControllerWithClassname:[QYFoundController description] imagename:@"icon_found" title:@"发现"];
//
//
//
//    [self addChildViewControllerWithClassname:[SKUserViewController description] imagename:@"icon_user" title:@"我的"];
//}

- (void)addChildViewController:(UIViewController *)viewController
                     imagename:(NSString *)imagename
                         title:(NSString *)title
{
    viewController.navigationItem.title = title;
    SKBaseNavigationController *nav = [[SKBaseNavigationController alloc] initWithRootViewController:viewController];
    nav.tabBarItem.title = title;
    
    
    //    适配IPad
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
        
        [nav.tabBarItem setTitleTextAttributes:@{NSFontAttributeName:SKFont(7)} forState:UIControlStateNormal];
        
    }
    
//    if ([viewController isKindOfClass:[SKCustomWebViewController class]]) {
//        [viewController.navigationController setNavigationBarHidden:YES animated:NO];
//    }
//    
    
    UIImage *myImage = [UIImage imageNamed:[imagename stringByAppendingString:@"_gray"]];
    myImage = [myImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav.tabBarItem.image = myImage;
    
    
    nav.tabBarItem.selectedImage = [[UIImage imageNamed:[imagename stringByAppendingString:@"_blue"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    [self addChildViewController:nav];
}

// 添加子控制器
- (void)addChildViewControllerWithClassname:(NSString *)classname
                                  imagename:(NSString *)imagename
                                      title:(NSString *)title {
    
    UIViewController *vc = [[NSClassFromString(classname) alloc] init];
    vc.navigationItem.title = title;
    SKBaseNavigationController *nav = [[SKBaseNavigationController alloc] initWithRootViewController:vc];
    nav.tabBarItem.title = title;
    
    
    //    适配IPad
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
        
        [nav.tabBarItem setTitleTextAttributes:@{NSFontAttributeName:SKFont(7)} forState:UIControlStateNormal];
        
    }
    
    
    UIImage *myImage = [UIImage imageNamed:[imagename stringByAppendingString:@"_gray"]];
    myImage = [myImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav.tabBarItem.image = myImage;
    
    
    nav.tabBarItem.selectedImage = [[UIImage imageNamed:[imagename stringByAppendingString:@"_blue"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    [self addChildViewController:nav];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
