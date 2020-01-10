//
//  SKUserFooterView.m
//  wallet
//
//  Created by talking　 on 2019/6/23.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "SKUserFooterView.h"
#import "UIButton+Addition.h"//快速创建一个button

@interface SKUserFooterView ()
@property (nonatomic, strong) UIButton *exitButton;


@end

@implementation SKUserFooterView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self customUI];
    }
    return self;
}
- (void)customUI {
    self.exitButton = [UIButton buttonWithTitle:@"退出账号" titleColor:SKWhiteColor bgColor:SKColor(198, 167, 113, 1.0) fontSize:20 target:self action:@selector(exitButtonClick:)];
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
    if ([self.delegate respondsToSelector:@selector(skUserFooterView:didClickInfo:)]) {
        [self.delegate skUserFooterView:self didClickInfo:@"要传递的信息"];
    }
}

- (void)setTitleText:(NSString *)titleText {
    _titleText = titleText;
    
    [self.exitButton setTitle:titleText forState:UIControlStateNormal];
}


@end
