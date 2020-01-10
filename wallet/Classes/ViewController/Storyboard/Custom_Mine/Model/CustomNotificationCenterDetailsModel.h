//
//  CustomNotificationCenterDetailsModel.h
//  wallet
//
//  Created by 曾云 on 2019/8/22.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "ObjcSectionModel.h"

NS_ASSUME_NONNULL_BEGIN


@interface CustomNotificationCenterDetailsSectionModel : ObjcSectionModel
@property (nonatomic,assign) double value;
@property (nonatomic,strong) NSString *tokenName;
@property (nonatomic,assign) double gasPrice;

@end

@interface CustomNotificationCenterDetailsModel : NSObject

/*
 
 转账数量:
 如果value 字段大于0,转账数量为value,否则 取字段realValue
 币单位:   取字段tokenName
 发送地址: sendAddress
 接受地址:  如果value 字段大于0,取字段receiveAddress
 如果value 字段等于0,则取字段realAddress
 交易hash 取字段ahsh
 手续费: 取字段 gas 乘 字段gas  除  1000000000000000000
 转账时间: 取time 字段
 */
@property (nonatomic,assign) NSInteger value;
@property (nonatomic,assign) NSString *btc_eth_value;
@property (nonatomic,strong) NSString *tokenName;
@property (nonatomic,strong) NSString *sendAddress;
@property (nonatomic,strong) NSString *toAddress;
@property (nonatomic,strong) NSString *hash_k;
@property (nonatomic,strong) NSString *hashO;

@property (nonatomic,assign) double gas;
@property (nonatomic,assign) double gasPrice;
@property (nonatomic,assign) NSInteger timestamp;


@property (nonatomic,strong) CustomNotificationCenterDetailsSectionModel *sectionModel;


- (instancetype)initWithItemModel:(CustomNotificationCenterItemModel *)itemModel;
- (instancetype)initWithITransfertemModel:(CustomNotificationCenterItemModel *)itemModel;

@end

NS_ASSUME_NONNULL_END
