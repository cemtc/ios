//
//  CustomLoginViewController.m
//  wallet
//
//  Created by 曾云 on 2019/8/17.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "CustomLoginViewController.h"

#import "CustomImportWalletView.h"

#import "CustomCreateIdentityViewController.h"
#import "CustomImportPrivateKeyViewController.h"
#import "CustomImportMnmonicWordViewController.h"

#import "SKCustomWebViewController.h"

@interface CustomLoginViewController ()
@property (nonatomic,assign) BOOL isread;

@end

@implementation CustomLoginViewController

- (IBAction)createIdentity:(UIButton *)sender {
    NSLog(@"创建身份");
//    if (!self.isread) {
//        [MBProgressHUD showMessage:@"请阅读并勾选服务协议"];
//        return;
//    }
    CustomCreateIdentityViewController *viewController = (CustomCreateIdentityViewController *)[[UIStoryboard storyboardWithName:@"User" bundle:nil] instantiateViewControllerWithIdentifier:@"CustomCreateIdentity"];
    [self pushVc:viewController];
}

- (IBAction)agreement:(UIButton *)sender {
    NSLog(@"用户协议");
    SKCustomWebViewController *viewController =  [[SKCustomWebViewController alloc]initWithUrl:UserAgreement];
    viewController.navigationItem.title = @"用户协议";
    [self pushVc:viewController];
}

- (IBAction)readAgreement:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.isread = sender.selected;
    NSLog(@"是否阅读用户协议 = %d",sender.selected);
}
- (IBAction)importWallet:(UIButton *)sender {
    NSLog(@"导入钱包");
//    if (!self.isread) {
//        [MBProgressHUD showMessage:@"请阅读并勾选服务协议"];
//        return;
//    }
    CustomImportWalletView *importWallet = [CustomImportWalletView initViewWithXibIndex:0];
    @weakify(self);
    [importWallet showClickButtonType:^(CustomImportWalletType type) {
        @strongify(self);
        switch (type) {
            case CustomImportWalletType_PrivateKey:
            {
                NSLog(@"回调私钥");
                
            CustomImportPrivateKeyViewController *viewController = [[UIStoryboard storyboardWithName:@"User" bundle:nil] instantiateViewControllerWithIdentifier:@"CustomImportPrivateKey"];
            [self pushVc:viewController];
            }
                break;
                
            case CustomImportWalletType_MnmonicWord:
            {
                NSLog(@"回调助记词");
                CustomImportMnmonicWordViewController *viewController = [[UIStoryboard storyboardWithName:@"User" bundle:nil] instantiateViewControllerWithIdentifier:@"CustomImportMnmonicWord"];
                [self pushVc:viewController];
            }
                break;
                
                
            case CustomImportWalletType_Cancel:
            {
                NSLog(@"回调取消");
            }
                break;
                
            default:
                break;
        }
    }];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isread = NO;
    

    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.barStyle = UIStatusBarStyleLightContent;
     [UIView setAnimationsEnabled:YES];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
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
