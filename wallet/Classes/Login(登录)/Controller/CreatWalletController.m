//
//  CreatWalletController.m
//  wallet
//
//  Created by talking　 on 2019/6/25.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "CreatWalletController.h"
#import "CreatWalletCell.h"
#import "CreatWalletModel.h"
#import "CreatWalletFooterView.h"

#import "ImportMnemonicAndPrivite.h"

#import "NSString+MD5.h"

#define Tip @"The private key is not imported to generate the default wallet"

@interface CreatWalletController ()<CreatWalletFooterViewDelegate>
/*底部视图*/
@property (nonatomic, strong) CreatWalletFooterView *footerView;

@end

@implementation CreatWalletController

- (CreatWalletFooterView *)footerView {
    if (!_footerView) {
        _footerView = [[CreatWalletFooterView alloc]initWithFrame:CGRectMake(0, 0, SKScreenWidth, 50)];
        self.tableView.tableFooterView = _footerView;
        _footerView.delegate = self;
    }
    return _footerView;
}


- (void)qycreatWalletFooterView:(CreatWalletFooterView *)footerView didClickInfo:(NSString *)info {
    
    SKDefineWeakSelf;
    [UIAlertView alertWithTitle:@"prompt" message:@"Create a default wallet if no private key is imported" okHandler:^{
        NSLog(@"创建钱包按钮");
        NSString *ETHkey = @"";
        NSString *BTCkey = @"";
        NSString *USDTkey = @"";
        //导入私钥 如果有私钥的话  如果没有私钥就创建默认钱包 caofuqing
        for (CreatWalletModel *model in self.dataArray) {
            
            NSLog(@"%@:%@",model.title,model.context);
            if (![model.context isEqualToString:Tip]) {
                if ([model.title isEqualToString:@"ETH"]) {
                    ETHkey = model.context;
                }else if ([model.title isEqualToString:@"BTC"]){
                    BTCkey = model.context;
                }else if ([model.title isEqualToString:@"USDT"]){
                    USDTkey = model.context;
                }
            }
        }
        
        [weakSelf creatWallLoginETHkey:ETHkey BTCkey:BTCkey USDTkey:USDTkey];

    } cancelHandler:^{
        
    }];
    
}

- (void)creatWallLoginETHkey:(NSString *)ETHkey BTCkey:(NSString *)BTCkey USDTkey:(NSString *)USDTkey{
    
        CFQtestSwift *a = [[CFQtestSwift alloc]init];

        if ([a creatgenerateMnemonicWordWithETHImPrKey:ETHkey BTCImPrKey:BTCkey USDTImPrKey:USDTkey mobileA:self.mobile]) {
            NSLog(@"创建钱包成功");
            [self loginServerETHkey:ETHkey BTCkey:BTCkey USDTkey:USDTkey];
        }else {
            NSLog(@"创建钱包失败");
        }
}
- (void)loginServerETHkey:(NSString *)ETHkey BTCkey:(NSString *)BTCkey USDTkey:(NSString *)USDTkey{
    SKDefineWeakSelf;
    NSMutableDictionary *d = [NSMutableDictionary new];
    [d setValue:self.mobile forKey:@"mobile"];
    [d setValue:MD532(self.password) forKey:@"password"];
    NSDictionary * input = d.copy;
    [MBProgressHUD showMessage:@"Logging in"];
    [CFQCommonServer cfqServerQYAPIloginWithInput:input Callback:^(id  _Nonnull response, BOOL success, NSString * _Nonnull message, NSString * _Nonnull code) {
        
        if (success) {
            NSDictionary *dict = (NSDictionary *)response;
            
            NSLog(@"%@",response);
            NSLog(@"%@",message);
            
            NSMutableDictionary *dicc = [NSMutableDictionary dictionary];
            [dicc setValue:weakSelf.mobile forKey:@"mobile"];
            
            CFQtestSwift *a = [[CFQtestSwift alloc]init];
            
            NSLog(@"此账号本地已经有这个钱包了,直接进入首页");
            //获取当前账号的本地数据库索引
            NSInteger index = [a currentUserModelIndexWithMobileA:weakSelf.mobile];
            [dicc setValue:[NSString stringWithFormat:@"%ld",index] forKey:@"indexString"];
            [dicc setValue:dict[@"token"] forKey:@"token"];
            [dicc setValue:dict[@"customerId"] forKey:@"customerId"];
            [dicc setValue:dict[@"myCode"] forKey:@"myCode"];
            
            //    保存用户登录信息
            [[SKUserInfoManager sharedManager] didLoginInWithUserInfo:dicc];
            //进入首页
            [SKGET_APP_DELEGATE checkLoginFromControl:@"login"];
            
            
            /*
            //网络请求余额
            if (ETHkey.length >= 1) {
                [a wangluoqingqiuBalanceWithType:@"ETH"];
            }
            if (BTCkey.length >= 1) {
                [a wangluoqingqiuBalanceWithType:@"BTC"];
            }
            if (USDTkey.length >= 1) {
                [a wangluoqingqiuBalanceWithType:@"USDT"];
            }
             */
            
            
        }else {
            
            NSLog(@"登录失败");
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [MBProgressHUD showError:message toView:nil];
                [MBProgressHUD showMessage:message];

            });
            
            
        }

    }];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = QYThemeColor;
    
    // 设置导航栏
    [self setUpItems];
    
    // 设置子视图
    [self setUpViews];

}

// 设置导航栏
- (void)setUpItems {
    
    self.navigationItem.title = @"添加钱包";
}

// 设置子视图
- (void)setUpViews {
    
    NSArray *imageNameArr = @[@"qy_BTC",@"qy_ETH",@"qy_USDT"];
    NSArray *titleArr = @[@"BTC",@"ETH",@"USDT"];
    NSArray *contextArr = @[Tip,Tip,Tip];

    for (NSInteger i = 0; i < 3; i++) {
        CreatWalletModel *model = [[CreatWalletModel alloc]init];
        model.title = titleArr[i];
        model.imageBG = imageNameArr[i];
        model.context = contextArr[i];
        [self.dataArray addObject:model];
    }

    //不需要分割线
    self.needCellSepLine = NO;
    

    self.footerView.titleText = @"Confirm add";
}
#pragma mark - UITableViewDelegate
//只有一个Section
- (NSInteger)sk_numberOfSections {
    return 1;
}
//cell 的数据源个数
- (NSInteger)sk_numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
//cell
- (SKBaseTableViewCell *)sk_cellAtIndexPath:(NSIndexPath *)indexPath {
    
    CreatWalletCell *cell = [CreatWalletCell cellWithTableView:self.tableView];
    cell.model = self.dataArray[indexPath.row];
    cell.backgroundColor = QYThemeColor;
    return cell;
}
//cell高度
- (CGFloat)sk_cellheightAtIndexPath:(NSIndexPath *)indexPath {
    return 135;
}
//section headview高度
- (CGFloat)sk_sectionHeaderHeightAtSection:(NSInteger)section {
    return 0;
}
//headview背景颜色为clear
- (UIView *)sk_headerAtSection:(NSInteger)section {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SKScreenWidth, 30)];
    view.backgroundColor = SKClearColor;
    return view;
}
//cell点击事件
- (void)sk_didSelectCellAtIndexPath:(NSIndexPath *)indexPath cell:(SKBaseTableViewCell *)cell {
    CreatWalletModel *model = self.dataArray[indexPath.row];
    
    ImportMnemonicAndPrivite *vc = [[ImportMnemonicAndPrivite alloc]init];
    if ([model.title isEqualToString:@"BTC"]) {
        vc.titleString = @"BTC";
        
    }else if ([model.title isEqualToString:@"ETH"]){
        vc.titleString = @"ETH";

    }else if ([model.title isEqualToString:@"USDT"]){
        vc.titleString = @"USDT";

    }
    
    SKDefineWeakSelf;
    vc.NextViewControllerBlock = ^(NSString * _Nonnull tfText, NSString * _Nonnull type) {
        
        model.context = tfText;
        [weakSelf.dataArray replaceObjectAtIndex:indexPath.row withObject:model];
        [weakSelf sk_reloadData];
    };
    
    [self pushVc:vc];
}


@end
