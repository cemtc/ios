//
//  QYForgetPwdController.m
//  wallet
//
//  Created by talking　 on 2019/7/19.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "QYForgetPwdController.h"
#import "QYForgetPwdView.h"

@interface QYForgetPwdController ()<QYForgetPwdViewDelegate>

@property (nonatomic, strong) QYForgetPwdView *registContentView;

@end

@implementation QYForgetPwdController
- (QYForgetPwdView *)registContentView {
    if (!_registContentView) {
        _registContentView = [[QYForgetPwdView alloc]init];
        _registContentView.delegate = self;
    }
    return _registContentView;
}
//regist
- (void)qyForgetPwdView:(QYForgetPwdView *)topView didClickInfo:(NSDictionary *)infoDict{
    SKDefineWeakSelf;

    
    if ([infoDict[@"name"] isEqualToString:@"rightBtn"]) {

        [MWShowPickerView showWithDataArr:@[@"您配偶的生日是？",@"您母亲的生日是？",@"您小学班主任的名字是？",@"您最熟悉的童年好友名字是？",@"对您影响最大的人名字是？"] title:@"选择币种" select:@"" callback:^(NSString * _Nonnull string) {

            weakSelf.registContentView.q1.text = string;
            
        }];
        
        return;
    }

    
    
    
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
    if (self.registContentView.passwordTextField2.text.length != 6) {
        [MBProgressHUD showMessage:@"请输入6位交易密码"];
        return;
    }
    if (self.registContentView.q1TextField.text == nil || self.registContentView.q1TextField.text.length ==0) {
        [MBProgressHUD showMessage:@"请输入问题答案"];
        return;
    }
    

    
    NSLog(@"下一步");
    
    NSMutableDictionary *d = [NSMutableDictionary new];
    [d setValue:self.registContentView.loginTextField.text forKey:@"mobile"];
    [d setValue:MD532(self.registContentView.passwordTextField1.text) forKey:@"newPwd"];
    [d setValue:MD532(self.registContentView.passwordTextField2.text) forKey:@"newTradePwd"];
    [d setValue:self.registContentView.q1.text forKey:@"quesTion"];
    [d setValue:self.registContentView.q1TextField.text forKey:@"answer"];

    NSDictionary * input = d.copy;
    [CFQCommonServer cfqServerQYAPIchangePwdByQuesWithInput:input Callback:^(id  _Nonnull response, BOOL success, NSString * _Nonnull message, NSString * _Nonnull code) {
        
        if (success) {
            [weakSelf pop];
            [MBProgressHUD showMessage:@"重置密码成功"];
            if (weakSelf.NextViewControllerBlock) {
                weakSelf.NextViewControllerBlock(@"需要传递的东西");
            }
        }else{
        }
    }];

    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // 设置导航栏
    [self setUpItems];
    
    // 设置子视图
    [self setUpViews];
    
}
// 设置导航栏
- (void)setUpItems {
    
    self.navigationItem.title = @"忘记密码";
    
}
// 设置子视图
- (void)setUpViews {
    
    [self.view addSubview:self.registContentView];
    [self.registContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(self.view);
    }];
    
    self.registContentView.q1.text = @"您配偶的生日是？";
}


@end
