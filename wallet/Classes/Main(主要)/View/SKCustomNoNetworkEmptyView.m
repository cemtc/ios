//
//  SKCustomNoNetworkEmptyView.m
//  Business
//
//  Created by talking　 on 2018/8/14.
//  Copyright © 2018年 talking　. All rights reserved.
//

#import "SKCustomNoNetworkEmptyView.h"

@interface SKCustomNoNetworkEmptyView ()

@property (nonatomic, weak) UIImageView *topTipImageView;
@property (nonatomic, weak) UIButton *retryBtn;

@end

@implementation SKCustomNoNetworkEmptyView


- (UIImageView *)topTipImageView {
    if (!_topTipImageView) {
        UIImageView *img = [[UIImageView alloc] init];
        [self addSubview:img];
        _topTipImageView = img;
        img.layer.masksToBounds = YES;
        img.backgroundColor = SKCommonBgColor;
    }
    return _topTipImageView;
}


- (UIButton *)retryBtn {
    if (!_retryBtn) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:btn];
        _retryBtn = btn;
        
        btn.backgroundColor = SKOrangeColor;
        [btn setTitle:@"马上重试" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.titleLabel.font = SKFont(15);
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.adjustsImageWhenDisabled = NO;
        btn.adjustsImageWhenHighlighted = NO;
    }
    return _retryBtn;
}

- (void)btnClick:(UIButton *)btn {
    if (self.customNoNetworkEmptyViewDidClickRetryHandle) {
        self.customNoNetworkEmptyViewDidClickRetryHandle(self);
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat topTipW = 100;
    CGFloat topTipX = SKScreenWidth / 2.0 - topTipW / 2.0;
    CGFloat topTipY = 150;
    CGFloat topTipH = 100;
    self.topTipImageView.frame = CGRectMake(topTipX, topTipY, topTipW, topTipH);
    
    CGFloat retryX = topTipX + 20;
    CGFloat retryY = self.topTipImageView.bottom + 15;
    CGFloat retryW = 60;
    CGFloat retryH = 25;
    self.retryBtn.frame = CGRectMake(retryX, retryY, retryW, retryH);
    
}

@end
