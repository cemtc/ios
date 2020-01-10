//
//  CustomImportMnmonicWordViewController.m
//  wallet
//
//  Created by 曾云 on 2019/8/17.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "CustomImportMnmonicWordViewController.h"
#import "CustomImportMnmonicWordTableViewCell.h"
#import "CustomImportMnmonicWordSectionView.h"
#import "CustomImportMnmonicWordModel.h"

@interface CustomImportMnmonicWordViewController ()
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;

@property (nonatomic,strong) CustomImportMnmonicWordModel *model;

@end

@implementation CustomImportMnmonicWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.model = [[CustomImportMnmonicWordModel alloc]init];
    self.navigationItem.title = @"Mnemonic import";
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
    CustomImportMnmonicWordItemModel *itemModel = self.model.dataArray[indexPath.row];
    CustomImportMnmonicWordTableViewCell *cell = [CustomImportMnmonicWordTableViewCell cellWithTableView:tableView identifier:itemModel.objc_Identifier];
    cell.itemModel = itemModel;
    cell.textFieldBlock = ^(ImportMnmonicWordItemType type,NSString *text) {
        switch (type) {
            case ImportMnmonicWordItemType_Name:
            {
                self.model.name = text;
            }
                break;
            case ImportMnmonicWordItemType_Password:
            {
                self.model.password = text;
            }
                break;
                
            case ImportMnmonicWordItemType_NewPassword:
            {
                self.model.newpassword = text;
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
    CustomImportMnmonicWordSectionView *footer = [CustomImportMnmonicWordSectionView initViewWithXibIndex:1];
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
    if ([wallet creatWalletAccountWithKey_eth:@"" mnemonic:self.model.mnmonicWord wallet_Identifier:userModel.projectName]) {
        NSLog(@"创建钱包成功 %@ %@",CustomWallet.privateKey,CustomWallet.address);
        userModel.name = self.model.name;
        userModel.passwrod = self.model.password;
        userModel.privateKey = wallet.privateKey;
        userModel.ethAddress = wallet.address;
        userModel.ethMnemonic = wallet.ethMnemonic;
        [[CustomUserManager customSharedManager]loginFinish:userModel];
        NSLog(@"a === %@",wallet.items);
        [MBProgressHUD showMessage:@"Mnemonic import success"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"run-----");
            KEY_WINDOW.rootViewController = [[SKTabBarController alloc]init];
        });
    } else {
        [MBProgressHUD showMessage:@"Mnemonic import fail, again import"];
        NSLog(@"创建钱包失败");
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    CustomImportMnmonicWordSectionView *header = [CustomImportMnmonicWordSectionView initViewWithXibIndex:0];
    @weakify(self);
    header.textViewBlock = ^(NSString * _Nonnull text) {
        @strongify(self);
        self.model.mnmonicWord = text;
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
