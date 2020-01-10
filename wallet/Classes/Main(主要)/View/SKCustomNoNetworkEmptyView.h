//
//  SKCustomNoNetworkEmptyView.h
//  Business
//
//  Created by talking　 on 2018/8/14.
//  Copyright © 2018年 talking　. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SKCustomNoNetworkEmptyView : UIView
/** 没有网络，重试*/
@property (nonatomic, copy) void(^customNoNetworkEmptyViewDidClickRetryHandle)(SKCustomNoNetworkEmptyView *view);

@end
