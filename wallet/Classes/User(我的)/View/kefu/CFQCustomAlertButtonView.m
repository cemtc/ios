//
//  CFQCustomAlertButtonView.m
//  wallet
//
//  Created by talking　 on 2019/6/23.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "CFQCustomAlertButtonView.h"

#import "UIView+Tap.h"

@interface CFQCustomAlertButtonView ()

@property (nonatomic, strong) UIView *bgView;



@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *contentLabel;


@end

@implementation CFQCustomAlertButtonView
- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc]init];
    }
    return _iconImageView;
}
- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _contentLabel.font = SKFont(12);
        _contentLabel.adjustsFontSizeToFitWidth = YES;
        _contentLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _contentLabel;
}
- (UILabel *)bottomL {
    if (!_bottomL) {
        _bottomL = [[UILabel alloc]init];
        _bottomL.textColor = [UIColor colorWithHexString:@"#333333"];
        _bottomL.font = SKFont(12);
        _bottomL.text = @"Copy";
    }
    return _bottomL;
}
- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
    }
    return _bgView;
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self customUI];
    }
    return self;
}
- (void)customUI {
    
    [self addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(self.mas_top);
        make.bottom.mas_equalTo(self.mas_bottom);
        make.width.mas_equalTo(140);
    }];
    
    [self.bgView addSubview:self.bottomL];
    [self.bottomL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.bgView.mas_centerX);
        make.bottom.mas_equalTo(self.bgView.mas_bottom);
    }];
    
    
    
    //add contentBgView
    UIView *contentBgView = [[UIView alloc]init];
    [self.bgView addSubview:contentBgView];
    [contentBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.bgView);
        make.bottom.mas_equalTo(self.bottomL.mas_top).offset(-10);
    }];
    contentBgView.layer.borderWidth = 1;
    contentBgView.layer.backgroundColor = SKBlackColor.CGColor;
    contentBgView.layer.cornerRadius = 15;
    contentBgView.backgroundColor = SKClearColor;
    
    
    [contentBgView addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(contentBgView.mas_left);
        make.right.mas_equalTo(contentBgView.mas_right);
        make.bottom.mas_equalTo(contentBgView.mas_bottom).offset(-10);
    }];


    [contentBgView addSubview:self.iconImageView];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(contentBgView.mas_centerX);
        make.top.mas_equalTo(contentBgView.mas_top).offset(15);
    }];
    
    
    //添加点击事件
    SKDefineWeakSelf;
    [self setTapActionWithBlock:^{
        if (weakSelf.clickBlock) {
            weakSelf.clickBlock(weakSelf.title);
        }
    }];
    
}
- (void)setTitle:(NSString *)title {
    _title = title;
    self.contentLabel.text = title;
}
- (void)setImageString:(NSString *)imageString {
    _imageString = imageString;
    self.iconImageView.image = SKImageNamed(imageString);
}

@end
