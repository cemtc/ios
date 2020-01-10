//
//  QYApplicationStarsView.m
//  wallet
//
//  Created by talking　 on 2019/7/7.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "QYApplicationStarsView.h"

@interface QYApplicationStarsView ()
@property (nonatomic, strong) UIImageView *bottomImageView;

@end

@implementation QYApplicationStarsView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self customUI];
    }
    return self;
}
- (void)customUI {

}
- (void)setIndexNum:(NSInteger)indexNum {
    _indexNum = indexNum;
    //如果之前有SKPlaceOrderItemView  把它移除
    for(UIView *itemView in [self subviews])
    {
        if ([itemView isKindOfClass:[UIImageView class]]) {
            [itemView removeFromSuperview];
        }
    }
    
    for (NSInteger i = 0; i < self.indexNum; i++) {
        self.bottomImageView = [[UIImageView alloc]initWithImage:SKImageNamed(@"icon_star")];
        self.bottomImageView.tag = i;
        [self addSubview:self.bottomImageView];
        [self.bottomImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top);
            make.height.width.mas_equalTo(10);
            make.left.mas_equalTo(self.mas_left).offset(10*i);
        }];
    }
}
@end
