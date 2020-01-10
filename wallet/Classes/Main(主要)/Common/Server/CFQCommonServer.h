//
//  CFQCommonServer.h
//  wallet
//
//  Created by talking　 on 2019/6/27.
//  Copyright © 2019 talking　. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CustomNotificationCenterModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CFQCommonServer : NSObject




//通知中心转账通知
/*
 pageNo
 pageSize
 address
 */
+(void)cfqServerQYAPIgetTokenNoticeTransRecordWithInput:(NSDictionary *)input Callback:(void(^)(id response, BOOL success, NSString *message, NSString *code))callback;
+ (void)getAllETHNoticeTransRecordPage:(NSInteger)page address:(NSString *)address complete:(void(^)(NSMutableArray<CustomNotificationCenterItemModel *> *dataArray,NSString *errMsg))completion;
+ (void)getAllTokenNoticeTransRecordPage:(NSInteger)page address:(NSString *)address complete:(void(^)(NSMutableArray<CustomNotificationCenterItemModel *> *dataArray,NSString *errMsg))completion;

+ (void)getCoinSystemComplete:(void(^)(NSMutableArray *dataArray,NSString *errMsg))completion;
    
//获取转账列表

    //CCM
    + (void)getCcmTransRecordPage:(NSInteger)page address:(NSString *)address complete:(void(^)(NSString *errMsg,NSString *count))completion;
    //其他
    + (void)getTokenTransRecordPage:(NSInteger)page address:(NSString *)address contractAddress:(NSString *)contractAddress complete:(void(^)(NSString *errMsg))completion;


//我的页面  获取未读消息数量
+ (void)getTokenNoticeTransRecordPage:(NSInteger)page address:(NSString *)address complete:(void(^)(NSInteger count))completion;
+ (void)getBTCNoticeTransRecordPage:(NSInteger)page address:(NSString *)address complete:(void(^)(NSInteger count))completion;
+ (void)updateReadStatusType:(NSString *)type hash:(NSString *)hash complete:(void(^)(NSString *errMsg))completion;




//通知中心 系统消息
+ (void)getNoticeListByPage:(NSInteger)page complete:(void(^)(NSMutableArray<CustomNotificationCenterItemModel *> *dataArray,NSString *errMsg))completion;


//意见反馈
+ (void)cfqServerQYAPIAddFeedback_Name:(NSString *)name mobile:(NSString *)mobile type:(NSString *)type text:(NSString *)text complete:(void(^)(NSString *errMsg))completion;




//1.登录接口
+(void)cfqServerQYAPIloginWithInput:(NSDictionary *)input Callback:(void(^)(id response, BOOL success, NSString *message, NSString *code))callback;
//3.获取汇率
+(void)cfqServerQYAPIGetCoinSystemWithInput:(NSDictionary *)input Callback:(void(^)(id response, BOOL success, NSString *message, NSString *code))callback;
//4.获取总资产和平台币GET(我的界面)
+(void)cfqServerQYAPIgetPropertyWithInput:(NSDictionary *)input Callback:(void(^)(id response, BOOL success, NSString *message, NSString *code))callback;
//8.systemType类型。1：帮助2：白皮书3：关于我们4：理 财5：赎回
+(void)cfqServerGetSystemHelpByTypeWithInput:(NSDictionary *)input callback:(void(^)(id response, BOOL success, NSString *message, NSString *code))callback;

//5.公告
+(void)cfqServerQYAPIGetNoticeListByPageWithInput:(NSDictionary *)input Callback:(void(^)(id response, BOOL success, NSString *message, NSString *code))callback;

//6.公告
+(void)cfqServerQYAPIInsertNoticeHandleWithInput:(NSDictionary *)input Callback:(void(^)(id response, BOOL success, NSString *message, NSString *code))callback;
//7.轮播图//1：理财2：应用
+(void)cfqServerQYAPIGetBannerByTypeWithInput:(NSDictionary *)input Callback:(void(^)(id response, BOOL success, NSString *message, NSString *code))callback;

//11.我的客服
+(void)cfqServerQYAPIGetCustomListWithInput:(NSDictionary *)input Callback:(void(^)(id response, BOOL success, NSString *message, NSString *code))callback;
//14.赎回
+(void)cfqServerQYAPIaddRansomRecordWithInput:(NSDictionary *)input Callback:(void(^)(id response, BOOL success, NSString *message, NSString *code))callback;
//15.赎回记录
+(void)cfqServerQYAPIgetRansomRecordListByPageWithInput:(NSDictionary *)input Callback:(void(^)(id response, BOOL success, NSString *message, NSString *code))callback;
//16.修改密码//密码类型1：登录密码2：交易密码
+(void)cfqServerQYAPIchangePwdWithInput:(NSDictionary *)input Callback:(void(^)(id response, BOOL success, NSString *message, NSString *code))callback;
//17.应用接口
+(void)cfqServerQYAPIgetApplicationListWithInput:(NSDictionary *)input Callback:(void(^)(id response, BOOL success, NSString *message, NSString *code))callback;
//18.更新接口//1：安卓2：ios
+(void)cfqServerQYAPIQYAPIgetVersionInfo_UrlWithInput:(NSDictionary *)input Callback:(void(^)(id response, BOOL success, NSString *message, NSString *code))callback;
//19.根据币种查询信息
+(void)cfqServerQYAPIQYAPIgetUseBalanceByCoinAndCustomerIdWithInput:(NSDictionary *)input Callback:(void(^)(id response, BOOL success, NSString *message, NSString *code))callback;
//20.    退出登录
+(void)cfqServerQYAPIlogoutWithInput:(NSDictionary *)input Callback:(void(^)(id response, BOOL success, NSString *message, NSString *code))callback;


//1. 添加理财记录POST
+(void)cfqServerQYAPIaddManageRecordWithInput:(NSDictionary *)input Callback:(void(^)(id response, BOOL success, NSString *message, NSString *code))callback;
//2.查询理财列表GET
+(void)cfqServerQYAPIgetManageRecordListWithInput:(NSDictionary *)input Callback:(void(^)(id response, BOOL success, NSString *message, NSString *code))callback;
////3.查询系统币信息GET
//+(void)cfqServerQYAPIgetCoinSysInfoWithInput:(NSDictionary *)input Callback:(void(^)(id response, BOOL success, NSString *message, NSString *code))callback;
//4.验证交易密码GET
+(void)cfqServerQYAPIQYAPIcheckTradePwdWithInput:(NSDictionary *)input Callback:(void(^)(id response, BOOL success, NSString *message, NSString *code))callback;
//5.理财收益记录GET
+(void)cfqServerQYAPIgetManageIncordListWithInput:(NSDictionary *)input Callback:(void(^)(id response, BOOL success, NSString *message, NSString *code))callback;
//5.1理财收益记录GET
+(void)cfqServerQYAPIgetAllIncomeWithInput:(NSDictionary *)input Callback:(void(^)(id response, BOOL success, NSString *message, NSString *code))callback;
//6.糖果GET
+(void)cfqServerQYAPIgetCustomerAwardListWithInput:(NSDictionary *)input Callback:(void(^)(id response, BOOL success, NSString *message, NSString *code))callback;
//7.众筹接口添加私募GET
+(void)cfqServerQYAPIaddPlacementRecordWithInput:(NSDictionary *)input Callback:(void(^)(id response, BOOL success, NSString *message, NSString *code))callback;
//8.众筹接口查询私募列表GET
+(void)cfqServerQYAPIgetPlacementRecordListWithInput:(NSDictionary *)input Callback:(void(^)(id response, BOOL success, NSString *message, NSString *code))callback;
//end.行情GET
+(void)cfqServerQYAPIgetHangqingWithInput:(NSDictionary *)input Callback:(void(^)(id response, BOOL success, NSString *message, NSString *code))callback;

////获得用户理财收益开关的状态GET
+(void)cfqServergetManageStatusWithInput:(NSDictionary *)input Callback:(void(^)(id response, BOOL success, NSString *message, NSString *code))callback;
//更改开关状态 传给服务器
+(void)cfqServerQYAPIupdateIncomeStatusWithInput:(NSDictionary *)input Callback:(void(^)(id response, BOOL success, NSString *message, NSString *code))callback;
//理财金额价值必须大于500美金! GET 后台去判断验证
+(void)cfqServerQYAPIcheckManageAmountWithInput:(NSDictionary *)input Callback:(void(^)(id response, BOOL success, NSString *message, NSString *code))callback;
//获取理财本金接口
+(void)cfqServerQYAPIgetUseBalanceByIdWithInput:(NSDictionary *)input Callback:(void(^)(id response, BOOL success, NSString *message, NSString *code))callback;
//app更新接口
+(void)cfqServerQYAPIgetVersionInfoWithInput:(NSDictionary *)input Callback:(void(^)(id response, BOOL success, NSString *message, NSString *code))callback;
+ (void)usdtChaxunyueAdress:(NSString *)adress Callback:(void(^)(NSString *value))callback;

+(void)checkNewBuildCallback:(void(^)(BOOL isUpdate))callback;

//忘记密码
+(void)cfqServerQYAPIchangePwdByQuesWithInput:(NSDictionary *)input Callback:(void(^)(id response, BOOL success, NSString *message, NSString *code))callback;
@end

NS_ASSUME_NONNULL_END
