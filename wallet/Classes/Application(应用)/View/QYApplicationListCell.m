//
//  QYApplicationListCell.m
//  wallet
//
//  Created by talking　 on 2019/6/29.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "QYApplicationListCell.h"
#import "QYApplicationListModel.h"
#import "UIView+Layer.h"
#import "UIView+Tap.h"
#import "CFQLabelBgView.h"

#import "QYApplicationStarsView.h"


@interface QYApplicationListCell ()
@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) SKBaseImageView *iconImg;
@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *contentLabel;

@property (nonatomic, strong) QYApplicationStarsView *startsView;

@property (nonatomic, strong) CFQLabelBgView * rightLabel1;
@property (nonatomic, strong) UILabel *rightLabel2;

@end

@implementation QYApplicationListCell
- (void)setModel:(QYApplicationListModel *)model {
    _model = model;
    [self.iconImg setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",SKAPI_BaseUrl,model.iconUrl]] placeHolder:SKImageNamed(@"wint_logo")];
    self.titleLabel.text = model.applicationName;
    self.contentLabel.text = model.applicationDesc;
    self.rightLabel2.text = [NSString stringWithFormat:@"%@M",model.iosSize];
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _titleLabel.font = SKFont(14);
        [self.bgView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.textColor = SKColor(153, 153, 153, 1.0);
        _contentLabel.font = SKFont(10);
        [self.bgView addSubview:_contentLabel];
    }
    return _contentLabel;
}

- (SKBaseImageView *)iconImg {
    if (!_iconImg) {
        _iconImg = [[SKBaseImageView alloc]init];
//                _iconImg.contentMode = UIViewContentModeScaleAspectFill;
        _iconImg.layer.cornerRadius = 3;
        _iconImg.layer.masksToBounds = YES;
        [self.bgView addSubview:_iconImg];
    }
    return _iconImg;
}

- (QYApplicationStarsView *)startsView {
    if (!_startsView) {
        _startsView = [[QYApplicationStarsView alloc]init];
        _startsView.indexNum = 5;
        [self.bgView addSubview:_startsView];
    }
    return _startsView;
}
- (CFQLabelBgView *)rightLabel1 {
    if (!_rightLabel1) {
        _rightLabel1 = [[CFQLabelBgView alloc]init];
        _rightLabel1.layerCornerRadius = 9;
        _rightLabel1.titleColor = SKWhiteColor;
        _rightLabel1.font = SKFont(11);
        _rightLabel1.bgColor = SKColor(46, 48, 59, 1.0);
        _rightLabel1.textAlignment = NSTextAlignmentCenter;
        _rightLabel1.title = @"下载";
        [self.bgView addSubview:_rightLabel1];
    }
    return _rightLabel1;
}

- (UILabel *)rightLabel2 {
    if (!_rightLabel2) {
        _rightLabel2 = [[UILabel alloc]init];
        _rightLabel2.textColor = SKColor(153, 153, 153, 1.0);
        _rightLabel2.font = SKFont(10);
        [self.bgView addSubview:_rightLabel2];
    }
    return _rightLabel2;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left);
        make.right.mas_equalTo(self.contentView.mas_right);
        make.top.mas_equalTo(self.contentView.mas_top);
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
    }];

    [self.iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgView.mas_top).offset(10);
        make.left.mas_equalTo(self.bgView.mas_left).offset(10);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];


    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.iconImg.mas_top).offset(3);
        make.left.mas_equalTo(self.iconImg.mas_right).offset(10);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel.mas_left);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(5);
        make.width.mas_equalTo(200);
    }];
    
    [self.startsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel.mas_left);
        make.top.mas_equalTo(self.contentLabel.mas_bottom).offset(5);
    }];
    
    
    [self.rightLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(44);
        make.height.mas_equalTo(18);
        make.centerY.mas_equalTo(self.bgView.mas_centerY).offset(-5);
        make.right.mas_equalTo(self.bgView.mas_right).offset(-20);
    }];
    
    
    SKDefineWeakSelf;
    [self.rightLabel1 setTapActionWithBlock:^{
        [weakSelf copLabelCilck];
    }];

    [self.rightLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.rightLabel1.mas_centerX);
        make.top.mas_equalTo(self.rightLabel1.mas_bottom).offset(3);
    }];
}

- (void)copLabelCilck{
    
    if (self.NextViewControllerBlock) {
        self.NextViewControllerBlock(self.model);
    }
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

@end
