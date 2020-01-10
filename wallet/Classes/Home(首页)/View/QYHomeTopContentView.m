//
//  QYHomeTopContentView.m
//  wallet
//
//  Created by talking　 on 2019/6/14.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "QYHomeTopContentView.h"

@interface QYHomeTopContentView ()

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) UIImageView *contentBgImageView;

@end

@implementation QYHomeTopContentView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self customUI];
    }
    return self;
}
- (void)customUI {
    
    [self addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(self);
        make.left.mas_equalTo(self.mas_left).offset(10);
        make.right.mas_equalTo(self.mas_right).offset(-10);
    }];
    
    [self.contentView addSubview:self.contentBgImageView];
    [self.contentBgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc]init];
    }
    return _contentView;
}

- (UIImageView *)contentBgImageView {
    if (!_contentBgImageView) {
        _contentBgImageView = [[UIImageView alloc]initWithImage:SKImageNamed(@"home_background")];
    }
    return _contentBgImageView;
}

@end
