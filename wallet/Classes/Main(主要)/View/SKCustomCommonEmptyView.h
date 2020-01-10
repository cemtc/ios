//
//  SKCustomCommonEmptyView.h
//  Business
//
//  Created by talking　 on 2018/8/14.
//  Copyright © 2018年 talking　. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SKCustomCommonEmptyView : UIView
@property (nonatomic, weak) UIImageView *topTipImageView;
@property (nonatomic, weak) UILabel *firstL;
@property (nonatomic, weak) UILabel *secondL;

- (instancetype)initWithTitle:(NSString *)title
                  secondTitle:(NSString *)secondTitle
                     iconname:(NSString *)iconname;
- (instancetype)initWithAttributedTitle:(NSMutableAttributedString *)attributedTitle
                  secondAttributedTitle:(NSMutableAttributedString *)secondAttributedTitle
                               iconname:(NSString *)iconname;
- (void)showInView:(UIView *)view; // 添加到view

@end
