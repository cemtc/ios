//
//  QYChangeTradingPwdView.m
//  wallet
//
//  Created by talking　 on 2019/6/26.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "QYChangeTradingPwdView.h"
#import "UITextField+HLLeftView.h"//快速创建textfile
#import "UIButton+Addition.h"//快速创建一个button
#import "UIView+Tap.h"

@interface QYChangeTradingPwdView ()
@property (nonatomic, strong) UIImageView *passwordIsTrueimageView1;
@property (nonatomic, strong) UIImageView *passwordIsTrueimageView2;

@end

@implementation QYChangeTradingPwdView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self customUI];
    }
    return self;
}
- (void)customUI {
    self.loginTextField = [UITextField textFieldWithPlaceholder:@"请输入原密码" leftIconImage:SKImageNamed(@"icon_password") height:SKAppAdapter(44) leftViewWith:35];
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
    
    
    self.passwordTextField1 = [UITextField textFieldWithPlaceholder:@"请输入新密码(6位数)" leftIconImage:SKImageNamed(@"icon_password") height:SKAppAdapter(44) leftViewWith:35];
    [self addSubview:self.passwordTextField1];
    [self.passwordTextField1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.loginTextField.mas_bottom).offset(30);
        make.left.mas_equalTo(self.mas_left).offset(SKAppAdapter(30));
        make.right.mas_equalTo(self.mas_right).offset(SKAppAdapter(-30) - 60);
        make.height.mas_equalTo(44);
    }];
    self.passwordTextField1.keyboardType = UIKeyboardTypePhonePad;
    self.passwordTextField1.secureTextEntry = YES;
    
    UILabel *lable2 = [[UILabel alloc]init];
    lable2.backgroundColor = SKItemNormalColor;
    lable2.alpha = 0.8;
    [self addSubview:lable2];
    [lable2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.loginTextField.mas_left).offset(10);
        make.right.equalTo(self.loginTextField.mas_right).offset(-25);
        make.top.mas_equalTo(self.passwordTextField1.mas_bottom);
        make.height.mas_equalTo(1);
    }];
    
    self.passwordTextField2 = [UITextField textFieldWithPlaceholder:@"请输入新密码(6位数)" leftIconImage:SKImageNamed(@"icon_password") height:SKAppAdapter(44) leftViewWith:35];
    [self addSubview:self.passwordTextField2];
    [self.passwordTextField2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.passwordTextField1.mas_bottom).offset(30);
        make.left.mas_equalTo(self.mas_left).offset(SKAppAdapter(30));
        make.right.mas_equalTo(self.mas_right).offset(SKAppAdapter(-30) - 60);
        make.height.mas_equalTo(44);
    }];
    self.passwordTextField2.keyboardType = UIKeyboardTypePhonePad;
    self.passwordTextField2.secureTextEntry = YES;
    
    UILabel *lable3 = [[UILabel alloc]init];
    lable3.backgroundColor = SKBlackColor;
    lable3.alpha = 0.9;
    [self addSubview:lable3];
    [lable3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.loginTextField.mas_left).offset(10);
        make.right.equalTo(self.loginTextField.mas_right).offset(-25);
        make.top.mas_equalTo(self.passwordTextField2.mas_bottom);
        make.height.mas_equalTo(1);
    }];
    
    
    self.nextButton = [UIButton buttonWithTitle:@"修改" titleColor:SKWhiteColor bgColor:QYThemeColor fontSize:20 target:self action:@selector(nextButtonClick:)];
    [self addSubview:self.nextButton];
    [self.nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.passwordTextField2.mas_bottom).offset(50);
        make.left.equalTo(self).offset(40);
        make.right.equalTo(self).offset(-40);
        make.height.mas_equalTo(50);
    }];
    self.nextButton.layer.cornerRadius = 25;
    
    
    [self addSubview:self.passwordIsTrueimageView1];
    [self.passwordIsTrueimageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.passwordTextField1.mas_centerY);
        make.right.mas_equalTo(lable2.mas_right).offset(-10);
    }];
    self.passwordIsTrueimageView1.image = SKImageNamed(@"icon_close");
    SKDefineWeakSelf;
    [self.passwordIsTrueimageView1 setTapActionWithBlock:^{
        [weakSelf passWorldTrueAndFalseHandle1];
    }];
    
    [self addSubview:self.passwordIsTrueimageView2];
    [self.passwordIsTrueimageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.passwordTextField2.mas_centerY);
        make.right.mas_equalTo(lable2.mas_right).offset(-10);
    }];
    self.passwordIsTrueimageView2.image = SKImageNamed(@"icon_close");
    [self.passwordIsTrueimageView2 setTapActionWithBlock:^{
        [weakSelf passWorldTrueAndFalseHandle2];
    }];
    
    
}
- (void)nextButtonClick:(UIButton *)button {
    
    if ([self.delegate respondsToSelector:@selector(qyChangeTradingPwdView:didClickInfo:)]) {
        [self.delegate qyChangeTradingPwdView:self didClickInfo:@{@"name":@"caofuqing"}];
    }
}
- (void)passWorldTrueAndFalseHandle1 {
    
    if (self.passwordTextField1.secureTextEntry == YES) {
        //显示
        self.passwordTextField1.secureTextEntry = NO;
        self.passwordIsTrueimageView1.image = SKImageNamed(@"icon_open");
    }else {
        //隐藏
        self.passwordTextField1.secureTextEntry = YES;
        self.passwordIsTrueimageView1.image = SKImageNamed(@"icon_close");
    }
    
    
}

- (UIImageView *)passwordIsTrueimageView1 {
    if (!_passwordIsTrueimageView1) {
        _passwordIsTrueimageView1 = [[UIImageView alloc]initWithImage:SKImageNamed(@"icon_close")];
    }
    return _passwordIsTrueimageView1;
}

- (void)passWorldTrueAndFalseHandle2 {
    
    if (self.passwordTextField2.secureTextEntry == YES) {
        //显示
        self.passwordTextField2.secureTextEntry = NO;
        self.passwordIsTrueimageView2.image = SKImageNamed(@"icon_open");
    }else {
        //隐藏
        self.passwordTextField2.secureTextEntry = YES;
        self.passwordIsTrueimageView2.image = SKImageNamed(@"icon_close");
    }
    
    
}
- (UIImageView *)passwordIsTrueimageView2 {
    if (!_passwordIsTrueimageView2) {
        _passwordIsTrueimageView2 = [[UIImageView alloc]initWithImage:SKImageNamed(@"icon_close")];
    }
    return _passwordIsTrueimageView2;
}


@end
