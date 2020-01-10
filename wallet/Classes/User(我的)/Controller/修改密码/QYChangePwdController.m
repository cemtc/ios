//
//  QYChangePwdController.m
//  wallet
//
//  Created by talking　 on 2019/6/26.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "QYChangePwdController.h"
#import "SKCustomSegmentView.h"
#import "QYChangeLoginPwdView.h"
#import "QYChangeTradingPwdView.h"

@interface QYChangePwdController ()<QYChangeLoginPwdViewDelegate,QYChangeTradingPwdViewDelegate>
@property (nonatomic, strong) QYChangeLoginPwdView *loginContentView;
@property (nonatomic, strong) QYChangeTradingPwdView *tradingContentView;

@end

@implementation QYChangePwdController

- (void)qyChangeLoginPwdView:(QYChangeLoginPwdView *)topView didClickInfo:(NSDictionary *)infoDict {
    
    if (self.loginContentView.loginTextField.text == nil || self.loginContentView.loginTextField.text.length ==0) {
        
        [MBProgressHUD showMessage:@"原密码不能为空"];
        return;
    }
    if (self.loginContentView.passwordTextField1.text == nil || self.loginContentView.passwordTextField1.text.length < 6) {
        
        [MBProgressHUD showMessage:@"密码长度至少6个字符"];
        return;
    }
    if (self.loginContentView.passwordTextField1.text == nil || self.loginContentView.passwordTextField1.text.length > 16) {
        
        [MBProgressHUD showMessage:@"密码长度超过16个字符"];
        return;
    }
    if (!([self.loginContentView.passwordTextField1.text isEqualToString:self.loginContentView.passwordTextField2.text])) {
        
        [MBProgressHUD showMessage:@"两次密码输入不一致"];
        return;
    }
    

    [self gotoServerType:@"1" oldPwd:self.loginContentView.loginTextField.text newPwd:self.loginContentView.passwordTextField1.text];

    NSLog(@"登录密码");
}
- (void)qyChangeTradingPwdView:(QYChangeTradingPwdView *)topView didClickInfo:(NSDictionary *)infoDict {
    if (self.tradingContentView.loginTextField.text.length != 6) {
        [MBProgressHUD showMessage:@"请输入6位交易密码"];
        return;
    }
    if (self.tradingContentView.passwordTextField1.text.length != 6) {
        [MBProgressHUD showMessage:@"请输入6位交易密码"];
        return;
    }
    if (!([self.tradingContentView.passwordTextField1.text isEqualToString:self.tradingContentView.passwordTextField2.text])) {
        [MBProgressHUD showMessage:@"两次交易密码输入不一致"];
        return;
    }


    NSLog(@"交易密码");
    
    [self gotoServerType:@"2" oldPwd:self.tradingContentView.loginTextField.text newPwd:self.tradingContentView.passwordTextField1.text];
}

- (void)gotoServerType:(NSString *)type oldPwd:(NSString *)oldPwd newPwd:(NSString *)newPwd{
    NSLog(@"%@",type);
    SKDefineWeakSelf;
     NSMutableDictionary *d = [NSMutableDictionary new];
     [d setValue:MD532(oldPwd) forKey:@"oldPwd"];
     [d setValue:MD532(newPwd) forKey:@"newPwd"];//密码md5后的值给server 用于登录密码
     [d setValue:type forKey:@"type"];//密码类型1：登录密码2：交易密码
     NSDictionary * input = d.copy;
     [CFQCommonServer cfqServerQYAPIchangePwdWithInput:input Callback:^(id  _Nonnull response, BOOL success, NSString * _Nonnull message, NSString * _Nonnull code) {
         
         if (success) {
             [MBProgressHUD showMessage:message];
             if ([type isEqualToString:@"1"]) {
                 
                 [weakSelf exitLogin];
             }else if([type isEqualToString:@"2"]){
                 [weakSelf pop];
             }
         }else{
             
         }
     }];
}

- (void)exitLogin{
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
}

- (QYChangeLoginPwdView *)loginContentView {
    if (!_loginContentView) {
        _loginContentView = [[QYChangeLoginPwdView alloc]init];
        _loginContentView.delegate = self;
    }
    return _loginContentView;
}
- (QYChangeTradingPwdView *)tradingContentView {
    if (!_tradingContentView) {
        _tradingContentView = [[QYChangeTradingPwdView alloc]init];
        _tradingContentView.delegate = self;
    }
    return _tradingContentView;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // 设置导航栏
    [self setUpItems];
}
// 设置导航栏
- (void)setUpItems {
    
    SKCustomSegmentView *segment = [[SKCustomSegmentView alloc] initWithItemTitles:@[@"登录密码", @"交易密码"]];
    self.navigationItem.titleView = segment;
    segment.frame = CGRectMake(0, 0, 200, 35);
    SKDefineWeakSelf;
    segment.SKCustomSegmentViewBtnClickHandle = ^(SKCustomSegmentView *segment, NSString *title, NSInteger currentIndex) {
        [weakSelf changeChildVcWithCurrentIndex:currentIndex];
    };
    [segment clickDefault];
    
    
    [self.view addSubview:self.loginContentView];
    [self.loginContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(50);
    }];
    [self.view addSubview:self.tradingContentView];
    [self.tradingContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(50);
    }];
    
    self.loginContentView.hidden = NO;
    self.tradingContentView.hidden = YES;

}

- (void)changeChildVcWithCurrentIndex:(NSInteger)currentIndex {
    BOOL isHot = (currentIndex == 0);
    
    if (isHot) { // 热门

        self.loginContentView.hidden = NO;
        self.tradingContentView.hidden = YES;
        NSLog(@"aaa");

    } else { // 订阅

        self.loginContentView.hidden = YES;
        self.tradingContentView.hidden = NO;
        NSLog(@"bbb");

    }
}



@end
