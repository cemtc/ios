//
//  MSMineRecommendListCell.m
//  wallet
//
//  Created by talking　 on 2019/6/30.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "MSMineRecommendListCell.h"
#import "MSMineRecommendListModel.h"

#import "UIView+Layer.h"
#import "UIView+Tap.h"
#import "CFQLabelBgView.h"

@interface MSMineRecommendListCell ()
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) CFQLabelBgView * iconImageView;
@property (nonatomic, strong) UIImageView * iconImageView1;

@end

@implementation MSMineRecommendListCell
- (UIImageView *)iconImageView1 {
    if (!_iconImageView1) {
        _iconImageView1 = [[UIImageView alloc]init];
        [self.contentView addSubview:_iconImageView1];
    }
    return _iconImageView1;
}
//bgview
- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor = SKWhiteColor;
        [self.contentView addSubview:_bgView];
    }
    return _bgView;
}

- (CFQLabelBgView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [[CFQLabelBgView alloc]init];
        _iconImageView.layerCornerRadius = 9;
        _iconImageView.titleColor = SKWhiteColor;
        _iconImageView.font = SKFont(16);
        _iconImageView.bgColor = SKColor(46, 48, 59, 1.0);
        _iconImageView.textAlignment = NSTextAlignmentCenter;
        _iconImageView.title = @"众筹";
        [self.bgView addSubview:_iconImageView];
    }
    return _iconImageView;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = SKFont(14);
        [self.bgView addSubview:_titleLabel];
    }
    return _titleLabel;
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
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left);
        make.right.mas_equalTo(self.contentView.mas_right);
        make.top.mas_equalTo(self.contentView.mas_top);
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
    }];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgView.mas_top).offset(10);
        make.centerX.mas_equalTo(self.bgView.mas_centerX);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    [self.iconImageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgView.mas_top).offset(10);
        make.centerX.mas_equalTo(self.bgView.mas_centerX);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];


    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(self.iconImageView.mas_bottom).offset(10);
    }];

}

- (void)setModel:(MSMineRecommendListModel *)model {
    _model = model;
    self.titleLabel.text = model.title;
    if ([model.title isEqualToString:@"众筹"]) {
        self.iconImageView.hidden = NO;
        self.iconImageView1.hidden = YES;
    }else{
        self.iconImageView1.image = SKImageNamed(model.iconImageString);
        self.iconImageView.hidden = YES;
        self.iconImageView1.hidden = NO;
    }
}

@end
