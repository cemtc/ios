//
//  ZWWTextView.m
//  MyBaseProgect
//
//  Created by 张威威 on 2018/4/27.
//  Copyright © 2018年 张威威. All rights reserved.
//

#import "ZWWTextView.h"

//获取屏幕宽高
#define KScreenWidth [[UIScreen mainScreen] bounds].size.width
#define KScreenHeight [[UIScreen mainScreen] bounds].size.height - ZWTabbarSafeBottomMargin
#define kScreen_Bounds [UIScreen mainScreen].bounds]
//屏幕适配==6s 做的适配
#define kRealValueWidth(with) (with)*KScreenWidth/375.0
#define kRealValueHeight(height) (height)*KScreenHeight/667.0
////根据ip6的屏幕来拉伸===
#define kRealValue(with) ((with)*(KScreenWidth/375.0f))

/// iPhone X
#define  ZWiPhoneX ([[UIScreen mainScreen] bounds].size.width == 375.f && [[UIScreen mainScreen] bounds].size.height == 812.f ? YES : NO)
#define  ZWTabbarSafeBottomMargin (ZWiPhoneX ? 34.f : 0.f)


@interface ZWWTextView ()<UITextViewDelegate>

@property(nonatomic,strong)UILabel *zw_label;

@end
@implementation ZWWTextView
+(instancetype)textView
{
    return [[self alloc]init];
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self initView];
        self.delegate = self;
    }
    return self;
}

- (void)initView
{
    self.zw_label            = [[UILabel alloc]initWithFrame:CGRectMake(kRealValueWidth(10), kRealValueHeight(0), kRealValue(300), kRealValue(30))];
    self.zw_label.textColor  = [UIColor colorWithHexString:@"C3C3C5"];
    self.zw_label.font       = self.font;
    self.zw_label.text       = @"placeholder";
    [self addSubview:self.zw_label];
    
}
- (void)setText:(NSString *)text
{
    [super setText:text];
    if (self.text.length == 0)
    {
        self.zw_label.hidden = NO;
    }
    else
    {
        self.zw_label.hidden = YES;
    }
}
- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    self.zw_label.font = font;
    self.zw_label.frame = CGRectMake(kRealValue(10),kRealValue(0),kRealValue(300),kRealValue(font.pointSize + 17));
}
-(void)setPlaceholderStr:(NSString *)placeholderStr{
    _placeholderStr = placeholderStr;
    self.zw_label.text = placeholderStr;
}
//- (void)setPlaceholder:(NSString *)placeholder
//{
//    _placeholder = placeholder;
//    self.zw_label.text = placeholder;
//}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (text.length == 0 && textView.text.length == 1)
    {
        self.zw_label.hidden = NO;
        return YES;
    }
    if (text.length == 0 && textView.text.length == 0)
    {
        self.zw_label.hidden = NO;
        return YES;
    }
    self.zw_label.hidden = YES;
    if (self.MessageTextTFChangeBlock) {
        self.MessageTextTFChangeBlock(text);
    }
    return YES;
}


@end
