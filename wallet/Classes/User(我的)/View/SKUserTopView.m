//
//  SKUserTopView.m
//  Business
//
//  Created by talking　 on 2018/8/31.
//  Copyright © 2018年 talking　. All rights reserved.
//

#import "SKUserTopView.h"
#import "UIView+Layer.h"

#import "UIView+Tap.h"

@interface SKUserTopView ()




@property (nonatomic, strong)UIView *bottomView;



@end

@implementation SKUserTopView

- (UILabel *)bottomLeftMoney {
    if (!_bottomLeftMoney) {
        _bottomLeftMoney = [[UILabel alloc]init];
        _bottomLeftMoney.font = SKFont(27);
        _bottomLeftMoney.textColor = SKWhiteColor;
        _bottomLeftMoney.textAlignment = NSTextAlignmentCenter;
        _bottomLeftMoney.text = @"0";
        _bottomLeftMoney.adjustsFontSizeToFitWidth = YES;
    }
    return _bottomLeftMoney;
}
- (UILabel *)bottomRightMoney {
    if (!_bottomRightMoney) {
        _bottomRightMoney = [[UILabel alloc]init];
        _bottomRightMoney.font = SKFont(27);
        _bottomRightMoney.textColor = SKWhiteColor;
        _bottomRightMoney.textAlignment = NSTextAlignmentCenter;
        _bottomRightMoney.text = @"0";
        _bottomRightMoney.adjustsFontSizeToFitWidth = YES;
    }
    return _bottomRightMoney;
}

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc]init];
    }
    return _bottomView;
}

- (UIImageView *)avatarImageView {
    if (!_avatarImageView) {
        _avatarImageView = [[UIImageView alloc]initWithImage:SKImageNamed(@"icon_user")];
    }
    return _avatarImageView;
}

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
    
    UIImageView *bgView = [[UIImageView alloc]initWithImage:SKImageNamed(@"my_background")];
    [self addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    [self addSubview:self.avatarImageView];
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(23);
        make.top.mas_equalTo(self.mas_top).offset(55);
    }];
    
    [self addSubview:self.nickNameLabel];
    [self.nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.avatarImageView.mas_centerY);
        make.left.mas_equalTo(self.avatarImageView.mas_right).offset(10);
    }];
    
    
    //tel
    UIImageView *telImageView = [[UIImageView alloc]initWithImage:SKImageNamed(@"icon_service")];
    [self addSubview:telImageView];
    [telImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.avatarImageView.mas_centerY);
        make.right.mas_equalTo(self.mas_right).offset(-20);
    }];
    
    
//    self.nickNameLabel.text = [SKUtils parseUserName:@"15082970403" nickname:@""];
    
    
    
    
    
    //bottomView
    [self addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(telImageView.mas_bottom);
//        make.left.right.bottom.mas_equalTo(self);
        make.width.mas_equalTo(SKScreenWidth);
        make.left.mas_equalTo(self.mas_left);
        make.right.mas_equalTo(self.mas_right);
        make.bottom.mas_equalTo(self.mas_bottom);
    }];
    
    
    
    UILabel *lineL = [[UILabel alloc]init];
    lineL.backgroundColor = SKWhiteColor;
    lineL.alpha = 0.5;
    [self.bottomView addSubview:lineL];
    [lineL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(self.bottomView.mas_height).multipliedBy(0.4);
        make.centerX.mas_equalTo(self.bottomView.mas_centerX);
        make.centerY.mas_equalTo(self.bottomView.mas_centerY);
    }];

    
    UILabel *bottomLeftL = [[UILabel alloc]init];
    bottomLeftL.font = SKFont(12);
    bottomLeftL.textColor = SKWhiteColor;
    bottomLeftL.text = @"资产价值（CNY）";
    bottomLeftL.textAlignment = NSTextAlignmentCenter;
    [self.bottomView addSubview:bottomLeftL];
    [bottomLeftL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bottomView.mas_left);
        make.width.mas_equalTo(SKScreenWidth*0.5);
        make.bottom.mas_equalTo(lineL.mas_top).offset(5);
    }];
    
    UILabel *bottomRightL = [[UILabel alloc]init];
    bottomRightL.font = SKFont(12);
    bottomRightL.textColor = SKWhiteColor;
    bottomRightL.text = @"资产价值（WINT）";
    bottomRightL.textAlignment = NSTextAlignmentCenter;
    [self.bottomView addSubview:bottomRightL];
    [bottomRightL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.bottomView.mas_right);
        make.width.mas_equalTo(SKScreenWidth*0.5);
        make.bottom.mas_equalTo(lineL.mas_top).offset(5);
    }];

    
    
    [self.bottomView addSubview:self.bottomLeftMoney];
    [self.bottomLeftMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bottomLeftL.mas_centerX);
        make.top.mas_equalTo(bottomLeftL.mas_bottom).offset(15);
        make.width.mas_equalTo(SKScreenWidth*0.5 - 10);
    }];
    [self.bottomView addSubview:self.bottomRightMoney];
    [self.bottomRightMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bottomRightL.mas_centerX);
        make.top.mas_equalTo(bottomRightL.mas_bottom).offset(15);
        make.width.mas_equalTo(SKScreenWidth*0.5 - 10);
    }];
 
//    self.bottomLeftMoney.text = @"54637.00";
//    self.bottomRightMoney.text = @"43452.00";
    
    SKDefineWeakSelf;
    [telImageView setTapActionWithBlock:^{
        if ([weakSelf.delegate respondsToSelector:@selector(skUserTopView:didClickInfo:)]) {
            [weakSelf.delegate skUserTopView:weakSelf didClickInfo:@"kefu"];
        }
    }];
}

- (UILabel *)nickNameLabel {
    if (!_nickNameLabel) {
        _nickNameLabel = [[UILabel alloc]init];
        _nickNameLabel.textColor = SKWhiteColor;
        _nickNameLabel.font = SKFont(14);
    }
    return _nickNameLabel;
}


@end
