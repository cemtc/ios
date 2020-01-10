//
//  QYMibaoView.m
//  wallet
//
//  Created by talking　 on 2019/7/19.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "QYMibaoView.h"
#import "UITextField+HLLeftView.h"//快速创建textfile
#import "UIButton+Addition.h"//快速创建一个button
#import "UIView+Tap.h"

@interface QYMibaoView ()
@property(nonatomic, strong) UIImageView *rightLabel1ImageViewBtn;
@property (nonatomic, strong) UILabel *titleWENTI;

@end

@implementation QYMibaoView
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
    
    [self addSubview:self.titleWENTI];
    [self.titleWENTI mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(SKAppAdapter(55));
        make.left.mas_equalTo(self.mas_left).offset(SKAppAdapter(30));
    }];

    
    [self addSubview:self.q1];
    [self.q1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(SKAppAdapter(55));
        make.left.mas_equalTo(self.titleWENTI.mas_right).offset(10);

    }];
    [self addSubview:self.q1TextField];
    [self.q1TextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.q1.mas_bottom).offset(20);

        make.left.mas_equalTo(self.mas_left).offset(SKAppAdapter(30));
        make.right.mas_equalTo(self.mas_right).offset(SKAppAdapter(-30));

        make.height.mas_equalTo(50);
    }];
    
    
    self.nextButton = [UIButton buttonWithTitle:@"注册" titleColor:SKWhiteColor bgColor:QYThemeColor fontSize:20 target:self action:@selector(nextButtonClick:)];
    [self addSubview:self.nextButton];
    [self.nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.q1TextField.mas_bottom).offset(50);
        
        //        make.top.equalTo(self.passwordTextField2.mas_bottom).offset(50);
        make.left.equalTo(self).offset(40);
        make.right.equalTo(self).offset(-40);
        make.height.mas_equalTo(50);
    }];
    self.nextButton.layer.cornerRadius = 25;
    
    
    //选择btn
    [self addSubview:self.rightLabel1ImageViewBtn];
    [self.rightLabel1ImageViewBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.q1.mas_centerY).offset(-2);
        make.right.mas_equalTo(self.q1TextField.mas_right);
    }];
    SKDefineWeakSelf;
    [self.rightLabel1ImageViewBtn setTapActionWithBlock:^{
        
        if ([weakSelf.delegate respondsToSelector:@selector(qyMibaoView:didClickInfo:)]) {
            [weakSelf.delegate qyMibaoView:weakSelf didClickInfo:@{@"name":@"rightBtn"}];
        }
        
    }];
    

    
}
- (void)nextButtonClick:(UIButton *)button {
    
    if ([self.delegate respondsToSelector:@selector(qyMibaoView:didClickInfo:)]) {
        [self.delegate qyMibaoView:self didClickInfo:@{@"name":@"caofuqing"}];
    }
    
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
