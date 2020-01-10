//
//  AppDelegate.m
//  Business
//
//  Created by talking　 on 2018/8/10.
//  Copyright © 2018年 talking　. All rights reserved.
//

#import "AppDelegate.h"

#import "SKBaseNavigationController.h"

#import <IQKeyboardManager.h>


#import "AFNetworking.h"
#import <Bugly/Bugly.h>

#import "CustomLoginViewController.h"
#import "CustomGuideViewController.h"



#import "SKFileCacheManager.h"
#import "QYLoginController.h"

@interface AppDelegate ()

/** 用户基本信息*/
@property (nonatomic, strong) SKUserInfoModel *userInfoModel;

@end

@implementation AppDelegate



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = SKWhiteColor;
    
    

    
    
    //创建本地数据库 钱包模型初始化
    CustomWalletSwift *wallet = CustomWallet;
    [wallet creatDataBase];
//        [a testPro];
    

    

    
    //    这个是判断是不是第一次安装的！！！！！！
    [self checkFirshTimeLaunch];
    
    //基本设置
    [self configAppearance];
    
    //开启App时 检测APP是否要更新
    [self checkAppVersionInfo];

    
    [self.window makeKeyAndVisible];


    return YES;
}
- (void)configAppearance
{
    [[IQKeyboardManager sharedManager] setEnable:YES];
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
    [IQKeyboardManager sharedManager].toolbarBarTintColor = [UIColor colorWithHexString:@"#e3e4e7"];
    
    [SVProgressHUD setBackgroundColor:[UIColor blackColor]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setShouldTintImages:YES];

}

- (SKTabBarController *)tabbarController {
    
    if (!_tabbarController) {
        
        _tabbarController = [[SKTabBarController alloc]init];
    }
    return _tabbarController;
}

//如果是第一次安装  启动新特性   如果不是  去检测之前有没有登录
-(void)checkFirshTimeLaunch {
    
//   if ([[NSUserDefaults standardUserDefaults] boolForKey:SKKEY_HAS_LAUNCHED_ONCE])
//    {
        // app already launched
        [self checkLoginFromControl:@"appdelegate"];
//    }
//    else
//    {
//        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:SKKEY_HAS_LAUNCHED_ONCE];
//        [[NSUserDefaults standardUserDefaults] synchronize];
//
//        [self presentIntro];
//    }
}

//第一次安装App 显示新特性
-(void)presentIntro {
    

}


-(void)checkLoginFromControl:(NSString *)control {
    
    
    BOOL isFfirst = [SKFileCacheManager readUserDataForKey:SKKEY_HAS_LAUNCHED_ONCE];
    if (!isFfirst) {
//        CustomGuideViewController *viewController = (CustomGuideViewController *)[[UIStoryboard storyboardWithName:@"User" bundle:nil] instantiateViewControllerWithIdentifier:@"CustomGuide"];
//        self.window.rootViewController = viewController;
        if ([CustomUserManager customSharedManager].userModel) {
            self.window.rootViewController = [[SKTabBarController alloc]init];
        } else {
            CustomLoginViewController *viewController = (CustomLoginViewController *)[[UIStoryboard storyboardWithName:@"User" bundle:nil] instantiateViewControllerWithIdentifier:@"CustomLogin"];
            self.window.rootViewController  = [[SKBaseNavigationController alloc] initWithRootViewController:viewController];
        }
    } else {
        
        if ([CustomUserManager customSharedManager].userModel) {
             self.window.rootViewController = [[SKTabBarController alloc]init];
        } else {
            CustomLoginViewController *viewController = (CustomLoginViewController *)[[UIStoryboard storyboardWithName:@"User" bundle:nil] instantiateViewControllerWithIdentifier:@"CustomLogin"];
            self.window.rootViewController  = [[SKBaseNavigationController alloc] initWithRootViewController:viewController];
        }
        
//        // 判断是否是登陆状态
//        if ([[CustomUserManager customSharedManager] isLogin]) {
//
//            //如果点击登录过来的 直接进入主页面
//            if ([control isEqualToString:@"login"]) {
//                //            NSLog(@"bbb");
//                //设置SKTabBarController 为rootViewController
//                [self setupTabViewController];
//                return;
//            }
//            [self setupTabViewController];
//        }else {
//            //   判断之前没有登录过  进入登录页面去登录
//            [self setupLoginViewController];
//        }

    }
}

//设置SKLoginViewController 为rootViewController
- (void)setupLoginViewController {
    CustomLoginViewController *viewController = (CustomLoginViewController *)[[UIStoryboard storyboardWithName:@"User" bundle:nil] instantiateViewControllerWithIdentifier:@"CustomLogin"];
        [self.window setRootViewController:[[SKBaseNavigationController alloc] initWithRootViewController:viewController]];

}

//设置SKTabBarController 为rootViewController
- (void)setupTabViewController {
    [self.window setRootViewController:self.tabbarController];
}


-(void)exitSign
{
    //1.  退出登录  清除APP本地保存的登录标识
    [[SKUserInfoManager sharedManager] didLoginOut];
    //    4.UI界面跳转
    self.tabbarController = nil;
    [self checkLoginFromControl:@"exitSign"];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    

}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)checkAppVersionInfo
{
    
    NSString *versionString = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    
    NSMutableDictionary *d = [NSMutableDictionary new];
    [d setValue:versionString forKey:@"versionName"];
    [d setValue:@"2" forKey:@"type"];
    
    NSDictionary * input = d.copy;
    SKDefineWeakSelf;
    [CFQCommonServer cfqServerQYAPIgetVersionInfoWithInput:input Callback:^(id  _Nonnull response, BOOL success, NSString * _Nonnull message, NSString * _Nonnull code) {
        
        if (success) {
            
            NSLog(@"%@",response);
            [CustomUserManager customSharedManager].userModel.serverVerson = response;
            
            [weakSelf downLoadIpaUrl:[NSString stringWithFormat:@"%@",message]];
            
        }else{
            
            NSLog(@"%@",response);
            NSLog(@"%@",message);
            
            NSLog(@"不需要升级");
        }
        
    }];
    
}

-(void)downLoadIpaUrl:(NSString *)url{
    [UIAlertView alertWithTitle:@"提示" message:@"立即更新" okHandler:^{
        
        NSString *iosHyperLink = [NSString stringWithFormat:@"itms-services://?action=download-manifest&url=%@",url];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:iosHyperLink]];
        
    } cancelHandler:^{
        
    }];
    
}
- (void)checkNewBuild{
    [CFQCommonServer checkNewBuildCallback:^(BOOL isUpdate) {
        if (isUpdate) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [UIAlertView alertWithTitle:@"提示" message:@"立即更新" okHandler:^{
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://fir.im/wToken"]];
                } cancelHandler:^{
                }];
            });
            
        }else{
            NSLog(@"不更新");
        }
    }];

}
@end
