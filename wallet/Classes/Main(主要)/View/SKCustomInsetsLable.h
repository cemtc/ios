//
//  SKCustomInsetsLable.h
//  Business
//
//  Created by talking　 on 2018/8/15.
//  Copyright © 2018年 talking　. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SKCustomInsetsLable : UILabel

@property (nonatomic, assign) UIEdgeInsets insets;

- (instancetype)initWithFrame:(CGRect)frame andInsets:(UIEdgeInsets) insets;

- (instancetype)initWithInsets:(UIEdgeInsets)insets;



@end
