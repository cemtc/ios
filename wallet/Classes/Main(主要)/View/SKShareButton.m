//
//  SKShareButton.m
//  Business
//
//  Created by talking　 on 2018/8/14.
//  Copyright © 2018年 talking　. All rights reserved.
//

#define KBorder 10.0f

#import "SKShareButton.h"

@implementation SKShareButton

- (instancetype)initWithFrame:(CGRect)frame
                    shareIcon:(NSString *)imageName
                 shareSNSName:(NSString *)snsName
{
    if (self = [super initWithFrame:frame]) {
        // 分享的icon
        CGFloat iconWidth = frame.size.width - KBorder * 2.0f;
        UIImageView * icon = [[UIImageView alloc] initWithFrame:CGRectMake(KBorder, 0, iconWidth, iconWidth)];
        [icon setImage:[UIImage imageNamed:imageName]];
        icon.layer.masksToBounds = YES;
        icon.layer.cornerRadius  = iconWidth / 2.0f;
        [self addSubview:icon];
        
        // 分享的平台名称
        UILabel * snsNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(icon.frame) + KBorder, frame.size.width, 20.0f)];
        snsNameLabel.font = [UIFont fontWithName:@"Arial Unicode MS" size:14.0f];
        //        snsNameLabel.textColor = RGBCOLOR(174, 174, 174, 1.0);
        snsNameLabel.textColor = [UIColor colorWithRed:174.0/255.0 green:174.0/255.0 blue:174.0/255.0 alpha:1.0];
        snsNameLabel.textAlignment = NSTextAlignmentCenter;
        snsNameLabel.text  = snsName;
        [self addSubview:snsNameLabel];
    }
    
    return self;
}

@end
