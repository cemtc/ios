//
//  ZWHomeBannerItemView.h
//  wallet
//
//  Created by 张威威 on 2019/9/27.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "PGIndexBannerSubiew.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZWHomeBannerItemView : PGIndexBannerSubiew
@property (nonatomic, strong) UILabel *indexLabel;
//
@property (nonatomic, strong) UILabel *NameLabel;
@property (nonatomic, strong) UILabel *AddressLabel;
@property (nonatomic, strong) UILabel *PriceLabel;
@property (nonatomic, strong) UIButton *QRCodeBtn;
@end

NS_ASSUME_NONNULL_END
