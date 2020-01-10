//
//  ZWHomeBannerItemView.m
//  wallet
//
//  Created by 张威威 on 2019/9/27.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "ZWHomeBannerItemView.h"
@interface ZWHomeBannerItemView ()
@property (nonatomic, strong) UIImageView *QRCodeImageView;
@end
@implementation ZWHomeBannerItemView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.indexLabel];
        [self.mainImageView addSubview:self.NameLabel];
        [self.mainImageView addSubview:self.AddressLabel];
        [self.mainImageView addSubview:self.QRCodeImageView];
        [self.mainImageView addSubview:self.QRCodeBtn];
        [self.mainImageView addSubview:self.PriceLabel];
    }

    return self;
}

- (void)setSubviewsWithSuperViewBounds:(CGRect)superViewBounds {

    if (CGRectEqualToRect(self.mainImageView.frame, superViewBounds)) {
        return;
    }

    self.mainImageView.frame = superViewBounds;
    self.coverView.frame = superViewBounds;
    self.indexLabel.frame = CGRectMake(0, 10, superViewBounds.size.width, 20);
    self.NameLabel.frame = CGRectMake(10, 10, 120, 25);
    self.AddressLabel.frame = CGRectMake(10, 38, 200, 22);
    self.QRCodeImageView.frame = CGRectMake(215, 40, 16, 16);
    self.QRCodeBtn.frame = CGRectMake(243, 38, 20, 20);
    self.PriceLabel.frame = CGRectMake(self.mainImageView.width - 130, self.mainImageView.height - 38, 120, 28);
}

- (UILabel *)indexLabel {
    if (_indexLabel == nil) {
        _indexLabel = [[UILabel alloc] init];
        _indexLabel.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.6];
        _indexLabel.font = [UIFont systemFontOfSize:16.0];
        _indexLabel.textColor = [UIColor whiteColor];
    }
    return _indexLabel;
}
- (UILabel *)NameLabel{
    if (_NameLabel == nil) {
        _NameLabel = [[UILabel alloc] init];
        _NameLabel.backgroundColor = [UIColor clearColor];
        _NameLabel.font = [UIFont systemFontOfSize:18.0];
        _NameLabel.textColor = [UIColor whiteColor];
        _NameLabel.text = @"EMTC";
    }
    return _NameLabel;
}
- (UILabel *)AddressLabel{
    if (_AddressLabel == nil) {
        _AddressLabel = [[UILabel alloc] init];
        _AddressLabel.backgroundColor = [UIColor clearColor];
        _AddressLabel.font = [UIFont systemFontOfSize:16.0];
        _AddressLabel.textColor = [UIColor whiteColor];
        _AddressLabel.text = @"0x95b4a1f0…A947de572";
    }
    return _AddressLabel;
}
- (UILabel *)PriceLabel{
    if (_PriceLabel == nil) {
        _PriceLabel = [[UILabel alloc] init];
        _PriceLabel.backgroundColor = [UIColor clearColor];
        _PriceLabel.font = [UIFont systemFontOfSize:20.0];
        _PriceLabel.textColor = [UIColor whiteColor];
        _PriceLabel.text = @"￥154999.67";
    }
    return _PriceLabel;
}
- (UIImageView *)QRCodeImageView{
    if (_QRCodeImageView == nil) {
        _QRCodeImageView = [[UIImageView alloc]init];
        _QRCodeImageView.image = [UIImage imageNamed:@"icon_home_erweima"];
    }
    return _QRCodeImageView;
}
- (UIButton *)QRCodeBtn{
    if (_QRCodeBtn == nil) {
        _QRCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _QRCodeBtn.backgroundColor = [UIColor clearColor];
    }
    return _QRCodeBtn;
}
@end
