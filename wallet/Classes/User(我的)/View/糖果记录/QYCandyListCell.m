//
//  QYCandyListCell.m
//  wallet
//
//  Created by talking　 on 2019/6/30.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "QYCandyListCell.h"

@interface QYCandyListCell ()

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UILabel *contentL;
@property (nonatomic, strong) UILabel *bottomL;

@property (nonatomic, strong) UILabel *lineL;


@property (nonatomic, strong) UILabel *bottomNumL;


@end

@implementation QYCandyListCell

- (UILabel *)lineL{
    if (!_lineL) {
        _lineL = [[UILabel alloc]init];
        _lineL.backgroundColor = SKItemNormalColor;
        _lineL.alpha = 0.3;
        [self.bgView addSubview:_lineL];
    }
    return _lineL;
}

- (UILabel *)contentL {
    if (!_contentL) {
        _contentL = [[UILabel alloc]init];
        _contentL.textColor = SKBlackColor;
        _contentL.font = SKFont(15);
        _contentL.numberOfLines = 0;
        [self.bgView addSubview:_contentL];
    }
    return _contentL;
}
- (UILabel *)bottomL {
    if (!_bottomL) {
        _bottomL = [[UILabel alloc]init];
        _bottomL.font = SKFont(12);
        _bottomL.textColor = SKItemNormalColor;
        [self.bgView addSubview:_bottomL];
    }
    return _bottomL;
}
- (UILabel *)bottomNumL {
    if (!_bottomNumL) {
        _bottomNumL = [[UILabel alloc]init];
        _bottomNumL.font = SKFont(12);
        _bottomNumL.textColor = SKItemNormalColor;
        [self.bgView addSubview:_bottomNumL];
    }
    return _bottomNumL;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left);
        make.right.mas_equalTo(self.contentView.mas_right);
        make.top.mas_equalTo(self.contentView.mas_top);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-5);
    }];
    
    [self.contentL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgView.mas_left).offset(10);
        make.top.mas_equalTo(self.bgView.mas_top).offset(15);
        make.right.mas_equalTo(self.bgView.mas_right).offset(-10);
    }];
    [self.bottomL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.bgView.mas_right).offset(-10);
        make.bottom.mas_equalTo(self.bgView.mas_bottom).offset(-10);
    }];
    
    
    [self.lineL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgView.mas_left);
        make.right.mas_equalTo(self.bgView.mas_right);
        make.height.mas_equalTo(1);
        make.bottom.mas_equalTo(self.bottomL.mas_top).offset(-10);
    }];
    
    [self.bottomNumL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.bottomL.mas_centerY);
        make.left.mas_equalTo(self.bgView.mas_left).offset(10);
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
- (void)setModel:(CFQCommonModel *)model{
    _model = model;

    self.contentL.text = model.awardDesc;
    self.bottomL.text = [SKUtils timeStampToTime:model.createTime];
    
    self.bottomNumL.text = [NSString stringWithFormat:@"糖果数量:%.2fWINT",[model.awardValue floatValue]];
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
