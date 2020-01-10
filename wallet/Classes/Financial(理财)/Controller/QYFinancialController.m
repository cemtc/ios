//
//  QYFinancialController.m
//  wallet
//
//  Created by talking　 on 2019/6/13.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "QYFinancialController.h"
#import "SKCustomSegmentView.h"
//========================================
#import "NewPagedFlowView.h"
#import "PGCustomBannerView.h"
#define Width [UIScreen mainScreen].bounds.size.width

#define bannerHight Width * 9 / 16 - 50
#define bannerImageHight (Width - 50) * 9 / 16 - 50
//=========================================

#import "QYNewFinancialTopCell.h"
#import "QYNewFinancialCenterCell.h"
#import "QYNewFinancialBottomCell.h"

#import "UIView+Tap.h"

#import "MSPayPwdInputView.h"

#import "QYNewFinancialTopTopCell.h"
#import "QYNewFinancialTopTopCell2.h"


#import "SKCustomAlertView.h"

@interface QYFinancialController ()<NewPagedFlowViewDelegate, NewPagedFlowViewDataSource>
/**
 *  图片数组
 */
@property (nonatomic, strong) NSMutableArray *imageArray;
/**
 *  轮播图
 */
@property (nonatomic, strong) NewPagedFlowView *pageFlowView;

@property (nonatomic, strong) UILabel *switchTipLabel;

@property (nonatomic, strong) UISwitch *switchBtn;

//UI
//bottom tip
@property (nonatomic, copy) NSString *leftbottomCellLabel;
@property (nonatomic, copy) NSString *rightbottomCellLabel;


//当前理财按钮背景图片颜色
@property (nonatomic, assign) BOOL lisOn;


//赎回
@property (nonatomic, copy) NSString * ruseBalance1;//余额
@property (nonatomic, copy) NSString * rpoundage2;//手续费
@property (nonatomic, copy) NSString * rtokenExchageRate3;//汇率

//理财本地余额
@property(nonatomic, copy) NSString *leftBalanceNum;

//0 licai    1shuhui  当前是理财还是赎回
@property (nonatomic, assign) BOOL currentSelectLicaiOrShuihui;




//left 选择币种信息
@property (nonatomic, copy) NSString *leftCurrentInfo;
//币种信息
@property (nonatomic, strong) NSMutableArray *sysInfoArray;
//right 选择币种信息
@property (nonatomic, copy) NSString *rightCurrentInfo;


@property (nonatomic, copy) NSString *rightTextField;
@property (nonatomic, copy) NSString *leftTextField;



//当前理财本金
@property (nonatomic, copy) NSString *currentLicaiBenjin;
//当前资金状态
@property (nonatomic, copy) NSString *currentLicaiBenjinRight;


//兑换汇率
@property (nonatomic, copy) NSString *duihuanHuilu;

@end

@implementation QYFinancialController
- (NSMutableArray *)sysInfoArray {
    if (!_sysInfoArray) {
        _sysInfoArray = [[NSMutableArray alloc]init];
    }
    return _sysInfoArray;
}


- (UISwitch *)switchBtn {
    if (!_switchBtn) {
//        SKDefineWeakSelf;
        _switchBtn = [[UISwitch alloc]init];
//        [_switchBtn addTarget:weakSelf action:@selector(valueChanged:) forControlEvents:(UIControlEventValueChanged)];
//        [_switchBtn addTarget:weakSelf action:@selector(valueChanged:) forControlEvents:(UIControlEventTouchUpInside)];
        _switchBtn.transform = CGAffineTransformMakeScale(0.85, 0.85);

    }
    return _switchBtn;
}
- (UILabel *)switchTipLabel {
    if (!_switchTipLabel) {
        _switchTipLabel = [[UILabel alloc]init];
        _switchTipLabel.text = @"开启智能AI";
        _switchTipLabel.font = SKFont(12);
        _switchTipLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    }
    return _switchTipLabel;
}

- (void)valueChanged{
    
//    if (self.switchBtn.on) {
//        SKDefineWeakSelf;
//        [UIAlertView alertWithTitle:@"提示" message:@"如果在30天内关闭此功能，提现将扣除30%的手续费，确定关闭吗？" okHandler:^{
//            [weakSelf updateImageBtnFlag:@"off"];
//            NSLog(@"==aa==");
//        } cancelHandler:^{
//            NSLog(@"==bb==");
//        }];
//    }else {
//        [self updateImageBtnFlag:@"on"];
//    }
    
    
    SKDefineWeakSelf;
    if (self.switchBtn.on) {
    SKCustomAlertView *alert = [[SKCustomAlertView alloc] initWithTitle:@"如果在30天内关闭此功能，提现将要扣除6%手续费。超过30天(包含30天)提现只收取3%手续费，确认关闭吗？" cancel:@"取消" sure:@"确定"];
    [alert showInView:self.view];
    [alert setupSureBlock:^BOOL{
        
        [weakSelf updateImageBtnFlag:@"off"];
        
        return YES;
    }];
    }else {
        [self updateImageBtnFlag:@"on"];
    }

}
//下拉
- (void)sk_refresh {
    [super sk_refresh];
    //网络请求余额
    NSLog(@"yy");
    //获取理财本金接口
    [self getWorkingUseBalance];
    //3.选择币种信息
    [self cfqgetCoinSysInfo];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.refreshType = SKBaseTableVcRefreshTypeOnlyCanRefresh;

    //默认
    self.leftCurrentInfo = @"BTC";
    self.rightCurrentInfo = @"BTC";

    
    // 设置导航栏
    [self setUpItems];
    
    //网络请求 轮播图
    [self loadData];
    

    
    //1.请求开关状态
    [self switchStateHandle];
    
    
    //2.赎回获取余额
    [self rightSelectInfo:@"BTC"];
    
    
    //3.选择币种信息
    [self cfqgetCoinSysInfo];
    //4.查询本地钱包余额
    [self leftSelectInfo:self.leftCurrentInfo isNetWork:NO];

    
    
    //请求文字说明
    [self loadDataWenzi:@"4"];
    [self loadDataWenzi:@"5"];
    
    
    //网络请求余额操作 是否成功
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dataYueFinish:) name:QYLICAIYUE object:nil];
    
    //监听本地钱包转账给server 是否成功
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dataZhuanzhangFinish:) name:QYLICAIZHUANZHANG object:nil];
    
    
    //获取理财本金接口
    [self getWorkingUseBalance];
    
    //当前资产价值
    //这个不用了
    [self currentCurrentLicaiBenjinRight];
}
//获取理财本金接口
- (void)getWorkingUseBalance{
    NSMutableDictionary *d = [NSMutableDictionary new];
    [d setValue:@"" forKey:@""];
    NSDictionary * input = d.copy;
    SKDefineWeakSelf;
    [CFQCommonServer cfqServerQYAPIgetUseBalanceByIdWithInput:input Callback:^(id  _Nonnull response, BOOL success, NSString * _Nonnull message, NSString * _Nonnull code) {
        if (success) {

            NSString *ss = [NSString stringWithFormat:@"%@",response];
            weakSelf.currentLicaiBenjin = ss;
            [weakSelf shuaxinTableViewCell:1];
        }else{
        }
    }];
}
//网络请求余额操作
-(void)dataYueFinish:(NSNotification *)noti
{
    //    let dictionary1 = ["success": "1", "type": type,"balance" : String(format: "%.6f", model.balance)]
    NSDictionary *dict = noti.object;
    if ([dict[@"success"] isEqualToString:@"1"])
    {
        if ([dict[@"type"] isEqualToString:self.leftCurrentInfo]) {
            NSLog(@"查询余额成功!");
            self.leftBalanceNum = dict[@"balance"];
            self.leftTextField = @"";
            self.duihuanHuilu = @"0.00";
        }
    }else{
        NSLog(@"失败======");
    }
    
}
//本地钱包转账结果!!!!!!!!!
-(void)dataZhuanzhangFinish:(NSNotification *)noti
{
    SKDefineWeakSelf;
    NSDictionary *dict = noti.object;
    NSMutableDictionary *d = [NSMutableDictionary new];
    [d setValue:dict[@"hash"] forKey:@"tradeHash"];
    [d setValue:dict[@"pwd"] forKey:@"tradePwd"];
    [d setValue:dict[@"type"] forKey:@"coinTypeDesc"];
    if ([dict[@"success"] isEqualToString:@"1"]&&[dict[@"indexStr"] isEqualToString:@"1"]&&self.isZiLei)
    {
        NSLog(@"=========simu==========");
        //众筹
        [d setValue:dict[@"money"] forKey:@"placementValue"];
        NSDictionary * input = d.copy;
        //众筹//7.添加私募
        [CFQCommonServer cfqServerQYAPIaddPlacementRecordWithInput:input Callback:^(id  _Nonnull response, BOOL success, NSString * _Nonnull message, NSString * _Nonnull code) {
            if (success) {
                [MBProgressHUD showMessage:message];
                NSLog(@"==========zhongchou======:%@",message);
                NSLog(@"==========zhongchou======%d",success);
                NSLog(@"==========zhongchou======%@",response);
            }else{
            }
        }];
        
    }else if ([dict[@"success"] isEqualToString:@"1"]&&[dict[@"indexStr"] isEqualToString:@"0"]&&(!self.isZiLei)){
        NSLog(@"=========licai==========");
        //            理财
        [d setValue:dict[@"money"] forKey:@"manageMoney"];
        NSDictionary * input = d.copy;
        //理财
        [CFQCommonServer cfqServerQYAPIaddManageRecordWithInput:input Callback:^(id  _Nonnull response, BOOL success, NSString * _Nonnull message, NSString * _Nonnull code) {
            if (success) {
                [MBProgressHUD showMessage:message];
                /*
                 //因为转账之后不能及时导致 需要延时  caofuqing 也可以实时查询转账状态
                 dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(30 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                 [weakSelf leftSelectInfo:dict[@"type"] isNetWork:YES];
                 });
                 */
                [MBProgressHUD showMessage:@"交易发送成功，本金到账有延迟，请稍等"];
                weakSelf.duihuanHuilu = @"0.00";
                
                
                //临时假装成功减点手续费=======
                if ([weakSelf.leftCurrentInfo isEqualToString:@"ETH"]) {
                    weakSelf.leftBalanceNum = [NSString stringWithFormat:@"%f",[weakSelf.leftBalanceNum floatValue] - QYETHGASPRICE - [weakSelf.leftTextField floatValue]];
                }else {
                    weakSelf.leftBalanceNum = [NSString stringWithFormat:@"%f",[weakSelf.leftBalanceNum floatValue] - QYUSDTANDBTCGASPRICE - [weakSelf.leftTextField floatValue]];
                }
                //临时假装成功减点手续费=======
                weakSelf.leftTextField = @"";

                

                [weakSelf shuaxinTableViewCell:3];
                NSLog(@"<<<<<<<licai<<<<<<<<%@>>>>>>>>>>>>>>",response);
                NSLog(@"<<<<<<<<licai<<<<<<<%@>>>>>>>>>>>>>>",message);
                NSLog(@"<<<<<<<<<licai<<<<<<%d>>>>>>>>>>>>>>",success);
                

                
            }else{
                
                NSLog(@"转账失败......%@..",message);
            }
        }];
        
    }
    else if ([dict[@"success"] isEqualToString:@"0"]){
        //        [MBProgressHUD showMessage:@"本地钱包转账失败"];
        NSLog(@"本地钱包转账失败");
    }else{
        NSLog(@"啥也不是");
    }
    
}


// 设置导航栏
- (void)setUpItems {
    
    SKCustomSegmentView *segment = [[SKCustomSegmentView alloc] initWithItemTitles:@[@"智能搬砖", @"搬砖提现"]];
    self.navigationItem.titleView = segment;
    segment.frame = CGRectMake(0, 0, 200, 35);
    SKDefineWeakSelf;
    segment.SKCustomSegmentViewBtnClickHandle = ^(SKCustomSegmentView *segment, NSString *title, NSInteger currentIndex) {
        [weakSelf changeChildVcWithCurrentIndex:currentIndex skCustomsegmentView:segment];
    };
    [segment clickDefault];
    
}

- (void)changeChildVcWithCurrentIndex:(NSInteger)currentIndex skCustomsegmentView:(SKCustomSegmentView *)segment {
    BOOL isHot = (currentIndex == 0);
    
    if (isHot) { // 热门
        
        NSLog(@"切换理财");
        self.currentSelectLicaiOrShuihui = NO;
        self.switchBtn.hidden = NO;
        self.switchTipLabel.hidden = NO;
    } else { // 订阅
        NSLog(@"切换赎回");
        
        if (self.switchBtn.on) {
            [segment clickDefault];
            [MBProgressHUD showMessage:@"关闭智能AI后才可提现，请确认是否已关闭"];
            return;
        }

        
        self.currentSelectLicaiOrShuihui = YES;
        self.switchBtn.hidden = YES;
        self.switchTipLabel.hidden = YES;

    }
    [self sk_reloadData];
}
//=================================================
#pragma mark - UITableViewDelegate
//只有一个Section
- (NSInteger)sk_numberOfSections {
    return 1;
}
//cell 的数据源个数
- (NSInteger)sk_numberOfRowsInSection:(NSInteger)section {
    return 4;
}
//cell
- (SKBaseTableViewCell *)sk_cellAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 1) {
        
        if (self.currentSelectLicaiOrShuihui) {
            QYNewFinancialTopTopCell2 *cell = [QYNewFinancialTopTopCell2 cellWithTableView:self.tableView];
            //这个不用了
            cell.currentLicaiBenjin = self.currentLicaiBenjinRight;
            return cell;
        }
        QYNewFinancialTopTopCell *cell = [QYNewFinancialTopTopCell cellWithTableView:self.tableView];
        cell.currentLicaiBenjin = self.currentLicaiBenjin;
        return cell;
        
    }else if (indexPath.row == 2) {
        QYNewFinancialTopCell *cell = [QYNewFinancialTopCell cellWithTableView:self.tableView];
        cell.leftCurrentInfo = self.leftCurrentInfo;
        cell.rightCurrentInfo = self.rightCurrentInfo;
        cell.currentSelectLicaiOrShuihui = self.currentSelectLicaiOrShuihui;
        
        SKDefineWeakSelf;
        cell.NextViewControllerBlock = ^(NSString * _Nonnull tfText, BOOL currentSHUHUI) {
            if (currentSHUHUI) {
                weakSelf.rightCurrentInfo = tfText;
                [weakSelf rightSelectInfo:weakSelf.rightCurrentInfo];
            }else{
                weakSelf.leftCurrentInfo = tfText;
                //读取余额本地数据库
                [weakSelf leftSelectInfo:weakSelf.leftCurrentInfo isNetWork:YES];
            }
        };
        return cell;
    }else if (indexPath.row == 3){
        QYNewFinancialCenterCell *cell = [QYNewFinancialCenterCell cellWithTableView:self.tableView];
        cell.rightCurrentInfo = self.rightCurrentInfo;
        cell.leftCurrentInfo = self.leftCurrentInfo;
        cell.lisOn = self.lisOn;
        cell.ruseBalance1 = self.ruseBalance1;
        cell.rpoundage2 = self.rpoundage2;
        cell.rtokenExchageRate3 = self.rtokenExchageRate3;
        
        
        cell.leftTextField = self.leftTextField;
        cell.rightTextField = self.rightTextField;
        
        cell.leftBalanceNum = self.leftBalanceNum;
        
        cell.duihuanHuilu = self.duihuanHuilu;
        
        cell.currentSelectLicaiOrShuihui = self.currentSelectLicaiOrShuihui;
        
        SKDefineWeakSelf;
        __weak typeof(cell) weakCell = cell;

        cell.NextViewControllerBlock = ^(NSString * _Nonnull tfText, BOOL currentSHUHUI) {

            if (currentSHUHUI) {
                
//                NSLog(@"%@",weakCell.inputTextfield.text);
                
                //赎回
                if ([tfText isEqualToString:@"SureButton"]) {
                    
                    [weakSelf celldidClickInfo:@"right" rightTextField:weakCell.inputTextfield2.text];
                    NSLog(@"赎回确认button");
                    
                }else if ([tfText isEqualToString:@"RightBtn"]) {
                    NSLog(@"全部赎回");
                    [weakSelf celldidClickInfo:@"right_RightBtn" rightTextField:weakCell.inputTextfield2.text];

                }
            }else{
                //理财
                if ([tfText isEqualToString:@"SureButton"]) {
                    
                    [weakSelf celldidClickInfo:@"left" rightTextField:weakCell.inputTextfield1.text];

                    NSLog(@"理财确认button");

                }else if ([tfText isEqualToString:@"RightBtn"]) {
                    NSLog(@"全部理财");
                    [weakSelf celldidClickInfo:@"left_RightBtn" rightTextField:weakCell.inputTextfield1.text];
                }
            }

        };
        cell.inputTextfieldBlock = ^(NSString * _Nonnull tfText, BOOL currentSHUHUI) {
            if (currentSHUHUI) {
                weakSelf.rightTextField = tfText;
            }else{
                weakSelf.leftTextField = tfText;
                if (tfText.length > 0) {
                    weakCell.duihuanHuilu = [weakSelf jisuanhuilu:tfText];
                }else{
                    weakCell.duihuanHuilu = @"0.00";
                }
            }
        };
        return cell;
    }else if (indexPath.row == 0){
        QYNewFinancialBottomCell *cell = [QYNewFinancialBottomCell cellWithTableView:self.tableView];
        cell.currentSelectLicaiOrShuihui = self.currentSelectLicaiOrShuihui;
        if (self.currentSelectLicaiOrShuihui) {
           cell.bottomString = self.rightbottomCellLabel;
        }else{
            cell.bottomString = self.leftbottomCellLabel;
        }
        return cell;
    }

    return nil;
}
- (NSString *)jisuanhuilu:(NSString *)tfText{
    
    if (!self.sysInfoArray.count) {
        return @"0.00";
    }
    NSString *typeRateString = @"";
    for (CFQCommonModel *model in self.sysInfoArray) {
        if ([model.coinName isEqualToString:self.leftCurrentInfo]) {
            typeRateString = model.rmgExchageRate;
            break;
        }
    }

    NSString *value = [NSString stringWithFormat:@"%.2f",[tfText floatValue] * [typeRateString floatValue]/6.8];
    
    return value;
}
- (void)verpassWorldisTrueInfo:(NSString *)info rightTextField:(NSString *)rightTextField{
    SKDefineWeakSelf;
    [self verifyisPassWordCallback:^(BOOL isLogin, NSString *passD) {
        if (isLogin) {
            [weakSelf verifyLoginSuccessPwd:passD type:info rightTextField:rightTextField];
        }else{
            //                [MBProgressHUD showMessage:@"您输入密码不对"];
        }
    }];
}
- (void)celldidClickInfo:(NSString *)info rightTextField:(NSString *)rightTextField{
    SKDefineWeakSelf;
    
    if ([info isEqualToString:@"left"]) {
        NSLog(@"确认left");
        
        if (rightTextField == nil || rightTextField.length < 1 ||[rightTextField isEqualToString:@"0"]) {
            
//            if ([self.currentLicaiBenjin floatValue] > 0) {
//                //转账成功之后再调用这个接口
//                [self updateImageBtnFlag:@"on"];
//                return;
//            }
            
            [MBProgressHUD showMessage:@"请输入数量"];
            return;
        }

        if ([self.leftBalanceNum floatValue] < QYETHGASPRICE) {
            [MBProgressHUD showMessage:@"余额不足"];
            return;
        }
        if (([rightTextField floatValue] + (QYETHGASPRICE - 0.000001)) > [self.leftBalanceNum floatValue]) {

            [MBProgressHUD showMessage:@"手续费不足"];
            return;
        }

        //验证金额大于500美元
        [self verifyisCoinTypeDesc:self.leftCurrentInfo amount:rightTextField Callback:^(BOOL isLogin) {

            if (isLogin) {
                [weakSelf verpassWorldisTrueInfo:info rightTextField:rightTextField];
            }else{
                
            }
        }];
        
    }else if ([info isEqualToString:@"right"]){
        NSLog(@"确认right");
        
        
        if (rightTextField == nil || rightTextField.length < 1 ||[rightTextField isEqualToString:@"0"]) {
            [MBProgressHUD showMessage:@"请输入数量"];
            return;
        }
        
        [self verifyisPassWordCallback:^(BOOL isLogin, NSString *passD) {
            if (isLogin) {
                [weakSelf verifyLoginSuccessPwd:passD type:info rightTextField:rightTextField];
            }else{
                //                [MBProgressHUD showMessage:@"您输入密码不对"];
            }
        }];
        
    }else if ([info isEqualToString:@"left_RightBtn"]){
        NSLog(@"全部理财left");
        
        
        if ([self.leftBalanceNum floatValue] < QYETHGASPRICE) {
            [MBProgressHUD showMessage:@"余额不足"];
            return;
        }
        self.leftTextField = [NSString stringWithFormat:@"%f",[self.leftBalanceNum floatValue] - QYETHGASPRICE];
        
        self.duihuanHuilu = [self jisuanhuilu:self.leftTextField];
        
        [self shuaxinTableViewCell:3];

    }else if ([info isEqualToString:@"right_RightBtn"]){
        NSLog(@"全部赎回right");
        self.rightTextField = self.ruseBalance1;
        
        [self shuaxinTableViewCell:3];
    }

}
- (void)verifyLoginSuccessPwd:(NSString *)pwd type:(NSString *)type rightTextField:(NSString *)rightTextField{
    SKDefineWeakSelf;
    
    if ([type isEqualToString:@"right"]) {
        //赎回
        CFQtestSwift *a = [[CFQtestSwift alloc]init];
        BTCWalletModel *btcModel = [a currentBTCModel];
        ETHWalletModel *ethModel = [a currentETHModel];
        USDTWalletModel *usdtModel = [a currentUSDTModel];
        
        //我的本地钱包地址  server向我转钱
        NSString *addressString = @"";
        if ([self.rightCurrentInfo isEqualToString:@"BTC"]) {
            addressString = btcModel.adress;
        }else if ([self.rightCurrentInfo isEqualToString:@"ETH"]){
            addressString = ethModel.adress;
        }else if ([self.rightCurrentInfo isEqualToString:@"USDT"]){
            addressString = usdtModel.adress;
        }
        
        //14.赎回
        NSMutableDictionary *d = [NSMutableDictionary new];
        [d setValue:addressString forKey:@"address"];
        [d setValue:rightTextField forKey:@"ransomValue"];
        [d setValue:self.rightCurrentInfo forKey:@"coinTypeDesc"];
        [d setValue:pwd forKey:@"tradePwd"];
        NSDictionary * input = d.copy;
        [CFQCommonServer cfqServerQYAPIaddRansomRecordWithInput:input Callback:^(id  _Nonnull response, BOOL success, NSString * _Nonnull message, NSString * _Nonnull code) {
            
            if (success) {
                [MBProgressHUD showMessage:message];
                //刷新一下
                [weakSelf rightSelectInfo:self.rightCurrentInfo];
                [weakSelf currentCurrentLicaiBenjinRight];

            }else{
            }
        }];
    }else if ([type isEqualToString:@"left"]) {
        
        if (!self.sysInfoArray.count) {
            return;
        }
        NSLog(@"理财本地钱包转账开始....");
        //caofuqing  重点!!!
        //1.本地钱包转账成功之后model.systemAddress  再操作交易成功后返回的hash
        NSString *addressString = @"";
        for (CFQCommonModel *model in self.sysInfoArray) {
            if ([model.coinName isEqualToString:self.leftCurrentInfo]) {
                addressString = model.rechargeAddress;
                break;
            }
        }
        CFQtestSwift *a = [[CFQtestSwift alloc]init];
        
        NSString *indexStr = @"";
        if (self.isZiLei) {
            //众筹
            indexStr = @"1";
        }else {
            //理财
        indexStr = @"0";
        }
    
        [a zhuanzhangWithType:self.leftCurrentInfo adress:addressString money:rightTextField pwd:pwd indexStr:indexStr];
        //这个是我本地钱包成功后交易结果给的 我自己本地钱包给的tradeHash
    }
    
    
}

//cell高度
- (CGFloat)sk_cellheightAtIndexPath:(NSIndexPath *)indexPath {
    
        //理财
    if (indexPath.row == 1) {
        
        return 55;
        
    }else if (indexPath.row == 2) {
        return 120;
        
    }else if (indexPath.row == 3) {
        
        return 235;

    }else if (indexPath.row == 0) {
        return 135;
    }

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
}



//=========================================第三方轮播start
- (void)setupUI {
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    NewPagedFlowView *pageFlowView = [[NewPagedFlowView alloc] initWithFrame:CGRectMake(0, 0, Width, bannerHight)];
    pageFlowView.backgroundColor = [UIColor clearColor];
    pageFlowView.delegate = self;
    pageFlowView.dataSource = self;
    pageFlowView.minimumPageAlpha = 0.4;
    
#warning 假设产品需求左右卡片间距30,底部对齐
    pageFlowView.leftRightMargin = 30;
    pageFlowView.topBottomMargin = 0;
    
    pageFlowView.orginPageCount = self.imageArray.count;
    pageFlowView.isOpenAutoScroll = YES;
    
    //初始化pageControl
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, pageFlowView.frame.size.height - 34, Width, 8)];
    pageFlowView.pageControl = pageControl;
    [pageFlowView addSubview:pageControl];
    [pageFlowView reloadData];
    //    [self.view addSubview:pageFlowView];
    
    
    
    UIView *bg = [[UIView alloc]init];
    bg.frame = CGRectMake(0, 0, Width, bannerHight + 50);
    [bg addSubview:pageFlowView];
    
    //背景图片
    UIImageView *bgImageView = [[UIImageView alloc]initWithImage:SKImageNamed(@"NFbackground")];
    [bg addSubview:bgImageView];
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bg.mas_top);
        make.left.mas_equalTo(bg.mas_left);
        make.right.mas_equalTo(bg.mas_right);
        make.height.mas_equalTo(bannerHight - 50);
    }];
    [bg sendSubviewToBack:bgImageView];
    bg.backgroundColor = SKWhiteColor;
    
    [bg addSubview:self.switchTipLabel];
    [self.switchTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(pageFlowView.mas_bottom).offset(20);
        make.right.mas_equalTo(bg.mas_right).offset(-70);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(70);
    }];

    //按钮
    [bg addSubview:self.switchBtn];
    bg.userInteractionEnabled = YES;
    [self.switchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.switchTipLabel.mas_right);
        make.centerY.mas_equalTo(self.switchTipLabel.mas_centerY);
    }];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [bg addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.switchBtn).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
//    button.backgroundColor = SKRedColor;
    [button addTarget:self action:@selector(valueChanged) forControlEvents:UIControlEventTouchUpInside];
    
    self.tableView.tableHeaderView = bg;
    self.pageFlowView = pageFlowView;
}

#pragma mark --NewPagedFlowView Delegate
- (void)didSelectCell:(UIView *)subView withSubViewIndex:(NSInteger)subIndex {
    
    NSLog(@"点击了第%ld张图",(long)subIndex + 1);
}

- (void)didScrollToPage:(NSInteger)pageNumber inFlowView:(NewPagedFlowView *)flowView {
    
    //    NSLog(@"CustomViewController 滚动到了第%ld页",pageNumber);
}

#warning 假设产品需求左右中间页显示大小为 Width - 50, (Width - 50) * 9 / 16
- (CGSize)sizeForPageInFlowView:(NewPagedFlowView *)flowView {
    return CGSizeMake(Width - 50, bannerImageHight);
}

#pragma mark --NewPagedFlowView Datasource
- (NSInteger)numberOfPagesInFlowView:(NewPagedFlowView *)flowView {
    
    return self.imageArray.count;
}

- (PGIndexBannerSubiew *)flowView:(NewPagedFlowView *)flowView cellForPageAtIndex:(NSInteger)index{
    
    PGCustomBannerView *bannerView = (PGCustomBannerView *)[flowView dequeueReusableCell];
    if (!bannerView) {
        bannerView = [[PGCustomBannerView alloc] init];
        bannerView.layer.cornerRadius = 4;
        bannerView.layer.masksToBounds = YES;
    }
    
    //在这里下载网络图片
    //    [bannerView.mainImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:SKAPI_BaseUrl,self.imageArray[index]]] placeholderImage:nil];
    
    [bannerView.mainImageView sd_setImageWithURL:[NSURL URLWithString:self.imageArray[index]] placeholderImage:SKImageNamed(@"Appbandmoren1")];
    
    
    //    bannerView.mainImageView.image = self.imageArray[index];
    bannerView.indexLabel.text = [NSString stringWithFormat:@"第%ld张图",(long)index + 1];
    bannerView.indexLabel.hidden = YES;
    
    return bannerView;
}

#pragma mark --懒加载
- (NSMutableArray *)imageArray {
    if (_imageArray == nil) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}


//=========================================end

- (void)loadData {
    SKDefineWeakSelf;
    //7.轮播图
    NSMutableDictionary *d = [NSMutableDictionary new];
    [d setValue:@"1" forKey:@"bannerType"];
    NSDictionary * input = d.copy;
    [CFQCommonServer cfqServerQYAPIGetBannerByTypeWithInput:input Callback:^(id  _Nonnull response, BOOL success, NSString * _Nonnull message, NSString * _Nonnull code) {
        if (success) {
            NSArray *array = (NSArray *)response;
            if (array.count > 0) {
                NSMutableArray *headArray = [NSMutableArray new];
                for (NSInteger i = 0; i < array.count; i++) {
                    NSString *urlString = [NSString stringWithFormat:@"%@%@",SKAPI_BaseUrl,array[i]];
                    headArray[i] = urlString;
                }
                weakSelf.imageArray = headArray.mutableCopy;
                //轮播图
                [weakSelf setupUI];
            }
            
        }else{
            
        }
        
    }];
}

//2.赎回获取余额
- (void)rightSelectInfo:(NSString *)type{
    SKDefineWeakSelf;
    //19.根据币种查询信息
    NSMutableDictionary *d = [NSMutableDictionary new];
    [d setValue:type forKey:@"coinName"];
    NSDictionary * input = d.copy;
    [CFQCommonServer cfqServerQYAPIQYAPIgetUseBalanceByCoinAndCustomerIdWithInput:input Callback:^(id  _Nonnull response, BOOL success, NSString * _Nonnull message, NSString * _Nonnull code) {
        if (success) {
            NSDictionary *dict = (NSDictionary *)response;
            CFQCommonModel *model = [CFQCommonModel modelWithDictionary:dict];
            //可提现在本地计算
//            weakSelf.ruseBalance1 = model.useBalance;
            
            weakSelf.ruseBalance1 = [NSString stringWithFormat:@"%.8f",[model.useBalance floatValue] - ([model.useBalance floatValue] * ([model.poundage floatValue])/100)];
            weakSelf.rpoundage2 = model.poundage;
            weakSelf.rtokenExchageRate3 = model.tokenExchageRate;
            
            weakSelf.rightTextField = @"";
            weakSelf.leftTextField = @"";

            
            [weakSelf shuaxinTableViewCell:3];
            [weakSelf shuaxinTableViewCell:2];

        }else{
            
        }
    }];
    
}

////1.获得用户理财收益开关的状态GET
-(void)switchStateHandle {
    NSMutableDictionary *d = [NSMutableDictionary new];
    [d setValue:@"" forKey:@""];
    NSDictionary * input = d.copy;
    SKDefineWeakSelf;
    [CFQCommonServer cfqServergetManageStatusWithInput:input Callback:^(id  _Nonnull response, BOOL success, NSString * _Nonnull message, NSString * _Nonnull code) {
        
        if (success) {
            
            NSDictionary *dict = (NSDictionary *)response;
            CFQCommonModel *model = [CFQCommonModel modelWithDictionary:dict];
            
            if ([model.isOn isEqualToString:@"1"]) {
                weakSelf.switchBtn.on = YES;
                weakSelf.lisOn = NO;
            }else if ([model.isOn isEqualToString:@"0"]) {
                weakSelf.switchBtn.on = NO;
                weakSelf.lisOn = YES;
            }
            [weakSelf shuaxinTableViewCell:3];
        }else{
            
        }
        
    }];
    

}
//更改开关状态 传给服务器
- (void)updateImageBtnFlag:(NSString *)flag{
    SKDefineWeakSelf;
    //19.根据币种查询信息
    NSMutableDictionary *d = [NSMutableDictionary new];
    [d setValue:flag forKey:@"flag"];
    NSDictionary * input = d.copy;
    [CFQCommonServer cfqServerQYAPIupdateIncomeStatusWithInput:input Callback:^(id  _Nonnull response, BOOL success, NSString * _Nonnull message, NSString * _Nonnull code) {
        
        if (success) {
            
            NSDictionary *dict = (NSDictionary *)response;
            CFQCommonModel *model = [CFQCommonModel modelWithDictionary:dict];
            
            if ([model.isOn isEqualToString:@"1"]) {
                if (weakSelf.switchBtn.on) {
                    [MBProgressHUD showMessage:message];
                }else{
                    weakSelf.switchBtn.on = YES;
                    weakSelf.lisOn = NO;
                }
            }else if ([model.isOn isEqualToString:@"0"]) {
                if (weakSelf.switchBtn.on) {
                    weakSelf.switchBtn.on = NO;
                    weakSelf.lisOn = YES;
                }else{
                    [MBProgressHUD showMessage:message];
                }
            }
            [weakSelf shuaxinTableViewCell:3];

        }else{
            
        }
        
        
    }];
    
}

//1.请求文字说明
- (void)loadDataWenzi:(NSString *)indexString{
    SKDefineWeakSelf;
    NSMutableDictionary *d = [NSMutableDictionary new];
    [d setValue:indexString forKey:@"systemType"];
    NSDictionary * input = d.copy;
    [CFQCommonServer cfqServerGetSystemHelpByTypeWithInput:input callback:^(id  _Nonnull response, BOOL success, NSString * _Nonnull message, NSString * _Nonnull code) {
        
        if (success) {
            NSDictionary *dict = (NSDictionary *)response;
            CFQCommonModel *model = [CFQCommonModel modelWithDictionary:dict];
            
            if ([indexString isEqualToString:@"4"]) {
                //                model.content
                weakSelf.leftbottomCellLabel = [SKUtils filterHTML:model.content];
                
            }else if ([indexString isEqualToString:@"5"]){
                //赎回
                weakSelf.rightbottomCellLabel = [SKUtils filterHTML:model.content];
            }
            
            [weakSelf shuaxinTableViewCell:0];
            
        }else {
        }
    }];
}

//刷新一行cell
- (void)shuaxinTableViewCell:(NSInteger)indexRow{
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:indexRow inSection:0];
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)cfqgetCoinSysInfo{
    //3.获取汇率
    SKDefineWeakSelf;
    NSMutableDictionary *d = [NSMutableDictionary new];
    [d setValue:@"" forKey:@""];
    NSDictionary * input = d.copy;
    [CFQCommonServer cfqServerQYAPIGetCoinSystemWithInput:input Callback:^(id  _Nonnull response, BOOL success, NSString * _Nonnull message, NSString * _Nonnull code) {
        
        //结束刷新
        [weakSelf sk_endRefresh];

        if (success) {
            weakSelf.sysInfoArray = [CFQCommonModel modelArrayWithDictArray:response];
            if (weakSelf.sysInfoArray.count) {
                
                //                SKLog(@"有数据");
                
            }else {
                //                SKLog(@"数据为空");
            }
            
        }else {
            
            NSLog(@"hhh请求失败hhhh");
        }
        
    }];
    
}

- (void)leftSelectInfo:(NSString *)type isNetWork:(BOOL)isNetWork{
    CFQtestSwift *a = [[CFQtestSwift alloc]init];
    
    //是否改的了本地数据库余额  如果改动了本地数据库余额就网络请求 如果没有改动就用本地的
    if (isNetWork) {
        //如果是网络请求的话 就去网络请求  网络请求成功余额  在post通知   在界面上刷新通知  和转账一样操作!!!!!!!!!!!!
        [a wangluoqingqiuBalanceWithType:type];
    }
    //获取本地钱包
    NSString *balanceNum = [a shujukuBalanceWithType:type];
    self.leftBalanceNum = balanceNum;
    self.rightTextField = @"";
    self.leftTextField = @"";
    self.duihuanHuilu = @"0.00";
    [self shuaxinTableViewCell:2];
    [self shuaxinTableViewCell:3];
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


//点击确认理财理财
//理财金额价值必须大于500美金! GET 后台去判断验证
- (void)verifyisCoinTypeDesc:(NSString *)type amount:(NSString *)amount Callback:(void(^)(BOOL isLogin))callback{
    NSMutableDictionary *d = [NSMutableDictionary new];
    [d setValue:type forKey:@"coinTypeDesc"];
    [d setValue:amount forKey:@"amount"];
    NSDictionary * input = d.copy;
    [MBProgressHUD showMessage:@"loading"];
    [CFQCommonServer cfqServerQYAPIcheckManageAmountWithInput:input Callback:^(id  _Nonnull response, BOOL success, NSString * _Nonnull message, NSString * _Nonnull code) {
        if (success) {
            callback(YES);
        }else {
            callback(NO);
        }
    }];
}



//当前资产价值
- (void)currentCurrentLicaiBenjinRight{
    SKDefineWeakSelf;
    //4.获取总资产和平台币GET(我的界面)
    NSMutableDictionary *d = [NSMutableDictionary new];
    [d setValue:@"" forKey:@""];
    NSDictionary * input = d.copy;
    [CFQCommonServer cfqServerQYAPIgetPropertyWithInput:input Callback:^(id  _Nonnull response, BOOL success, NSString * _Nonnull message, NSString * _Nonnull code) {
        
        if (success) {
            NSDictionary *dict = (NSDictionary *)response;
            CFQCommonModel *model = [CFQCommonModel modelWithDictionary:dict];
            if (model.totalBalance) {
                weakSelf.currentLicaiBenjinRight = model.totalBalance;
            }else {
                weakSelf.currentLicaiBenjinRight = @"0";
            }
            [weakSelf shuaxinTableViewCell:1];
        }else{
            
        }
    }];

}

@end
