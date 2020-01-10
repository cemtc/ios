//
//  SKUserListCell.m
//  Business
//
//  Created by talking　 on 2018/8/31.
//  Copyright © 2018年 talking　. All rights reserved.
//

#import "SKUserListCell.h"
#import "SKUserListModel.h"

@interface SKUserListCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UIImageView *pushImageView;


@property (nonatomic, strong) UILabel *gengxin;

@end

@implementation SKUserListCell


- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {

        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.left.mas_equalTo(self.contentView.mas_left).offset(20);
        
        make.width.mas_equalTo(SKAppAdapter(23));
        make.height.mas_equalTo(SKAppAdapter(23));
    }];
    
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.iconImageView.mas_right).offset(15);
        make.centerY.mas_equalTo(self.iconImageView.mas_centerY);
    }];
    
    
    [self.bottomLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(0.7);
        make.left.mas_equalTo(self.titleLabel.mas_left);
        make.right.mas_equalTo(self.contentView.mas_right);
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
    }];
    
    
    [self.pushImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-18);
        
        make.width.mas_equalTo(SKAppAdapter(7));
        make.height.mas_equalTo(SKAppAdapter(13));
        
    }];
    
    [self.gengxin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).offset(-18);
        make.centerY.mas_equalTo(self.titleLabel.mas_centerY);
    }];
    
}

- (void)setModel:(SKUserListModel *)model {
    _model = model;
    
    self.titleLabel.text = model.title;
    if ([model.title isEqualToString:@"400-021-2811"]) {
        
        _titleLabel.textColor = [UIColor colorWithHexString:@"#1c91f7"];
        
    }else {
        
        _titleLabel.textColor = [UIColor colorWithHexString:@"#333333"];

    }
    
    self.iconImageView.image = SKImageNamed(model.title);
    
    
    if ([model.title isEqualToString:@"检测更新"]) {
        self.gengxin.hidden = NO;
        self.pushImageView.hidden = YES;
        
    }else{
        self.gengxin.hidden = YES;
        self.pushImageView.hidden = NO;

    }
    
}

- (UILabel *)bottomLineLabel {
    if (!_bottomLineLabel) {
        _bottomLineLabel = [[UILabel alloc]init];
        _bottomLineLabel.backgroundColor = [UIColor colorWithHexString:@"#a7a7a7"];
        _bottomLineLabel.alpha = 0.5;
        [self.contentView addSubview:_bottomLineLabel];
    }
    return _bottomLineLabel;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _titleLabel.font = SKFont(17);
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UILabel *)gengxin {
    if (!_gengxin) {
        _gengxin = [[UILabel alloc]init];
        _gengxin.font = SKFont(14);
        _gengxin.textColor = SKItemNormalColor;
        [self.contentView addSubview:_gengxin];
        _gengxin.hidden = YES;
        NSString *versionString = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
        _gengxin.text = versionString;
    }
    return _gengxin;
}

- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc]init];
        [self.contentView addSubview:_iconImageView];
    }
    return _iconImageView;
}

- (UIImageView *)pushImageView {
    if (!_pushImageView) {
        _pushImageView = [[UIImageView alloc]init];
        _pushImageView.image = SKImageNamed(@"详情");
        [self.contentView addSubview:_pushImageView];
    }
    return _pushImageView;
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
