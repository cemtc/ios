//
//  ZWWTextView.h
//  MyBaseProgect
//
//  Created by 张威威 on 2018/4/27.
//  Copyright © 2018年 张威威. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZWWTextView : UITextView
@property(nonatomic,copy)NSString *placeholderStr;
@property (nonatomic, copy)void(^MessageTextTFChangeBlock)(NSString *TextStr);
/**
 *  构建方法
 */
+ (instancetype)textView;
@end
