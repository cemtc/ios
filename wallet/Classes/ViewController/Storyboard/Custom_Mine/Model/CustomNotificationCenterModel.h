//
//  CustomNotificationCenterModel.h
//  wallet
//
//  Created by 曾云 on 2019/8/21.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "ObjcBaseModel.h"
#import "InputModel.h"
#import "OutputsModel.h"
NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM (NSUInteger, CustomNotificationCenterItemType) {
    CustomNotificationCenterItemType_Transfer = 1,/**< 转账消息 */
    CustomNotificationCenterItemType_System/**< 系统消息 */
};

@interface CustomNotificationCenterItemModel : ObjcBaseModel
/*
 没有文档 我也不知到字段意思  只告诉我规则 如下：
 
 转账通知界面:
 
 如果from 转小写 比较address 如果相等,
 如果fromReadStatus 等于1 ,则内容全部灰色显示.
 
 显示标题  "转账失败通知"然后,如果 0x1等于status,则标题显示"转账成功通知"
 -------------
 
 如果from 转小写 比较address 如果不相等,
 如果toReadStatus 等于1 ,则内容全部灰色显示.
 
 显示标题  "收款失败通知"然后,如果 0x1等于status,则标题显示"收款成功通知"
 
 --------------
 时间显示timestamp  字段
 内容显示: 交易hash:AAAAAA...,点击查看详情
 AAAAAA  代表字段hash 前十个字母
 */

@property (nonatomic,assign) CustomNotificationCenterItemType type1;
//
//@property (nonatomic,assign) double objc_Height;
//@property (nonatomic,strong) NSString *objc_Identifier;

@property (nonatomic,assign) NSString *blockhumber;
@property (nonatomic,strong) NSString *blockhash;
@property (nonatomic,assign) NSString *cumulativegasused;
@property (nonatomic,assign) NSString *fromreadstatus;
@property (nonatomic,assign) NSString *toreadstatus;
@property (nonatomic,assign) NSString *transactionindex;
@property (nonatomic,assign) NSString *kind;
@property (nonatomic,strong) NSString *hashO;
@property (nonatomic,assign) NSString *none;
@property (nonatomic,assign) double gasprice;
@property (nonatomic,strong) NSArray<InputModel *> *inputs;
@property (nonatomic,strong) NSArray<OutputsModel *> *outputs;
@property (nonatomic,strong) NSArray *tos;
@property (nonatomic,strong) NSArray *froms;
@property (nonatomic,strong) NSString *fee;
@property (nonatomic,strong) NSString *type;

@property (nonatomic,strong) NSString *blockHash;
@property (nonatomic,assign) NSInteger blockNumber;
@property (nonatomic,assign) NSInteger contract;
@property (nonatomic,assign) NSInteger cumulativeGasUsed;
@property (nonatomic,strong) NSString *from;
@property (nonatomic,assign) NSInteger fromReadStatus;
@property (nonatomic,assign) double gas;
@property (nonatomic,assign) double gasPrice;
@property (nonatomic,assign) NSInteger gasUsed;
@property (nonatomic,strong) NSString *hash_K;
@property (nonatomic,strong) NSString *input;
@property (nonatomic,assign) NSInteger nonce;
@property (nonatomic,strong) NSString *realAddress;
@property (nonatomic,assign) double realValue;
@property (nonatomic,assign) BOOL removed;
@property (nonatomic,strong) NSString *status;
@property (nonatomic,assign) NSInteger timestamp;
@property (nonatomic,strong) NSString *to;
@property (nonatomic,assign) NSInteger toReadStatus;
@property (nonatomic,strong) NSString *tokenName;
@property (nonatomic,strong) NSArray *topics;
@property (nonatomic,assign) NSInteger transactionIndex;
@property (nonatomic,assign) NSInteger v;
@property (nonatomic,assign) double value;
@property (nonatomic,strong) NSString *btc_eth_value;

@end


@interface CustomNotificationCenterModel : NSObject

@property (nonatomic,assign) CustomNotificationCenterItemType type1;

@property (nonatomic,strong) NSMutableArray<CustomNotificationCenterItemModel *> *transferArray;
@property (nonatomic,strong) NSMutableArray<CustomNotificationCenterItemModel *> *transferCopyArray;
@property (nonatomic,strong) NSMutableArray<CustomNotificationCenterItemModel *> *systemArray;

@end



NS_ASSUME_NONNULL_END
