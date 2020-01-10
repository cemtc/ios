//
//  QYHomeListCell.m
//  wallet
//
//  Created by talking　 on 2019/6/14.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "QYHomeListCell.h"
#import "QYHomeListModel.h"

@interface QYHomeListCell ()
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIImageView *bgImageView;



@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *numberLabel;
@property (nonatomic, strong) UILabel *priceLabel;


@end

@implementation QYHomeListCell

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left);
        make.right.mas_equalTo(self.contentView.mas_right);
        make.top.mas_equalTo(self.contentView.mas_top);
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
    }];
    
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.bgView).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgView.mas_left).offset(35);
        make.top.mas_equalTo(self.bgView.mas_top).offset(20);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.iconImageView.mas_top);
        make.left.mas_equalTo(self.iconImageView.mas_right).offset(10);
    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel.mas_left);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(8);
    }];
    [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.mas_equalTo(self.titleLabel.mas_centerY);
        make.right.mas_equalTo(self.bgView.mas_right).offset(-35);
    }];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentLabel.mas_centerY);
        make.right.mas_equalTo(self.numberLabel.mas_right);
    }];
}

- (void)setModel:(QYHomeListModel *)model {
    _model = model;
    self.iconImageView.image = SKImageNamed(model.imageName);
    self.titleLabel.text = model.title;
    self.contentLabel.text = model.content;
    
    if ([model.number isEqualToString:@"0"]) {
        self.numberLabel.text = @"0";
    }else{
        self.numberLabel.text = model.number;
    }
    
    self.priceLabel.text = [NSString stringWithFormat:@"≈￥%@",model.price];
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

- (UIImageView *)bgImageView {
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc]initWithImage:SKImageNamed(@"home_background_wallet")];
        [self.bgView addSubview:_bgImageView];
    }
    return _bgImageView;
}


- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = SKFont(17);
        [self.bgView addSubview:_titleLabel];
    }
    return _titleLabel;
}
- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.font = SKFont(12);
        _contentLabel.textColor = SKColor(153, 153, 153, 153);
        [self.bgView addSubview:_contentLabel];
    }
    return _contentLabel;
}
- (UILabel *)numberLabel {
    if (!_numberLabel) {
        _numberLabel = [[UILabel alloc]init];
        _numberLabel.font = SKFont(17);
        [self.bgView addSubview:_numberLabel];
    }
    return _numberLabel;
}
- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc]init];
        _priceLabel.font = SKFont(12);
        _priceLabel.textColor = SKColor(153, 153, 153, 153);
        [self.bgView addSubview:_priceLabel];
    }
    return _priceLabel;
}

- (UIImageView *)iconImageView{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc]initWithImage:SKImageNamed(@"icon_market")];
        [self.bgView addSubview:_iconImageView];
    }
    return _iconImageView;
}

@end
