//
//  EFTagButton.m
//  wallet
//
//  Created by 董文龙 on 2019/11/28.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "EFTagButton.h"
extern CGFloat const imageViewWH;
@implementation EFTagButton

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (self.imageView.frame.size.width <= 0) return;
    CGFloat btnW = self.bounds.size.width;
    CGFloat btnH = self.bounds.size.height;
    self.titleLabel.frame = CGRectMake(_margin, self.titleLabel.frame.origin.y, self.titleLabel.frame.size.width, self.titleLabel.frame.size.height);
    CGFloat imageX = btnW - self.imageView.frame.size.width -  _margin;
    self.imageView.frame = CGRectMake(imageX, (btnH - imageViewWH) * 0.5, imageViewWH, imageViewWH);
}

- (void)setHighlighted:(BOOL)highlighted {
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end

