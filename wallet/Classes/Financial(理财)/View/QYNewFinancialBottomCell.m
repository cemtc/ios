//
//  QYNewFinancialBottomCell.m
//  wallet
//
//  Created by talking　 on 2019/7/4.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "QYNewFinancialBottomCell.h"

@interface QYNewFinancialBottomCell ()
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *bottomLabel;

@property (nonatomic, strong) UIView *topBgView;


@end

@implementation QYNewFinancialBottomCell

- (UIView *)topBgView {
    if (!_topBgView) {
        _topBgView = [[UIView alloc]init];
        _topBgView.backgroundColor = SKColor(240, 240, 240, 1.0);;
        [self.bgView addSubview:_topBgView];
    }
    return _topBgView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = @"搬砖说明";
        _titleLabel.font = SKFont(14);
        _titleLabel.textColor = SKBlackColor;
        [self.bgView addSubview:_titleLabel];
    }
    return _titleLabel;
}
- (UILabel *)bottomLabel {
    if (!_bottomLabel) {
        _bottomLabel = [[UILabel alloc]init];
        _bottomLabel.font = SKFont(12);
        _bottomLabel.textColor = SKItemNormalColor;
        _bottomLabel.numberOfLines = 0;
        _bottomLabel.text = @"搬砖也涵盖了风险管理。因为未来的更多流量具有不确定性，包括人身风险、财产风险与市场风险，都会影响到现金流入（收入中断风险）或现金流出";
        [self.bgView addSubview:_bottomLabel];
    }
    return _bottomLabel;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left);
        make.right.mas_equalTo(self.contentView.mas_right);
        make.top.mas_equalTo(self.contentView.mas_top);
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
    }];
    
    [self.topBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgView.mas_left);
        make.right.mas_equalTo(self.bgView.mas_right);
        make.top.mas_equalTo(self.bgView.mas_top);
        make.height.mas_equalTo(10);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgView.mas_left).offset(10);
        make.top.mas_equalTo(self.topBgView.mas_bottom).offset(10);
    }];
    
    
    [self.bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(15);
        make.left.mas_equalTo(self.titleLabel.mas_left);
        make.right.mas_equalTo(self.bgView.mas_right).offset(-10);
    }];
    
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

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setCurrentSelectLicaiOrShuihui:(BOOL)currentSelectLicaiOrShuihui {
    _currentSelectLicaiOrShuihui = currentSelectLicaiOrShuihui;
    
    if (currentSelectLicaiOrShuihui) {
        NSLog(@"QYNewFinancialBottomCell赎回");
        self.titleLabel.text = @"提现说明";

    }else{
        NSLog(@"QYNewFinancialBottomCell搬砖");
        self.titleLabel.text = @"搬砖说明";

    }
    
}
- (void)setBottomString:(NSString *)bottomString {
    _bottomString = bottomString;
    self.bottomLabel.text = bottomString;
}
@end
