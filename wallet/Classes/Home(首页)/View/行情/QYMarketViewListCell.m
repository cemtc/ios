//
//  QYMarketViewListCell.m
//  wallet
//
//  Created by talking　 on 2019/6/29.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "QYMarketViewListCell.h"
#import "CFQLabelBgView.h"
#import "UIView+Layer.h"

#import <YYImage/YYImage.h>
#import <YYWebImage/YYWebImage.h>

@interface QYMarketViewListCell ()
@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) YYAnimatedImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLable;
@property (nonatomic, strong) UILabel *centerTopLable;
@property (nonatomic, strong) UILabel *centerBottomLable;
@property (nonatomic, strong) CFQLabelBgView *rightLabel;
@end

@implementation QYMarketViewListCell


- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left);
        make.right.mas_equalTo(self.contentView.mas_right);
        make.top.mas_equalTo(self.contentView.mas_top);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-1);
    }];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.bgView.mas_centerY);
        make.left.mas_equalTo(self.bgView.mas_left).offset(10);
        make.height.width.mas_equalTo(30);
    }];
    
    [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.iconImageView.mas_right).offset(8);
        make.centerY.mas_equalTo(self.iconImageView.mas_centerY);
    }];
    
    [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.iconImageView.mas_centerY);
        make.right.mas_equalTo(self.bgView.mas_right).offset(-10);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(30);
    }];
    
    [self.centerTopLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.rightLabel.mas_left).offset(-14);
        make.top.mas_equalTo(self.rightLabel.mas_top).offset(-3);
    }];
    [self.centerBottomLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.rightLabel.mas_left).offset(-14);
        make.top.mas_equalTo(self.centerTopLable.mas_bottom).offset(5);
    }];
    self.backgroundColor = [UIColor colorWithHexString:@"#E6E8EB"];
}
- (void)setModelA:(QYHangQingModel *)modelA{
    _modelA = modelA;
    NSString *ImageRrl = [NSString stringWithFormat:@"%@",modelA.logo];
    [self.iconImageView yy_setImageWithURL:[NSURL URLWithString:ImageRrl] placeholder:[UIImage imageNamed:@"icon_export_logo"]];
    self.titleLable.text = [NSString stringWithFormat:@"%@",modelA.name];
    self.centerTopLable.text = modelA.current_price;
    self.centerBottomLable.text = modelA.current_price_usd;

//    if ([[modelA.up_down substringToIndex:1] isEqualToString:@"-"]) {
//        self.rightLabel.bgColor = SKColor(65, 201, 119, 1.0);
//    }else{
//        self.rightLabel.bgColor = SKColor(251, 72, 72, 1.0);
//    }
    self.rightLabel.title = [NSString stringWithFormat:@"%@",modelA.change_percent];

}
- (void)setModel:(CFQCommonModel *)model{
    _model = model;
    
//    self.iconImageView.image = SKImageNamed(model.hqIconImageString);
//    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[model.hqIconImageString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]] placeholderImage:nil];
//    [self.iconImageView yy_setImageWithURL:[NSURL URLWithString:model.hqIconImageString] placeholderImage:nil];
    [self.iconImageView yy_setImageWithURL:[NSURL URLWithString:model.hqIconImageString] placeholder:nil];
    

    self.titleLable.text = model.hqTitleString;
    self.centerTopLable.text = model.hqCenterTopString;
    self.centerBottomLable.text = model.hqCenterBottomString;
    
    

    if ([[model.hqRightString substringToIndex:1] isEqualToString:@"-"]) {
        self.rightLabel.bgColor = SKColor(65, 201, 119, 1.0);
    }else{
        self.rightLabel.bgColor = SKColor(251, 72, 72, 1.0);
    }
//    self.rightLabel.title = model.hqRightString;
    self.rightLabel.title = [NSString stringWithFormat:@"%@%@",model.hqRightString,@"%"];

}
//bgview
- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_bgView];
    }
    return _bgView;
}

- (YYAnimatedImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [[YYAnimatedImageView alloc]init];
        [self.bgView addSubview:_iconImageView];
    }
    return _iconImageView;
}
- (UILabel *)titleLable {
    if (!_titleLable) {
        _titleLable = [[UILabel alloc]init];
        _titleLable.font = SKFont(16);
        _titleLable.textColor = [UIColor blackColor];
        [self.bgView addSubview:_titleLable];
    }
    return _titleLable;
}
- (UILabel *)centerTopLable {
    if (!_centerTopLable) {
        _centerTopLable = [[UILabel alloc]init];
        _centerTopLable.font = SKFont(16);
        _centerTopLable.textColor = [UIColor blackColor];
        [self.bgView addSubview:_centerTopLable];
    }
    return _centerTopLable;
}
- (UILabel *)centerBottomLable {
    if (!_centerBottomLable) {
        _centerBottomLable = [[UILabel alloc]init];
        _centerBottomLable.font = SKFont(12);
        _centerBottomLable.textColor = [UIColor colorWithHexString:@"#999999"];
        _centerBottomLable.alpha = 0.5;
        [self.bgView addSubview:_centerBottomLable];
    }
    return _centerBottomLable;
}
- (CFQLabelBgView *)rightLabel {
    if (!_rightLabel) {
        _rightLabel = [[CFQLabelBgView alloc]init];
        _rightLabel.layerCornerRadius = 3;
        _rightLabel.titleColor = SKWhiteColor;
        _rightLabel.font = SKFont(14);
        _rightLabel.bgColor = SKColor(65, 201, 119, 1.0);
        _rightLabel.textAlignment = NSTextAlignmentCenter;
        [self.bgView addSubview:_rightLabel];
    }
    return _rightLabel;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentView.backgroundColor = [UIColor colorWithHexString:@"#E6E8EB"];
    self.backgroundColor = [UIColor colorWithHexString:@"#E6E8EB"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

