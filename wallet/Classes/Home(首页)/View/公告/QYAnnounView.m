//
//  QYAnnounView.m
//  wallet
//
//  Created by talking　 on 2019/6/14.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "QYAnnounView.h"
#import "JWCycleLabel.h"

@interface QYAnnounView ()
@property (nonatomic, strong) JWCycleLabel * cycleLB;//公告


@property (nonatomic, strong) UIImageView *leftImageView;
@property (nonatomic, strong) UIImageView *rightImageView;

@end

@implementation QYAnnounView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = SKColor(248, 248, 248, 1.0);
        
        [self customUI];
    }
    return self;
}
- (void)customUI {
    
    [self addSubview:self.leftImageView];
    [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);
        make.left.mas_equalTo(self.mas_left).offset(8);
    }];
    
    [self addSubview:self.rightImageView];
    [self.rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);
        make.right.mas_equalTo(self.mas_right).offset(-8);
    }];
    
    //公告
    [self addSubview:self.cycleLB];
    self.cycleLB.frame = CGRectMake(30, CGRectGetMaxY(self.frame), SKScreenWidth - 20 - 60, 40);
}

- (void)setGonggaoArray:(NSArray *)gonggaoArray{
    _gonggaoArray = gonggaoArray;
    [self.cycleLB startWithTextArray:gonggaoArray];
}
- (JWCycleLabel *)cycleLB
{
    if (!_cycleLB) {
        _cycleLB           = [JWCycleLabel new];
        _cycleLB.textColor = SKColor(153, 153, 153, 1);
        _cycleLB.font      = [UIFont systemFontOfSize:14];
        _cycleLB.backgroundColor = SKColor(248, 248, 248, 1.0);
    }
    return _cycleLB;
}

- (UIImageView *)leftImageView {
    if (!_leftImageView) {
        _leftImageView = [[UIImageView alloc]initWithImage:SKImageNamed(@"icon_announcement")];
    }
    return _leftImageView;
}
- (UIImageView *)rightImageView {
    if (!_rightImageView) {
        _rightImageView = [[UIImageView alloc]initWithImage:SKImageNamed(@"icon_more")];
    }
    return _rightImageView;
}

@end
