//
//  QYNewFinancialTopItemView.m
//  wallet
//
//  Created by talking　 on 2019/7/4.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "QYNewFinancialTopItemView.h"

@interface QYNewFinancialTopItemView ()

@end

@implementation QYNewFinancialTopItemView
- (UIImageView *)bgImageView {
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc]init];
    }
    return _bgImageView;
}
- (UIImageView *)iconimageView {
    if (!_iconimageView) {
        _iconimageView = [[UIImageView alloc]init];
    }
    return _iconimageView;
}
- (UILabel *)title {
    if (!_title) {
        _title = [[UILabel alloc]init];
        _title.textColor = SKBlackColor;
        _title.font = SKFont(16);
    }
    return _title;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self customUI];
    }
    return self;
}
- (void)customUI {
    
    [self addSubview:self.bgImageView];
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.mas_equalTo(self);
    }];
    [self addSubview:self.iconimageView];
    [self.iconimageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);
        make.right.mas_equalTo(self.mas_centerX).offset(-10);
    }];

    [self addSubview:self.title];
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.iconimageView.mas_right).offset(7);
        make.centerY.mas_equalTo(self.iconimageView.mas_centerY);
    }];

}
@end
