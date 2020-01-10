//
//  CreatWallViewController.m
//  wallet
//
//  Created by 张威威 on 2019/9/8.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "CreatWallViewController.h"
#import "CreatWallItemCell.h"
#import "CreatWallWithTypeView.h"
#import "ZWMnemoincAndPrivaceViewController.h"
#import "ZWMakeMallViewController.h"
@interface CreatWallViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *myTabview;
//@property (nonatomic,strong)NSMutableArray *dataSourceARR;
@end

@implementation CreatWallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"create wallet";
   [self leftBarButtomItemWithNormalName:@"icon_return_black" highName:@"icon_return_black" selector:@selector(back) target:self];
    [self.view addSubview:self.myTabview];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
            {//jinlai进来默认创建了ccm钱包
                [MBProgressHUD showMessage:@"At most one EMTC address can exist！"];
                //ccm  程序进来.默认创建了当前钱包
//                CreatWallWithTypeView *importWallet = [CreatWallWithTypeView initViewWithXibIndex:0];
//                @weakify(self);
//                [importWallet showClickButtonType:^(CustomImportWalletType type) {
//                    @strongify(self);
//                    switch (type) {
//                        case CustomImportWalletType_PrivateKey:
//                        {
//                            NSLog(@"回调私钥");
//                            ZWMnemoincAndPrivaceViewController *viewController = [[ZWMnemoincAndPrivaceViewController alloc]init];
//                            viewController.Type = @"1";
//                            [self pushVc:viewController];
//                        }
//                            break;
//                        case CustomImportWalletType_MnmonicWord:
//                        {
//                            NSLog(@"回调助记词");
//                            ZWMnemoincAndPrivaceViewController *viewController = [[ZWMnemoincAndPrivaceViewController alloc]init];
//                            viewController.Type = @"2";
//                            [self pushVc:viewController];
//                        }
//                            break;
//                        case CustomImportWalletType_CraetWall:
//                        {
//                            NSLog(@"创建钱包");
//                            ZWMakeMallViewController *viewController = [[ZWMakeMallViewController alloc]init];
//                            [self pushVc:viewController];
//                        }
//                            break;
//                        case CustomImportWalletType_Cancel:
//                        {
//                            NSLog(@"回调取消");
//                        }
//                            break;
//
//                        default:
//                            break;
//                    }
//                }];
            }
            break;
        case 1:
        {
            //btc  判断本地是否有BTC钱包
            CustomWalletSwift *a = [[CustomWalletSwift alloc]init];
            BOOL ishaveBtc = [a isHasWalletHandleWithMobileA:@"BTC"];
            if (ishaveBtc) {
                [MBProgressHUD showMessage:@"At most one BTC address can exist!"];
            } else {
                //开始创建钱包
                CreatWallWithTypeView *importWallet = [CreatWallWithTypeView initViewWithXibIndex:0];
                @weakify(self);
                [importWallet showClickButtonType:^(CustomImportWalletType type) {
                    @strongify(self);
                    switch (type) {
                        case CustomImportWalletType_PrivateKey:
                        {
                            NSLog(@"回调私钥");
                            ZWMnemoincAndPrivaceViewController *viewController = [[ZWMnemoincAndPrivaceViewController alloc]init];
                            viewController.Type = @"1";
                            viewController.WallType = @"BTC";
                            [self pushVc:viewController];
                        }
                            break;

                        case CustomImportWalletType_MnmonicWord:
                        {
                            NSLog(@"回调助记词");
                            ZWMnemoincAndPrivaceViewController *viewController = [[ZWMnemoincAndPrivaceViewController alloc]init];
                            viewController.Type = @"2";
                            viewController.WallType = @"BTC";
                            [self pushVc:viewController];
                        }
                            break;

                        case CustomImportWalletType_CraetWall:
                        {
                            NSLog(@"创建钱包");
                            ZWMakeMallViewController *viewController = [[ZWMakeMallViewController alloc]init];
                            viewController.Type = @"3";
                            viewController.WallType = @"BTC";
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



        }
            break;
        case 2:
        {
            //usdt  eth
            NSLog(@"判断当前x数据库中是否有以太坊钱包");
            NSUserDefaults *userDefure = [NSUserDefaults standardUserDefaults];
            NSString *ishaveETH = [userDefure objectForKey:@"ishaveETH"];
            if ([ishaveETH isEqualToString:@"1"]) {
               [MBProgressHUD showMessage:@"At most one ETH address can exist！"];
            }else{
                CreatWallWithTypeView *importWallet = [CreatWallWithTypeView initViewWithXibIndex:0];
                @weakify(self);
                [importWallet showClickButtonType:^(CustomImportWalletType type) {
                    @strongify(self);
                    switch (type) {
                        case CustomImportWalletType_PrivateKey:
                        {
                            NSLog(@"回调私钥");
                            ZWMnemoincAndPrivaceViewController *viewController = [[ZWMnemoincAndPrivaceViewController alloc]init];
                            viewController.Type = @"1";
                            viewController.WallType = @"ETH";
                            [self pushVc:viewController];
                        }
                            break;

                        case CustomImportWalletType_MnmonicWord:
                        {
                            NSLog(@"回调助记词");
                            ZWMnemoincAndPrivaceViewController *viewController = [[ZWMnemoincAndPrivaceViewController alloc]init];
                            viewController.Type = @"2";
                            viewController.WallType = @"ETH";
                            [self pushVc:viewController];
                        }
                            break;

                        case CustomImportWalletType_CraetWall:
                        {
                            NSLog(@"创建钱包");
                            ZWMakeMallViewController *viewController = [[ZWMakeMallViewController alloc]init];
                            viewController.Type = @"3";
                            viewController.WallType = @"ETH";
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
//            CustomWalletSwift *a = [[CustomWalletSwift alloc]init];
//            BOOL ishaveBtc = [a isHasWalletHandleWithMobileA:@"ETH"];
//            if (ishaveBtc) {
//                [MBProgressHUD showMessage:@"最多只能存在一个ETH地址！"];
//            } else {
//                CreatWallWithTypeView *importWallet = [CreatWallWithTypeView initViewWithXibIndex:0];
//                @weakify(self);
//                [importWallet showClickButtonType:^(CustomImportWalletType type) {
//                    @strongify(self);
//                    switch (type) {
//                        case CustomImportWalletType_PrivateKey:
//                        {
//                            NSLog(@"回调私钥");
//                            ZWMnemoincAndPrivaceViewController *viewController = [[ZWMnemoincAndPrivaceViewController alloc]init];
//                            viewController.Type = @"1";
//                            viewController.WallType = @"ETH";
//                            [self pushVc:viewController];
//                        }
//                            break;
//
//                        case CustomImportWalletType_MnmonicWord:
//                        {
//                            NSLog(@"回调助记词");
//                            ZWMnemoincAndPrivaceViewController *viewController = [[ZWMnemoincAndPrivaceViewController alloc]init];
//                            viewController.Type = @"2";
//                            viewController.WallType = @"ETH";
//                            [self pushVc:viewController];
//                        }
//                            break;
//
//                        case CustomImportWalletType_CraetWall:
//                        {
//                            NSLog(@"创建钱包");
//                            ZWMakeMallViewController *viewController = [[ZWMakeMallViewController alloc]init];
//                            viewController.Type = @"3";
//                            viewController.WallType = @"ETH";
//                            [self pushVc:viewController];
//
//                        }
//                            break;
//                        case CustomImportWalletType_Cancel:
//                        {
//                            NSLog(@"回调取消");
//                        }
//                            break;
//                        default:
//                            break;
//                    }
//                }];
//
//            }

        }
            break;
        default:
            break;
    }

}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    CreatWallItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CreatWallItemCell" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[CreatWallItemCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CreatWallItemCell"];
    }
    NSArray *BgImageNameARR = [NSArray arrayWithObjects:@"EMTC",@"BTC",@"ETH", nil];
    NSArray *IconImageNameARR = [NSArray arrayWithObjects:@"logo_ccm",@"logo_btc",@"logo_eth", nil];
    NSArray *TitleARR = [NSArray arrayWithObjects:@"EMTC-Wallet",@"BTC-Wallet",@"ETH-Wallet", nil];
    [cell UpdateWithBgImageName:BgImageNameARR[indexPath.row] iconImage:IconImageNameARR[indexPath.row] Title:TitleARR[indexPath.row]];
    return cell;
}
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1f;
}
- (UITableView *)myTabview{
    if (_myTabview == nil) {
        _myTabview = [[UITableView alloc]initWithFrame:CGRectMake(0, 15, self.view.width, self.view.height - 70) style:UITableViewStylePlain];
        _myTabview.delegate = self;
        _myTabview.dataSource = self;
        _myTabview.rowHeight = 100.0f;
        _myTabview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _myTabview.showsVerticalScrollIndicator = NO;
        _myTabview.backgroundColor = [UIColor clearColor];
        [_myTabview registerClass:[CreatWallItemCell class] forCellReuseIdentifier:@"CreatWallItemCell"];
    }
    return _myTabview;
}
@end
