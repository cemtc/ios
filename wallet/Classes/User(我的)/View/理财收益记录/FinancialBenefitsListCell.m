//
//  FinancialBenefitsListCell.m
//  wallet
//
//  Created by talking　 on 2019/6/23.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "FinancialBenefitsListCell.h"

@interface FinancialBenefitsListCell ()

@property (nonatomic, strong) UILabel *leftLabel;
@property (nonatomic, strong) UILabel *centerLabel;
@property (nonatomic, strong) UILabel *rightLabel;

@end

@implementation FinancialBenefitsListCell

- (UILabel *)leftLabel {
    if (!_leftLabel) {
        _leftLabel = [[UILabel alloc]init];
        _leftLabel.textColor = SKColor(46, 48, 59, 1.0);
        _leftLabel.font = SKFont(14);
        [self.contentView addSubview:_leftLabel];
    }
    return _leftLabel;
}

- (UILabel *)centerLabel {
    if (!_centerLabel) {
        _centerLabel = [[UILabel alloc]init];
        _centerLabel.textColor = SKColor(198, 167, 113, 1.0);
        _centerLabel.font = SKFont(14);
        [self.contentView addSubview:_centerLabel];
    }
    return _centerLabel;
}
- (UILabel *)rightLabel {
    if (!_rightLabel) {
        _rightLabel = [[UILabel alloc]init];
        _rightLabel.textColor = SKColor(198, 167, 113, 1.0);
        _rightLabel.font = SKFont(14);
        [self.contentView addSubview:_rightLabel];
    }
    return _rightLabel;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(30);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
    }];
    
    [self.centerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
    }];
    [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-60);
    }];
}

- (void)setModel:(CFQCommonModel *)model{
    _model = model;
    
    self.leftLabel.text = model.date;
    self.centerLabel.text = [NSString stringWithFormat:@"+%.2f",[model.income floatValue]];
    self.rightLabel.text = [NSString stringWithFormat:@"+%.2f",[model.recommend floatValue]];
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
