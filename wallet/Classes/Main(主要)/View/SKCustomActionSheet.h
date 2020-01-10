//
//  SKCustomActionSheet.h
//  Business
//
//  Created by talking　 on 2018/8/14.
//  Copyright © 2018年 talking　. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SKCustomActionSheet;
typedef void(^SKCustomActionSheetItemClickHandle)(SKCustomActionSheet *actionSheet,NSInteger currentIndex,NSString *title);

@interface SKCustomActionSheet : UIView


/**
 *  初始化
 *
 *  @param cancelTitle 取消
 *  @param alertTitle  提示文字
 *  @param title       子控件文本
 */
+ (instancetype)actionSheetWithCancelTitle:(NSString *)cancelTitle alertTitle:(NSString *)alertTitle SubTitles:(NSString *)title,...NS_REQUIRES_NIL_TERMINATION;

- (void)setCustomActionSheetItemClickHandle:(SKCustomActionSheetItemClickHandle)itemClickHandle;

- (void)setActionSheetDismissItemClickHandle:(SKCustomActionSheetItemClickHandle)dismissItemClickHandle;

- (void)show;



@end
