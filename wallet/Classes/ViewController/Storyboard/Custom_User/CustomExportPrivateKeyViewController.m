//
//  CustomExportPrivateKeyViewController.m
//  wallet
//
//  Created by 曾云 on 2019/8/17.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "CustomExportPrivateKeyViewController.h"
#import "CustomExportPrivateKeyTableViewCell.h"

@interface CustomExportPrivateKeyViewController ()
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;

@property(nonatomic,strong)NSMutableArray *addressARR;
@property(nonatomic,strong)NSMutableArray *siyaoARR;
@property(nonatomic,strong)NSMutableArray *nameARR;
@end

@implementation CustomExportPrivateKeyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Private key export";
    [self leftBarButtomItemWithNormalName:@"icon_return_black" highName:@"icon_return_black" selector:@selector(back) target:self];
    CustomWalletSwift *a = [[CustomWalletSwift alloc]init];
    BOOL ishaveBtc = [a isHasWalletHandleWithMobileA:@"BTC"];
    //拿到当前钱包
    if (ishaveBtc) {
        CFQtestSwift *textSwift = [[CFQtestSwift alloc]init];
        BTCWalletModel *BTCModel = [textSwift customCurrentZWBTCModel];
        if (BTCModel) {
            [self.addressARR addObject:BTCModel.adress];
            [self.nameARR addObject:@"BTC"];
            [self.siyaoARR addObject:BTCModel.priviteKey];
            CustomUserModel *model =  [CustomUserManager customSharedManager].userModel;
            [self.addressARR addObject:model.ethAddress];
            [self.nameARR addObject:@"EMTC"];
            [self.siyaoARR addObject:model.privateKey];
            [self.mainTableView reloadData];
            [self getETHWallWith];
        }else{
            CustomUserModel *model =  [CustomUserManager customSharedManager].userModel;
            [self.addressARR addObject:model.ethAddress];
            [self.nameARR addObject:@"EMTC"];
            [self.siyaoARR addObject:model.privateKey];
            [self.mainTableView reloadData];
            [self getETHWallWith];

        }
    }else{
        CustomUserModel *model =  [CustomUserManager customSharedManager].userModel;
        [self.addressARR addObject:model.ethAddress];
        [self.nameARR addObject:@"EMTC"];
        [self.siyaoARR addObject:model.privateKey];
        [self.mainTableView reloadData];
        [self getETHWallWith];
    }
}
-(void)getETHWallWith{
    NSUserDefaults *userDefure = [NSUserDefaults standardUserDefaults];
    NSString *ishaveETH = [userDefure objectForKey:@"ishaveETH"];
    if ([ishaveETH isEqualToString:@"1"]){
        ZWETHWallModel *ZWETHModel = [[ZWETHWallModel alloc]init];
        ZWETHModel.adress =[userDefure objectForKey:@"adress"];
        ZWETHModel.mnemonic =[userDefure objectForKey:@"mnemonic"];
        ZWETHModel.priviteKey =[userDefure objectForKey:@"priviteKey"];
        ZWETHModel.publiceKey =[userDefure objectForKey:@"publiceKey"];
        ZWETHModel.name =[userDefure objectForKey:@"name"];
        ZWETHModel.imgurl =[userDefure objectForKey:@"imgurl"];
        [self.addressARR addObject:ZWETHModel.adress];
        [self.nameARR addObject:@"ETH"];
        [self.siyaoARR addObject:ZWETHModel.priviteKey];
        [self.mainTableView reloadData];
        NSLog(@"开始获取xccm钱包");

    }else{

    }

}
-(void)getBTCWithwall:(dispatch_group_t)group{
    CustomWalletSwift *a = [[CustomWalletSwift alloc]init];
    BOOL ishaveBtc = [a isHasWalletHandleWithMobileA:@"BTC"];
    if (ishaveBtc) {
        //拿到当前钱包
        CFQtestSwift *textSwift = [[CFQtestSwift alloc]init];
        BTCWalletModel *BTCModel = [textSwift customCurrentZWBTCModel];
        if (BTCModel) {
            [self.addressARR addObject:BTCModel.adress];
            [self.nameARR addObject:@"BTC"];
            [self.siyaoARR addObject:BTCModel.priviteKey];
            dispatch_group_leave(group);
        }else{
            dispatch_group_leave(group);

        }
    }

}
-(void)getETHWallWith:(dispatch_group_t)group{
    NSUserDefaults *userDefure = [NSUserDefaults standardUserDefaults];
    NSString *ishaveETH = [userDefure objectForKey:@"ishaveETH"];
    if ([ishaveETH isEqualToString:@"1"]){
        ZWETHWallModel *ZWETHModel = [[ZWETHWallModel alloc]init];
        ZWETHModel.adress =[userDefure objectForKey:@"adress"];
        ZWETHModel.mnemonic =[userDefure objectForKey:@"mnemonic"];
        ZWETHModel.priviteKey =[userDefure objectForKey:@"priviteKey"];
        ZWETHModel.publiceKey =[userDefure objectForKey:@"publiceKey"];
        ZWETHModel.name =[userDefure objectForKey:@"name"];
        ZWETHModel.imgurl =[userDefure objectForKey:@"imgurl"];
        [self.addressARR addObject:ZWETHModel.adress];
        [self.nameARR addObject:@"ETH"];
        [self.siyaoARR addObject:ZWETHModel.priviteKey];
        dispatch_group_leave(group);
    }else{
        dispatch_group_leave(group);
    }


}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
//包含多个钱包
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.addressARR.count;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomExportPrivateKeyTableViewCell *cell = [CustomExportPrivateKeyTableViewCell cellWithTableView:tableView identifier:@"Identifier_CustomExportPrivateKey"];
    cell.siyao = self.siyaoARR[indexPath.row];
    cell.addressstr = self.addressARR[indexPath.row];
    cell.namestr = self.nameARR[indexPath.row];
    return cell;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 192.0f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc]initWithFrame:CGRectZero];;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc]initWithFrame:CGRectZero];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(NSMutableArray *)addressARR{
    if (_addressARR == nil) {
        _addressARR = [[NSMutableArray alloc]init];
    }
    return _addressARR;
}
-(NSMutableArray *)nameARR{
    if (_nameARR == nil) {
        _nameARR = [[NSMutableArray alloc]init];
    }
    return _nameARR;
}
-(NSMutableArray *)siyaoARR{
    if (_siyaoARR == nil) {
        _siyaoARR = [[NSMutableArray alloc]init];
    }
    return _siyaoARR;
}
@end
