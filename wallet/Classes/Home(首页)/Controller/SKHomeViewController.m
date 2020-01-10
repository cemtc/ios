//
//  SKHomeViewController.m
//  Business
//
//  Created by talking　 on 2018/8/15.
//  Copyright © 2018年 talking　. All rights reserved.
//

#import "SKHomeViewController.h"
#import "QYHomeTopView.h"
#import "QYHomeListCell.h"
#import "QYHomeListModel.h"

//轮播图
#import "JZKHeaderView.h"


//push
#import "QYExportPrivateController.h"
#import "QYMarketViewController.h"

//3.获取汇率
#import "QYgetCoinSystemModel.h"

//公告
#import "QYGonggaoController.h"

#import "MSPayPwdInputView.h"

@interface SKHomeViewController ()
//topView
@property (nonatomic, strong) QYHomeTopView *topView;

//调用封装好的头视图
@property (nonatomic, strong) JZKHeaderView *headerView;
@end

@implementation SKHomeViewController
//////如果不要导航把这个打开
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
   // [UIView setAnimationsEnabled:YES];
    //[self.navigationController setNavigationBarHidden:YES animated:YES];
    
//    //================================================
//    //网络请求余额
//    CFQtestSwift *a = [[CFQtestSwift alloc]init];
//    [a wangluoqingqiuBalanceWithType:@"ETH"];
//    [a wangluoqingqiuBalanceWithType:@"BTC"];
//    [a wangluoqingqiuBalanceWithType:@"USDT"];
//
//
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        //网络请求
//        [self loadData];
//    });
//    //================================================

}
- (QYHomeTopView *)topView {
    if (!_topView) {
        
        CGFloat _originHeight = 0;
        if (SKIsIphoneX) {
            _originHeight = 250 + (88 - 64);
        }else {
            _originHeight = 250;
        }
        
        _topView = [[QYHomeTopView alloc]initWithFrame:CGRectMake(0, 0, SKScreenWidth, _originHeight)];
        _topView.backgroundColor = [UIColor redColor];
//        [self.view addSubview:_topView];
        
        
        if (SKIsIphoneX) {
            self.tableView.contentInset = UIEdgeInsetsMake(_topView.frame.size.height - 44, 0, 0, 0);
        }else{
            self.tableView.contentInset = UIEdgeInsetsMake(_topView.frame.size.height - 20, 0, 0, 0);
        }
        SKDefineWeakSelf;
        _topView.NextViewControllerBlock = ^(NSString * _Nonnull tfText) {
            if ([tfText isEqualToString:@"l"]) {
                [weakSelf daochusiyao];
            }else if ([tfText isEqualToString:@"r"]){
                QYMarketViewController *vc = [[QYMarketViewController alloc]init];
                [weakSelf pushVc:vc];
            }else if ([tfText isEqualToString:@"公告"]){
                QYGonggaoController *vc = [[QYGonggaoController alloc]init];
                [weakSelf pushVc:vc];
            }
        };
    }
    return _topView;
}

- (void)daochusiyao{
    SKDefineWeakSelf;
    [self verifyisPassWordCallback:^(BOOL isLogin, NSString *passD) {
        if (isLogin) {
            QYExportPrivateController *vc = [[QYExportPrivateController alloc]init];
            [weakSelf pushVc:vc];
        }else{
            //                [MBProgressHUD showMessage:@"您输入密码不对"];
        }
    }];
}

- (JZKHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[JZKHeaderView alloc]initWithFrame:CGRectMake(10, 10, SKScreenWidth-20, 110.0f)];
        _headerView.backgroundColor = [UIColor colorWithHexString:@"#0693C2"];
        
        _headerView.headViewBlock = ^(NSInteger index){
            
            NSLog(@"%ld",index);
        };
        [self.view addSubview:_headerView];
    }
    return _headerView;
}
//下拉
- (void)sk_refresh {
    [super sk_refresh];
    //网络请求余额
    CFQtestSwift *a = [[CFQtestSwift alloc]init];
    [a wangluoqingqiuBalanceWithType:@"ETH"];
//    [a wangluoqingqiuBalanceWithType:@"BTC"];
//    [a wangluoqingqiuBalanceWithType:@"USDT"];

    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //网络请求
        [self loadData];
    });
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //修改状态栏颜色
//    self.barStyle = UIStatusBarStyleLightContent;
    
    self.refreshType = SKBaseTableVcRefreshTypeOnlyCanRefresh;

    // 设置导航栏
    [self setUpItems];
    
    // 设置子视图
    [self setUpViews];
    
    //网络请求
    [self loadData];
    
    [self loadDataGonggao];
    
    //================================================
    //网络请求余额操作 是否成功
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dataYueFinish:) name:QYLICAIYUE object:nil];
    
    CFQtestSwift *a = [[CFQtestSwift alloc]init];
    ETHWalletModel *model = [a customCurrentETHModel];
    
    [a wangluoqingqiuBalanceWithType:@"ETH"];
//    [a wangluoqingqiuBalanceWithType:@"BTC"];
//    [a wangluoqingqiuBalanceWithType:@"USDT"];
    //================================================

}
//网络请求余额操作
-(void)dataYueFinish:(NSNotification *)noti
{
    //    let dictionary1 = ["success": "1", "type": type,"balance" : String(format: "%.6f", model.balance)]
    NSDictionary *dict = noti.object;
    if ([dict[@"success"] isEqualToString:@"1"])
    {
        //网络请求
        [self loadData];
        NSLog(@"查询余额成功!");
        //        self.leftView.balanceNum = dict[@"balance"];
    }else{
        NSLog(@"失败======");
    }
}

- (void)loadDataGonggao{
    //5.公告
    NSMutableDictionary *d = [NSMutableDictionary new];
    [d setValue:@"1" forKey:@"pageNo"];
    [d setValue:@"20" forKey:@"pageSize"];
    NSDictionary * input = d.copy;
    SKDefineWeakSelf;
    [CFQCommonServer cfqServerQYAPIGetNoticeListByPageWithInput:input Callback:^(id  _Nonnull response, BOOL success, NSString * _Nonnull message, NSString * _Nonnull code) {
        
        NSMutableArray *dArray = [CFQCommonModel modelArrayWithDictArray:response];
        NSMutableArray *titleArray = [NSMutableArray new];
        for (CFQCommonModel *model in dArray) {
//            NSLog(@"%@",model.noticeTitle);
//            NSLog(@"%@",model.noticeId);
//            NSLog(@"%@",model.isRead);
            //            isRead = 0; 0是没有读 是黑色
            [titleArray addObject:[NSString stringWithFormat:@"公告: %@",model.noticeTitle]];
        }
        weakSelf.topView.gonggaoArrayTop = titleArray.copy;
    }];

}

- (void)loadData {
    //3.获取汇率
    SKDefineWeakSelf;
    NSMutableDictionary *d = [NSMutableDictionary new];
    [d setValue:@"" forKey:@""];
    NSDictionary * input = d.copy;
    [CFQCommonServer cfqServerQYAPIGetCoinSystemWithInput:input Callback:^(id  _Nonnull response, BOOL success, NSString * _Nonnull message, NSString * _Nonnull code) {
        
        //结束刷新
        [weakSelf sk_endRefresh];

        if (success) {
            
            NSMutableArray *dArray = [QYgetCoinSystemModel modelArrayWithDictArray:response];
            
            if (weakSelf.dataArray.count) {
                [weakSelf.dataArray removeAllObjects];
            }
            
            if (dArray.count) {
                [weakSelf reloadHomeUI:dArray.copy];
            }else {
                SKLog(@"数据为空");
            }
            
            //刷新tab
            [weakSelf sk_reloadData];
            
        }else {
            
            NSLog(@"hhh请求失败hhhh");
        }

    }];
    
}
- (void)reloadHomeUI:(NSArray *)array{
    
    float ptb = 0;
    float rmb = 0;
    
    //获取本地钱包
    CFQtestSwift *a = [[CFQtestSwift alloc]init];
    NSString *BTCNum = [a shujukuBalanceWithType:@"BTC"];
    NSString *ETHNum = [a shujukuBalanceWithType:@"ETH"];
    NSString *USDTNum = [a shujukuBalanceWithType:@"USDT"];

    
    //因为要加一块算总资产 肯定要这么写!!!!  最后把值付给
    for (NSInteger i = 0; i < array.count; i++) {
        
        QYHomeListModel *model = [[QYHomeListModel alloc]init];

        QYgetCoinSystemModel *dmodel = array[i];
        
        model.imageName = [NSString stringWithFormat:@"qy_%@",dmodel.coinName];
        model.title = dmodel.coinName;
        model.content = [NSString stringWithFormat:@"%@ Wallet",dmodel.coinName];
        
        //本地钱包
        if ([dmodel.coinName isEqualToString:@"BTC"]) {
            model.number = BTCNum;
            model.price = [NSString stringWithFormat:@"%.2f",[BTCNum floatValue] *[dmodel.rmgExchageRate floatValue]];
            model.pricePTB = [NSString stringWithFormat:@"%.2f",[BTCNum floatValue] *[dmodel.tokenExchageRate floatValue]];

        }else if ([dmodel.coinName isEqualToString:@"ETH"]){
            model.number = ETHNum;
            model.price = [NSString stringWithFormat:@"%.2f",[ETHNum floatValue] *[dmodel.rmgExchageRate floatValue]];
            model.pricePTB = [NSString stringWithFormat:@"%.2f",[ETHNum floatValue] *[dmodel.tokenExchageRate floatValue]];

        }else if ([dmodel.coinName isEqualToString:@"USDT"]){
            model.number = USDTNum;
            model.price = [NSString stringWithFormat:@"%.2f",[USDTNum floatValue] *[dmodel.rmgExchageRate floatValue]];
            model.pricePTB = [NSString stringWithFormat:@"%.2f",[USDTNum floatValue] *[dmodel.tokenExchageRate floatValue]];
        }
        
        [self.dataArray addObject:model];
        
        ptb += [model.pricePTB floatValue];
        rmb += [model.price floatValue];
    }

    self.headerView.contentArr = @[[NSString stringWithFormat:@"%.2f",rmb]].mutableCopy;
    
    if (ptb == 0) {
        self.headerView.bottomArr = @[[NSString stringWithFormat:@"平台币 WINT    %@",@"0"]].mutableCopy;
    }else{
        self.headerView.bottomArr = @[[NSString stringWithFormat:@"平台币 WINT    %.2f",ptb]].mutableCopy;
    }
    
    
    
    //添加假数据start caofuqing
    QYHomeListModel *model1 = [[QYHomeListModel alloc]init];
    model1.imageName = @"logo01";
    model1.title = @"LTK";
    model1.content = @"LTK Wallet";
    model1.number = @"0";//本地钱包
    model1.price = @"0.00";
    model1.isTest = YES;
    [self.dataArray addObject:model1];
    QYHomeListModel *model2 = [[QYHomeListModel alloc]init];
    model2.imageName = @"logo02";
    model2.title = @"BRC";
    model2.content = @"BRC Wallet";
    model2.number = @"0";//本地钱包
    model2.price = @"0.00";
    model2.isTest = YES;
    [self.dataArray addObject:model2];
    QYHomeListModel *model3 = [[QYHomeListModel alloc]init];
    model3.imageName = @"logo03";
    model3.title = @"LAMB";
    model3.content = @"LAMB Wallet";
    model3.number = @"0";//本地钱包
    model3.price = @"0.00";
    model3.isTest = YES;
    [self.dataArray addObject:model3];
    QYHomeListModel *model4 = [[QYHomeListModel alloc]init];
    model4.imageName = @"logo04";
    model4.title = @"BT";
    model4.content = @"BT Wallet";
    model4.number = @"0";//本地钱包
    model4.price = @"0.00";
    model4.isTest = YES;
    [self.dataArray addObject:model4];
    //添加假数据end

}

// 设置导航栏
- (void)setUpItems {
    [self setNavItemTitle:@"Wallet"];
    [self leftBarButtomItemWithNormalName:@"icon_export" highName:@"icon_export" selector:@selector(daochusiyao) target:self];
}

// 设置子视图
- (void)setUpViews {
    self.topView.backgroundColor = SKWhiteColor;
    self.headerView.imageArr=@[].mutableCopy;
    self.headerView.titleArr = @[@"总资产（CNY）"].mutableCopy;
    /*
 self.headerView.contentArr = @[@"1534.06"].mutableCopy;
    self.headerView.bottomArr = @[@"平台币 WINT    103253.00"].mutableCopy;

    NSArray *imageNameArr = @[@"qy_BTC",@"qy_ETH",@"qy_USDT"];
    NSArray *titleArr = @[@"BTC",@"ETH",@"USDT"];
    NSArray *contentArr = @[@"BTC Wallet",@"ETH Wallet",@"USDT Wallet"];
    
    CFQtestSwift *a = [[CFQtestSwift alloc]init];

    NSArray *numberArr = @[[a shujukuBalanceWithType:titleArr[0]],[a shujukuBalanceWithType:titleArr[1]],[a shujukuBalanceWithType:titleArr[2]]];
    NSArray *priceArr = @[@"≈￥62.26",@"≈￥4.26",@"≈￥234.21"];

    for (NSInteger i = 0; i < 3; i++) {
        QYHomeListModel *model = [[QYHomeListModel alloc]init];
        model.imageName = imageNameArr[i];
        model.title = titleArr[i];
        model.content = contentArr[i];
        model.number = numberArr[i];
        model.price = priceArr[i];
        [self.dataArray addObject:model];
    }
    */
    //不需要分割线
    self.needCellSepLine = NO;
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
    
    QYHomeListCell *cell = [QYHomeListCell cellWithTableView:self.tableView];
    cell.model = self.dataArray[indexPath.row];
    cell.backgroundColor = SKCommonBgColor;
    return cell;
}
//cell高度
- (CGFloat)sk_cellheightAtIndexPath:(NSIndexPath *)indexPath {
    return 130;
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
    
    QYHomeListModel *model = self.dataArray[indexPath.row];
    if (model.isTest) {
        [MBProgressHUD showMessage:@"此功能未开放"];
        return;
    }
    CFQtestSwift *a = [[CFQtestSwift alloc]init];
    [a cellPushWithType:model.title indexRow:indexPath.row owner:self];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//验证登录交易密码验证
- (void)verifyisPassWordCallback:(void(^)(BOOL isLogin,NSString *passD))callback{
    
    [MSPayPwdInputView showPwdInputWithTitle:@"输入交易密码" money:0  closeBlock:^{
        callback(NO,@"");
        NSLog(@"guanbi");
    } callBack:^(NSString *pwd) {
        NSLog(@"密码::::::::%@",pwd);
        //验证交易密码测试
        NSMutableDictionary *d = [NSMutableDictionary new];
        [d setValue:MD532(pwd) forKey:@"tradePwd"];
        NSDictionary * input = d.copy;
        [CFQCommonServer cfqServerQYAPIQYAPIcheckTradePwdWithInput:input Callback:^(id  _Nonnull response, BOOL success, NSString * _Nonnull message, NSString * _Nonnull code) {
            if (success) {
                callback(YES,MD532(pwd));
            }else {
                callback(NO,@"");
            }
        }];
    }];
}


@end
