//
//  UITextField+HLLeftView.m
//  Business
//
//  Created by talking on 2017/10/2.
//  Copyright © 2017年 talking　. All rights reserved.
//

#import "UITextField+HLLeftView.h"

@implementation UITextField (HLLeftView)

+ (UITextField *)textFieldWithPlaceholder:(NSString *)placeholder leftIconImage:(UIImage *)leftIconImage height:(CGFloat)height leftViewWith:(CGFloat)leftViewWith{
    
    UITextField *textField = [[UITextField alloc] init];
    
//    if ([placeholder isEqualToString:@"输入密码"]||[placeholder isEqualToString:@"验证码"]||[placeholder isEqualToString:@"新密码"]||[placeholder isEqualToString:@"密码"]) {
//
//
//    }else{
    
//        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
//    }
    
//    if ([placeholder isEqualToString:@"输入密码"] || [placeholder isEqualToString:@"新密码"] || [placeholder isEqualToString:@"密码"]) {
//
//        [textField setSecureTextEntry:YES];
//    }else if ([placeholder isEqualToString:@"手机号码"]||[placeholder isEqualToString:@"手机号"]||[placeholder isEqualToString:@"验证码"]) {
//
//        textField.keyboardType = UIKeyboardTypePhonePad;
//    }
//
    textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholder attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHexString:@"#757575"],NSFontAttributeName:[UIFont systemFontOfSize:16.0]}];
    
//    textField.borderStyle = UITextBorderStyleRoundedRect;
//    textField.layer.cornerRadius = SKAppAdapter(17);
//    textField.layer.masksToBounds = YES;
//    textField.backgroundColor = SKColor(244, 244, 244, 1.0);
//    textField.layer.borderColor = JCColor(231, 231, 231).CGColor;
//    textField.layer.borderWidth = 1.0;
    
    if (leftIconImage) {
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, leftViewWith, height)];
        leftView.backgroundColor = [UIColor clearColor];
        
        UIImageView *leftIconImv = [[UIImageView alloc] initWithImage:leftIconImage];
        leftIconImv.center = leftView.center;
        [leftView addSubview:leftIconImv];
        
        textField.leftView = leftView;
        textField.leftViewMode = UITextFieldViewModeAlways;
    }else {
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 15.0, height)];
        leftView.backgroundColor = [UIColor clearColor];
        
        textField.leftView = leftView;
        textField.leftViewMode = UITextFieldViewModeAlways;
    }
    
    return textField;
    
}
@end
