//
//  CustomMineViewController.m
//  wallet
//
//  Created by 曾云 on 2019/8/17.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "CustomMineViewController.h"
#import "CustomMineTableViewCell.h"
#import "CustomMineSectionView.h"
#import "CustomMineModel.h"

#import "CustomNotificationCenterViewController.h"
#import "CustomUserFeedBackViewController.h"
#import "CustomModifyPassWordViewController.h"
#import "CustomAboutMeViewController.h"
#import "CustomVersionViewController.h"

#import "SKCustomWebViewController.h"

@interface CustomMineViewController ()
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;

@property (weak, nonatomic) IBOutlet UILabel *walletName;/**< 钱包名称 */
@property (weak, nonatomic) IBOutlet UIImageView *header_img;/**< 头像 */
@property (nonatomic,strong) CustomMineModel *model;

@end

@implementation CustomMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.barStyle = UIStatusBarStyleLightContent;
    self.model = [[CustomMineModel alloc]init];
    self.walletName.text = @"EMTC Wallet";
    //self.walletName.text = [CustomUserManager customSharedManager].userModel.name;
 
//    CFQtestSwift *a = [[CFQtestSwift alloc]init];
//    NSString *str1 = [a QueryWalletAddressDataWithType:@"BTC"];
//    NSString *str2 = [a QueryWalletAddressDataWithType:@"ETH"];

    [[NSRunLoop currentRunLoop] addTimer:[NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(timer) userInfo:nil repeats:YES] forMode:NSRunLoopCommonModes];
    [self timer];
}
-(void)loadBtcNoticeData{
    NSString *obj = [[NSUserDefaults standardUserDefaults] objectForKey:@"BTCethAddress"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [CFQCommonServer getBTCNoticeTransRecordPage:1 address:obj complete:^(NSInteger count) {
        CustomMineItemModel *notification = self.model.setup.itemArray.firstObject;
        notification.count = count;
        if (count) {
            [self getTokenNoticeTransRecordPage:count];
        }else{
            self.navigationController.tabBarItem.badgeValue = nil;
        }
        [self.mainTableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
    }];
    
}
-(void)getTokenNoticeTransRecordPage:(NSInteger)index{
    [CFQCommonServer getTokenNoticeTransRecordPage:1 address:[CustomUserManager customSharedManager].userModel.ethAddress complete:^(NSInteger count) {
        CustomMineItemModel *notification = self.model.setup.itemArray.firstObject;
        notification.count = count + index;
        if (notification.count) {
            self.navigationController.tabBarItem.badgeValue = [NSString stringWithFormat:@"%ld",(long)notification.count];
        }else{
            self.navigationController.tabBarItem.badgeValue = nil;
        }
        [self.mainTableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
    }];
}
- (void)timer {
    [self loadBtcNoticeData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIView setAnimationsEnabled:YES];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.model.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.model.dataArray[section] itemArray].count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomMineItemModel *itemModel = [self.model.dataArray[indexPath.section] itemArray][indexPath.row];
    CustomMineTableViewCell *cell = [CustomMineTableViewCell cellWithTableView:tableView identifier:itemModel.objc_Identifier];
    cell.itemModel = itemModel;
    return cell;
}


#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [[self.model.dataArray[indexPath.section] itemArray][indexPath.row] objc_Height];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [self.model.dataArray[section] header_Height];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return [self.model.dataArray[section] footer_Height];;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc]initWithFrame:CGRectZero];;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    CustomMineSectionView *header = [CustomMineSectionView initViewWithXibIndex:0];
    header.sectionModel = self.model.dataArray[section];
    
    return header;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
     CustomMineItemModel *itemModel = [self.model.dataArray[indexPath.section] itemArray][indexPath.row];
    
    switch (itemModel.type) {
        case CustomMineItemType_NotificationCenter:
        {
            CustomNotificationCenterViewController *viewController = [[UIStoryboard storyboardWithName:@"Mine" bundle:nil] instantiateViewControllerWithIdentifier:@"CustomNotificationCenter"];
            [self pushVc:viewController];
        }
            break;
            
        case CustomMineItemType_UserFeedback:
        {
            CustomUserFeedBackViewController *viewController = [[UIStoryboard storyboardWithName:@"Mine" bundle:nil] instantiateViewControllerWithIdentifier:@"CustomUserFeedBack"];
            [self pushVc:viewController];
        }
            break;
            
        case CustomMineItemType_ModifyPassword:
        {
            CustomModifyPassWordViewController *viewController = [[UIStoryboard storyboardWithName:@"Mine" bundle:nil] instantiateViewControllerWithIdentifier:@"CustomModifyPassWord"];
            [self pushVc:viewController];
        }
            break;
            
//        case CustomMineItemType_UserAgreement:
//        {
//            SKCustomWebViewController *viewController =  [[SKCustomWebViewController alloc]initWithUrl:UserAgreement];
//            viewController.navigationItem.title = @"用户协议";
//            [self pushVc:viewController];
//        }
//            break;
//            
        case CustomMineItemType_AboutMe:
        {
            CustomAboutMeViewController *viewController = [[UIStoryboard storyboardWithName:@"Mine" bundle:nil] instantiateViewControllerWithIdentifier:@"CustomAboutMe"];
            [self pushVc:viewController];
        }
            break;
        case CustomMineItemType_Version:
        {
            CustomVersionViewController *viewController = [[UIStoryboard storyboardWithName:@"Mine" bundle:nil] instantiateViewControllerWithIdentifier:@"CustomVersion"];
            [self pushVc:viewController];
        }
            break;
        case CustomMineItemType_LoginOut:
        {

            CustomWalletPassWordView *password = [CustomWalletPassWordView initViewWithXibIndex:0];
            [password showClickButton:^(NSString * _Nonnull text) {
                NSString *user_password = [CustomUserManager customSharedManager].userModel.passwrod;
                if (![text isEqualToString:user_password]) {
                    [MBProgressHUD showMessage:@"密码错误"];
                    return ;
                }
            }];
            password.CanclebuttonClickBlock = ^(NSString * _Nonnull text) {
                NSUserDefaults *userdefout = [NSUserDefaults standardUserDefaults];
                [userdefout setObject:@"1" forKey:@"loginout"];
                [userdefout synchronize];
                [self exitApplication];


            };
        }
            break;
            
        default:
            break;
    }
}
- (void)exitApplication {
    exit(0);
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
