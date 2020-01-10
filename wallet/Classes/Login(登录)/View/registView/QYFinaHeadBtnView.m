//
//  QYFinaHeadBtnView.m
//  wallet
//
//  Created by talking　 on 2019/6/19.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "QYFinaHeadBtnView.h"
#import "UIView+Tap.h"

@interface QYFinaHeadBtnView ()

@property (nonatomic, strong) UIImageView *leftImageView;
@property (nonatomic, strong) UIImageView *rightImageView;

@end

@implementation QYFinaHeadBtnView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self customUI];
    }
    return self;
}
- (void)customUI {
    
    //add subViews
    [self addSubview:self.leftImageView];
    [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top);
        make.left.mas_equalTo(self.mas_left);
    }];
    [self addSubview:self.rightImageView];
    [self.rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.leftImageView.mas_bottom);
        make.left.mas_equalTo(self.leftImageView.mas_right).offset(-30);
    }];
    
    //让理财在最上层显示
    [self bringSubviewToFront:self.leftImageView];
    //add Click
    SKDefineWeakSelf;
    [self.leftImageView setTapActionWithBlock:^{
        [weakSelf imageClick:@"left"];
    }];
    [self.rightImageView setTapActionWithBlock:^{
        [weakSelf imageClick:@"right"];
    }];

}
- (void)imageClick:(NSString *)str{
    
    if ([str isEqualToString:@"left"]) {
        self.leftImageView.image = SKImageNamed(@"button_licai");
        self.rightImageView.image = SKImageNamed(@"button_shuhui");
        
        //让理财在最上层显示
        [self bringSubviewToFront:self.leftImageView];
        
        //重置之前的约束
        [self.leftImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top);
            make.left.mas_equalTo(self.mas_left);
        }];
        [self.rightImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.leftImageView.mas_bottom);
            make.left.mas_equalTo(self.leftImageView.mas_right).offset(-30);
        }];
        
        
    }else if ([str isEqualToString:@"right"]){
        self.leftImageView.image = SKImageNamed(@"button_licai_02");
        self.rightImageView.image = SKImageNamed(@"button_shuhui_02");

        //让赎回在最上层显示
        [self bringSubviewToFront:self.rightImageView];
        
        //重置之前的约束
        [self.leftImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top).offset(3);
            make.left.mas_equalTo(self.mas_left);
        }];
        [self.rightImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.leftImageView.mas_bottom);
            make.left.mas_equalTo(self.leftImageView.mas_right).offset(-30);
        }];
    }
    
    if ([self.delegate respondsToSelector:@selector(qyFinaHeadBtnView:didClickInfo:)]) {
        [self.delegate qyFinaHeadBtnView:self didClickInfo:str];
    }
    
}

- (UIImageView *)leftImageView {
    if (!_leftImageView) {
        _leftImageView = [[UIImageView alloc]initWithImage:SKImageNamed(@"button_licai")];
    }
    return _leftImageView;
}
- (UIImageView *)rightImageView {
    if (!_rightImageView) {
        _rightImageView = [[UIImageView alloc]initWithImage:SKImageNamed(@"button_shuhui")];
    }
    return _rightImageView;
}

@end
