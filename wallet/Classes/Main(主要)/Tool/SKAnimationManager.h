//
//  SKAnimationManager.h
//  Business
//
//  Created by talking　 on 2018/8/14.
//  Copyright © 2018年 talking　. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SKAnimationManager : NSObject

/**
 *  为某个视图添加
 */
+ (void)addTransformAnimationForView:(UIView *)view;

/**
 *  让某一个视图抖动
 *
 *  @param viewToShake 需要抖动的视图
 */
+ (void)shakeView:(UIView*)viewToShake;





//talking 写的抖动动画
//[view.layer addAnimation:[HLAnimationManager shakeAnimation:CGRectMake(100, 100, 100, 100)] forKey:nil];
+(CAKeyframeAnimation *)shakeAnimation:(CGRect)frame;

@end
