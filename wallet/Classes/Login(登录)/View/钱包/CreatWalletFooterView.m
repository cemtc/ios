//
//  CreatWalletFooterView.m
//  wallet
//
//  Created by talking　 on 2019/6/25.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "CreatWalletFooterView.h"
#import "UIButton+Addition.h"//快速创建一个button
@interface CreatWalletFooterView ()
@property (nonatomic, strong) UIButton *exitButton;

@end
@implementation CreatWalletFooterView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self customUI];
    }
    return self;
}
- (void)customUI {
    self.exitButton = [UIButton buttonWithTitle:@"确认添加" titleColor:SKWhiteColor bgColor:SKColor(85, 99, 162, 1.0) fontSize:20 target:self action:@selector(exitButtonClick:)];
    [self addSubview:self.exitButton];
    [self.exitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(20);
        make.left.equalTo(self).offset(20);
        make.right.equalTo(self).offset(-20);
        make.height.mas_equalTo(45);
    }];
    self.exitButton.layer.cornerRadius = 5;
    
}
- (void)exitButtonClick:(UIButton *)button {
    if ([self.delegate respondsToSelector:@selector(qycreatWalletFooterView:didClickInfo:)]) {
        [self.delegate qycreatWalletFooterView:self didClickInfo:@"要传递的信息"];
    }
}

- (void)setTitleText:(NSString *)titleText {
    _titleText = titleText;
    
    [self.exitButton setTitle:titleText forState:UIControlStateNormal];
}


@end


