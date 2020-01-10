//
//  QYGonggaoListCell.m
//  wallet
//
//  Created by talking　 on 2019/6/28.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "QYGonggaoListCell.h"

@interface QYGonggaoListCell ()
@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UIImageView *topImageView;
@property (nonatomic, strong) UILabel *topLabel;
@property (nonatomic, strong) UILabel *rightLabel;

@property (nonatomic, strong) UILabel *contentLabel;

@property (nonatomic, strong) UILabel *lineLabel;

@end

@implementation QYGonggaoListCell
- (void)layoutSubviews {
    [super layoutSubviews];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left);
        make.right.mas_equalTo(self.contentView.mas_right);
        make.top.mas_equalTo(self.contentView.mas_top);
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
    }];
    
    [self.topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgView.mas_left).offset(10);
        make.top.mas_equalTo(self.bgView.mas_top).offset(10);
    }];
    [self.topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.topImageView.mas_right).offset(10);
        make.centerY.mas_equalTo(self.topImageView.mas_centerY);
    }];
    
    [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.topLabel.mas_centerY);
        make.right.mas_equalTo(self.bgView.mas_right).offset(-10);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.topLabel.mas_left);
        make.right.mas_equalTo(self.rightLabel.mas_right);
        make.top.mas_equalTo(self.topLabel.mas_bottom).offset(12);
    }];
    
    [self.lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.left.mas_equalTo(self.bgView);
        make.height.mas_equalTo(0.5);
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
- (UILabel *)lineLabel {
    if (!_lineLabel) {
        _lineLabel = [[UILabel alloc]init];
        _lineLabel.backgroundColor = SKItemNormalColor;
        _lineLabel.alpha = 0.3;
        [self.bgView addSubview:_lineLabel];
    }
    return _lineLabel;
}

- (UIImageView *)topImageView {
    if (!_topImageView) {
        _topImageView = [[UIImageView alloc]init];
        [self.bgView addSubview:_topImageView];
    }
    return _topImageView;
}
- (UILabel *)topLabel{
    if (!_topLabel) {
        _topLabel = [[UILabel alloc]init];
        _topLabel.font = SKFont(14);
        _topLabel.textColor = SKColor(51, 51, 51, 1.0);
        [self.bgView addSubview:_topLabel];
    }
    return _topLabel;
}

- (UILabel *)rightLabel {
    if (!_rightLabel) {
        _rightLabel = [[UILabel alloc]init];
        _rightLabel.font = SKFont(11);
        _rightLabel.textColor = SKColor(153, 153, 153, 1.0);
        [self.bgView addSubview:_rightLabel];
    }
    return _rightLabel;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.font = SKFont(13);
        _contentLabel.textColor = SKColor(51, 51, 51, 1.0);
        _contentLabel.numberOfLines = 0;
        [self.bgView addSubview:_contentLabel];
    }
    return _contentLabel;
}

- (void)setModel:(CFQCommonModel *)model {
    _model = model;
    
    self.topLabel.text = model.noticeTitle;
    self.rightLabel.text = [SKUtils timeStampToTime:model.createTime];
    self.contentLabel.text = model.noticeDesc;

    if ([model.isRead isEqualToString:@"1"]) {
        //已经读了
        self.topLabel.textColor = SKColor(197, 197, 197, 1.0);
        self.topImageView.image = SKImageNamed(@"icon_announcement_gray");
        self.rightLabel.textColor = SKColor(197, 197, 197, 1.0);
        self.contentLabel.textColor = SKColor(197, 197, 197, 1.0);
    }else{
        //没有读 是黑色
        self.topLabel.textColor = SKColor(51, 51, 51, 1.0);
        self.topImageView.image = SKImageNamed(@"icon_announcement");
        self.rightLabel.textColor = SKColor(153, 153, 153, 1.0);
        self.contentLabel.textColor = SKColor(51, 51, 51, 1.0);

    }
    
    
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
