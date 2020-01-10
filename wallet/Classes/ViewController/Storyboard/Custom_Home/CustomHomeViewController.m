//
//  CustomHomeViewController.m
//  wallet
//
//  Created by 曾云 on 2019/8/17.
//  Copyright © 2019 talking　. All rights reserved.
//
#import "AFNetworking.h"
#import "YYModel.h"
#import "CustomHomeViewController.h"
#import "CustomHomeTableViewCell.h"
#import "CustomHomeSectionView.h"
#import "QYTagViewController.h"

#import "QYExportPrivateController.h"
#import "MSPayPwdInputView.h"
#import "CustomExportPrivateKeyViewController.h"
#import "CustomExportMnmonicWordViewController.h"
#import "CustomWalletPassWordView.h"
#import "CustomImportWalletView.h"
#import <MJExtension/MJExtension.h>

#import "CustomHomeModel.h"


//banner
#import "NewPagedFlowView.h"
//#import "PGCustomBannerView.h"
#import "ZWHomeBannerItemView.h"


#define bannerHight 140
#define bannerImageHight 110

#import "CreatWallViewController.h"

#import "ZWSoketRocketUtility.h"
#import "QYHangQingModel.h"
@interface CustomHomeViewController ()<NewPagedFlowViewDelegate, NewPagedFlowViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;
@property (nonatomic, strong) NSMutableArray *imageArray;
@property (nonatomic, strong) NSMutableArray *nameArray;
@property (nonatomic, strong) NSMutableArray *addressArray;
@property (nonatomic, strong) NSMutableArray *balanceArray;
@property (nonatomic, strong) NSMutableArray *siyaoArray;
@property (nonatomic, strong) NSMutableArray *zhujiciArray;
@property (nonatomic, strong) NewPagedFlowView *pageFlowView;
@property (weak, nonatomic) IBOutlet UILabel *name;//名字
@property (weak, nonatomic) IBOutlet UILabel *privateKey;//地址
@property (weak, nonatomic) IBOutlet UILabel *price;//余额
@property (weak, nonatomic) IBOutlet UIImageView *imageView;//w二维码
@property(nonatomic,strong) NSArray<ETHWalletModel *> * _Nonnull array;
@property (nonatomic,strong) CustomHomeModel *model;

@property(nonatomic,strong) ZWSoketRocketUtility * socket;
@end

@implementation CustomHomeViewController
{
    NSInteger CurrrentWallIndex;
    BTCWalletModel *BTCModel;
    ETHWalletModel *ETHModel;//CCM 钱包
    ZWETHWallModel *ZWETHModel;//以太坊钱包
    BOOL ishaveZWETH;
    BOOL ishaveBTC;
    double BTCExange;
    double ZWETHExange;
    NSString *ccmAddress;
}
-(void)CCMItemClick{
    CustomHomeItemModel *itemModel = self.model.dataArray.firstObject;
    TokenModel *token = [[TokenModel alloc]init];
    token.adress = ccmAddress;
    token.balance = itemModel.balance;
    token.exchange = itemModel.exchange;
    token.name = itemModel.name;
    token.priviteKey = itemModel.priviteKey;
    token.seedStr = itemModel.seedStr;
    [CustomWallet qrcodePushWithToken:token owner:self];
}
- (IBAction)qrCodeClick:(UIButton *)sender {
    CustomHomeItemModel *itemModel = self.model.dataArray.firstObject;
    TokenModel *token = [[TokenModel alloc]init];
    token.adress = itemModel.adress;
    token.balance = itemModel.balance;
    token.exchange = itemModel.exchange;
    token.name = itemModel.name;
    token.priviteKey = itemModel.priviteKey;
    token.seedStr = itemModel.seedStr;
    [CustomWallet qrcodePushWithToken:token owner:self];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.socket SRWebSocketClose];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.model = [[CustomHomeModel alloc]init];
    self.socket = [ZWSoketRocketUtility instance];
    [self loadSocketWithData];
//    [self requestData];

}
- (void)viewDidLoad {
    [super viewDidLoad];
//    [self loadSARFiatPrice];

    self.model = [[CustomHomeModel alloc]init];
    self.socket = [ZWSoketRocketUtility instance];
    
    [self loadSocketWithData];
    [self requestData];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getBTCWall) name:@"BTC" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(GetZWEThWall) name:@"ETH" object:nil];
    [self leftBarButtomItemWithNormalName:@"icon_export" highName:@"icon_export" selector:@selector(ExportPrivateKey) target:self];
    [self rightBarButtomItemWithNormalName:@"icon_add" highName:@"icon_add" selector:@selector(addWallt) target:self];
    //判断是否退出登录进来的
    NSUserDefaults *userdefout = [NSUserDefaults standardUserDefaults];
    NSString *obj = [userdefout objectForKey:@"loginout"];
    if ([obj isEqualToString:@"1"]) {
        CustomWalletPassWordView *password = [CustomWalletPassWordView initViewWithXibIndex:0];
        [password showClickButton:^(NSString * _Nonnull text) {
            NSString *user_password = [CustomUserManager customSharedManager].userModel.passwrod;
            if (![text isEqualToString:user_password]) {
                [MBProgressHUD showMessage:@"password error"];
                return;
            }else{
                NSUserDefaults *userdefout = [NSUserDefaults standardUserDefaults];
                [userdefout setObject:@"2" forKey:@"loginout"];
                [userdefout synchronize];
                [MBProgressHUD showLoading:@"loading" toView:nil];
                [self requestData];
                [self GetMyAllWall];
//                [SKUtils beginPullRefreshForScrollView:self.mainTableView];
            }
        }];

        password.CanclebuttonClickBlock = ^(NSString * _Nonnull text) {
            NSUserDefaults *userdefout = [NSUserDefaults standardUserDefaults];
            [userdefout setObject:@"1" forKey:@"loginout"];
            [userdefout synchronize];
            exit(0);
        };
    }else{
        [self requestData];
        [self GetMyAllWall];
        [MBProgressHUD showLoading:@"loading" toView:nil];
        [SKUtils beginPullRefreshForScrollView:self.mainTableView];
    }


    UIView *BannerView = [[UIView alloc]init];
    BannerView.backgroundColor = [UIColor clearColor];
    BannerView.frame = CGRectMake(0, 0, SKScreenWidth, 150);
    [self.view addSubview:BannerView];
    NewPagedFlowView *pageFlowView = [[NewPagedFlowView alloc] initWithFrame:CGRectMake(0, 0, SKScreenWidth, bannerHight)];
    pageFlowView.backgroundColor = [UIColor whiteColor];
    pageFlowView.delegate = self;
    pageFlowView.dataSource = self;
    pageFlowView.minimumPageAlpha = 0.4;

    pageFlowView.leftRightMargin = 30;
    pageFlowView.topBottomMargin = 8;
    pageFlowView.isOpenAutoScroll = NO;
    pageFlowView.orginPageCount = self.imageArray.count;
    self.pageFlowView = pageFlowView;
    [BannerView addSubview:self.pageFlowView];
    [self.pageFlowView reloadData];
    //打印测试本地数据库路径
    CFQtestSwift *textSwift = [[CFQtestSwift alloc]init];
    [textSwift saveCCMWalletCoinInfoWithProjectName:@""];
    
}
-(void)loadSocketWithData{
    [self.socket SRWebSocketOpen];
    //下面获取汇率   使用soket  之取出第一次
    SKDefineWeakSelf;
    self.socket.didReceiveMessage = ^(id  _Nonnull message) {
        NSLog(@"=========收到数据=%@",message);
        //收到第一次数据,就把数据关闭  下次进来,还会进行获取汇率操作
        [weakSelf.socket SRWebSocketClose];
        [[NSUserDefaults standardUserDefaults] setObject:message forKey:@"walletData"];
        [[NSUserDefaults standardUserDefaults] synchronize];

    };
}
#pragma mark --NewPagedFlowView Delegate
- (void)didSelectCell:(UIView *)subView withSubViewIndex:(NSInteger)subIndex {
    NSLog(@"点击了某一个cell=%ld",(long)subIndex);
    switch (subIndex) {
        case 0:
        {
            [self CCMItemClick];
        }
            break;
        case 1:
        {
            //BTC
            if (ishaveBTC) {
                TokenModel *token = [[TokenModel alloc]init];
                token.adress = BTCModel.adress;
                token.balance = BTCModel.balance;
                token.exchange = BTCExange;
                token.name = BTCModel.name;
                token.priviteKey = BTCModel.priviteKey;
                token.seedStr = BTCModel.seedStr;
                [CustomWallet qrcodePushWithToken:token owner:self];

            }else{
                [MBProgressHUD showMessage:@"Please create an BTC wallet first."];
            }
        }
            break;
        case 2:
        {
            //ETH
            if (ishaveZWETH) {
                TokenModel *token = [[TokenModel alloc]init];
                token.adress = ZWETHModel.adress;
                token.balance = ZWETHModel.balance;
                token.exchange = ZWETHExange;
                token.name = ZWETHModel.name;
                token.priviteKey = ZWETHModel.priviteKey;
                token.seedStr = ZWETHModel.seedStr;
                [CustomWallet qrcodePushWithToken:token owner:self];

            }else{
               [MBProgressHUD showMessage:@"Please create an ETH wallet first."];
            }
        }
            break;

        default:
            break;
    }

}
- (void)didScrollToPage:(NSInteger)pageNumber inFlowView:(NewPagedFlowView *)flowView{
    CurrrentWallIndex = pageNumber;
    //0 : ccm  1:BTC   2:ETH
    [self.mainTableView reloadData];
}
- (CGSize)sizeForPageInFlowView:(NewPagedFlowView *)flowView {
    return CGSizeMake(SKScreenWidth - 50, bannerImageHight);
}
#pragma mark --NewPagedFlowView Datasource
- (NSInteger)numberOfPagesInFlowView:(NewPagedFlowView *)flowView {
    return self.imageArray.count;
}
- (PGIndexBannerSubiew *)flowView:(NewPagedFlowView *)flowView cellForPageAtIndex:(NSInteger)index{
    ZWHomeBannerItemView *bannerView = (ZWHomeBannerItemView *)[flowView dequeueReusableCell];
    if (!bannerView) {
        bannerView = [[ZWHomeBannerItemView alloc] init];
        bannerView.layer.cornerRadius = 4;
        bannerView.layer.masksToBounds = YES;
    }
    bannerView.mainImageView.image = [UIImage imageNamed:self.imageArray[index]];
    bannerView.indexLabel.hidden = YES;
    bannerView.NameLabel.text = self.nameArray[index];
    bannerView.AddressLabel.text = self.addressArray[index];
    bannerView.PriceLabel.text = @"";
    
//    bannerView.PriceLabel.text = @"";
    [CSingleSample instance].sum = 0;
    double d = 0;
    NSMutableArray *arr = [NSMutableArray array];
    switch (index) {
        case 0:
            for (int i=0; i<self.model.dataArray.count; i++) {
                CustomHomeItemModel *item = self.model.dataArray[i];
//                if ([item.name isEqualToString:@"SAR"]) {
//                    [[NSUserDefaults standardUserDefaults] setObject:[CSingleSample instance].ccmFiatPrice forKey:@"ccmFiatPrice"];
//                    [[NSUserDefaults standardUserDefaults] synchronize];
//                    NSString *obj=[[NSUserDefaults standardUserDefaults] objectForKey:@"ccmFiatPrice"];
//                    [[NSUserDefaults standardUserDefaults] synchronize];
//                    if ([CSingleSample instance].ccmFiatPrice != nil) {
//                        NSDecimalNumber *num1 = [[NSDecimalNumber alloc]initWithString:[CSingleSample instance].ccmFiatPrice];
//
//                        d = item.balance * [num1 doubleValue];
//                    }
                    
//                }
                [CSingleSample instance].sum += item.balance;
                [arr addObject:[NSString stringWithFormat:@"%f",[CSingleSample instance].sum]];
            }
            if (arr.count>0) {
                NSDecimalNumber *num1 = [[NSDecimalNumber alloc]initWithString:arr[0]];
                NSDecimalNumber *num2 = [[NSDecimalNumber alloc]initWithString:[NSString stringWithFormat:@"%f",d]];
                NSDecimalNumber *num3 = [num2 decimalNumberByAdding:num1];
                bannerView.PriceLabel.text = [num3 stringValue];
            }
            break;
        case 1:
            bannerView.PriceLabel.text = self.balanceArray[index];

            break;
        case 2:
            bannerView.PriceLabel.text = self.balanceArray[index];

            break;
        default:
            break;
    }

    return bannerView;
}
- (NSDictionary *)convertjsonStringToDict:(NSString *)jsonString{
    NSDictionary *retDict = nil;
    if ([jsonString isKindOfClass:[NSString class]]) {
        NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
        retDict = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:NULL];
        return  retDict;
    }else{
        return retDict;
    }
}
-(void)GetMyAllWall{
    [self getBTCWall];
    [self GetZWEThWall];
}
-(void)getBTCWall{
    CustomWalletSwift *a = [[CustomWalletSwift alloc]init];
    BOOL ishaveBtc = [a isHasWalletHandleWithMobileA:@"BTC"];
    if (ishaveBtc) {
        //拿到当前钱包
        CFQtestSwift *textSwift = [[CFQtestSwift alloc]init];
        BTCModel = [textSwift customCurrentZWBTCModel];
       
        if (BTCModel) {
            NSLog(@"获取到当前的BTC钱包=%@",BTCModel);//开始赋值
            NSString *name = BTCModel.name;
            NSString *address = BTCModel.adress;
            if (address.length >10) {
                address = [NSString stringWithFormat:@"%@...%@",[BTCModel.adress substringToIndex:10],[BTCModel.adress substringFromIndex:BTCModel.adress.length-10]];
            }
            //获取余额
            BTCModel.balance = [textSwift GetYuEBTCWithAddress:BTCModel.adress];
            NSLog(@"虎丘的余额为 == %f",BTCModel.balance);
            NSString *balance = [NSString stringWithFormat:@"￥%f",BTCModel.balance *BTCExange];
            [self.nameArray replaceObjectAtIndex:1 withObject:name];
            [self.addressArray replaceObjectAtIndex:1 withObject:address];
            [self.balanceArray replaceObjectAtIndex:1 withObject:balance];
            [self.siyaoArray replaceObjectAtIndex:1 withObject:BTCModel.priviteKey];
            [self.zhujiciArray replaceObjectAtIndex:1 withObject:BTCModel.mnemonic];
            [CustomUserManager customSharedManager].userModel.BTCethAddress = BTCModel.adress;
            ishaveBTC = YES;
        }else{
            NSLog(@"没有获取到当前钱包");
            ishaveBTC = NO;
        }
    }else{
        NSLog(@"不存在BTC钱包");
        ishaveBTC = NO;
    }
}
-(void)GetZWEThWall{
    NSUserDefaults *userDefure = [NSUserDefaults standardUserDefaults];
    NSString *ishaveETH = [userDefure objectForKey:@"ishaveETH"];
    if ([ishaveETH isEqualToString:@"1"]) {
        NSLog(@"有ZWETH钱包");
        ZWETHModel = [[ZWETHWallModel alloc]init];
        ZWETHModel.adress =[userDefure objectForKey:@"adress"];
        ZWETHModel.mnemonic =[userDefure objectForKey:@"mnemonic"];
        ZWETHModel.priviteKey =[userDefure objectForKey:@"priviteKey"];
        ZWETHModel.publiceKey =[userDefure objectForKey:@"publiceKey"];
        ZWETHModel.name =[userDefure objectForKey:@"name"];
        ZWETHModel.imgurl =[userDefure objectForKey:@"imgurl"];

        NSString *name = ZWETHModel.name;
        NSString *address = ZWETHModel.adress;
        if (address.length >10) {
            address = [NSString stringWithFormat:@"%@...%@",[ZWETHModel.adress substringToIndex:10],[ZWETHModel.adress substringFromIndex:ZWETHModel.adress.length-10]];
        }
        CFQtestSwift *textSwift = [[CFQtestSwift alloc]init];
        ZWETHModel.balance = [textSwift GetYueETHWithAddress:ZWETHModel.adress];
        NSLog(@"虎丘的xxxxxxxxxxxxxxx余额为 == %f",ZWETHModel.balance);
        NSString *s = [textSwift GetERC20TokenInfoWithAddress:ZWETHModel.adress];
        NSLog(@"-----ERC20TokenInfo-----------%@",s);
        NSString *balance = [NSString stringWithFormat:@"￥%f",ZWETHModel.balance *ZWETHExange];
        NSLog(@"======Balance=%@--33---%.2f",balance,ZWETHExange);
        [self.nameArray replaceObjectAtIndex:2 withObject:name];
        [self.addressArray replaceObjectAtIndex:2 withObject:address];
        [self.balanceArray replaceObjectAtIndex:2 withObject:balance];
        //这个余额  是计算之后的
        [self.siyaoArray replaceObjectAtIndex:2 withObject:ZWETHModel.priviteKey];
        [self.zhujiciArray replaceObjectAtIndex:2 withObject:ZWETHModel.mnemonic];
        [CustomUserManager customSharedManager].userModel.ethAddress = ZWETHModel.adress;
        ishaveZWETH = YES;
    }else{
        NSLog(@"不存在TZWETH钱包");
        ishaveZWETH = NO;
    }
}
- (void)requestData {
        [SKUtils addPullRefreshForScrollView:self.mainTableView pullRefreshCallBack:^{
            if (self->CurrrentWallIndex == 0) {
                //解析数据.保存到本地数据
                id obj = [[NSUserDefaults standardUserDefaults] objectForKey:@"walletData"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                NSDictionary *messageDict = [self convertjsonStringToDict:obj];
                
                NSArray *messageARR = messageDict[@"type_list"];
                if (messageARR.count) {
                    NSMutableArray *Mutablearr = [[NSMutableArray alloc]init];
                    for (int i = 0; i < messageARR.count; i++) {
                        NSDictionary *dict = messageARR[i];
                        NSArray *arr = dict[@"data"];
                        if (arr.count) {
                            NSArray *itemARR = [QYHangQingModel modelArrayWithDictArray:arr];
                            [Mutablearr addObjectsFromArray:itemARR];
                        }
                    }
                    NSLog(@"获取到的汇率=%@",Mutablearr);//里面装的模型
                    
                    [self reloadWallet:Mutablearr];
                    [SKUtils endRefreshForScrollView:self.mainTableView];
                }else{
                    //没有获取到任何汇率数据,界面展示效果默认吧
//                    [SKUtils endRefreshForScrollView:self.mainTableView];
                }
                [SKUtils endRefreshForScrollView:self.mainTableView];
            }else if (self->CurrrentWallIndex == 1){
                [self getBTCWall];
                [SKUtils endRefreshForScrollView:self.mainTableView];
            }else{
                [self GetZWEThWall];
                [SKUtils endRefreshForScrollView:self.mainTableView];
            }
        }];


}
//-(void)loadSARFiatPrice{
//    [[AFHTTPSessionManager manager] GET:[NSString stringWithFormat:@"https://www.ccm.one/api/Otc/getOtcTransactionList?currency_id=13&legal_currency=1&trade_type=buy&member_id=&page=1&row=10"] parameters:nil progress:^(NSProgress *_Nonnull uploadProgress) {
//    }                           success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
//        @try {
//            if (responseObject != nil) {
//                NSDictionary *dataInfo = responseObject;
//                NSDictionary *dataDict = [dataInfo objectForKey:@"data"];
//                if (dataDict != nil) {
//                    NSString *dataStr = [dataDict objectForKey:@"price"];
//                    if(dataStr){
////                        [[NSUserDefaults standardUserDefaults] setObject:dataStr forKey:@"ccmFiatPrice"];
////                        [[NSUserDefaults standardUserDefaults] synchronize];
////                        NSString *obj=[[NSUserDefaults standardUserDefaults] objectForKey:@"ccmFiatPrice"];
////                        [[NSUserDefaults standardUserDefaults] synchronize];
//                        [CSingleSample instance].ccmFiatPrice = dataStr;
//                    }
//                }
//            }
//        } @catch (NSException *exception) {
//        } @finally {
//        }
//    }
//                                failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
//    }];
//
//}
- (void)reloadWallet:(NSMutableArray *)array {
    self.model = [[CustomHomeModel alloc]initWith:[CustomWallet getCustomCurrentWallet_ETHModel] complete:^(NSInteger index) {}];
   
    //取出来,是ETHModel  CCM钱包模型进行赋值即可
    [CSingleSample instance].listArr = array;
    for (QYHangQingModel * ExchangeModel in array) {
        if (ExchangeModel && [ExchangeModel isKindOfClass:[QYHangQingModel class]]) {
            id coinName = ExchangeModel.name;
            double rmgExchageRate = [ExchangeModel.current_price doubleValue];
            if (coinName && [coinName isKindOfClass:[NSString class]]) {
                if (self.model.dataArray.count != 0) {
//                    CFQtestSwift *textSwift = [[CFQtestSwift alloc]init];
//                    _array = [textSwift saveCCMWalletCoinInfoWithProjectName:@"CCMWALLET"];
//                    NSMutableArray<CustomHomeItemModel *> *arrayModel = [NSMutableArray array];
//                    NSArray *dictArray = [CustomHomeItemModel mj_keyValuesArrayWithObjectArray:_array];
//                    NSError *error;
//                    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictArray options:NSJSONWritingPrettyPrinted error:&error];
//                    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//                    NSArray *array001 = [NSArray yy_modelArrayWithClass:CustomHomeItemModel.class json:jsonString];
//                    arrayModel = [array001 copy];
//                    for (CustomHomeItemModel *item in arrayModel) {
//                        if ([item.name isEqualToString:@"CCM"]) {
//                            [CustomUserManager customSharedManager].userModel.ethAddress = item.adress;
//
//                        }
//                        [self.model.dataArray addObject:item];
//                    }

                    for (CustomHomeItemModel *itemModel in self.model.dataArray) {
                        if ([coinName isEqualToString:itemModel.name]) {
                            itemModel.exchange = rmgExchageRate;
                        }
                        if ([coinName isEqualToString:@"BTC"]) {
                            BTCExange = rmgExchageRate;
                            NSLog(@"比特币汇率=%f",BTCExange);
                            NSString *balance = [NSString stringWithFormat:@"￥%f",BTCModel.balance *BTCExange];
                            [[NSUserDefaults standardUserDefaults] setObject:BTCModel.adress forKey:@"BTCethAddress"];
                            [[NSUserDefaults standardUserDefaults] synchronize];
                            [self.balanceArray replaceObjectAtIndex:1 withObject:balance];
                        }
                        if ([coinName isEqualToString:@"ETH"]) {
                            ZWETHExange = rmgExchageRate;
                            NSLog(@"以太坊汇率=%f",ZWETHExange);
                            [CSingleSample instance].ethFiatPrice = ZWETHExange;
                            [CustomUserManager customSharedManager].userModel.ethAddress = ZWETHModel.adress;
                            [[NSUserDefaults standardUserDefaults] setObject:ZWETHModel.adress forKey:@"ETHethAddress"];
                            [[NSUserDefaults standardUserDefaults] synchronize];
                            NSString *balance = [NSString stringWithFormat:@"￥%f",ZWETHModel.balance *ZWETHExange];
                            [self.balanceArray replaceObjectAtIndex:2 withObject:balance];

                        }
                    }
                }else{
            
                    for (CustomHomeItemModel *itemModel in self.model.dataArray) {
                        if ([coinName isEqualToString:itemModel.name]) {
                            itemModel.exchange = rmgExchageRate;
                        }
                        if ([coinName isEqualToString:@"BTC"]) {
                            BTCExange = rmgExchageRate;
                            NSLog(@"比特币汇率=%f",BTCExange);
                            NSString *balance = [NSString stringWithFormat:@"￥%f",BTCModel.balance *BTCExange];
                            [[NSUserDefaults standardUserDefaults] setObject:BTCModel.adress forKey:@"BTCethAddress"];
                            [[NSUserDefaults standardUserDefaults] synchronize];
                            [self.balanceArray replaceObjectAtIndex:1 withObject:balance];
                        }
                        if ([coinName isEqualToString:@"ETH"]) {
                            ZWETHExange = rmgExchageRate;
                            NSLog(@"以太坊汇率=%f",ZWETHExange);
                            [CSingleSample instance].ethFiatPrice = ZWETHExange;
                            [CustomUserManager customSharedManager].userModel.ethAddress = ZWETHModel.adress;
                            [[NSUserDefaults standardUserDefaults] setObject:ZWETHModel.adress forKey:@"ETHethAddress"];
                            [[NSUserDefaults standardUserDefaults] synchronize];
                            NSString *balance = [NSString stringWithFormat:@"￥%f",ZWETHModel.balance *ZWETHExange];
                            [self.balanceArray replaceObjectAtIndex:2 withObject:balance];

                        }
                    }
                }
                
            }
        }
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        //回调或者说是通知主线程刷新，
        [MBProgressHUD showMessage:@"Refresh successfully"];
        CustomHomeItemModel *ccm = self.model.dataArray.firstObject;
        if (ccm.adress.length >10) {
            self->ccmAddress = ccm.adress;
            ccm.adress = [NSString stringWithFormat:@"%@...%@",[ccm.adress substringToIndex:10],[ccm.adress substringFromIndex:ccm.adress.length-10]];
        }
        [self.nameArray replaceObjectAtIndex:0 withObject:[CustomUserManager customSharedManager].userModel.name];
        [self.addressArray replaceObjectAtIndex:0 withObject:ccm.adress];
        [self.balanceArray replaceObjectAtIndex:0 withObject:[NSString stringWithFormat:@"￥%f",ccm.balance *ccm.exchange]];
        [self.siyaoArray replaceObjectAtIndex:0 withObject:ccm.priviteKey];
        [self.zhujiciArray replaceObjectAtIndex:0 withObject:ccm.mnemonic];


    });
    //刷新banner
    [self.pageFlowView reloadData];
    [self.mainTableView reloadData];
}
//数组转为json字符串
- (NSString *)arrayToJSONString:(NSArray *)array {
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    NSString *jsonTemp = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        NSString *jsonResult = [jsonString stringByReplacingOccurrencesOfString:@"" withString:@""];
    return jsonResult;
}
///到出钱包
- (void)showWallet {
    if (CurrrentWallIndex == 0) {
        CustomImportWalletView *exportWallet = [CustomImportWalletView initViewWithXibIndex:0];
        exportWallet.title = @"Please choose how to export your wallet";
        @weakify(self);
        [exportWallet showClickButtonType:^(CustomImportWalletType type) {
            @strongify(self);
            switch (type) {
                case CustomImportWalletType_PrivateKey:
                {
                    NSLog(@"回调私钥 导出私钥");
                    CustomExportPrivateKeyViewController *viewController = [[UIStoryboard storyboardWithName:@"User" bundle:nil] instantiateViewControllerWithIdentifier:@"CustomExportPrivateKey"];
                    [self pushVc:viewController];
                }
                    break;
                case CustomImportWalletType_MnmonicWord:
                {
                   
                    NSLog(@"回调助记词%@",[CustomUserManager customSharedManager].userModel.ethMnemonic);
                    NSString *mnmonic = [CustomUserManager customSharedManager].userModel.ethMnemonic;
                    if ([mnmonic isEqualToString:kMNullStr]) {
                        [MBProgressHUD showMessage:@"There are no mnemonics that can be exported at the current address. Please confirm if the import method is a mnemonic or whether it is a new wallet"];
                        return;
                    }
//                    QYTagViewController *vc = [[QYTagViewController alloc]initWithPsw:@"" mn:mnmonic];
                    CustomExportMnmonicWordViewController *viewController = [[UIStoryboard storyboardWithName:@"User" bundle:nil] instantiateViewControllerWithIdentifier:@"CustomExportMnmonicWord"];
                    viewController.mn = mnmonic;
                    NSLog(@"CustomExportMnmonicWord======%@",mnmonic);
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
    }else if (CurrrentWallIndex == 1){
        if (ishaveBTC) {
            CustomImportWalletView *exportWallet = [CustomImportWalletView initViewWithXibIndex:0];
            exportWallet.title = @"Please choose how to export your wallet";
            @weakify(self);
            [exportWallet showClickButtonType:^(CustomImportWalletType type) {
                @strongify(self);
                switch (type) {
                    case CustomImportWalletType_PrivateKey:
                    {
                        NSLog(@"回调私钥 导出私钥");
                        NSString *privateKey = self.siyaoArray[self->CurrrentWallIndex];
                        NSString *address = self.addressArray[self->CurrrentWallIndex];
                        CustomExportPrivateKeyViewController *viewController = [[UIStoryboard storyboardWithName:@"User" bundle:nil] instantiateViewControllerWithIdentifier:@"CustomExportPrivateKey"];
                        viewController.siyao = privateKey;
                        viewController.address = address;
                        [self pushVc:viewController];
                    }
                        break;
                    case CustomImportWalletType_MnmonicWord:
                    {
                        NSLog(@"回调助记词");
                        NSString *mnmonic = self.zhujiciArray[self->CurrrentWallIndex];
                        if ([mnmonic isEqualToString:kMNullStr]) {
                            [MBProgressHUD showMessage:@"There are no mnemonics that can be exported at the current address. Please confirm if the import method is a mnemonic or whether it is a new wallet"];
                            return;
                        }
                        CustomExportMnmonicWordViewController *viewController = [[UIStoryboard storyboardWithName:@"User" bundle:nil] instantiateViewControllerWithIdentifier:@"CustomExportMnmonicWord"];
                        viewController.zhujici = mnmonic;
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


        }else{
            [MBProgressHUD showMessage:@"create wallet"];
        }

    }else{
        if (ishaveZWETH) {
            CustomImportWalletView *exportWallet = [CustomImportWalletView initViewWithXibIndex:0];
            exportWallet.title = @"Please choose how to export your wallet";
            @weakify(self);
            [exportWallet showClickButtonType:^(CustomImportWalletType type) {
                @strongify(self);
                switch (type) {
                    case CustomImportWalletType_PrivateKey:
                    {
                        NSLog(@"回调私钥 导出私钥");
                        NSString *siyao = self.siyaoArray[self->CurrrentWallIndex];
                        NSString *address = self.addressArray[self->CurrrentWallIndex];
                        CustomExportPrivateKeyViewController *viewController = [[UIStoryboard storyboardWithName:@"User" bundle:nil] instantiateViewControllerWithIdentifier:@"CustomExportPrivateKey"];
                        viewController.siyao = siyao;
                        viewController.address = address;
                        [self pushVc:viewController];
                    }
                        break;
                    case CustomImportWalletType_MnmonicWord:
                    {
                        NSLog(@"回调助记词");
                        NSString *mnmonic = self.zhujiciArray[self->CurrrentWallIndex];
                        if ([mnmonic isEqualToString:kMNullStr]) {
                            [MBProgressHUD showMessage:@"There are no mnemonics that can be exported at the current address. Please confirm if the import method is a mnemonic or whether it is a new wallet"];
                            return;
                        }
                        CustomExportMnmonicWordViewController *viewController = [[UIStoryboard storyboardWithName:@"User" bundle:nil] instantiateViewControllerWithIdentifier:@"CustomExportMnmonicWord"];
                        viewController.zhujici = mnmonic;
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


        }else{
            [MBProgressHUD showMessage:@"Create Ethereum Wallet"];
        }

    }

}
- (void)addWallt {
    CreatWallViewController *creatWallViewVC = [[CreatWallViewController alloc]init];
    [self pushVc:creatWallViewVC];
}
- (void)ExportPrivateKey {
     @weakify(self);
    [[CustomUserManager customSharedManager] showWalletPassWordViewFinish:^(NSString * _Nonnull password) {
        @strongify(self);
        NSString *userPwd = [CustomUserManager customSharedManager].userModel.passwrod;
       
        if (![password isEqualToString:userPwd]) {
            [MBProgressHUD showMessage:@"password error"];
            return;
        }
         [self showWallet];
    }];
}
//验证登录交易密码验证
- (void)verifyisPassWordCallback:(void(^)(BOOL isLogin,NSString *passD))callback{
    CustomWalletPassWordView *password = [CustomWalletPassWordView initViewWithXibIndex:0];
    @weakify(self);
    [password showClickButton:^(NSString * _Nonnull text) {
        @strongify(self);
        CustomExportPrivateKeyViewController *viewController = [[UIStoryboard storyboardWithName:@"User" bundle:nil] instantiateViewControllerWithIdentifier:@"CustomExportPrivateKey"];
        [self pushVc:viewController];
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (CurrrentWallIndex == 0) {
//        return 30;
        return self.model.dataArray.count;
    }else if (CurrrentWallIndex == 1){
        if (ishaveBTC) {
            return 1;
        }else{
            return 0;
        }
    }else{
        if (ishaveZWETH) {
            return 1;
        }else{
            return 0;
        }
    }
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomHomeItemModel *itemModel;
//    if (self.model.dataArray.count > 0) {
        if (CurrrentWallIndex == 0) {
            if (self.model.dataArray.count>0) {
                itemModel = self.model.dataArray[indexPath.row];

            }
        }else if (CurrrentWallIndex == 1){
            itemModel = [[CustomHomeItemModel alloc]init];
            itemModel.name = @"BTC";
            itemModel.balance = BTCModel.balance;
            itemModel.exchange = BTCExange;
            itemModel.imgUrl = @"https://raw.githubusercontent.com/iozhaq/image/master/BTC.png";
        }else{
            itemModel = [[CustomHomeItemModel alloc]init];
            itemModel.name = @"ETH";
            itemModel.balance = ZWETHModel.balance;
            itemModel.exchange = ZWETHExange;
            itemModel.imgUrl = @"https://raw.githubusercontent.com/iozhaq/image/master/ETH.png";
//
        }
        CustomHomeTableViewCell *cell = [CustomHomeTableViewCell cellWithTableView:tableView  identifier:@"Identifier_CustomHome"];
        cell.itemModel = itemModel;
    
        return cell;

//    }
    
//    return nil;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return  40;
    if (self.model.dataArray.count>0) {
        return [self.model.dataArray[indexPath.row] objc_Height];
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 45.0f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc]initWithFrame:CGRectZero];;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [CustomHomeSectionView initViewWithXibIndex:0];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (CurrrentWallIndex == 0) {
        if (self.model.dataArray.count>0) {
            CustomHomeItemModel *itemModel = self.model.dataArray[indexPath.row];
            //        NSLog(@"-----name9999-----%@",itemModel.name);
            //        if(self.model.dataArray.count >= indexPath.row){
            TokenModel *token = [[TokenModel alloc]init];
            token.adress = ccmAddress;
            token.balance = itemModel.balance;
            token.exchange = itemModel.exchange;
            token.name = itemModel.name;
            token.priviteKey = itemModel.priviteKey;
            token.seedStr = itemModel.seedStr;
            [CustomWallet cellClickWithToken:token owner:self];
        }

//        }else{
//
//        }
//

    }else if (CurrrentWallIndex == 1){
        TokenModel *token = [[TokenModel alloc]init];
        token.adress = BTCModel.adress;
        token.balance = BTCModel.balance;
        token.exchange = BTCExange;
        token.name = @"BTC";
        token.priviteKey = BTCModel.priviteKey;
        token.seedStr = BTCModel.seedStr;
        [CustomWallet cellClickWithToken:token owner:self];
    }else{
        TokenModel *token = [[TokenModel alloc]init];
        token.adress = ZWETHModel.adress;
        token.balance = ZWETHModel.balance;
        token.exchange = ZWETHExange;
        token.name = @"ETH";
        token.priviteKey = ZWETHModel.priviteKey;
        token.seedStr = ZWETHModel.seedStr;
        [CustomWallet cellClickWithToken:token owner:self];

    }


}

#pragma mark --懒加载
- (NSMutableArray *)imageArray {
    if (_imageArray == nil) {
        _imageArray = [[NSMutableArray alloc]init];
        [_imageArray addObject:@"CCM"];
        [_imageArray addObject:@"BTC"];
        [_imageArray addObject:@"ETH"];
    }
    return _imageArray;
}
- (NSMutableArray *)nameArray {
    if (_nameArray == nil) {
        _nameArray = [[NSMutableArray alloc]init];
        [_nameArray addObject:@"EMTC"];
        [_nameArray addObject:@"BTC"];
        [_nameArray addObject:@"ETH"];
    }
    return _nameArray;
}
- (NSMutableArray *)addressArray {
    if (_addressArray == nil) {
        _addressArray = [[NSMutableArray alloc]init];
        [_addressArray addObject:@""];
        [_addressArray addObject:@""];
        [_addressArray addObject:@""];
    }
    return _addressArray;
}
- (NSMutableArray *)balanceArray {
    if (_balanceArray == nil) {
        _balanceArray = [[NSMutableArray alloc]init];
        [_balanceArray addObject:@""];
        [_balanceArray addObject:@""];
        [_balanceArray addObject:@""];
    }
    return _balanceArray;
}
- (NSMutableArray *)siyaoArray {
    if (_siyaoArray == nil) {
        _siyaoArray = [[NSMutableArray alloc]init];
        [_siyaoArray addObject:@""];
        [_siyaoArray addObject:@""];
        [_siyaoArray addObject:@""];
    }
    return _siyaoArray;
}
- (NSMutableArray *)zhujiciArray {
    if (_zhujiciArray == nil) {
        _zhujiciArray = [[NSMutableArray alloc]init];
        [_zhujiciArray addObject:@""];
        [_zhujiciArray addObject:@""];
        [_zhujiciArray addObject:@""];
    }
    return _zhujiciArray;
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
