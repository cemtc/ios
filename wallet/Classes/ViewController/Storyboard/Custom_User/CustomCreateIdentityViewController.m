//
//  CustomCreateIdentityViewController.m
//  wallet
//
//  Created by 曾云 on 2019/8/17.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "CustomCreateIdentityViewController.h"
#import "CustomCreateIdentitySectionView.h"
#import "CustomCreateIdentityTableViewCell.h"

#import "CustomCreateIdentityModel.h"
#import "CustomHomeModel.h"

@interface CustomCreateIdentityViewController ()
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;

@property (nonatomic,strong) CustomCreateIdentityModel *model;

@end

@implementation CustomCreateIdentityViewController
- (IBAction)back:(UIButton *)sender {
    [super back];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.model = [[CustomCreateIdentityModel alloc]init];
    [self leftBarButtomItemWithNormalName:@"icon_return_black" highName:@"icon_return_black" selector:@selector(back) target:self];
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    //设置开始和结束位置(设置渐变的方向)
    gradient.startPoint = CGPointMake(0,0);
    gradient.endPoint = CGPointMake(0,1);
    gradient.frame = self.backView.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[UIColor colorWithHexString:@"#0692C2"].CGColor,(id)[UIColor colorWithHexString:@"#1186CE"].CGColor,nil];
    [self.backView.layer insertSublayer:gradient atIndex:0];
//    [self creatCCMWallet];

    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.barStyle = UIStatusBarStyleLightContent;
    [UIView setAnimationsEnabled:YES];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.model.dataArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomCreateIdentityItemModel *itemModel = self.model.dataArray[indexPath.row];
    CustomCreateIdentityTableViewCell *cell = [CustomCreateIdentityTableViewCell cellWithTableView:tableView identifier:itemModel.objc_Identifier];
    cell.itemModel = itemModel;
    cell.textFieldBlock = ^(CreateIdentityItemType type,NSString *text) {
        switch (type) {
            case CreateIdentityItemType_Name:
            {
                self.model.name = text;
            }
                break;
            case CreateIdentityItemType_NewPassword:
            {
                self.model.newpassword = text;
            }
                break;
                
            case CreateIdentityItemType_Password:
            {
                self.model.password = text;
            }
                break;
                
            default:
                break;
        }
    };
    return cell;
}


#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.model.dataArray[indexPath.row] objc_Height];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return self.model.header_Height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return self.model.footer_Height;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    CustomCreateIdentitySectionView *footer = [CustomCreateIdentitySectionView initViewWithXibIndex:0];
    @weakify(self);
    footer.buttonClickBlock = ^{
        @strongify(self);
        NSString *errMsg = self.model.errMsg;
        if (![errMsg isEqualToString:kMNullStr]) {
             [MBProgressHUD showMessage:errMsg];
            return ;
        }
        [self creatCCMWallet];
    };
    return footer;
}


- (void)creatCCMWallet {
    CustomUserModel *userModel = [[CustomUserModel alloc]init];
    CustomWalletSwift *wallet = CustomWallet;
    if ([wallet creatWalletAccountWithKey_eth:@"" mnemonic:@"" wallet_Identifier:userModel.projectName]) {
        NSLog(@"创建钱包成功 %@ %@",wallet.privateKey,wallet.address);
        userModel.name = self.model.name;
        userModel.passwrod = self.model.password;
        userModel.privateKey = wallet.privateKey;
        userModel.ethAddress = wallet.address;
        userModel.ethMnemonic = wallet.ethMnemonic;
        NSLog(@"b888888 === %@",userModel.ethMnemonic);
        [CustomUserManager customSharedManager].userModel.ethMnemonic = wallet.ethMnemonic;
        [[CustomUserManager customSharedManager]loginFinish:userModel];
        NSLog(@"a === %@",wallet.items);
        [MBProgressHUD showMessage:@"Create wallet success"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"run-----");
            KEY_WINDOW.rootViewController = [[SKTabBarController alloc]init];
        });
        
        
    } else {
        [MBProgressHUD showMessage:@"Create wallet fail,Please create again."];
        NSLog(@"创建钱包失败");
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    return [[UIView alloc]initWithFrame:CGRectZero];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
