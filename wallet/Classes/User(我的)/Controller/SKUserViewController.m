//
//  SKUserViewController.m
//  Business
//
//  Created by talking　 on 2018/8/15.
//  Copyright © 2018年 talking　. All rights reserved.
//

#import "SKUserViewController.h"

#import "SKUserTopView.h"
#import "SKUserListCell.h"

#import "SKUserListModel.h"


#import "SKCustomWebViewController.h"//加载webView H5

#import "SKUserFooterView.h"

#import "CFQCustomAlertView.h"//客服

//理财记录
#import "QYFinancialRecordsController.h"
//理财收益记录
#import "FinancialBenefitsController.h"


//我的邀请码
#import "QYInviteCodeController.h"
#import "SKCustomActionSheet.h"

//修改密码
#import "QYChangePwdController.h"

//关于我们
#import "QYAboutUsController.h"

//赎回记录
#import "QYRedemptionController.h"

//糖果记录
#import "QYCandyController.h"


//众筹记录
#import "QYRaiseRecordController.h"


@interface SKUserViewController ()<SKUserFooterViewDelegate,SKUserTopViewDelegate>

@property (nonatomic, strong) SKUserTopView *topView;

/** 用户基本信息*/
@property (nonatomic, strong) SKUserInfoModel *userInfoModel;


/*底部视图*/
@property (nonatomic, strong) SKUserFooterView *footerView;
@end

@implementation SKUserViewController
- (void)skUserFooterView:(SKUserFooterView *)topView didClickInfo:(NSString *)info {
    
    [UIAlertView alertWithTitle:@"提示" message:@"确定退出账号？" okHandler:^{
        //20.退出登录
        NSMutableDictionary *d = [NSMutableDictionary new];
        [d setValue:@"" forKey:@""];
        NSDictionary * input = d.copy;
        [CFQCommonServer cfqServerQYAPIlogoutWithInput:input Callback:^(id  _Nonnull response, BOOL success, NSString * _Nonnull message, NSString * _Nonnull code) {
            if (success) {
                [SKGET_APP_DELEGATE exitSign];
            }else {
                //如果请求失败了也暂时退出账号去
                [SKGET_APP_DELEGATE exitSign];
            }
        }];

    } cancelHandler:^{
        
    }];
}

- (void)skUserTopView:(SKUserTopView *)topView didClickInfo:(NSString *)info {
    
    SKDefineWeakSelf;
    if ([info isEqualToString:@"kefu"]) {
        
         NSMutableDictionary *d = [NSMutableDictionary new];
         [d setValue:@"" forKey:@""];
         NSDictionary * input = d.copy;
         [CFQCommonServer cfqServerQYAPIGetCustomListWithInput:input Callback:^(id  _Nonnull response, BOOL success, NSString * _Nonnull message, NSString * _Nonnull code) {

             if (success) {
                 
                 NSMutableArray *dArray = [CFQCommonModel modelArrayWithDictArray:response];
                 if (dArray.count) {
                     
                     [weakSelf alertDataHandle:dArray];

                 }else{
                     
                     [MBProgressHUD showMessage:@"暂无数据"];
                 }
                 
                 NSLog(@"%@",response);
             }else{
                 
             }

         }];

        
    }
    
}
- (void)alertDataHandle:(NSArray *)data{
    CFQCommonModel *model = data[0];
    
    SKDefineWeakSelf;
    CFQCustomAlertView *alertView = [[CFQCustomAlertView alloc]init];
    alertView.imagesArray = @[@"icon_qq",@"icon_wechat",@"icon_email",@"icon_phone"];
    alertView.titlesArray = @[model.tencentNo,model.wechatNo,model.email,model.phoneNo];
    alertView.clickBlock = ^(NSString * _Nonnull info) {
        
        if ([model.phoneNo isEqualToString:info]) {
            [weakSelf alertIphoneClick:info];
        }else{
            [weakSelf alertClick:info];
        }
    };
    [alertView show];

}
- (void)alertIphoneClick:(NSString *)str {
    NSString *telStr = str;
    UIWebView *callWebView = [[UIWebView alloc] init];
    NSURL *telURL          = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",telStr]];
    [callWebView loadRequest:[NSURLRequest requestWithURL:telURL]];
    [self.view addSubview:callWebView];
}

- (void)alertClick:(NSString *)str {
    NSLog(@"%@",str);
    [UIPasteboard generalPasteboard].string = str;
    [MBProgressHUD showMessage:@"复制成功"];
}

- (SKUserFooterView *)footerView {
    if (!_footerView) {
        _footerView = [[SKUserFooterView alloc]initWithFrame:CGRectMake(0, 0, SKScreenWidth, 50)];
        self.tableView.tableFooterView = _footerView;
        _footerView.delegate = self;
    }
    return _footerView;
}

//////如果不要导航把这个打开
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIView setAnimationsEnabled:YES];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    
    SKDefineWeakSelf;
     //4.获取总资产和平台币GET(我的界面)
     NSMutableDictionary *d = [NSMutableDictionary new];
     [d setValue:@"" forKey:@""];
     NSDictionary * input = d.copy;
//     [CFQCommonServer cfqServerQYAPIgetPropertyWithInput:input Callback:^(id  _Nonnull response, BOOL success, NSString * _Nonnull message, NSString * _Nonnull code) {
//         
//         if (success) {
//             NSDictionary *dict = (NSDictionary *)response;
//             CFQCommonModel *model = [CFQCommonModel modelWithDictionary:dict];
//             if (model.property) {
//                 weakSelf.topView.bottomLeftMoney.text = [NSString stringWithFormat:@"%.2f",[model.property floatValue]];
//             }else {
//                 weakSelf.topView.bottomLeftMoney.text = @"0";
//             }
//             if (model.totalBalance) {
//                 weakSelf.topView.bottomRightMoney.text = [NSString stringWithFormat:@"%.2f",[model.totalBalance floatValue]];
//             }else {
//                 weakSelf.topView.bottomRightMoney.text = @"0";
//             }
//         }else{
//             
//         }
//     }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //修改状态栏颜色
    self.barStyle = UIStatusBarStyleLightContent;
    // 设置导航栏
    [self setUpItems];
    
    // 设置子视图
    [self setUpViews];
}
// 设置导航栏
- (void)setUpItems {
    
    self.navigationItem.title = @"我的";
}

// 设置子视图
- (void)setUpViews {
    
    //不需要分割线
    self.needCellSepLine = NO;
    

    self.userInfoModel = [[SKUserInfoManager sharedManager] currentUserInfo];
    self.topView.nickNameLabel.text = [SKUtils parseUserName:self.userInfoModel.mobile nickname:@""];
    
    self.dataArray = @[@[@"搬砖记录",@"搬砖成果",@"提现记录",@"糖果记录",@"众筹记录"],@[@"关于我们",@"项目白皮书"],@[@"我的邀请码",@"修改密码",@"检测更新"]].mutableCopy;
    
    
    self.footerView.titleText = @"退出账号";
}

- (SKUserTopView *)topView {
    if (!_topView) {
        
        CGFloat _originHeight = 0;
        if (SKIsIphoneX) {
            _originHeight = 200 + (88 - 64);
        }else {
            _originHeight = 200;
        }

        _topView = [[SKUserTopView alloc]initWithFrame:CGRectMake(0, 0, SKScreenWidth, _originHeight)];
        [self.view addSubview:_topView];
        _topView.delegate = self;
        
        if (SKIsIphoneX) {
            self.tableView.contentInset = UIEdgeInsetsMake(_topView.frame.size.height - 44, 0, 50, 0);
        }else{
            self.tableView.contentInset = UIEdgeInsetsMake(_topView.frame.size.height - 20, 0, 50, 0);
        }
    }
    return _topView;
}

#pragma mark - UITableViewDelegate
//只有一个Section
- (NSInteger)sk_numberOfSections {
    return self.dataArray.count;
}
//cell 的数据源个数
- (NSInteger)sk_numberOfRowsInSection:(NSInteger)section {
    return [self.dataArray[section] count];
}
//cell
- (SKBaseTableViewCell *)sk_cellAtIndexPath:(NSIndexPath *)indexPath {
    
    SKUserListCell *cell = [SKUserListCell cellWithTableView:self.tableView];
    SKUserListModel *model = [[SKUserListModel alloc]init];
    model.title = self.dataArray[indexPath.section][indexPath.row];
    cell.model = model;
    //隐藏最后一个cell
    if (indexPath.row == [self.tableView numberOfRowsInSection:indexPath.section]-1) {
        cell.bottomLineLabel.hidden = YES;
    }else {
        cell.bottomLineLabel.hidden = NO;
    }

    return cell;
}
//cell高度
- (CGFloat)sk_cellheightAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
//section headview高度
- (CGFloat)sk_sectionHeaderHeightAtSection:(NSInteger)section {
    return 12;
}
//headview背景颜色为clear
- (UIView *)sk_headerAtSection:(NSInteger)section {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SKScreenWidth, 5)];
    view.backgroundColor = SKClearColor;
    return view;
}
//cell点击事件
- (void)sk_didSelectCellAtIndexPath:(NSIndexPath *)indexPath cell:(SKBaseTableViewCell *)cell {
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            //理财记录
            QYFinancialRecordsController *vc = [[QYFinancialRecordsController alloc]init];
            [self pushVc:vc];
        }else if (indexPath.row == 1){
            //理财收益记录
            NSLog(@"理财收益记录");
            FinancialBenefitsController *vc = [[FinancialBenefitsController alloc]init];
            [self pushVc:vc];
        }else if (indexPath.row == 2){
            //赎回记录
            NSLog(@"赎回记录");
            QYRedemptionController *vc = [[QYRedemptionController alloc]init];
            [self pushVc:vc];
        }else if (indexPath.row == 3){
            //糖果记录
            NSLog(@"糖果记录");
            QYCandyController *vc = [[QYCandyController alloc]init];
            [self pushVc:vc];
        }else if (indexPath.row == 4){
            QYRaiseRecordController *vc = [[QYRaiseRecordController alloc]init];
            [self pushVc:vc];
        }
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            //关于我们
            NSLog(@"关于我们");
            
            QYAboutUsController *vc = [QYAboutUsController new];
            vc.indexString = @"3";
            vc.navigationItem.title = @"关于我们";
            [self pushVc:vc];
            
        }else if (indexPath.row == 1){
            //项目白皮书
            NSLog(@"项目白皮书");
            QYAboutUsController *vc = [QYAboutUsController new];
            vc.indexString = @"2";
            vc.navigationItem.title = @"项目白皮书";
            [self pushVc:vc];
            
        }
    }else if (indexPath.section == 2){
        if (indexPath.row == 0) {
            //我的邀请码
            NSLog(@"我的邀请码");
            QYInviteCodeController *vc = [[QYInviteCodeController alloc]init];
            [self pushVc:vc];
            
        }else if (indexPath.row == 1){
            //修改密码
            NSLog(@"修改密码");
            QYChangePwdController *vc = [[QYChangePwdController alloc]init];
            [self pushVc:vc];
        }else if (indexPath.row == 2){
            NSLog(@"检测更新");
           /* [CFQCommonServer checkNewBuildCallback:^(BOOL isUpdate) {
                if (isUpdate) {
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [UIAlertView alertWithTitle:@"提示" message:@"立即更新" okHandler:^{
                            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://fir.im/wToken"]];
                        } cancelHandler:^{
                        }];
                    });
                    
                }else{
                    dispatch_async(dispatch_get_main_queue(), ^{

                        [MBProgressHUD showMessage:@"当前版本已经是最新版本"];

                    });


                }
            }];
            */
            [self checkAppVersionInfo];

        }
    }
}
- (void)checkAppVersionInfo
{
    
    NSString *versionString = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    
    NSMutableDictionary *d = [NSMutableDictionary new];
    [d setValue:versionString forKey:@"versionName"];
    [d setValue:@"2" forKey:@"type"];
    
    NSDictionary * input = d.copy;
    SKDefineWeakSelf;
    [CFQCommonServer cfqServerQYAPIgetVersionInfoWithInput:input Callback:^(id  _Nonnull response, BOOL success, NSString * _Nonnull message, NSString * _Nonnull code) {
        
        if (success) {
            
            NSLog(@"%@",response);
            
            [weakSelf downLoadIpaUrl:[NSString stringWithFormat:@"%@",message]];
            
        }else{
            
//            NSLog(@"%@",response);
//            NSLog(@"%@",message);
//
//            NSLog(@"不需要升级");
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [MBProgressHUD showMessage:@"The current version is already the latest version"];
                
            });

        }
        
    }];
    
}

-(void)downLoadIpaUrl:(NSString *)url{
    [UIAlertView alertWithTitle:@"Message" message:@"Update App" okHandler:^{
        
        NSString *iosHyperLink = [NSString stringWithFormat:@"itms-services://?action=download-manifest&url=%@",url];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:iosHyperLink]];
        
    } cancelHandler:^{
        
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
