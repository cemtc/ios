//
//  QYOldFinancialController.m
//  wallet
//
//  Created by talking　 on 2019/7/4.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "QYOldFinancialController.h"
//轮播图
#import "JZKHeaderView.h"

#import "QYFinaHeadBtnView.h"

#import "QYFinaLeftContentView.h"//理财
#import "QYFinaRightContentView.h"//赎回

#import "MSPayPwdInputView.h"

@interface QYOldFinancialController ()<QYFinaHeadBtnViewDelegate,QYFinaContentViewDelegate>
//调用封装好的头视图
@property (nonatomic, strong) JZKHeaderView *headerView;

@property (nonatomic, strong) QYFinaHeadBtnView *btnView;

@property (nonatomic, strong) QYFinaLeftContentView *leftView;
@property (nonatomic, strong) QYFinaRightContentView *rightView;


//left 选择币种信息
@property (nonatomic, copy) NSString *leftCurrentInfo;
//币种信息
@property (nonatomic, strong) NSMutableArray *sysInfoArray;

//right 选择币种信息
@property (nonatomic, copy) NSString *rightCurrentInfo;
//币种值
@property (nonatomic, copy) NSString *rightCurrentValue;


@end

@implementation QYOldFinancialController
- (NSMutableArray *)sysInfoArray {
    if (!_sysInfoArray) {
        _sysInfoArray = [[NSMutableArray alloc]init];
    }
    return _sysInfoArray;
}

//content
- (void)qyFinaContentView:(QYFinaContentView *)topView didClickInfo:(NSString *)info {
    SKDefineWeakSelf;
    
    if ([info isEqualToString:@"left"]) {
        NSLog(@"确认left");
        
        if (self.leftView.rightTextField.text == nil || self.leftView.rightTextField.text.length < 1 ||[self.leftView.rightTextField.text isEqualToString:@"0"]) {
            [MBProgressHUD showMessage:@"请输入数量"];
            return;
        }
        
        if ([self.leftView.balanceNum floatValue] < QYETHGASPRICE) {
            [MBProgressHUD showMessage:@"余额不足"];
            return;
        }
        if (([self.leftView.rightTextField.text floatValue] + (QYETHGASPRICE - 0.000001)) > [self.leftView.balanceNum floatValue]) {
            
            [MBProgressHUD showMessage:@"手续费不足"];
            return;
        }
        
        SKDefineWeakSelf;
        [self verifyisPassWordCallback:^(BOOL isLogin, NSString *passD) {
            if (isLogin) {
                [weakSelf verifyLoginSuccessPwd:passD type:info];
            }else{
                //                [MBProgressHUD showMessage:@"您输入密码不对"];
            }
        }];
        
        
    }else if ([info isEqualToString:@"right"]){
        NSLog(@"确认right");
        
        
        if (self.rightView.rightTextField.text == nil || self.rightView.rightTextField.text.length < 1 ||[self.rightView.rightTextField.text isEqualToString:@"0"]) {
            [MBProgressHUD showMessage:@"请输入数量"];
            return;
        }
        
        SKDefineWeakSelf;
        [self verifyisPassWordCallback:^(BOOL isLogin, NSString *passD) {
            if (isLogin) {
                [weakSelf verifyLoginSuccessPwd:passD type:info];
            }else{
                //                [MBProgressHUD showMessage:@"您输入密码不对"];
            }
        }];
        
    }else if ([info isEqualToString:@"left_RightBtn"]){
        NSLog(@"全部理财left");
        
        
        if ([self.leftView.balanceNum floatValue] < QYETHGASPRICE) {
            [MBProgressHUD showMessage:@"余额不足"];
            return;
        }
        self.leftView.rightTextField.text = [NSString stringWithFormat:@"%f",[self.leftView.balanceNum floatValue] - QYETHGASPRICE];
        
    }else if ([info isEqualToString:@"right_RightBtn"]){
        NSLog(@"全部赎回right");
        self.rightView.rightTextField.text = self.rightCurrentValue;
        
    }else if ([info isEqualToString:@"选择币种L"]){
        [MWShowPickerView showWithDataArr:@[@"BTC",@"USDT",@"ETH"] title:@"选择币种" select:@"" callback:^(NSString * _Nonnull string) {
            weakSelf.leftCurrentInfo = string;
            weakSelf.leftView.rightLabel1.text = string;
            //读取余额本地数据库
            [self leftSelectInfo:self.leftCurrentInfo isNetWork:YES];
        }];
    }else if ([info isEqualToString:@"选择币种R"]){
        [MWShowPickerView showWithDataArr:@[@"BTC",@"USDT",@"ETH"] title:@"选择币种" select:@"" callback:^(NSString * _Nonnull string) {
            weakSelf.rightCurrentInfo = string;
            weakSelf.rightView.rightLabel1.text = string;
            [weakSelf rightSelectInfo:weakSelf.rightCurrentInfo];
        }];
    }
    
}

- (void)verifyLoginSuccessPwd:(NSString *)pwd type:(NSString *)type{
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
        [d setValue:self.rightView.rightTextField.text forKey:@"ransomValue"];
        [d setValue:self.rightCurrentInfo forKey:@"coinTypeDesc"];
        [d setValue:pwd forKey:@"tradePwd"];
        NSDictionary * input = d.copy;
        [CFQCommonServer cfqServerQYAPIaddRansomRecordWithInput:input Callback:^(id  _Nonnull response, BOOL success, NSString * _Nonnull message, NSString * _Nonnull code) {
            
            if (success) {
                [MBProgressHUD showMessage:message];
                //刷新一下
                [weakSelf rightSelectInfo:self.rightCurrentInfo];
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
        
        [a zhuanzhangWithType:self.leftCurrentInfo adress:addressString money:self.leftView.rightTextField.text pwd:pwd indexStr:indexStr];
        //这个是我本地钱包成功后交易结果给的 我自己本地钱包给的tradeHash
    }
    
    
}

//btn
- (void)qyFinaHeadBtnView:(QYFinaHeadBtnView *)topView didClickInfo:(NSString *)info {
    
    if ([info isEqualToString:@"left"]) {
        self.leftView.hidden = NO;
        self.rightView.hidden = YES;
    }else if ([info isEqualToString:@"right"]){
        self.leftView.hidden = YES;
        self.rightView.hidden = NO;
    }
}

- (QYFinaHeadBtnView *)btnView {
    if (!_btnView) {
        _btnView = [[QYFinaHeadBtnView alloc]init];
        _btnView.delegate = self;
        _btnView.userInteractionEnabled = YES;
    }
    return _btnView;
}
- (QYFinaLeftContentView *)leftView{
    if (!_leftView) {
        _leftView = [[QYFinaLeftContentView alloc]init];
        _leftView.delegate = self;
    }
    return _leftView;
}
- (QYFinaRightContentView *)rightView {
    if (!_rightView) {
        _rightView = [[QYFinaRightContentView alloc]init];
        _rightView.delegate = self;
    }
    return _rightView;
}

- (JZKHeaderView *)headerView {
    if (!_headerView) {
        
        CGFloat _originHeight = 0;
        if (SKIsIphoneX) {
            _originHeight = 250 + (88 - 64);
        }else {
            _originHeight = 250;
        }
        _headerView = [[JZKHeaderView alloc]initWithFrame:CGRectMake(10, 10, SKScreenWidth-20, _originHeight*0.5)];
        _headerView.headViewBlock = ^(NSInteger index){
            
            NSLog(@"%ld",index);
        };
        [self.view addSubview:_headerView];
        
        //添加背景图片
        UIImageView *imageBg = [[UIImageView alloc]initWithImage:SKImageNamed(@"login_background")];
        imageBg.frame = CGRectMake(10, 10, SKScreenWidth-20, _originHeight*0.5);
        [self.view addSubview:imageBg];
        [self.view sendSubviewToBack:imageBg];
        //添加背景图片
        
    }
    return _headerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //默认
    self.leftCurrentInfo = @"BTC";
    self.rightCurrentInfo = @"BTC";
    self.rightCurrentValue = @"";
    
    
    // 设置导航栏
    [self setUpItems];
    
    // 设置子视图
    [self setUpViews];
    
    //网络请求 轮播图
    [self loadData];
    
    
    //文字
    [self loadDataWenzi:@"4"];
    [self loadDataWenzi:@"5"];
    
    
    //选择币种信息
    [self cfqgetCoinSysInfo];
    
    //查询本地钱包余额
    [self leftSelectInfo:self.leftCurrentInfo isNetWork:NO];
    //赎回的//19.根据币种查询信息
    [self rightSelectInfo:self.rightCurrentInfo];
    
    
    //网络请求余额操作 是否成功
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dataYueFinish:) name:QYLICAIYUE object:nil];
    
    //监听本地钱包转账给server 是否成功
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dataZhuanzhangFinish:) name:QYLICAIZHUANZHANG object:nil];
    
    if (self.isZiLei) {
        //众筹
        self.btnView.hidden = YES;
        self.leftView.topTextLabel.hidden = YES;
        self.leftView.lineL.hidden = YES;
        [self.leftView.sureButton setTitle:@"确认众筹" forState:UIControlStateNormal];
        self.leftView.rightLabelBtn.text = @"全部众筹";
        NSLog(@"aaaa");
    }else{
        //理财
        NSLog(@"bbb");
    }
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
            self.leftView.balanceNum = dict[@"balance"];
            self.leftView.rightTextField.text = @"";
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
                NSLog(@"<<<<<<<licai<<<<<<<<%@>>>>>>>>>>>>>>",response);
                NSLog(@"<<<<<<<<licai<<<<<<<%@>>>>>>>>>>>>>>",message);
                NSLog(@"<<<<<<<<<licai<<<<<<%d>>>>>>>>>>>>>>",success);
            }else{
                
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

- (void)rightSelectInfo:(NSString *)type{
    SKDefineWeakSelf;
    //19.根据币种查询信息
    NSMutableDictionary *d = [NSMutableDictionary new];
    [d setValue:type forKey:@"coinName"];
    NSDictionary * input = d.copy;
    [CFQCommonServer cfqServerQYAPIQYAPIgetUseBalanceByCoinAndCustomerIdWithInput:input Callback:^(id  _Nonnull response, BOOL success, NSString * _Nonnull message, NSString * _Nonnull code) {
        
        if (success) {
            
            weakSelf.rightCurrentValue = [NSString stringWithFormat:@"%@",response];
            weakSelf.rightView.rightLabel2.text = [NSString stringWithFormat:@"%@ %@",weakSelf.rightCurrentValue,weakSelf.rightCurrentInfo];
            weakSelf.rightView.rightTextField.text = @"";
        }else{
            
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
    self.leftView.balanceNum = balanceNum;
    self.leftView.rightTextField.text = @"";
}

-(void)cfqgetCoinSysInfo{
    
    //3.获取汇率
    SKDefineWeakSelf;
    NSMutableDictionary *d = [NSMutableDictionary new];
    [d setValue:@"" forKey:@""];
    NSDictionary * input = d.copy;
    [CFQCommonServer cfqServerQYAPIGetCoinSystemWithInput:input Callback:^(id  _Nonnull response, BOOL success, NSString * _Nonnull message, NSString * _Nonnull code) {
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
                weakSelf.leftView.topTextLabel.text = [SKUtils filterHTML:model.content];
                
            }else if ([indexString isEqualToString:@"5"]){
                //赎回
                weakSelf.rightView.topTextLabel.text = [SKUtils filterHTML:model.content];
            }
            
        }else {
        }
    }];
}

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
                weakSelf.headerView.imageArr = headArray.mutableCopy;
                //=================
                //填充假的数据  caofuqing
                NSMutableArray *arr = [NSMutableArray new];
                for (NSInteger i = 0; i < array.count; i++) {
                    [arr addObject:@""];
                }
                weakSelf.headerView.titleArr = arr.mutableCopy;
                weakSelf.headerView.contentArr = arr.mutableCopy;
                weakSelf.headerView.bottomArr = arr.mutableCopy;
                //===========caofuqing
            }
            
        }else{
            
        }
        
    }];
}

// 设置导航栏
- (void)setUpItems {
    
    self.navigationItem.title = @"搬砖";
    
}

// 设置子视图
- (void)setUpViews {
    self.headerView.imageArr=@[@""].mutableCopy;
    self.headerView.titleArr = @[@""].mutableCopy;
    self.headerView.contentArr = @[@""].mutableCopy;
    self.headerView.bottomArr = @[@""].mutableCopy;
    
    //addSubViews
    [self.view addSubview:self.btnView];
    [self.btnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headerView.mas_bottom).offset(40);
        make.left.mas_equalTo(self.headerView.mas_left);
        make.right.mas_equalTo(self.headerView.mas_right);
        make.height.mas_equalTo(30);
    }];
    
    [self.view addSubview:self.leftView];
    [self.leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.btnView.mas_left);
        make.top.mas_equalTo(self.btnView.mas_bottom);
        make.right.mas_equalTo(self.btnView.mas_right);
        make.bottom.mas_equalTo(self.view.mas_bottom);
    }];
    [self.view addSubview:self.rightView];
    [self.rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.btnView.mas_left);
        make.top.mas_equalTo(self.btnView.mas_bottom);
        make.right.mas_equalTo(self.btnView.mas_right);
        make.bottom.mas_equalTo(self.view.mas_bottom);
    }];
    
    self.leftView.hidden = NO;
    self.rightView.hidden = YES;
    
    self.leftView.topTextLabel.text = @"";
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
