//
//  ZWSoketRocketUtility.h
//  wallet
//
//  Created by 张威威 on 2019/9/20.
//  Copyright © 2019 talking　. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SocketRocket.h>
NS_ASSUME_NONNULL_BEGIN

@interface ZWSoketRocketUtility : NSObject
/** 连接状态 */
@property (nonatomic,assign) SRReadyState socketReadyState;
@property (nonatomic,  copy) void (^didReceiveMessage)(id message);
+ (ZWSoketRocketUtility *)instance;

-(void)SRWebSocketOpen;//开启连接
-(void)SRWebSocketClose;//关闭连接
- (void)sendData:(NSDictionary *)paramDic withRequestURI:(NSString*)requestURI;//发送数据
- (void)registerNetworkNotifications;//监测网络状态
@end

NS_ASSUME_NONNULL_END
