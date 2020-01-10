//
//  QYForgetPwdView.m
//  wallet
//
//  Created by talking　 on 2019/7/19.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "QYForgetPwdView.h"
#import "UITextField+HLLeftView.h"//快速创建textfile
#import "UIButton+Addition.h"//快速创建一个button
#import "UIView+Tap.h"

@interface QYForgetPwdView ()
@property (nonatomic, strong) UIImageView *passwordIsTrueimageView1;
@property (nonatomic, strong) UIImageView *passwordIsTrueimageView2;

@property(nonatomic, strong) UIImageView *rightLabel1ImageViewBtn;


@property (nonatomic, strong) UILabel *titleWENTI;

@end

@implementation QYForgetPwdView
- (UIImageView *)rightLabel1ImageViewBtn {
    if (!_rightLabel1ImageViewBtn) {
        _rightLabel1ImageViewBtn = [[UIImageView alloc]initWithImage:SKImageNamed(@"三角形")];
    }
    return _rightLabel1ImageViewBtn;
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
    
    
    self.passwordTextField1 = [UITextField textFieldWithPlaceholder:@"请设置登录密码" leftIconImage:SKImageNamed(@"icon_password") height:SKAppAdapter(44) leftViewWith:35];
    [self addSubview:self.passwordTextField1];
    [self.passwordTextField1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.loginTextField.mas_bottom).offset(30);
        make.left.mas_equalTo(self.mas_left).offset(SKAppAdapter(30));
        make.right.mas_equalTo(self.mas_right).offset(SKAppAdapter(-30) - 60);
        make.height.mas_equalTo(44);
    }];
    //    self.passwordTextField1.keyboardType = UIKeyboardTypePhonePad;
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
    
    self.passwordTextField2 = [UITextField textFieldWithPlaceholder:@"请设置交易密码" leftIconImage:SKImageNamed(@"icon_password") height:SKAppAdapter(44) leftViewWith:35];
    [self addSubview:self.passwordTextField2];
    [self.passwordTextField2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.passwordTextField1.mas_bottom).offset(30);
        make.left.mas_equalTo(self.mas_left).offset(SKAppAdapter(30));
        make.right.mas_equalTo(self.mas_right).offset(SKAppAdapter(-30) - 60);
        make.height.mas_equalTo(44);
    }];
    //    self.passwordTextField2.keyboardType = UIKeyboardTypePhonePad;
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
    
    [self addSubview:self.titleWENTI];
    [self.titleWENTI mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.passwordTextField2.mas_bottom).offset(40);
        make.left.mas_equalTo(lable3.mas_left);
    }];
    
    [self addSubview:self.q1];
    [self.q1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.passwordTextField2.mas_bottom).offset(40);
        make.left.mas_equalTo(self.titleWENTI.mas_right).offset(10);
    }];
    [self addSubview:self.q1TextField];
    [self.q1TextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.q1.mas_bottom).offset(20);
        make.left.right.mas_equalTo(lable3);
        make.height.mas_equalTo(50);
    }];
    
    
    self.nextButton = [UIButton buttonWithTitle:@"验证并更改" titleColor:SKWhiteColor bgColor:QYThemeColor fontSize:20 target:self action:@selector(nextButtonClick:)];
    [self addSubview:self.nextButton];
    [self.nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
    make.top.equalTo(self.q1TextField.mas_bottom).offset(50);

//        make.top.equalTo(self.passwordTextField2.mas_bottom).offset(50);
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
    
    
    //选择btn
    [self addSubview:self.rightLabel1ImageViewBtn];
    [self.rightLabel1ImageViewBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.q1.mas_centerY).offset(-2);
        make.right.mas_equalTo(lable3.mas_right);
    }];
    [self.rightLabel1ImageViewBtn setTapActionWithBlock:^{


        if ([weakSelf.delegate respondsToSelector:@selector(qyForgetPwdView:didClickInfo:)]) {
            [weakSelf.delegate qyForgetPwdView:weakSelf didClickInfo:@{@"name":@"rightBtn"}];
        }


    }];

    
}
- (void)nextButtonClick:(UIButton *)button {
    
    if ([self.delegate respondsToSelector:@selector(qyForgetPwdView:didClickInfo:)]) {
        [self.delegate qyForgetPwdView:self didClickInfo:@{@"name":@"caofuqing"}];
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

- (UILabel *)titleWENTI {
    if (!_titleWENTI) {
        _titleWENTI = [[UILabel alloc]init];
        _titleWENTI.textColor = SKItemNormalColor;
        _titleWENTI.font = [UIFont systemFontOfSize:14];
        _titleWENTI.text = @"问题:";
    }
    return _titleWENTI;
}

- (UILabel *)q1 {
    if (!_q1) {
        _q1 = [[UILabel alloc]init];
        _q1.textColor = SKItemNormalColor;
        _q1.font = [UIFont systemFontOfSize:14];
    }
    return _q1;
}
- (UITextField *)q1TextField {
    if (!_q1TextField) {
        _q1TextField = [[UITextField alloc]init];
        _q1TextField.backgroundColor = SKColor(239, 239, 239, 1.0);
        _q1TextField.textColor = SKBlackColor;
        _q1TextField.font = SKFont(15);
        _q1TextField.layer.cornerRadius = 5;
        _q1TextField.placeholder = @"请输入问题答案";
    }
    return _q1TextField;
}
@end
