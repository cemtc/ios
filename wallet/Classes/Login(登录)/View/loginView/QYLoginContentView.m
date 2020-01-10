//
//  QYLoginContentView.m
//  wallet
//
//  Created by talking　 on 2019/6/18.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "QYLoginContentView.h"
#import "UITextField+HLLeftView.h"//快速创建textfile
#import "UIButton+Addition.h"//快速创建一个button
#import "UIView+Tap.h"

@interface QYLoginContentView ()


@property (nonatomic, strong) UIImageView *passwordIsTrueimageView;


@property (nonatomic, strong) UILabel *wangjimimaL;

@end

@implementation QYLoginContentView

- (UILabel *)wangjimimaL {
    if (!_wangjimimaL) {
        _wangjimimaL = [[UILabel alloc]init];
        _wangjimimaL.textColor = QYThemeColor;
        _wangjimimaL.font = [UIFont systemFontOfSize:12];
        _wangjimimaL.text = @"忘记密码";
    }
    return _wangjimimaL;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self customUI];
    }
    return self;
}
- (void)customUI {
    
    self.loginTextField = [UITextField textFieldWithPlaceholder:@"请输入手机号" leftIconImage:SKImageNamed(@"icon_iphone") height:SKAppAdapter(44) leftViewWith:35];
    [self addSubview:self.loginTextField];
    [self.loginTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(SKAppAdapter(55));
        make.left.mas_equalTo(self.mas_left).offset(SKAppAdapter(30));
        make.right.mas_equalTo(self.mas_right).offset(SKAppAdapter(-30));
        make.height.mas_equalTo(44);
    }];
    self.loginTextField.keyboardType = UIKeyboardTypePhonePad;
    self.loginTextField.clearButtonMode = UITextFieldViewModeWhileEditing;

    
    UILabel *lable1 = [[UILabel alloc]init];
    lable1.backgroundColor = SKBlackColor;
    lable1.alpha = 0.9;
    [self addSubview:lable1];
    [lable1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.loginTextField.mas_left).offset(10);
        make.right.equalTo(self.loginTextField.mas_right).offset(-25);
        make.top.mas_equalTo(self.loginTextField.mas_bottom);
        make.height.mas_equalTo(1);
    }];


    self.passwordTextField = [UITextField textFieldWithPlaceholder:@"请输入登录密码" leftIconImage:SKImageNamed(@"icon_password") height:SKAppAdapter(44) leftViewWith:35];
    [self addSubview:self.passwordTextField];
    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.loginTextField.mas_bottom).offset(30);
        make.left.mas_equalTo(self.mas_left).offset(SKAppAdapter(30));
        make.right.mas_equalTo(self.mas_right).offset(SKAppAdapter(-30) - 60);
        make.height.mas_equalTo(44);
    }];
//    self.passwordTextField.keyboardType = UIKeyboardTypePhonePad;
    self.passwordTextField.secureTextEntry = YES;

    UILabel *lable2 = [[UILabel alloc]init];
    lable2.backgroundColor = SKItemNormalColor;
    lable2.alpha = 0.8;
    [self addSubview:lable2];
    [lable2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.loginTextField.mas_left).offset(10);
        make.right.equalTo(self.loginTextField.mas_right).offset(-25);
        make.top.mas_equalTo(self.passwordTextField.mas_bottom);
        make.height.mas_equalTo(1);
    }];


    self.loginButton = [UIButton buttonWithTitle:@"登录" titleColor:SKWhiteColor bgColor:QYThemeColor fontSize:20 target:self action:@selector(loginButtonClick:)];
    [self addSubview:self.loginButton];
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.passwordTextField.mas_bottom).offset(50);
        make.left.equalTo(self).offset(40);
        make.right.equalTo(self).offset(-40);
        make.height.mas_equalTo(50);
    }];
    self.loginButton.layer.cornerRadius = 25;

    
    [self addSubview:self.passwordIsTrueimageView];
    [self.passwordIsTrueimageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.passwordTextField.mas_centerY);
        make.right.mas_equalTo(lable2.mas_right).offset(-10);
    }];
    self.passwordIsTrueimageView.image = SKImageNamed(@"icon_close");
    SKDefineWeakSelf;
    [self.passwordIsTrueimageView setTapActionWithBlock:^{
        [weakSelf passWorldTrueAndFalseHandle];
    }];
    
    
    
    [self addSubview:self.wangjimimaL];
    [self.wangjimimaL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(lable2.mas_right);
        make.top.mas_equalTo(lable2.mas_bottom).offset(10);
    }];
    
    [self.wangjimimaL setTapActionWithBlock:^{
        if ([weakSelf.delegate respondsToSelector:@selector(qyLoginContentView:didClickInfo:)]) {
            [weakSelf.delegate qyLoginContentView:weakSelf didClickInfo:@{@"name":@"忘记密码"}];
        }
    }];
}
- (void)loginButtonClick:(UIButton *)button {
    
    if ([self.delegate respondsToSelector:@selector(qyLoginContentView:didClickInfo:)]) {
        [self.delegate qyLoginContentView:self didClickInfo:@{@"name":@"caofuqing"}];
    }
    
}
- (void)passWorldTrueAndFalseHandle {
    
    if (self.passwordTextField.secureTextEntry == YES) {
        //显示
        self.passwordTextField.secureTextEntry = NO;
        self.passwordIsTrueimageView.image = SKImageNamed(@"icon_open");
    }else {
        //隐藏
        self.passwordTextField.secureTextEntry = YES;
        self.passwordIsTrueimageView.image = SKImageNamed(@"icon_close");
    }
    

}

- (UIImageView *)passwordIsTrueimageView {
    if (!_passwordIsTrueimageView) {
        _passwordIsTrueimageView = [[UIImageView alloc]initWithImage:SKImageNamed(@"icon_close")];
    }
    return _passwordIsTrueimageView;
}

@end
