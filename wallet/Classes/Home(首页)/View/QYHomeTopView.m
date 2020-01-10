//
//  QYHomeTopView.m
//  wallet
//
//  Created by talking　 on 2019/6/14.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "QYHomeTopView.h"
#import "QYHomeTopContentView.h"
#import "QYAnnounView.h"

#import "UIView+Tap.h"

@interface QYHomeTopView ()
@property (nonatomic, strong) UIView *topBgView;
@property (nonatomic, strong) QYHomeTopContentView *topContentView;

@property (nonatomic, strong) UIImageView *imageBtn;
@property (nonatomic, strong) UIImageView *imageLeftBtn;

//公告
@property (nonatomic, strong) QYAnnounView *announView;

@end

@implementation QYHomeTopView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = SKWhiteColor;
        [self customUI];
    }
    return self;
}
- (void)customUI {
    [self addSubview:self.topBgView];
    [self.topBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self);
        make.height.mas_equalTo(self.mas_height).multipliedBy(0.6);
        
    }];
    
    [self addSubview:self.imageBtn];
    [self.imageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mas_top).offset(60);
        make.right.mas_equalTo(self.mas_right).offset(-20);
    }];
    
    [self addSubview:self.imageLeftBtn];
    [self.imageLeftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mas_top).offset(60);
        make.left.mas_equalTo(self.mas_left).offset(20);
    }];


    
    [self addSubview:self.topContentView];
    [self.topContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.height.mas_equalTo(self.mas_height).multipliedBy(0.5);
        make.top.mas_equalTo(self.imageBtn.mas_bottom).offset(10);
    }];
    
    
    [self addSubview:self.announView];
    [self.announView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mas_bottom).offset(-10);
        make.left.mas_equalTo(self.mas_left).offset(10);
        make.right.mas_equalTo(self.mas_right).offset(-10);
        make.height.mas_equalTo(40);
    }];
    
    SKDefineWeakSelf;
    [self.imageBtn setTapActionWithBlock:^{
        if (weakSelf.NextViewControllerBlock) {
            weakSelf.NextViewControllerBlock(@"r");
        }

    }];
    [self.imageLeftBtn setTapActionWithBlock:^{
        if (weakSelf.NextViewControllerBlock) {
            weakSelf.NextViewControllerBlock(@"l");
        }
    }];
    
    
    [self.announView setTapActionWithBlock:^{
        if (weakSelf.NextViewControllerBlock) {
            weakSelf.NextViewControllerBlock(@"公告");
        }
    }];
    
    
    self.imageBtn.hidden = YES;
    
}

- (void)setGonggaoArrayTop:(NSArray *)gonggaoArrayTop{
    _gonggaoArrayTop = gonggaoArrayTop;
    self.announView.gonggaoArray = gonggaoArrayTop;
}

- (UIView *)topBgView {
    if (!_topBgView) {
        _topBgView = [[UIView alloc]init];
        _topBgView.backgroundColor = QYThemeColor;
    }
    return _topBgView;
}

- (QYHomeTopContentView *)topContentView {
    if (!_topContentView) {
        _topContentView = [[QYHomeTopContentView alloc]init];
    }
    return _topContentView;
}

- (UIImageView *)imageBtn {
    if (!_imageBtn) {
        _imageBtn = [[UIImageView alloc]initWithImage:SKImageNamed(@"icon_market")];
    }
    return _imageBtn;
}

- (UIImageView *)imageLeftBtn {
    if (!_imageLeftBtn) {
        _imageLeftBtn = [[UIImageView alloc]initWithImage:SKImageNamed(@"icon_export")];
    }
    return _imageLeftBtn;
}

- (QYAnnounView *)announView {
    if (!_announView) {
        _announView = [[QYAnnounView alloc]init];
    }
    return _announView;
}

@end
