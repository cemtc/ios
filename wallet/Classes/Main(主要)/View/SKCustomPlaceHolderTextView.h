//
//  SKCustomPlaceHolderTextView.h
//  Business
//
//  Created by talking　 on 2018/8/15.
//  Copyright © 2018年 talking　. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SKCustomPlaceHolderTextView;

@protocol SKCustomPlaceHolderTextViewDelegate <NSObject>

/** 文本改变回调*/
- (void)customPlaceHolderTextViewTextDidChange:(SKCustomPlaceHolderTextView *)textView;
@end

@interface SKCustomPlaceHolderTextView : UITextView

@property (nonatomic, weak) id <SKCustomPlaceHolderTextViewDelegate> del;
@property (nonatomic,copy) NSString *placehoder;
@property (nonatomic,strong)UIColor *placehoderColor;
@property (nonatomic, assign) CGFloat placeholderTopMargin;
@property (nonatomic, assign) CGFloat placeholderLeftMargin;
@property (nonatomic, strong) UIFont *placeholderFont;

@end
