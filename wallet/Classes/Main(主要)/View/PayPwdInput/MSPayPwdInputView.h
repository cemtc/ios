//
//  XYPayPwdInputView.h
//  xiangyue
//
//  Created by Shendou on 15/9/29.
//  Copyright (c) 2015年 shendou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSPayPwdInputView : UIView

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *upConstraint;

@property (weak, nonatomic) IBOutlet UIView *alInView;
@property (weak, nonatomic) IBOutlet UITextField *inputPayPwdTF;

@property (weak, nonatomic) IBOutlet UIButton *closeBtn;
@property (weak, nonatomic) IBOutlet UIView *allBtnOnView;


+ (instancetype)showPwdInputWithTitle:(NSString *)title money:(CGFloat)money closeBlock:(void(^)(void))closeBlock callBack:(void(^)(NSString *pwd))callback;

@end
