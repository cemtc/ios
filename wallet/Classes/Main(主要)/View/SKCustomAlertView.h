//
//  SKCustomAlertView.h
//  Business
//
//  Created by talking　 on 2018/8/14.
//  Copyright © 2018年 talking　. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SKCustomAlertView : UIView

/**
 *  自定义取消按钮点击事件
 *
 *  @param cancelBlock 可选
 */
- (void)setupCancelBlock:(BOOL (^)())cancelBlock;
/**
 *  自定义确定或者自定义按钮点击事件
 *
 *  @param touchBlock 必选
 */
- (void)setupSureBlock:(BOOL (^)())touchBlock;

/**
 *  传nil默认为app window
 */
- (void)showInView:(UIView *)view;

/**
 *  构造方法
 *
 *  @param title  内容
 *  @param cancel 取消 左边
 *  @param sure   确定 右边
 */
- (instancetype)initWithTitle:(NSString *)title cancel:(NSString *)cancel sure:(NSString *)sure;

@end
