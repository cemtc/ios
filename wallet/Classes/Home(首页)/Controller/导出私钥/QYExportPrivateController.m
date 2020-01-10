//
//  QYExportPrivateController.m
//  wallet
//
//  Created by talking　 on 2019/6/26.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "QYExportPrivateController.h"
#import "QYExportPrivateListCell.h"
#import "QYExportPrivateListModel.h"
#import "MSPayPwdInputView.h"


@interface QYExportPrivateController ()

@end

@implementation QYExportPrivateController

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
    
    
    self.navigationItem.title = @"私钥导出";
}

// 设置子视图
- (void)setUpViews {
    
    NSArray *imageNameArr = @[@"qy_BTC",@"qy_ETH",@"qy_USDT"];
    NSArray *titleArr = @[@"BTC",@"ETH",@"USDT"];
    
    CFQtestSwift *a = [[CFQtestSwift alloc]init];
    BTCWalletModel *btcModel = [a currentBTCModel];
    ETHWalletModel *ethModel = [a currentETHModel];
    USDTWalletModel *usdtModel = [a currentUSDTModel];

    NSArray *addressArray = @[btcModel.adress,ethModel.adress,usdtModel.adress];
    NSArray *privateArray = @[btcModel.priviteKey,ethModel.priviteKey,usdtModel.priviteKey];
    
    for (NSInteger i = 0; i < 3; i++) {
        QYExportPrivateListModel *model = [[QYExportPrivateListModel alloc]init];
        model.imageName = imageNameArr[i];
        model.title = titleArr[i];
        model.addressString = addressArray[i];
        model.privateString = privateArray[i];
        [self.dataArray addObject:model];
    }

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
    
    QYExportPrivateListCell *cell = [QYExportPrivateListCell cellWithTableView:self.tableView];
    cell.model = self.dataArray[indexPath.row];
    cell.backgroundColor = QYThemeColor;
    return cell;
}
//cell高度
- (CGFloat)sk_cellheightAtIndexPath:(NSIndexPath *)indexPath {
    return 200;
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
    
}

@end
