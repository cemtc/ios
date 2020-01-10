//
//  QYNewFinancialTopTopCell2.m
//  wallet
//
//  Created by talking　 on 2019/7/12.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "QYNewFinancialTopTopCell2.h"
@interface QYNewFinancialTopTopCell2 ()
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *contentLabel;

@property (nonatomic, strong) UIView *contentBgView;

@end

@implementation QYNewFinancialTopTopCell2
- (void)setCurrentLicaiBenjin:(NSString *)currentLicaiBenjin {
    _currentLicaiBenjin = currentLicaiBenjin;
    
    self.contentLabel.text = [NSString stringWithFormat:@"%.2f WINT",[currentLicaiBenjin floatValue]];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left);
        make.right.mas_equalTo(self.contentView.mas_right);
        make.top.mas_equalTo(self.contentView.mas_top);
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
    }];
    [self.contentBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(self.bgView);
        make.top.mas_equalTo(self.bgView.mas_top).offset(10);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentBgView.mas_centerY);
        make.right.mas_equalTo(self.contentBgView.mas_centerX).offset(-10);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.titleLabel.mas_centerY);
        make.left.mas_equalTo(self.titleLabel.mas_right).offset(5);
    }];
}

//bgview
- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor = SKColor(240, 240, 240, 1.0);;
        [self.contentView addSubview:_bgView];
    }
    return _bgView;
}
- (UIView *)contentBgView {
    if (!_contentBgView) {
        _contentBgView = [[UIView alloc]init];
        _contentBgView.backgroundColor = SKWhiteColor;
        [self.bgView addSubview:_contentBgView];
    }
    return _contentBgView;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = @"当前平台币余额:";
        _titleLabel.font = SKFont(12);
        _titleLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        [self.contentBgView addSubview:_titleLabel];
    }
    return _titleLabel;
}
- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.font = SKFont(12);
        _contentLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        [self.contentBgView addSubview:_contentLabel];
    }
    return _contentLabel;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
