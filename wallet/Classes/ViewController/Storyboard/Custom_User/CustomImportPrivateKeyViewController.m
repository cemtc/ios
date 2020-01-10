//
//  CustomImportPrivateKeyViewController.m
//  wallet
//
//  Created by 曾云 on 2019/8/17.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "CustomImportPrivateKeyViewController.h"
#import "CustomImportPrivateKeySectionView.h"
#import "CustomImportPrivateKeyTableViewCell.h"
#import "CustomImportPrivateKeyModel.h"

@interface CustomImportPrivateKeyViewController ()
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;

@property (nonatomic,strong) CustomImportPrivateKeyModel *model;
@end

@implementation CustomImportPrivateKeyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.model = [[CustomImportPrivateKeyModel alloc]init];
    self.navigationItem.title = @"Import private key";
    [self leftBarButtomItemWithNormalName:@"icon_return_black" highName:@"icon_return_black" selector:@selector(back) target:self];
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.model.dataArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomImportPrivateKeyItemModel *itemModel = self.model.dataArray[indexPath.row];
    CustomImportPrivateKeyTableViewCell *cell = [CustomImportPrivateKeyTableViewCell cellWithTableView:tableView identifier:itemModel.objc_Identifier];
    cell.itemModel = itemModel;
    cell.textFieldBlock = ^(ImportPrivateKeyItemType type,NSString *text) {
        switch (type) {
            case ImportPrivateKeyItemType_Name:
            {
                self.model.name = text;
            }
                break;
            case ImportPrivateKeyItemType_NewPassword:
            {
                self.model.newpassword = text;
            }
                break;
                
            case ImportPrivateKeyItemType_Password:
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
    CustomImportPrivateKeySectionView *footer = [CustomImportPrivateKeySectionView initViewWithXibIndex:1];
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
    if ([wallet creatWalletAccountWithKey_eth:self.model.privateKey mnemonic:@"" wallet_Identifier:userModel.projectName]) {
        NSLog(@"创建钱包成功 %@ %@",CustomWallet.privateKey,CustomWallet.address);
        userModel.name = self.model.name;
        userModel.passwrod = self.model.password;
        userModel.privateKey = wallet.privateKey;
         userModel.ethAddress = wallet.address;
         userModel.ethMnemonic = wallet.ethMnemonic;
        [[CustomUserManager customSharedManager]loginFinish:userModel];
        NSLog(@"a === %@",wallet.items);
        [MBProgressHUD showMessage:@"Import private success"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"run-----");
            KEY_WINDOW.rootViewController = [[SKTabBarController alloc]init];
        });
    } else {
        [MBProgressHUD showMessage:@"Import private key fail ,please again import"];
        NSLog(@"创建钱包失败");
    }
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    CustomImportPrivateKeySectionView *header = [CustomImportPrivateKeySectionView initViewWithXibIndex:0];
    @weakify(self);
    header.textViewBlock = ^(NSString * _Nonnull text) {
        @strongify(self);
        self.model.privateKey = text;
    };
    return header;
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
