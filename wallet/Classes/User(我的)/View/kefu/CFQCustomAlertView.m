//
//  CFQCustomAlertView.m
//  wallet
//
//  Created by talking　 on 2019/6/23.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "CFQCustomAlertView.h"
#import "UIView+Layer.h"
#import "UIView+Tap.h"

#import "CFQCustomAlertButtonView.h"

#define SKKeyWindow [UIApplication sharedApplication].keyWindow

#define itemHeight 140

@interface CFQCustomAlertView ()
/**
 蒙板
 */
@property (nonatomic, strong) UIView *becloudView;

//buttonView
@property (nonatomic, strong) CFQCustomAlertButtonView *buttonView;

@end

@implementation CFQCustomAlertView

- (void)setTitlesArray:(NSArray *)titlesArray {
    _titlesArray = titlesArray;
    
    SKDefineWeakSelf;
    //如果之前有 把它移除
    for(UIView *itemView in [self subviews])
    {
        if ([itemView isKindOfClass:[CFQCustomAlertButtonView class]]) {
            [itemView removeFromSuperview];
        }
    }
    for (NSInteger i = 0; i < titlesArray.count; i++) {
        self.buttonView = [[CFQCustomAlertButtonView alloc]init];
        self.buttonView.title = titlesArray[i];
        self.buttonView.imageString = self.imagesArray[i];
        if (i == titlesArray.count - 1) {
            self.buttonView.bottomL.text = @"点击拨打";
        }
        [self addSubview:self.buttonView];
        [self.buttonView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.top.mas_equalTo(self.mas_top).offset(20+itemHeight*i);
            make.height.mas_equalTo(120);
            make.width.mas_equalTo(100);
        }];
        self.buttonView.clickBlock = ^(NSString * _Nonnull info) {
            if (weakSelf.clickBlock) {
                weakSelf.clickBlock(info);
            }
        };
    }
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self customUI];
    }
    return self;
}
- (void)customUI {
    self.backgroundColor = SKWhiteColor;
    self.layerCornerRadius = 5.0;
}

/**
 显示
 */
- (void)show {
    
    [SKKeyWindow addSubview:self.becloudView];
    // 输入框
    self.frame = CGRectMake(0, 0, self.becloudView.frame.size.width * 0.8, itemHeight*self.titlesArray.count + 20);
    self.center = CGPointMake(self.becloudView.center.x, self.becloudView.frame.size.height * 0.5);

    [SKKeyWindow addSubview:self];
    
}
/**
 移除
 */
- (void)dismiss {
    [self removeFromSuperview];
    [self.becloudView removeFromSuperview];
}
- (UIView *)becloudView {
    if (!_becloudView) {
        _becloudView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _becloudView.backgroundColor = [UIColor blackColor];
        _becloudView.layer.opacity = 0.3;
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeAlertView)];
        [_becloudView addGestureRecognizer:tapGR];
    }
    return _becloudView;
}
- (void)closeAlertView {
    [self dismiss];
}

@end
