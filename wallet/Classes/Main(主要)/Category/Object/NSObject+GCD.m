//
//  NSObject+GCD.m
//  Business
//
//  Created by talking on 2017/10/1.
//  Copyright © 2017年 talking　. All rights reserved.
//

#import "NSObject+GCD.h"

@implementation NSObject (GCD)

/**
 *    异步执行代码块
 *
 *   block 代码块
 */
- (void)performAsynchronous:(void(^)(void))block {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, block);
}
/**
 *    GCD主线程执行代码块
 *
 *   block 代码块
 *   wait  是否同步请求
 */
- (void)performOnMainThread:(void(^)(void))block wait:(BOOL)shouldWait {
    if (shouldWait) {
        // Synchronous
        dispatch_sync(dispatch_get_main_queue(), block);
    }
    else {
        // Asynchronous
        dispatch_async(dispatch_get_main_queue(), block);
    }
}
/**
 *    延迟执行代码块
 *
 *   seconds 延迟时间 秒
 *   block   代码块
 */
- (void)performAfter:(NSTimeInterval)seconds block:(void(^)(void))block {
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, seconds * NSEC_PER_SEC);
    //    dispatch_after(popTime, dispatch_get_current_queue(), block);
    dispatch_after(popTime, dispatch_get_main_queue(), block);
    
}

@end
