//
//  CreatWalletCell.m
//  wallet
//
//  Created by talking　 on 2019/6/25.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "CreatWalletCell.h"

@interface CreatWalletCell ()

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIImageView *bgImageView;

@property (nonatomic, strong) UILabel *contentTitle;

@property (nonatomic, strong) UILabel *contentText;

@end

@implementation CreatWalletCell

- (UILabel *)contentText {
    if (!_contentText) {
        _contentText = [[UILabel alloc]init];
        _contentText.font = SKFont(12);
        _contentText.textColor = SKWhiteColor;
        _contentText.numberOfLines = 0;
        _contentText.textAlignment = NSTextAlignmentCenter;
        [self.bgView addSubview:_contentText];
    }
    return _contentText;
}

- (UILabel *)contentTitle {
    if (!_contentTitle) {
        _contentTitle = [[UILabel alloc]init];
        _contentTitle.font = SKFont(17);
        _contentTitle.textColor = SKWhiteColor;
        [self.bgView addSubview:_contentTitle];
    }
    return _contentTitle;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(10);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-10);
        make.top.mas_equalTo(self.contentView.mas_top);
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
    }];
    
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.bgView);
        make.bottom.mas_equalTo(self.bgView.mas_bottom).offset(-15);
    }];
    
    [self.contentTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.bgView.mas_centerX);
//        make.centerY.mas_equalTo(self.bgView.mas_centerY);
        make.top.mas_equalTo(self.bgView.mas_top).offset(20);
    }];
    
    [self.contentText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.bgView.mas_centerY);
        make.left.mas_equalTo(self.bgView.mas_left).offset(10);
        make.right.mas_equalTo(self.bgView.mas_right).offset(-10);
    }];

    
    //让view保持在最下层
    [self.bgView sendSubviewToBack:self.bgImageView];

}

- (void)setModel:(CreatWalletModel *)model {
    _model = model;
    self.contentTitle.text = [NSString stringWithFormat:@"导入%@私钥",model.title];
    
    self.contentText.text = model.context;
}

//bgview
- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        [self.contentView addSubview:_bgView];
    }
    return _bgView;
}
- (UIImageView *)bgImageView {
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc]initWithImage:SKImageNamed(@"add_wallet_import")];
        [self.bgView addSubview:_bgImageView];
    }
    return _bgImageView;
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
