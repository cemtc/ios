//
//  QYLoginController.m
//  wallet
//
//  Created by talking　 on 2019/6/14.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "QYLoginController.h"
#import "QYLoginHeadView.h"

//subviews
#import "QYLoginContentView.h"
#import "QYRegistPushContentView.h"
#import "QYRegistContentView.h"

#import "QYMibaoView.h"



//创建新的钱包  如果本地有钱包 就不创建新的钱包了  如果本地没有钱包 就去提示导入私钥
#import "CreatWalletController.h"

#import "QYForgetPwdController.h"


@interface QYLoginController ()<QYLoginHeadViewDelegate,QYLoginContentViewDelegate,QYRegistPushContentViewDelegate,QYRegistContentViewDelegate,QYMibaoViewDelegate>
@property (nonatomic, strong) QYLoginHeadView *topView;

@property (nonatomic, strong) QYLoginContentView *loginContentView;
@property (nonatomic, strong) QYRegistPushContentView *registPushContentView;
@property (nonatomic, strong) QYRegistContentView *registContentView;

//0 1 2
@property (nonatomic, assign) NSInteger completeNext;


@property (nonatomic, strong) QYMibaoView *mibaoView;

@end

@implementation QYLoginController

- (QYMibaoView *)mibaoView {
    if (!_mibaoView) {
        _mibaoView = [[QYMibaoView alloc]init];
        _mibaoView.delegate = self;
    }
    return _mibaoView;
}

- (QYLoginContentView *)loginContentView {
    if (!_loginContentView) {
        _loginContentView = [[QYLoginContentView alloc]init];
        _loginContentView.delegate = self;
    }
    return _loginContentView;
}
- (QYRegistContentView *)registContentView {
    if (!_registContentView) {
        _registContentView = [[QYRegistContentView alloc]init];
        _registContentView.delegate = self;
    }
    return _registContentView;
}
- (QYRegistPushContentView *)registPushContentView {
    if (!_registPushContentView) {
        _registPushContentView = [[QYRegistPushContentView alloc]init];
        _registPushContentView.delegate = self;
    }
    return _registPushContentView;
}

//////如果不要导航把这个打开
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIView setAnimationsEnabled:YES];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

//header click
- (void)qyLoginHeadView:(QYLoginHeadView *)topView didClickInfo:(NSString *)info {
    
    if ([info isEqualToString:@"login"]) {
        
        NSLog(@"登录");
        self.loginContentView.hidden = NO;
        self.registContentView.hidden = YES;
        self.registPushContentView.hidden = YES;
        self.mibaoView.hidden = YES;

        
    }else if ([info isEqualToString:@"regist"]){
        NSLog(@"注册");
        self.loginContentView.hidden = YES;
        
        //判断是否已经在那个界面  如果已经点击了下一步 就是push页面 如果没有点击下一步就是上个界面
        if (self.completeNext == 1) {
            //已经设置了登录 点击了下一步了
            //注册 push 1
            self.registContentView.hidden = YES;
            self.mibaoView.hidden = YES;
            self.registPushContentView.hidden = NO;

        }else if (self.completeNext == 2){
            //注册 验证 2
            self.registContentView.hidden = YES;
            self.mibaoView.hidden = NO;
            self.registPushContentView.hidden = YES;
        }
        else {
            //注册 0
            self.registContentView.hidden = NO;
            self.registPushContentView.hidden = YES;
            self.mibaoView.hidden = YES;
        }
        
    }
}


//login
- (void)qyLoginContentView:(QYLoginContentView *)topView didClickInfo:(NSDictionary *)infoDict {
    if ([infoDict[@"name"] isEqualToString:@"忘记密码"]) {

        SKDefineWeakSelf;
        QYForgetPwdController *vc = [[QYForgetPwdController alloc]init];
        [self pushVc:vc];
        vc.NextViewControllerBlock = ^(NSString * _Nonnull tfText) {
            weakSelf.loginContentView.loginTextField.text = @"";
            weakSelf.loginContentView.passwordTextField.text = @"";
        };
        return;
    }
    if (self.loginContentView.loginTextField.text == nil || self.loginContentView.loginTextField.text.length ==0) {
        
        [MBProgressHUD showMessage:@"账号不能为空"];
        return;
    }
//    if (![SKUtils isValidateMobile:self.loginContentView.loginTextField.text]) {
//        [MBProgressHUD showMessage:@"请输入正确的手机号"];
//        return;
//    }
    if (self.loginContentView.passwordTextField.text == nil || self.loginContentView.passwordTextField.text.length < 6) {
        
        [MBProgressHUD showMessage:@"密码长度至少6个字符"];
        return;
    }
    if (self.loginContentView.passwordTextField.text == nil || self.loginContentView.passwordTextField.text.length > 16) {
        
        [MBProgressHUD showMessage:@"密码长度超过16个字符"];
        return;
    }
    
    SKDefineWeakSelf;
    [self verifyisPhoneNumberCallback:^(BOOL isLogin) {
        if (isLogin) {
            [weakSelf verifyLoginSuccess];
        }else{
            [MBProgressHUD showMessage:@"您输入的账号或密码不对"];
        }
    }];
}
//验证登录成功
- (void)verifyLoginSuccess{
    CFQtestSwift *a = [[CFQtestSwift alloc]init];
    if ([a isHasWalletHandleWithMobileA:self.loginContentView.loginTextField.text]) {
        [self loginServer];
    }else{
        CreatWalletController *vc = [[CreatWalletController alloc]init];
        vc.mobile = self.loginContentView.loginTextField.text;
        vc.password = self.loginContentView.passwordTextField.text;
        [self pushVc:vc];
        NSLog(@"此账号本地钱包没有创建,去导入私钥界面,然后去创建钱包");
    }
}
- (void)loginServer{
    
    SKDefineWeakSelf;
    NSMutableDictionary *d = [NSMutableDictionary new];
    [d setValue:self.loginContentView.loginTextField.text forKey:@"mobile"];
    [d setValue:MD532(self.loginContentView.passwordTextField.text) forKey:@"password"];
    NSDictionary * input = d.copy;
    [MBProgressHUD showMessage:@"正在登陆中"];
    [CFQCommonServer cfqServerQYAPIloginWithInput:input Callback:^(id  _Nonnull response, BOOL success, NSString * _Nonnull message, NSString * _Nonnull code) {

        if (success) {
            NSDictionary *dict = (NSDictionary *)response;
            
            NSLog(@"%@",response);
            NSLog(@"%@",message);
            
            NSMutableDictionary *dicc = [NSMutableDictionary dictionary];
            [dicc setValue:weakSelf.loginContentView.loginTextField.text forKey:@"mobile"];
            
            CFQtestSwift *a = [[CFQtestSwift alloc]init];
            
            NSLog(@"此账号本地已经有这个钱包了,直接进入首页");
            //获取当前账号的本地数据库索引
            NSInteger index = [a currentUserModelIndexWithMobileA:weakSelf.loginContentView.loginTextField.text];
            [dicc setValue:[NSString stringWithFormat:@"%ld",index] forKey:@"indexString"];
            [dicc setValue:dict[@"token"] forKey:@"token"];
            [dicc setValue:dict[@"customerId"] forKey:@"customerId"];
            [dicc setValue:dict[@"myCode"] forKey:@"myCode"];
            
            
            //    保存用户登录信息
            [[SKUserInfoManager sharedManager] didLoginInWithUserInfo:dicc];
            //进入首页
            [SKGET_APP_DELEGATE checkLoginFromControl:@"login"];
            
        }else {
            
            NSLog(@"登录失败");
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [MBProgressHUD showError:message toView:nil];
                [MBProgressHUD showMessage:message];
            });
        }

    }];
    
}


//regist
- (void)qyRegistContentView:(QYRegistContentView *)topView didClickInfo:(NSDictionary *)infoDict {
    
    if (self.registContentView.loginTextField.text == nil || self.registContentView.loginTextField.text.length ==0) {
        
        [MBProgressHUD showMessage:@"账号不能为空"];
        return;
    }
    if (self.registContentView.passwordTextField1.text == nil || self.registContentView.passwordTextField1.text.length < 6) {
        
        [MBProgressHUD showMessage:@"密码长度至少6个字符"];
        return;
    }
    if (self.registContentView.passwordTextField1.text == nil || self.registContentView.passwordTextField1.text.length > 16) {
        
        [MBProgressHUD showMessage:@"密码长度超过16个字符"];
        return;
    }
    if (!([self.registContentView.passwordTextField1.text isEqualToString:self.registContentView.passwordTextField2.text])) {
        
        [MBProgressHUD showMessage:@"两次密码输入不一致"];
        return;
    }

    
    
    
    NSLog(@"下一步");
    
    
    
    //最后进入了设置交易密码界面
    self.loginContentView.hidden = YES;
    self.registContentView.hidden = YES;
    self.mibaoView.hidden = YES;
    self.registPushContentView.hidden = NO;
    self.completeNext = 1;
}
//registpush
- (void)qyRegistPushContentView:(QYRegistPushContentView *)topView didClickInfo:(NSDictionary *)infoDict {
    if (self.registPushContentView.passwordTextField1.text.length != 6) {
        [MBProgressHUD showMessage:@"请输入6位交易密码"];
        return;
    }
    if (!([self.registPushContentView.passwordTextField1.text isEqualToString:self.registPushContentView.passwordTextField2.text])) {
        [MBProgressHUD showMessage:@"两次交易密码输入不一致"];
        return;
    }
//    if (self.registPushContentView.invitationTextField.text == nil || self.registPushContentView.invitationTextField.text.length ==0) {
//
//        [MBProgressHUD showMessage:@"邀请码不能为空"];
//        return;
//    }
    self.loginContentView.hidden = YES;
    self.registContentView.hidden = YES;
    self.mibaoView.hidden = NO;
    self.registPushContentView.hidden = YES;
    self.completeNext = 2;

    


    
//    // 重置用户信息 保存本地
//    SKUserInfoModel *model = [SKUserInfoManager sharedManager].currentUserInfo;
//    model.talkingPayPassword = self.registPushContentView.passwordTextField2.text;
//    //登录
//    [[SKUserInfoManager sharedManager] didLoginInWithUserInfo:@{@"talkingPayPassword":model.talkingPayPassword}];
//
//    // 重置用户信息 保存本地
////    [[SKUserInfoManager sharedManager] resetUserInfoWithUserInfo:];
//
//
    
//    NSDictionary *dict = @{@"talkingPayPassword":self.registPushContentView.passwordTextField2.text};
//    //    保存用户登录信息
//    [[SKUserInfoManager sharedManager] didLoginInWithUserInfo:dict];
//
//    //设置SKTabBarController 为rootViewController
//    [SKGET_APP_DELEGATE checkLoginFromControl:@"login"];
//
//    CFQtestSwift *a = [[CFQtestSwift alloc]init];
//    if ([a isHasWalletHandle]) {
//        NSLog(@"去导入私钥界面");
//    }else{
//        [a creatgenerateMnemonicWord];
//    }
}
- (void)qyMibaoView:(QYMibaoView *)topView didClickInfo:(NSDictionary *)infoDict {
    SKDefineWeakSelf;
    
    if ([infoDict[@"name"] isEqualToString:@"rightBtn"]) {
        
        [MWShowPickerView showWithDataArr:@[@"您配偶的生日是？",@"您母亲的生日是？",@"您小学班主任的名字是？",@"您最熟悉的童年好友名字是？",@"对您影响最大的人名字是？"] title:@"选择币种" select:@"" callback:^(NSString * _Nonnull string) {
            
            weakSelf.mibaoView.q1.text = string;
            
        }];
        
        return;
    }

    
    if (self.mibaoView.q1TextField.text == nil || self.mibaoView.q1TextField.text.length ==0) {
        [MBProgressHUD showMessage:@"请输入问题答案"];
        return;
    }
    NSLog(@"注册");
    SKBaseRequest *request = [SKBaseRequest sk_request];
    request.sk_url = QYAPI_register_Url;
    //请求类型
    request.sk_methodType = SKRequestMethodTypePOST;
    //接收类型
    request.sk_resultType = SKResultResponTypeDictionary;
    
    NSMutableDictionary *dicc = [NSMutableDictionary dictionary];
    [dicc setValue:@"" forKey:@"customerName"];
    [dicc setValue:self.registContentView.loginTextField.text forKey:@"mobile"];
    [dicc setValue:MD532(self.registContentView.passwordTextField1.text) forKey:@"password"];
    [dicc setValue:@"" forKey:@"msgCode"];
    [dicc setValue:self.registPushContentView.invitationTextField.text forKey:@"inviteCode"];
    //交易密码
    [dicc setValue:MD532(self.registPushContentView.passwordTextField1.text) forKey:@"tradePwd"];
    
    [dicc setValue:self.mibaoView.q1.text forKey:@"quesTion"];
    [dicc setValue:self.mibaoView.q1TextField.text forKey:@"answer"];
    
    
    request.data = dicc;
    [MBProgressHUD showMessage:@"loading"];
    [request sk_sendRequestWithCompletion:^(id response, BOOL success, NSString *message, NSString *code) {
        if (success) {
            NSLog(@"%@",response);
            NSLog(@"%@",message);
            
            //注册成功之后去登录界面  让用户登录
            self.loginContentView.hidden = NO;
            self.registContentView.hidden = YES;
            self.registPushContentView.hidden = YES;
            self.completeNext = 0;
            self.mibaoView.hidden = YES;
            self.topView.bottomLeftImageView.hidden = NO;
            self.topView.bottomRightImageView.hidden = YES;
            
            //            self.loginContentView.loginTextField.text = self.registContentView.loginTextField.text;
            //注册成功之后 进入登录页 登录页手机号清空
            self.loginContentView.loginTextField.text = @"";
            self.loginContentView.passwordTextField.text = @"";
            
            
            self.registContentView.loginTextField.text = @"";
            self.registContentView.passwordTextField1.text = @"";
            self.registContentView.passwordTextField2.text = @"";
            
            self.registPushContentView.passwordTextField1.text = @"";
            self.registPushContentView.passwordTextField2.text = @"";
            self.registPushContentView.invitationTextField.text = @"";
            
        }else {
            NSLog(@"注册失败");
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                //                [MBProgressHUD showError:message toView:nil];
                [MBProgressHUD showMessage:message];
                
            });
            
        }
    }];

    
    
}
- (QYLoginHeadView *)topView{
    if (!_topView) {
        _topView = [[QYLoginHeadView alloc]init];
        _topView.delegate = self;
    }
    return _topView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.completeNext = 0;

    // 设置导航栏
    [self setUpItems];
    
    // 设置子视图
    [self setUpViews];
    
}
// 设置导航栏
- (void)setUpItems {
    
    self.navigationItem.title = @"登录";
    
}
// 设置子视图
- (void)setUpViews {
    CGFloat _originHeight = 0;
    if (SKIsIphoneX) {
        _originHeight = 220 + (88 - 64);
    }else {
        _originHeight = 220;
    }
    //topView
    [self.view addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(_originHeight);
    }];
    
    [self.view addSubview:self.loginContentView];
    [self.view addSubview:self.registContentView];
    [self.view addSubview:self.registPushContentView];
    [self.view addSubview:self.mibaoView];

    [self.loginContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(self.topView.mas_bottom);
    }];
    [self.registContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(self.topView.mas_bottom);
    }];
    [self.registPushContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(self.topView.mas_bottom);
    }];
    
    [self.mibaoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(self.topView.mas_bottom);
    }];

    self.loginContentView.hidden = NO;
    self.registContentView.hidden = YES;
    self.registPushContentView.hidden = YES;
    self.mibaoView.hidden = YES;

    
    self.mibaoView.q1.text = @"您配偶的生日是？";
}
//验证登录
- (void)verifyisPhoneNumberCallback:(void(^)(BOOL isLogin))callback{
    NSMutableDictionary *d = [NSMutableDictionary new];
    [d setValue:self.loginContentView.loginTextField.text forKey:@"mobile"];
    [d setValue:MD532(self.loginContentView.passwordTextField.text) forKey:@"password"];
    NSDictionary * input = d.copy;
    [MBProgressHUD showMessage:@"loading"];
    [CFQCommonServer cfqServerQYAPIloginWithInput:input Callback:^(id  _Nonnull response, BOOL success, NSString * _Nonnull message, NSString * _Nonnull code) {
        if (success) {
            callback(YES);
        }else {
            callback(NO);
        }
    }];
}

@end
