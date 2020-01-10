//
//  QYLoginHeadView.m
//  wallet
//
//  Created by talking　 on 2019/6/18.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "QYLoginHeadView.h"
#import "UIView+Tap.h"

@interface QYLoginHeadView ()

@property (nonatomic, strong) UIImageView *bgImagView;


@property (nonatomic, strong) UILabel *leftTitleLabel;
@property (nonatomic, strong) UILabel *rightTitleLabel;
@property (nonatomic, strong) UILabel *lineTitleLabel;


@end

@implementation QYLoginHeadView

- (UILabel *)leftTitleLabel {
    if (!_leftTitleLabel) {
        _leftTitleLabel = [[UILabel alloc]init];
        _leftTitleLabel.text = @"登录";
        _leftTitleLabel.textColor = SKWhiteColor;
        _leftTitleLabel.font = SKFont(16);
    }
    return _leftTitleLabel;
}
- (UILabel *)rightTitleLabel {
    if (!_rightTitleLabel) {
        _rightTitleLabel = [[UILabel alloc]init];
        _rightTitleLabel.text = @"注册";
        _rightTitleLabel.textColor = SKWhiteColor;
        _rightTitleLabel.font = SKFont(16);
    }
    return _rightTitleLabel;
}
- (UILabel *)lineTitleLabel {
    if (!_lineTitleLabel) {
        _lineTitleLabel = [[UILabel alloc]init];
        _lineTitleLabel.backgroundColor = SKWhiteColor;
    }
    return _lineTitleLabel;
}


- (UIImageView *)bgImagView {
    if (!_bgImagView) {
        _bgImagView = [[UIImageView alloc]initWithImage:SKImageNamed(@"login_background")];
    }
    return _bgImagView;
}
- (UIImageView *)bottomLeftImageView {
    if (!_bottomLeftImageView) {
        _bottomLeftImageView = [[UIImageView alloc]initWithImage:SKImageNamed(@"qy_icon_triangle")];
    }
    return _bottomLeftImageView;
}
- (UIImageView *)bottomRightImageView {
    if (!_bottomRightImageView) {
        _bottomRightImageView = [[UIImageView alloc]initWithImage:SKImageNamed(@"qy_icon_triangle")];
    }
    return _bottomRightImageView;
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
    //add bgImageView
    [self addSubview:self.bgImagView];
    [self.bgImagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    
    //add subViews
    [self addSubview:self.bottomLeftImageView];
    [self.bottomLeftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mas_bottom);
        make.left.mas_equalTo(self.mas_left).offset(SKScreenWidth*0.28);
    }];
    [self addSubview:self.bottomRightImageView];
    [self.bottomRightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mas_bottom);
        make.right.mas_equalTo(self.mas_right).offset(-(SKScreenWidth*0.28));
    }];
    [self addSubview:self.leftTitleLabel];
    [self.leftTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.bottomLeftImageView.mas_top).offset(-15);
        make.centerX.mas_equalTo(self.bottomLeftImageView.mas_centerX);
    }];
    [self addSubview:self.rightTitleLabel];
    [self.rightTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.bottomRightImageView.mas_top).offset(-15);
        make.centerX.mas_equalTo(self.bottomRightImageView.mas_centerX);
    }];
    [self addSubview:self.lineTitleLabel];
    [self.lineTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(1);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.centerY.mas_equalTo(self.leftTitleLabel.mas_centerY);
        make.height.mas_equalTo(self.leftTitleLabel.mas_height);
    }];
    
    self.bottomLeftImageView.hidden = NO;
    self.bottomRightImageView.hidden = YES;
    
    
    //add Click
    SKDefineWeakSelf;
    [self.leftTitleLabel setTapActionWithBlock:^{
        [weakSelf labelClick:@"login"];
    }];
    [self.rightTitleLabel setTapActionWithBlock:^{
        [weakSelf labelClick:@"regist"];
    }];
}
- (void)labelClick:(NSString *)str{
    if ([str isEqualToString:@"login"]) {
        self.bottomLeftImageView.hidden = NO;
        self.bottomRightImageView.hidden = YES;
    }else if ([str isEqualToString:@"regist"]){
        self.bottomLeftImageView.hidden = YES;
        self.bottomRightImageView.hidden = NO;
    }
    if ([self.delegate respondsToSelector:@selector(qyLoginHeadView:didClickInfo:)]) {
        [self.delegate qyLoginHeadView:self didClickInfo:str];
    }
}

@end
