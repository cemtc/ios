//
//  FinancialBenefitsTopView.m
//  wallet
//
//  Created by talking　 on 2019/6/23.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "FinancialBenefitsTopView.h"

@interface FinancialBenefitsTopView ()

@property (nonatomic, strong) UILabel *titleL;

@end

@implementation FinancialBenefitsTopView

- (UILabel *)titleL {
    if (!_titleL) {
        _titleL = [[UILabel alloc]init];
        _titleL.textColor = SKBlackColor;
        _titleL.font = SKFont(14);
        _titleL.text = @"累计收益(WINT)";
        _titleL.textAlignment = NSTextAlignmentCenter;
    }
    return _titleL;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.textColor = SKColor(198, 167, 113, 1.0);
        _contentLabel.font = SKFont(40);
        _contentLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _contentLabel;
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

    [self addSubview:self.titleL];
    [self.titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(20);
        make.left.right.mas_equalTo(self);
    }];
    
    [self addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleL.mas_bottom).offset(20);
        make.left.right.mas_equalTo(self);
    }];
    
    
    UILabel *lineL = [[UILabel alloc]init];
    lineL.backgroundColor = SKCommonBgColor;
    [self addSubview:lineL];
    [lineL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.height.mas_equalTo(9);
        make.top.mas_equalTo(self.contentLabel.mas_bottom).offset(20);
    }];
    
    
    UILabel *bottomLine = [[UILabel alloc]init];
    bottomLine.backgroundColor = SKCommonBgColor;
    [self addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(self);
        make.height.mas_equalTo(1);
    }];
    
    
    
    UILabel *bottomTitle1 = [[UILabel alloc]init];
    bottomTitle1.text = @"日期";
    bottomTitle1.textColor = SKColor(46, 48, 59, 1.0);
    bottomTitle1.font = SKFont(16);
    [self addSubview:bottomTitle1];
    [bottomTitle1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(60);
        make.bottom.mas_equalTo(bottomLine.mas_top).offset(-15);
    }];
    
    
    
    
    UILabel *bottomTitle2 = [[UILabel alloc]init];
    bottomTitle2.text = @"收益";
    bottomTitle2.textColor = SKColor(46, 48, 59, 1.0);
    bottomTitle2.font = SKFont(16);
    [self addSubview:bottomTitle2];
    [bottomTitle2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.bottom.mas_equalTo(bottomLine.mas_top).offset(-15);
    }];

    
    UILabel *bottomTitle3 = [[UILabel alloc]init];
    bottomTitle3.text = @"激励";
    bottomTitle3.textColor = SKColor(46, 48, 59, 1.0);
    bottomTitle3.font = SKFont(16);
    [self addSubview:bottomTitle3];
    [bottomTitle3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-60);
        make.bottom.mas_equalTo(bottomLine.mas_top).offset(-15);
    }];

}



@end
