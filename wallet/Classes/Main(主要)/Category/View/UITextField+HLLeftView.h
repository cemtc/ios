//
//  UITextField+HLLeftView.h
//  Business
//
//  Created by talking on 2017/10/2.
//  Copyright © 2017年 talking　. All rights reserved.
//快速创建textfile

#import <UIKit/UIKit.h>

@interface UITextField (HLLeftView)
+ (UITextField *)textFieldWithPlaceholder:(NSString *)placeholder leftIconImage:(UIImage *)leftIconImage height:(CGFloat)height leftViewWith:(CGFloat)leftViewWith;

@end
