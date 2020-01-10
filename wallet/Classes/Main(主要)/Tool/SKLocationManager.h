//
//  SKLocationManager.h
//  Business
//
//  Created by talking　 on 2018/8/15.
//  Copyright © 2018年 talking　. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SKLocationManager : NSObject

@end

////  定位管理类  导入头文件即可//#import <AMapLocationKit/AMapLocationKit.h>//导入头文件即可
//用法如下 把所有注释打开
/*
 
 见NHDiscoverNearByViewController
 
 if ([NHLocationManager sharedManager].hasLocation) {
 NSString *lati = [[NSUserDefaults standardUserDefaults] objectForKey:kNHUserCurrentLatitude];
 NSString *longi = [[NSUserDefaults standardUserDefaults] objectForKey:kNHUserCurrentLongitude];
 [self loadDataWithLatitude:lati longitude:longi];
 } else {
 [[NHLocationManager sharedManager] startSerialLocation];
 [[NHLocationManager sharedManager] setUpLocationManagerUpdateLocationHandle:^(CLLocation *newLocation, NSString *newLatitude, NSString *newLongitude) {
 [self loadDataWithLatitude:newLatitude longitude:newLongitude];
 }];
 // 默认加载这个经纬度附近的人
 [self loadDataWithLatitude:@"40.07233784961181" longitude:@"116.3415643071043"];
 }
 
 */

//#import <Foundation/Foundation.h>
//#import <AMapLocationKit/AMapLocationKit.h>//导入头文件即可


//typedef void(^NHLocationManagerDidUpdateLocationHandle)(CLLocation *newLocation, NSString *newLatitude, NSString *newLongitude);

//@interface JCLocationManager : NSObject
//
//
///** 开始定位*/
//- (void)startSerialLocation;
//
//+ (instancetype)sharedManager;
//
///** 更新定位回调*/
//- (void)setUpLocationManagerUpdateLocationHandle:(NHLocationManagerDidUpdateLocationHandle)updateLocationHandle;
//
///** 是否可以定位*/
//@property (nonatomic, assign) BOOL canLocationFlag;
//
///** 是否有经纬度*/
//@property (nonatomic, assign) BOOL hasLocation;

