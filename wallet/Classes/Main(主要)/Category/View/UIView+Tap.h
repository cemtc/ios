//
//  UIView+Tap.h
//  Business
//
//  Created by talking on 2017/10/1.
//  Copyright © 2017年 talking　. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Tap)

/**
 *  动态添加手势
 */
- (void)setTapActionWithBlock:(void (^)(void))block ;



@end
