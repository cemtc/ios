//
//  SKCustomInsetsLable.m
//  Business
//
//  Created by talking　 on 2018/8/15.
//  Copyright © 2018年 talking　. All rights reserved.
//

#import "SKCustomInsetsLable.h"

@implementation SKCustomInsetsLable


@synthesize insets = _insets;

- (instancetype)initWithFrame:(CGRect)frame andInsets:(UIEdgeInsets)insets {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.insets = insets;
    }
    
    return self;
    
}

- (instancetype)initWithInsets:(UIEdgeInsets)insets {
    
    self = [super init];
    if (self) {
        
        self.insets = insets;
    }
    
    return self;
}

- (void)drawTextInRect:(CGRect)rect {
    
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, self.insets)];
    
}

@end
