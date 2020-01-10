//
//  CFQCommonServer.m
//  wallet
//
//  Created by talking　 on 2019/6/27.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "CFQCommonServer.h"
#import "AFNetworking.h"
#import "SKRequestManager.h"
//#import "EthNotificationCenterItemModel.h"

@implementation CFQCommonServer


//通知中心转账通知
/*
 pageNo
 pageSize
 address
 */
+(void)cfqServerQYAPIgetTokenNoticeTransRecordWithInput:(NSDictionary *)input Callback:(void(^)(id response, BOOL success, NSString *message, NSString *code))callback {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:input[@"pageNo"] forKey:@"pageNo"];
    [dict setValue:@(20) forKey:@"pageSize"];
    [dict setValue:input[@"address"] forKey:@"address"];
    // [MBProgressHUD showMessage:message];
    
    [SKRequestManager GET:[SKUtils noWhiteSpaceString:QYAPI_getTokenNoticeTransRecord_Url] parameters:dict responseSeializerType:SKResponseSeializerTypeJSON success:^(id responseObject) {
//        NSLog(@"%@ \n %@"QYAPI_getTokenNoticeTransRecord_Url,responseObject);
        // 处理数据
    } failure:^(NSURLSessionDataTask *task,NSError *error) {
        // 数据请求处理
        
    }];
    
//    SKBaseRequest *request = [SKBaseRequest sk_request];
//    request.sk_url = QYAPI_getTokenNoticeTransRecord_Url;
//    //请求类型
//    request.sk_methodType = SKRequestMethodTypeGET;
//    //接收类型
//    request.sk_resultType = SKResultResponTypeDictionary;
//
//    request.data = dicc;
//    [request sk_sendRequestWithCompletion:^(id response, BOOL success, NSString *message, NSString *code) {
//
//        if (success) {
//            callback(response,success,message,code);
//        }else {
//
//            callback(response,success,message,code);
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                //                [MBProgressHUD showError:message toView:nil];
//                [MBProgressHUD showMessage:message];
//            });
//        }
//
//    }];
    
}

+ (void)getAllETHNoticeTransRecordPage:(NSInteger)page address:(NSString *)address complete:(void(^)(NSMutableArray<CustomNotificationCenterItemModel *> *dataArray,NSString *errMsg))completion {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:@(page) forKey:@"pageNo"];
    [dict setValue:@(20) forKey:@"pageSize"];
    [dict setValue:address forKey:@"address"];
    [SKRequestManager GET:[SKUtils noWhiteSpaceString:QYAPI_getBTCNoticeTransRecord_Url] parameters:dict responseSeializerType:SKResponseSeializerTypeJSON success:^(id responseObject) {
        NSDictionary *dataInfo = responseObject;
        if ([dataInfo objectForKey:@"data"]  != nil && ![[dataInfo objectForKey:@"data"] isEqual:@"<null>"]) {
            id obj = [dataInfo objectForKey:@"data"];
            if (obj && [obj isKindOfClass:[NSArray class]]) {
                NSMutableArray<CustomNotificationCenterItemModel *> *dataArray = [NSMutableArray<CustomNotificationCenterItemModel *> array];
                for (id objc in obj) {
                    if (objc && [objc isKindOfClass:[NSDictionary class]]) {
                        NSLog(@"%@",objc);
                        CustomNotificationCenterItemModel *itemModel = [[CustomNotificationCenterItemModel alloc]initWithDictionary:objc];
                        if ([objc objectForKey:@"type"] != nil) {
                            itemModel.type = [objc objectForKey:@"type"];
                            itemModel.blockhumber = [objc objectForKey:@"blocknumber"];
                            itemModel.blockhash = [objc objectForKey:@"blockhash"];
                            itemModel.cumulativegasused = [objc objectForKey:@"cumulativegasused"];
                            itemModel.fromreadstatus = [objc objectForKey:@"fromreadstatus"];
                            itemModel.toreadstatus = [objc objectForKey:@"toreadstatus"];
                            itemModel.transactionindex = [objc objectForKey:@"transactionindex"];
                            itemModel.kind = [objc objectForKey:@"kind"];
                            itemModel.hashO = [objc objectForKey:@"hash"];
                            itemModel.none = [objc objectForKey:@"none"];
//                            double bol = [[objc objectForKey:@"gasprice"] doubleValue];
//                            itemModel.gasprice = bol;
                            itemModel.outputs = [objc objectForKey:@"outputs"];
                            itemModel.inputs = [objc objectForKey:@"inputs"];
                            itemModel.tos = [objc objectForKey:@"tos"];
                            itemModel.froms = [objc objectForKey:@"froms"];
                            itemModel.fee = [objc objectForKey:@"fee"];
                            itemModel.btc_eth_value = [objc objectForKey:@"value"];
                            itemModel.objc_Identifier = @"Identifier_CustomNotificationCenter";
                            itemModel.objc_Height = 70.0f;
                            itemModel.type1 = CustomNotificationCenterItemType_Transfer;
                            [dataArray addObject:itemModel];
                        }
                     

                    }
                }
                if (completion) {
                    completion (dataArray,nil);
                }
            } else {
                if (completion) {
                    completion (nil,@"服务器数据出错");
                }
            }
            
        }
        
        
    } failure:^(NSURLSessionDataTask *task,NSError *error) {
        // 数据请求处理
        if (completion) {
            completion (nil,error.domain);
        }
        
    }];
}
+ (void)getAllTokenNoticeTransRecordPage:(NSInteger)page address:(NSString *)address complete:(void(^)(NSMutableArray<CustomNotificationCenterItemModel *> *dataArray,NSString *errMsg))completion {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:@(page) forKey:@"pageNo"];
    [dict setValue:@(20) forKey:@"pageSize"];
    [dict setValue:address forKey:@"address"];
    
    [SKRequestManager GET:[SKUtils noWhiteSpaceString:QYAPI_getTokenNoticeTransRecord_Url] parameters:dict responseSeializerType:SKResponseSeializerTypeJSON success:^(id responseObject) {
//        NSLog(@"%@ \n %@",QYAPI_getTokenNoticeTransRecord_Url,responseObject);
        id info = [SKUtils convertJSONToDict:responseObject[@"info"]];
        if (info && [info isKindOfClass:[NSDictionary class]]) {
            NSMutableArray *dataArray = [NSMutableArray array];
            id obj = info[@"obj"];
            if (obj && [obj isKindOfClass:[NSArray class]]) {
                for (id objc in obj) {
                    if (objc && [objc isKindOfClass:[NSDictionary class]]) {
                        NSLog(@"%@",objc);
                        CustomNotificationCenterItemModel *itemModel = [[CustomNotificationCenterItemModel alloc]initWithDictionary:objc];
                        itemModel.objc_Identifier = @"Identifier_CustomNotificationCenter";
                        itemModel.objc_Height = 70.0f;
                        itemModel.type1 = CustomNotificationCenterItemType_Transfer;
                        [dataArray addObject:itemModel];
                    }
                }
                if (completion) {
                    completion (dataArray,nil);
                }
            } else {
                if (completion) {
                    completion (nil,@"服务器数据出错");
                }
            }
        } else {
            if (completion) {
                completion (nil,@"服务器数据出错");
            }
        }
        
        
        
    } failure:^(NSURLSessionDataTask *task,NSError *error) {
        // 数据请求处理
        if (completion) {
            completion (nil,error.domain);
        }
        
    }];
}
+ (void)getBTCNoticeTransRecordPage:(NSInteger)page address:(NSString *)address complete:(void(^)(NSInteger count))completion{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:@(page) forKey:@"pageNo"];
    [dict setValue:@(20) forKey:@"pageSize"];
    [dict setValue:address forKey:@"address"];
    [SKRequestManager GET:[SKUtils noWhiteSpaceString:QYAPI_getBTCNoticeTransRecord_Url] parameters:dict responseSeializerType:SKResponseSeializerTypeJSON success:^(id responseObject) {
        NSDictionary *dataInfo = responseObject;
        if ([dataInfo objectForKey:@"data"] != nil && ![[dataInfo objectForKey:@"data"] isEqual:@"<null>"]) {
            id obj = [dataInfo objectForKey:@"data"];
            NSInteger count = 0;
            CustomUserModel *model = [CustomUserManager customSharedManager].userModel;
            if (obj && [obj isKindOfClass:[NSArray class]]) {
                for (id objc in obj) {
                    if (objc && [objc isKindOfClass:[NSDictionary class]]) {
                        NSLog(@"%@ == %@",objc,model.ethAddress );
                        //lowercaseString
                        id from = objc[@"from"];
                        id fromReadStatus =  objc[@"fromreadstatus"];
                        id toReadStatus =  objc[@"fromreadstatus"];
                        if (from && [from isKindOfClass:[NSString class]]) {
                            if ([[model.ethAddress lowercaseString] isEqualToString:[from lowercaseString]]) {
                                if ([fromReadStatus integerValue] == 0) {
                                    count ++;
                                }
                            } else {
                                if ([toReadStatus integerValue] == 0) {
                                    count ++;
                                }
                            }
                        }
                        
                    }
                }
            }
            if (completion) {
                completion (count);
            }
        }
        
        
        
        
    } failure:^(NSURLSessionDataTask *task,NSError *error) {
        // 数据请求处理
        if (completion) {
            completion (0);
        }
        
    }];
}
+ (void)getTokenNoticeTransRecordPage:(NSInteger)page address:(NSString *)address complete:(void(^)(NSInteger count))completion {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:@(page) forKey:@"pageNo"];
    [dict setValue:@(20) forKey:@"pageSize"];
    [dict setValue:address forKey:@"address"];
   
    [SKRequestManager GET:[SKUtils noWhiteSpaceString:QYAPI_getTokenNoticeTransRecord_Url] parameters:dict responseSeializerType:SKResponseSeializerTypeJSON success:^(id responseObject) {
//         NSLog(@"%@ \n %@",QYAPI_getTokenNoticeTransRecord_Url,responseObject);
        id info = [SKUtils convertJSONToDict:responseObject[@"info"]];
        NSInteger count = 0;
        CustomUserModel *model = [CustomUserManager customSharedManager].userModel;
        if (info && [info isKindOfClass:[NSDictionary class]]) {
            id obj = info[@"obj"];
            if (obj && [obj isKindOfClass:[NSArray class]]) {
                for (id objc in obj) {
                    if (objc && [objc isKindOfClass:[NSDictionary class]]) {
                         NSLog(@"%@ == %@",objc,model.ethAddress );
                        //lowercaseString
                        id from = objc[@"from"];
                        id fromReadStatus =  objc[@"fromReadStatus"];
                        id toReadStatus =  objc[@"toReadStatus"];
                        if (from && [from isKindOfClass:[NSString class]]) {
                            if ([[model.ethAddress lowercaseString] isEqualToString:[from lowercaseString]]) {
                                if ([fromReadStatus integerValue] == 0) {
                                    count ++;
                                }
                            } else {
                                if ([toReadStatus integerValue] == 0) {
                                    count ++;
                                }
                            }
                        }
                        
                    }
                }
            }
        }
        if (completion) {
            completion (count);
        }
        
        
    } failure:^(NSURLSessionDataTask *task,NSError *error) {
        // 数据请求处理
        if (completion) {
            completion (0);
        }
        
    }];
}

    
    
    
    
    //CCM
    + (void)getCcmTransRecordPage:(NSInteger)page address:(NSString *)address complete:(void(^)(NSString *errMsg,NSString *count))completion {
        [SKRequestManager GET:[SKUtils noWhiteSpaceString:QYAPI_getCcmTransRecord_Url] parameters:@{@"pageNo":@(page),@"pageSize":@(20),@"address":address} responseSeializerType:SKResponseSeializerTypeJSON success:^(id responseObject) {
            NSLog(@"%@ \n %@",QYAPI_getCoinSystem_Url,responseObject);
            
            NSInteger  success = [responseObject[@"success"] integerValue];
            if (success) {
                id data = responseObject[@"data"];
                
                
            } else {
                
//                if (completion) {
//                    completion (nil,responseObject[@"info"]);
//                }
            }
            
        } failure:^(NSURLSessionDataTask *task,NSError *error) {
            // 数据请求处理
//            if (completion) {
//                completion (nil,error.domain);
//            }
            
        }];
    }
    //其他
    + (void)getTokenTransRecordPage:(NSInteger)page address:(NSString *)address contractAddress:(NSString *)contractAddress complete:(void(^)(NSString *errMsg))completion {
        [SKRequestManager GET:[SKUtils noWhiteSpaceString:QYAPI_getTokenTransRecord_Url]
                   parameters:@{@"pageNo":@(page),
                                @"pageSize":@(20),
                                @"address":address,
                                @"contractAddress":contractAddress}
        responseSeializerType:SKResponseSeializerTypeJSON
                      success:^(id responseObject) {
            NSLog(@"%@ \n %@",QYAPI_getCoinSystem_Url,responseObject);
            
            NSInteger  success = [responseObject[@"success"] integerValue];
            if (success) {
                id data = responseObject[@"data"];
                
                
            } else {
                
//                if (completion) {
//                    completion (nil,responseObject[@"info"]);
//                }
            }
            
        } failure:^(NSURLSessionDataTask *task,NSError *error) {
            // 数据请求处理
            //            if (completion) {
            //                completion (nil,error.domain);
            //            }
            
        }];
    }

+ (void)updateReadStatusType:(NSString *)type hash:(NSString *)hash complete:(void(^)(NSString *errMsg))completion {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:type forKey:@"type"];
    [dict setValue:hash forKey:@"hash"];
    
    [SKRequestManager GET:[SKUtils noWhiteSpaceString:QYAPI_updateReadStatus_Url] parameters:dict responseSeializerType:SKResponseSeializerTypeJSON success:^(id responseObject) {
        
    } failure:^(NSURLSessionDataTask *task,NSError *error) {
        // 数据请求处理
    }];
}

    

//通知中心 系统消息
+ (void)getNoticeListByPage:(NSInteger)page complete:(void(^)(NSMutableArray<CustomNotificationCenterItemModel *> *dataArray,NSString *errMsg))completion {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:@(page) forKey:@"pageNo"];
    [dict setValue:@(20) forKey:@"pageSize"];
    
    [SKRequestManager GET:[SKUtils noWhiteSpaceString:QYAPI_getNoticeListByPage_Url] parameters:dict responseSeializerType:SKResponseSeializerTypeJSON success:^(id responseObject) {
        NSLog(@"%@ \n %@",QYAPI_getTokenNoticeTransRecord_Url,responseObject);
        
        NSInteger  success = [responseObject[@"success"] integerValue];
        if (success) {
            id data = responseObject[@"data"];
            if (data && [data isKindOfClass:[NSArray class]]) {
                NSMutableArray *dataArray = [NSMutableArray array];
                for (id objc in data) {
                    if (objc && [objc isKindOfClass:[NSDictionary class]]) {
                        NSLog(@"%@",objc);
                        CustomNotificationCenterItemModel *itemModel = [[CustomNotificationCenterItemModel alloc]init];
                        itemModel.objc_Identifier = @"Identifier_CustomNotificationCenter";
                        itemModel.objc_Height = 70.0f;
                        itemModel.type1 = CustomNotificationCenterItemType_System;
                        itemModel.blockHash = [itemModel modelAttribute:objc[@"noticeTitle"] withNullString:kMNullStr];
                        itemModel.hash_K = [itemModel modelAttribute:objc[@"noticeDesc"] withNullString:kMNullStr];
                        itemModel.timestamp = [itemModel modelAttributeInteger:objc[@"createTime"]];
                        [dataArray addObject:itemModel];
                    }
                }
                if (completion) {
                    completion (dataArray,nil);
                }
            } else {
                if (completion) {
                    completion (nil,@"服务器数据出错");
                }
            }
            
        } else {
            
            if (completion) {
                completion (nil,responseObject[@"info"]);
            }
        }

    } failure:^(NSURLSessionDataTask *task,NSError *error) {
        // 数据请求处理
        if (completion) {
            completion (nil,error.domain);
        }
        
    }];
}


+ (void)getCoinSystemComplete:(void(^)(NSMutableArray *dataArray,NSString *errMsg))completion {
    [SKRequestManager GET:[SKUtils noWhiteSpaceString:QYAPI_getCoinSystem_Url] parameters:@{} responseSeializerType:SKResponseSeializerTypeJSON success:^(id responseObject) {
        NSLog(@"%@ \n %@",QYAPI_getCoinSystem_Url,responseObject);
        
        NSInteger  success = [responseObject[@"success"] integerValue];
        if (success) {
            id data = responseObject[@"data"];
            if (data && [data isKindOfClass:[NSArray class]]) {
                if (completion) {
                    completion (data,nil);
                }
            } else {
                if (completion) {
                    completion (nil,@"服务器数据出错");
                }
            }
            
        } else {
            
            if (completion) {
                completion (nil,responseObject[@"info"]);
            }
        }
        
    } failure:^(NSURLSessionDataTask *task,NSError *error) {
        // 数据请求处理
        if (completion) {
            completion (nil,error.domain);
        }
        
    }];
}


//意见反馈
+ (void)cfqServerQYAPIAddFeedback_Name:(NSString *)name
                                mobile:(NSString *)mobile
                                  type:(NSString *)type
                                  text:(NSString *)text
                              complete:(void(^)(NSString *errMsg))completion {
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setValue:name forKey:@"name"];
    [params setValue:mobile forKey:@"mobie"];
    [params setValue:type forKey:@"type"];
    [params setValue:text forKey:@"text"];
    
    [SKRequestManager GET:[SKUtils noWhiteSpaceString:QYAPI_addFeedback_Url]
               parameters:params
    responseSeializerType:SKResponseSeializerTypeJSON
                  success:^(id responseObject) {
        NSLog(@"%@",responseObject);
                      BOOL success = [responseObject[@"success"] boolValue];
                      if (success) {
                          if (completion) {
                              completion(nil);
                          }
                      } else {
                          if (completion) {
                              completion(responseObject[@"info"]);
                          }
                      }
        // 处理数据
    } failure:^(NSURLSessionDataTask *task,NSError *error) {
        // 数据请求处理
        NSLog(@"%@",error.domain);
        if (completion) {
            completion(error.domain);
        }
    }];
}


//登录接口
+(void)cfqServerQYAPIloginWithInput:(NSDictionary *)input Callback:(void(^)(id response, BOOL success, NSString *message, NSString *code))callback{
    
    NSString *mobile = input[@"mobile"];
    NSString *password = input[@"password"];

    
    SKBaseRequest *request = [SKBaseRequest sk_request];
    request.sk_url = QYAPI_login_Url;
    //请求类型
    request.sk_methodType = SKRequestMethodTypePOST;
    //接收类型
    request.sk_resultType = SKResultResponTypeDictionary;
    NSMutableDictionary *dicc = [NSMutableDictionary dictionary];
    [dicc setValue:mobile forKey:@"mobile"];
    [dicc setValue:password forKey:@"password"];

    request.data = dicc;
    [request sk_sendRequestWithCompletion:^(id response, BOOL success, NSString *message, NSString *code) {
        
        if (success) {
            callback(response,success,message,code);
        }else {
            
            callback(response,success,message,code);
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [MBProgressHUD showError:message toView:nil];
                [MBProgressHUD showMessage:message];
            });
        }
        
    }];
}

//3.获取汇率
+(void)cfqServerQYAPIGetCoinSystemWithInput:(NSDictionary *)input Callback:(void(^)(id response, BOOL success, NSString *message, NSString *code))callback{
    
    
    SKBaseRequest *request = [SKBaseRequest sk_request];
    request.sk_url = QYAPI_getCoinSystem_Url;
    //请求类型
    request.sk_methodType = SKRequestMethodTypeGET;
    //接收类型
    request.sk_resultType = SKResultResponTypeDictionary;
//    [MBProgressHUD showMessage:@"正在加载中"];
    [SVProgressHUD show];
    [request sk_sendRequestWithCompletion:^(id response, BOOL success, NSString *message, NSString *code) {
        
        if (success) {
            callback(response,success,message,code);
        }else {
            
            callback(response,success,message,code);
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [MBProgressHUD showError:message toView:nil];
                [MBProgressHUD showMessage:message];

            });
        }
        
    }];
}

//8.systemType类型。1：帮助2：白皮书3：关于我们4：理 财5：赎回
+(void)cfqServerGetSystemHelpByTypeWithInput:(NSDictionary *)input callback:(void(^)(id response, BOOL success, NSString *message, NSString *code))callback{
    
    NSString *systemType = input[@"systemType"];
    
    SKBaseRequest *request = [SKBaseRequest sk_request];
    request.sk_url = QYAPI_getSystemHelpByType_Url;
    //请求类型
    request.sk_methodType = SKRequestMethodTypeGET;
    //接收类型
    request.sk_resultType = SKResultResponTypeDictionary;
    
    NSMutableDictionary *dicc = [NSMutableDictionary dictionary];
    [dicc setValue:systemType forKey:@"systemType"];
    request.data = dicc;
//    [MBProgressHUD showMessage:@"正在加载中"];
    [SVProgressHUD show];

    [request sk_sendRequestWithCompletion:^(id response, BOOL success, NSString *message, NSString *code) {
        
        if (success) {
            callback(response,success,message,code);
        }else {
            
            callback(response,success,message,code);
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [MBProgressHUD showError:message toView:nil];
            });
        }
        
    }];
    

    
}
//4.获取总资产和平台币GET(我的界面)
+(void)cfqServerQYAPIgetPropertyWithInput:(NSDictionary *)input Callback:(void(^)(id response, BOOL success, NSString *message, NSString *code))callback{
    
    
    SKBaseRequest *request = [SKBaseRequest sk_request];
    request.sk_url = QYAPI_getProperty_Url;
    //请求类型
    request.sk_methodType = SKRequestMethodTypeGET;
    //接收类型
    request.sk_resultType = SKResultResponTypeDictionary;
//    [MBProgressHUD showMessage:@"正在加载中"];
    [request sk_sendRequestWithCompletion:^(id response, BOOL success, NSString *message, NSString *code) {
        
        if (success) {
            callback(response,success,message,code);
        }else {
            
            callback(response,success,message,code);
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [MBProgressHUD showError:message toView:nil];
                [MBProgressHUD showMessage:message];

            });
        }
        
    }];
}


//5.公告
+(void)cfqServerQYAPIGetNoticeListByPageWithInput:(NSDictionary *)input Callback:(void(^)(id response, BOOL success, NSString *message, NSString *code))callback{
    
    NSString *pageNo = input[@"pageNo"];
    NSString *pageSize = input[@"pageSize"];

    
    SKBaseRequest *request = [SKBaseRequest sk_request];
    request.sk_url = QYAPI_getNoticeListByPage_Url;
    //请求类型
    request.sk_methodType = SKRequestMethodTypeGET;
    //接收类型
    request.sk_resultType = SKResultResponTypeDictionary;
    
    NSMutableDictionary *dicc = [NSMutableDictionary dictionary];
    [dicc setValue:pageNo forKey:@"pageNo"];
    [dicc setValue:pageSize forKey:@"pageSize"];

    request.data = dicc;
//    [MBProgressHUD showMessage:@"正在加载中"];
    [SVProgressHUD show];

    [request sk_sendRequestWithCompletion:^(id response, BOOL success, NSString *message, NSString *code) {
        
        if (success) {
            callback(response,success,message,code);
        }else {
            
            callback(response,success,message,code);
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [MBProgressHUD showError:message toView:nil];
                [MBProgressHUD showMessage:message];

            });
        }
        
    }];
    
    
    
}
//6.公告
+(void)cfqServerQYAPIInsertNoticeHandleWithInput:(NSDictionary *)input Callback:(void(^)(id response, BOOL success, NSString *message, NSString *code))callback{
    
    NSString *noticeId = input[@"noticeId"];

    
    SKBaseRequest *request = [SKBaseRequest sk_request];
    request.sk_url = QYAPI_insertNoticeHandle_Url;
    //请求类型
    request.sk_methodType = SKRequestMethodTypeGET;
    //接收类型
    request.sk_resultType = SKResultResponTypeDictionary;
    
    NSMutableDictionary *dicc = [NSMutableDictionary dictionary];
    [dicc setValue:noticeId forKey:@"noticeId"];
    request.data = dicc;
//    [MBProgressHUD showMessage:@"正在加载中"];
    [request sk_sendRequestWithCompletion:^(id response, BOOL success, NSString *message, NSString *code) {
        
        if (success) {
            callback(response,success,message,code);
        }else {
            
            callback(response,success,message,code);
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [MBProgressHUD showError:message toView:nil];
                [MBProgressHUD showMessage:message];

            });
        }
        
    }];
}
//7.轮播图//1：理财2：应用
+(void)cfqServerQYAPIGetBannerByTypeWithInput:(NSDictionary *)input Callback:(void(^)(id response, BOOL success, NSString *message, NSString *code))callback{
    
    NSString *bannerType = input[@"bannerType"];

    SKBaseRequest *request = [SKBaseRequest sk_request];
    request.sk_url = QYAPI_getBannerByType_Url;
    //请求类型
    request.sk_methodType = SKRequestMethodTypeGET;
    //接收类型
    request.sk_resultType = SKResultResponTypeDictionary;
    
    NSMutableDictionary *dicc = [NSMutableDictionary dictionary];
    [dicc setValue:bannerType forKey:@"bannerType"];
    request.data = dicc;
//    [MBProgressHUD showMessage:@"正在加载中"];
    [SVProgressHUD show];

    [request sk_sendRequestWithCompletion:^(id response, BOOL success, NSString *message, NSString *code) {
        
        if (success) {
            callback(response,success,message,code);
        }else {
            
            callback(response,success,message,code);
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [MBProgressHUD showError:message toView:nil];
                [MBProgressHUD showMessage:message];

            });
        }
        
    }];
}

//11.我的客服
+(void)cfqServerQYAPIGetCustomListWithInput:(NSDictionary *)input Callback:(void(^)(id response, BOOL success, NSString *message, NSString *code))callback{
    
    
    SKBaseRequest *request = [SKBaseRequest sk_request];
    request.sk_url = QYAPI_getCustomList_Url;
    //请求类型
    request.sk_methodType = SKRequestMethodTypeGET;
    //接收类型
    request.sk_resultType = SKResultResponTypeDictionary;
//    [MBProgressHUD showMessage:@"正在加载中"];
    [SVProgressHUD show];

    [request sk_sendRequestWithCompletion:^(id response, BOOL success, NSString *message, NSString *code) {
        
        if (success) {
            callback(response,success,message,code);
        }else {
            
            callback(response,success,message,code);
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [MBProgressHUD showError:message toView:nil];
                [MBProgressHUD showMessage:message];

            });
        }
        
    }];
}

//14.赎回
+(void)cfqServerQYAPIaddRansomRecordWithInput:(NSDictionary *)input Callback:(void(^)(id response, BOOL success, NSString *message, NSString *code))callback{
    
    NSString *address = input[@"address"];
    NSString *ransomValue = input[@"ransomValue"];
    NSString *coinTypeDesc = input[@"coinTypeDesc"];
    NSString *tradePwd = input[@"tradePwd"];

    
    SKBaseRequest *request = [SKBaseRequest sk_request];
    request.sk_url = QYAPI_addRansomRecord_Url;
    //请求类型
    request.sk_methodType = SKRequestMethodTypePOST;
    //接收类型
    request.sk_resultType = SKResultResponTypeDictionary;
    
    NSMutableDictionary *dicc = [NSMutableDictionary dictionary];
    
    [dicc setValue:address forKey:@"address"];
    [dicc setValue:ransomValue forKey:@"ransomValue"];
    [dicc setValue:coinTypeDesc forKey:@"coinTypeDesc"];
    [dicc setValue:tradePwd forKey:@"tradePwd"];

    
    
    request.data = dicc;
//    [MBProgressHUD showMessage:@"正在加载中"];
    [request sk_sendRequestWithCompletion:^(id response, BOOL success, NSString *message, NSString *code) {
        
        if (success) {
            callback(response,success,message,code);
        }else {
            
            callback(response,success,message,code);
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [MBProgressHUD showError:message toView:nil];
                [MBProgressHUD showMessage:message];

            });
        }
        
    }];
}

//15.赎回记录
+(void)cfqServerQYAPIgetRansomRecordListByPageWithInput:(NSDictionary *)input Callback:(void(^)(id response, BOOL success, NSString *message, NSString *code))callback{
    
    NSString *pageNo = input[@"pageNo"];
    NSString *pageSize = input[@"pageSize"];
    
    SKBaseRequest *request = [SKBaseRequest sk_request];
    request.sk_url = QYAPI_getRansomRecordListByPage_Url;
    //请求类型
    request.sk_methodType = SKRequestMethodTypeGET;
    //接收类型
    request.sk_resultType = SKResultResponTypeDictionary;
    
    NSMutableDictionary *dicc = [NSMutableDictionary dictionary];
    
    [dicc setValue:pageNo forKey:@"pageNo"];
    [dicc setValue:pageSize forKey:@"pageSize"];
    
    
    
    request.data = dicc;
//    [MBProgressHUD showMessage:@"正在加载中"];
    [SVProgressHUD show];

    [request sk_sendRequestWithCompletion:^(id response, BOOL success, NSString *message, NSString *code) {
        
        if (success) {
            callback(response,success,message,code);
        }else {
            
            callback(response,success,message,code);
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [MBProgressHUD showError:message toView:nil];
                [MBProgressHUD showMessage:message];

            });
        }
        
    }];
}
//16.修改密码//密码类型1：登录密码2：交易密码
+(void)cfqServerQYAPIchangePwdWithInput:(NSDictionary *)input Callback:(void(^)(id response, BOOL success, NSString *message, NSString *code))callback{
    
    NSString *oldPwd1 = input[@"oldPwd"];
    NSString *newPwd1 = input[@"newPwd"];
    NSString *type1 = input[@"type"];////密码类型1：登录密码2：交易密码

    SKBaseRequest *request = [SKBaseRequest sk_request];
    request.sk_url = QYAPI_changePwd_Url;
    //请求类型
    request.sk_methodType = SKRequestMethodTypeGET;
    //接收类型
    request.sk_resultType = SKResultResponTypeDictionary;
    
    NSMutableDictionary *dicc = [NSMutableDictionary dictionary];
    
    [dicc setValue:oldPwd1 forKey:@"oldPwd"];
    [dicc setValue:newPwd1 forKey:@"newPwd"];
    [dicc setValue:type1 forKey:@"type"];

    
    
    request.data = dicc;
//    [MBProgressHUD showMessage:@"正在加载中"];
    [SVProgressHUD show];

    [request sk_sendRequestWithCompletion:^(id response, BOOL success, NSString *message, NSString *code) {
        
        if (success) {
            callback(response,success,message,code);
        }else {
            
            callback(response,success,message,code);
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [MBProgressHUD showError:message toView:nil];
                [MBProgressHUD showMessage:message];

            });
        }
        
    }];
}
//17.应用接口
+(void)cfqServerQYAPIgetApplicationListWithInput:(NSDictionary *)input Callback:(void(^)(id response, BOOL success, NSString *message, NSString *code))callback{
    
    
    SKBaseRequest *request = [SKBaseRequest sk_request];
    request.sk_url = QYAPI_getApplicationList_Url;
    //请求类型
    request.sk_methodType = SKRequestMethodTypeGET;
    //接收类型
    request.sk_resultType = SKResultResponTypeDictionary;
//    [MBProgressHUD showMessage:@"正在加载中"];
    [SVProgressHUD show];

    [request sk_sendRequestWithCompletion:^(id response, BOOL success, NSString *message, NSString *code) {
        
        if (success) {
            callback(response,success,message,code);
        }else {
            
            callback(response,success,message,code);
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [MBProgressHUD showError:message toView:nil];
                [MBProgressHUD showMessage:message];

            });
        }
        
    }];
}

//=============================暂时先不做=strat========================
//18.更新接口//1：安卓2：ios
+(void)cfqServerQYAPIQYAPIgetVersionInfo_UrlWithInput:(NSDictionary *)input Callback:(void(^)(id response, BOOL success, NSString *message, NSString *code))callback{
    
    NSString *versionName = input[@"versionName"];//1：安卓2：ios
    NSString *type = @"2";//1：安卓2：ios

    
    
    SKBaseRequest *request = [SKBaseRequest sk_request];
    request.sk_url = QYAPI_getVersionInfo_Url;
    
    //请求类型
    request.sk_methodType = SKRequestMethodTypeGET;
    //接收类型
    request.sk_resultType = SKResultResponTypeDictionary;
    
    NSMutableDictionary *dicc = [NSMutableDictionary dictionary];
    [dicc setValue:versionName forKey:@"versionName"];
    [dicc setValue:type forKey:@"type"];
    NSLog(@"%@",QYAPI_getVersionInfo_Url);
    request.data = dicc;
//    [MBProgressHUD showMessage:@"正在加载中"];
    [SVProgressHUD show];

    [request sk_sendRequestWithCompletion:^(id response, BOOL success, NSString *message, NSString *code) {
        
        if (success) {
            callback(response,success,message,code);
        } else {
            callback(response,success,message,code);
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [MBProgressHUD showError:message toView:nil];
//                [MBProgressHUD showMessage:message];

            });
        }
        
    }];
}
//=============================暂时先不做=end========================

//19.根据币种查询信息
+(void)cfqServerQYAPIQYAPIgetUseBalanceByCoinAndCustomerIdWithInput:(NSDictionary *)input Callback:(void(^)(id response, BOOL success, NSString *message, NSString *code))callback{
    
    NSString *coinName = input[@"coinName"];

    SKBaseRequest *request = [SKBaseRequest sk_request];
    request.sk_url = QYAPI_getUseBalanceByCoinAndCustomerId_Url;
    //请求类型
    request.sk_methodType = SKRequestMethodTypeGET;
    //接收类型
    request.sk_resultType = SKResultResponTypeDictionary;
    
    NSMutableDictionary *dicc = [NSMutableDictionary dictionary];
    [dicc setValue:coinName forKey:@"coinName"];

    request.data = dicc;
//    [MBProgressHUD showMessage:@"正在加载中"];
    [SVProgressHUD show];

    [request sk_sendRequestWithCompletion:^(id response, BOOL success, NSString *message, NSString *code) {
        
        if (success) {
            callback(response,success,message,code);
        }else {
            
            callback(response,success,message,code);
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [MBProgressHUD showError:message toView:nil];
                [MBProgressHUD showMessage:message];

            });
        }
        
    }];
}

//20.    退出登录
+(void)cfqServerQYAPIlogoutWithInput:(NSDictionary *)input Callback:(void(^)(id response, BOOL success, NSString *message, NSString *code))callback{
    
    SKBaseRequest *request = [SKBaseRequest sk_request];
    request.sk_url = QYAPI_logout_Url;
    //请求类型
    request.sk_methodType = SKRequestMethodTypeGET;
    //接收类型
    request.sk_resultType = SKResultResponTypeDictionary;
    
//    [MBProgressHUD showMessage:@"正在加载中"];
    [SVProgressHUD show];

    [request sk_sendRequestWithCompletion:^(id response, BOOL success, NSString *message, NSString *code) {
        
        if (success) {
            callback(response,success,message,code);
        }else {
            
            callback(response,success,message,code);
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [MBProgressHUD showError:message toView:nil];
                [MBProgressHUD showMessage:message];

            });
        }
        
    }];
}

//1. 添加理财记录POST
+(void)cfqServerQYAPIaddManageRecordWithInput:(NSDictionary *)input Callback:(void(^)(id response, BOOL success, NSString *message, NSString *code))callback{
    
    NSString *coinTypeDesc = input[@"coinTypeDesc"];
    NSString *manageMoney = input[@"manageMoney"];
    NSString *tradeHash = input[@"tradeHash"];
    NSString *tradePwd = input[@"tradePwd"];

    
    
    

    
    SKBaseRequest *request = [SKBaseRequest sk_request];
    request.sk_url = QYAPI_addManageRecord_Url;
    //请求类型
    request.sk_methodType = SKRequestMethodTypePOST;
    //接收类型
    request.sk_resultType = SKResultResponTypeDictionary;
    
    NSMutableDictionary *dicc = [NSMutableDictionary dictionary];
    
    [dicc setValue:coinTypeDesc forKey:@"coinTypeDesc"];
    [dicc setValue:manageMoney forKey:@"manageMoney"];
    [dicc setValue:tradeHash forKey:@"tradeHash"];
    [dicc setValue:tradePwd forKey:@"tradePwd"];

    request.data = dicc;
//    [MBProgressHUD showMessage:@"正在加载中"];
    [SVProgressHUD show];

    [request sk_sendRequestWithCompletion:^(id response, BOOL success, NSString *message, NSString *code) {
        
        if (success) {
            callback(response,success,message,code);
        }else {
            
            callback(response,success,message,code);
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [MBProgressHUD showError:message toView:nil];
                [MBProgressHUD showMessage:message];

            });
        }
        
    }];
}
//2.查询理财列表GET
+(void)cfqServerQYAPIgetManageRecordListWithInput:(NSDictionary *)input Callback:(void(^)(id response, BOOL success, NSString *message, NSString *code))callback{
    
    NSString *pageNo = input[@"pageNo"];
    NSString *pageSize = input[@"pageSize"];

    SKBaseRequest *request = [SKBaseRequest sk_request];
    request.sk_url = QYAPI_getManageRecordList_Url;
    //请求类型
    request.sk_methodType = SKRequestMethodTypeGET;
    //接收类型
    request.sk_resultType = SKResultResponTypeDictionary;
//    [MBProgressHUD showMessage:@"正在加载中"];
    [SVProgressHUD show];

    NSMutableDictionary *dicc = [NSMutableDictionary dictionary];
    [dicc setValue:pageNo forKey:@"pageNo"];
    [dicc setValue:pageSize forKey:@"pageSize"];
    request.data = dicc;
    [request sk_sendRequestWithCompletion:^(id response, BOOL success, NSString *message, NSString *code) {
        
        if (success) {
            callback(response,success,message,code);
        }else {
            
            callback(response,success,message,code);
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [MBProgressHUD showError:message toView:nil];
                [MBProgressHUD showMessage:message];

            });
        }
        
    }];
}
////3.查询系统币信息GET
//+(void)cfqServerQYAPIgetCoinSysInfoWithInput:(NSDictionary *)input Callback:(void(^)(id response, BOOL success, NSString *message, NSString *code))callback{
//    
//    
//    SKBaseRequest *request = [SKBaseRequest sk_request];
//    request.sk_url = QYAPI_getCoinSysInfo_Url;
//    //请求类型
//    request.sk_methodType = SKRequestMethodTypeGET;
//    //接收类型
//    request.sk_resultType = SKResultResponTypeDictionary;
//    [MBProgressHUD showMessage:@"正在加载中"];
//    [request sk_sendRequestWithCompletion:^(id response, BOOL success, NSString *message, NSString *code) {
//        
//        if (success) {
//            callback(response,success,message,code);
//        }else {
//            
//            callback(response,success,message,code);
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [MBProgressHUD showError:message toView:nil];
//            });
//        }
//        
//    }];
//}
//4.验证交易密码GET
+(void)cfqServerQYAPIQYAPIcheckTradePwdWithInput:(NSDictionary *)input Callback:(void(^)(id response, BOOL success, NSString *message, NSString *code))callback{
    
    NSString *tradePwd = input[@"tradePwd"];
    
    SKBaseRequest *request = [SKBaseRequest sk_request];
    request.sk_url = QYAPI_checkTradePwd_Url;
    //请求类型
    request.sk_methodType = SKRequestMethodTypeGET;
    //接收类型
    request.sk_resultType = SKResultResponTypeDictionary;
    
    NSMutableDictionary *dicc = [NSMutableDictionary dictionary];
    [dicc setValue:tradePwd forKey:@"tradePwd"];
    
    request.data = dicc;
//    [MBProgressHUD showMessage:@"正在加载中"];
    [SVProgressHUD show];

    [request sk_sendRequestWithCompletion:^(id response, BOOL success, NSString *message, NSString *code) {
        
        if (success) {
            callback(response,success,message,code);
        }else {
            
            callback(response,success,message,code);
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [MBProgressHUD showError:message toView:nil];
                [MBProgressHUD showMessage:message];

            });
        }
        
    }];
}
//5.理财收益记录GET
+(void)cfqServerQYAPIgetManageIncordListWithInput:(NSDictionary *)input Callback:(void(^)(id response, BOOL success, NSString *message, NSString *code))callback{
    
    NSString *pageNo = input[@"pageNo"];
    NSString *pageSize = input[@"pageSize"];
    
    SKBaseRequest *request = [SKBaseRequest sk_request];
    request.sk_url = QYAPI_getManageIncordList_Url;
    //请求类型
    request.sk_methodType = SKRequestMethodTypeGET;
    //接收类型
    request.sk_resultType = SKResultResponTypeDictionary;
//    [MBProgressHUD showMessage:@"正在加载中"];
    [SVProgressHUD show];

    NSMutableDictionary *dicc = [NSMutableDictionary dictionary];
    [dicc setValue:pageNo forKey:@"pageNo"];
    [dicc setValue:pageSize forKey:@"pageSize"];
    request.data = dicc;
    [request sk_sendRequestWithCompletion:^(id response, BOOL success, NSString *message, NSString *code) {
        
        if (success) {
            callback(response,success,message,code);
        }else {
            
            callback(response,success,message,code);
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [MBProgressHUD showError:message toView:nil];
                [MBProgressHUD showMessage:message];

            });
        }
        
    }];
}
//5.1理财收益记录GET
+(void)cfqServerQYAPIgetAllIncomeWithInput:(NSDictionary *)input Callback:(void(^)(id response, BOOL success, NSString *message, NSString *code))callback{
    
    SKBaseRequest *request = [SKBaseRequest sk_request];
    request.sk_url = QYAPI_getAllIncome_Url;
    //请求类型
    request.sk_methodType = SKRequestMethodTypeGET;
    //接收类型
    request.sk_resultType = SKResultResponTypeDictionary;
//    [MBProgressHUD showMessage:@"正在加载中"];
    [SVProgressHUD show];

    [request sk_sendRequestWithCompletion:^(id response, BOOL success, NSString *message, NSString *code) {
        
        if (success) {
            callback(response,success,message,code);
        }else {
            
            callback(response,success,message,code);
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [MBProgressHUD showError:message toView:nil];
                [MBProgressHUD showMessage:message];

            });
        }
        
    }];
}


//6.糖果GET
+(void)cfqServerQYAPIgetCustomerAwardListWithInput:(NSDictionary *)input Callback:(void(^)(id response, BOOL success, NSString *message, NSString *code))callback{
    
    NSString *pageNo = input[@"pageNo"];
    NSString *pageSize = input[@"pageSize"];
    
    SKBaseRequest *request = [SKBaseRequest sk_request];
    request.sk_url = QYAPI_getCustomerAwardList_Url;
    //请求类型
    request.sk_methodType = SKRequestMethodTypeGET;
    //接收类型
    request.sk_resultType = SKResultResponTypeDictionary;
//    [MBProgressHUD showMessage:@"正在加载中"];
    [SVProgressHUD show];

    NSMutableDictionary *dicc = [NSMutableDictionary dictionary];
    [dicc setValue:pageNo forKey:@"pageNo"];
    [dicc setValue:pageSize forKey:@"pageSize"];
    request.data = dicc;
    [request sk_sendRequestWithCompletion:^(id response, BOOL success, NSString *message, NSString *code) {
        
        if (success) {
            callback(response,success,message,code);
        }else {
            
            callback(response,success,message,code);
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [MBProgressHUD showError:message toView:nil];
                [MBProgressHUD showMessage:message];

            });
        }
        
    }];
}
//7.众筹接口添加私募POST
+(void)cfqServerQYAPIaddPlacementRecordWithInput:(NSDictionary *)input Callback:(void(^)(id response, BOOL success, NSString *message, NSString *code))callback{
    
    NSString *placementValue = input[@"placementValue"];
    NSString *coinTypeDesc = input[@"coinTypeDesc"];
    NSString *tradePwd = input[@"tradePwd"];
    NSString *tradeHash = input[@"tradeHash"];

    

    SKBaseRequest *request = [SKBaseRequest sk_request];
    request.sk_url = QYAPI_addPlacementRecord_Url;
    //请求类型
    request.sk_methodType = SKRequestMethodTypePOST;
    //接收类型
    request.sk_resultType = SKResultResponTypeDictionary;
//    [MBProgressHUD showMessage:@"正在加载中"];
    [SVProgressHUD show];

    NSMutableDictionary *dicc = [NSMutableDictionary dictionary];
    [dicc setValue:placementValue forKey:@"placementValue"];
    [dicc setValue:coinTypeDesc forKey:@"coinTypeDesc"];
    [dicc setValue:tradePwd forKey:@"tradePwd"];
    [dicc setValue:tradeHash forKey:@"tradeHash"];


    request.data = dicc;
    [request sk_sendRequestWithCompletion:^(id response, BOOL success, NSString *message, NSString *code) {
        
        if (success) {
            callback(response,success,message,code);
        }else {
            
            callback(response,success,message,code);
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [MBProgressHUD showError:message toView:nil];
                [MBProgressHUD showMessage:message];

            });
        }
        
    }];
}
//8.众筹接口查询私募列表GET
+(void)cfqServerQYAPIgetPlacementRecordListWithInput:(NSDictionary *)input Callback:(void(^)(id response, BOOL success, NSString *message, NSString *code))callback{
    
    NSString *pageNo = input[@"pageNo"];
    NSString *pageSize = input[@"pageSize"];

    
    SKBaseRequest *request = [SKBaseRequest sk_request];
    request.sk_url = QYAPI_getPlacementRecordList_Url;
    //请求类型
    request.sk_methodType = SKRequestMethodTypeGET;
    //接收类型
    request.sk_resultType = SKResultResponTypeDictionary;
//    [MBProgressHUD showMessage:@"正在加载中"];
    [SVProgressHUD show];

    NSMutableDictionary *dicc = [NSMutableDictionary dictionary];
    [dicc setValue:pageNo forKey:@"pageNo"];
    [dicc setValue:pageSize forKey:@"pageSize"];
    request.data = dicc;
    [request sk_sendRequestWithCompletion:^(id response, BOOL success, NSString *message, NSString *code) {
        
        if (success) {
            callback(response,success,message,code);
        }else {
            
            callback(response,success,message,code);
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [MBProgressHUD showError:message toView:nil];
                [MBProgressHUD showMessage:message];

            });
        }
        
    }];
}
//end.行情GET
+(void)cfqServerQYAPIgetHangqingWithInput:(NSDictionary *)input Callback:(void(^)(id response, BOOL success, NSString *message, NSString *code))callback{
    
    SKBaseRequest *request = [SKBaseRequest sk_request];
    request.sk_url = QYAPI_getHangqing_Url;
    //请求类型
    request.sk_methodType = SKRequestMethodTypeGET;
    //接收类型
    request.sk_resultType = SKResultResponTypeDictionary;
//    [MBProgressHUD showMessage:@"正在加载中"];
    NSMutableDictionary *dicc = [NSMutableDictionary dictionary];
    request.data = dicc;
    [request sk_sendRequestWithCompletion:^(id response, BOOL success, NSString *message, NSString *code) {
        
        if (success) {
            callback(response,success,message,code);
        }else {
            
            callback(response,success,message,code);
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [MBProgressHUD showError:message toView:nil];
                [MBProgressHUD showMessage:message];

            });
        }
        
    }];
}

//new 理财
//获得用户理财收益开关的状态
+(void)cfqServergetManageStatusWithInput:(NSDictionary *)input Callback:(void(^)(id response, BOOL success, NSString *message, NSString *code))callback{
    
    
    SKBaseRequest *request = [SKBaseRequest sk_request];
    request.sk_url = QYAPI_getManageStatus_Url;
    //请求类型
    request.sk_methodType = SKRequestMethodTypeGET;
    //接收类型
    request.sk_resultType = SKResultResponTypeDictionary;
//    [MBProgressHUD showMessage:@"正在加载中"];
    [SVProgressHUD show];

    [request sk_sendRequestWithCompletion:^(id response, BOOL success, NSString *message, NSString *code) {
        
        if (success) {
            callback(response,success,message,code);
        }else {
            
            callback(response,success,message,code);
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [MBProgressHUD showError:message toView:nil];
                [MBProgressHUD showMessage:message];

            });
        }
        
    }];
}

//更改开关状态 传给服务器
+(void)cfqServerQYAPIupdateIncomeStatusWithInput:(NSDictionary *)input Callback:(void(^)(id response, BOOL success, NSString *message, NSString *code))callback{
    
    NSString *flag = input[@"flag"];
    
    
    SKBaseRequest *request = [SKBaseRequest sk_request];
    request.sk_url = QYAPI_updateIncomeStatus_Url;
    //请求类型
    request.sk_methodType = SKRequestMethodTypeGET;
    //接收类型
    request.sk_resultType = SKResultResponTypeDictionary;
//    [MBProgressHUD showMessage:@"正在加载中"];
    [SVProgressHUD show];

    NSMutableDictionary *dicc = [NSMutableDictionary dictionary];
    [dicc setValue:flag forKey:@"flag"];
    request.data = dicc;
    [request sk_sendRequestWithCompletion:^(id response, BOOL success, NSString *message, NSString *code) {
        
        if (success) {
            callback(response,success,message,code);
        }else {
            
            callback(response,success,message,code);
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [MBProgressHUD showError:message toView:nil];
                [MBProgressHUD showMessage:message];

            });
        }
        
    }];
}
//理财金额价值必须大于500美金! GET 后台去判断验证
+(void)cfqServerQYAPIcheckManageAmountWithInput:(NSDictionary *)input Callback:(void(^)(id response, BOOL success, NSString *message, NSString *code))callback{
    
    NSString *coinTypeDesc = input[@"coinTypeDesc"];
    NSString *amount = input[@"amount"];

    
    SKBaseRequest *request = [SKBaseRequest sk_request];
    request.sk_url = QYAPI_checkManageAmount_Url;
    //请求类型
    request.sk_methodType = SKRequestMethodTypeGET;
    //接收类型
    request.sk_resultType = SKResultResponTypeDictionary;
//    [MBProgressHUD showMessage:@"正在加载中"];
    [SVProgressHUD show];

    NSMutableDictionary *dicc = [NSMutableDictionary dictionary];
    [dicc setValue:coinTypeDesc forKey:@"coinTypeDesc"];
    [dicc setValue:amount forKey:@"amount"];

    request.data = dicc;
    [request sk_sendRequestWithCompletion:^(id response, BOOL success, NSString *message, NSString *code) {
        
        if (success) {
            callback(response,success,message,code);
        }else {
            
            callback(response,success,message,code);
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [MBProgressHUD showError:message toView:nil];
                [MBProgressHUD showMessage:message];

            });
        }
        
    }];
}
//获取理财本金接口
+(void)cfqServerQYAPIgetUseBalanceByIdWithInput:(NSDictionary *)input Callback:(void(^)(id response, BOOL success, NSString *message, NSString *code))callback{
    
    
    SKBaseRequest *request = [SKBaseRequest sk_request];
    request.sk_url = QYAPI_getUseBalanceById_Url;
    //请求类型
    request.sk_methodType = SKRequestMethodTypeGET;
    //接收类型
    request.sk_resultType = SKResultResponTypeDictionary;
//    [MBProgressHUD showMessage:@"正在加载中"];
    [SVProgressHUD show];

    [request sk_sendRequestWithCompletion:^(id response, BOOL success, NSString *message, NSString *code) {
        
        if (success) {
            callback(response,success,message,code);
        }else {
            
            callback(response,success,message,code);
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [MBProgressHUD showError:message toView:nil];
                [MBProgressHUD showMessage:message];

            });
        }
        
    }];
}
//app更新接口
+(void)cfqServerQYAPIgetVersionInfoWithInput:(NSDictionary *)input Callback:(void(^)(id response, BOOL success, NSString *message, NSString *code))callback{
    
    NSString *versionName = input[@"versionName"];
    NSString *type = input[@"type"];

    SKBaseRequest *request = [SKBaseRequest sk_request];
    request.sk_url = QYAPI_getVersionInfo_Url;
    //请求类型
    request.sk_methodType = SKRequestMethodTypeGET;
    //接收类型
    request.sk_resultType = SKResultResponTypeDictionary;
    NSMutableDictionary *dicc = [NSMutableDictionary dictionary];
    [dicc setValue:versionName forKey:@"versionName"];
    [dicc setValue:type forKey:@"type"];

    
    request.data = dicc;
    [request sk_sendRequestWithCompletion:^(id response, BOOL success, NSString *message, NSString *code) {
        
        if (success) {
            callback(response,success,message,code);
        }else {
            
            callback(response,success,message,code);
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [MBProgressHUD showError:message toView:nil];
//            });
        }
        
    }];
}

+ (void)usdtChaxunyueAdress:(NSString *)adress Callback:(void(^)(NSString *value))callback{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    
    //这里对登录做了特殊处理  如果登录好了之后就把登录判断删除
    //    if ([URLString isEqualToString:SKAPI_business_login_Url]) {
    //
    //        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    //
    //    }else{
    //    对传入的json 格式 特殊处理！！！！！！！！！start  raw 和 format区别
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    //    }
    
    [manager.requestSerializer setValue:@"Basic b21uaWNvcmU6ZjZ2aDEzdzZJVWdlTmhxMUdHMUk=" forHTTPHeaderField:@"Authorization"];
    
    //上面的可以换成这个  这个是后台给我提供的用户名和密码 不是用户的密码下面是错误的 问后台要
    //    [manager.requestSerializer setAuthorizationHeaderFieldWithUsername:[SKUserInfoManager sharedManager].currentUserInfo.mobile password:MD532(@"123456")];

    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//

    //    [manager.requestSerializer setValue:[self xAccessToken] forHTTPHeaderField:@"accessToken"];
    
    //    if ([URLString isEqualToString:SKAPI_business_token_expire_Url]) {
    // 设置超时时间
    //        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    //        manager.requestSerializer.timeoutInterval = 3.f;
    //        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    //    }else {
    manager.requestSerializer.timeoutInterval = 12.f;
    //    }
//
//    {
//        "method":"omni_getbalance",
//        "id":"1563378260704",
//        "jsonrpc":"2.0",
//        "params":[
//                  "1CNKArGWupyLktzkWKYdnZAH3W5Z5g5giD",
//                  31
//                  ]
//    }
//    NSDictionary *dic = @{@"method":@"omni_getbalance",@"id":@"1563378260704",@"jsonrpc":@"2.0",@"params":@[@"1CNKArGWupyLktzkWKYdnZAH3W5Z5g5giD",@"31"]};
    
    
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:@"omni_getbalance" forKey:@"method"]; //分页
    [dic setValue:@"1563378260704" forKey:@"id"]; //分页
    [dic setValue:@"2.0" forKey:@"jsonrpc"]; //分页
    [dic setValue:@[adress,@31] forKey:@"params"]; //分页
    
    
    
    
    
    [manager POST:@"http://47.90.21.32:8888" parameters:dic progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSString *outNumber = @"";
        NSString *usdtBalance = responseObject[@"result"][@"balance"];
        if (usdtBalance.length > 0) {
            outNumber = [NSString stringWithFormat:@"%@",@(usdtBalance.floatValue)];
        }
        callback(outNumber);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        callback(@"");
        NSData *d = error.userInfo[@"com.alamofire.serialization.response.error.data"];
        NSString *str = [[NSString alloc]initWithData:d encoding:NSUTF8StringEncoding];
        NSLog(@"服务器的错误原因:%@",str);

    }];

}

#pragma mark 检测是否有新版本,只有测试的才有
#define kFirIMAutoLoad          @"http://api.fir.im/apps/latest/5d2408fdf94548110a51aea1?api_token=c72843048fd9288a481e2e5fc1d81a02"//fir.im自动检测更新
+(void)checkNewBuildCallback:(void(^)(BOOL isUpdate))callback{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSDictionary* infoDic = [[NSBundle mainBundle] infoDictionary];
        
        
        NSURL* url = [NSURL URLWithString:kFirIMAutoLoad];
        NSString* checkStr = [[NSString alloc] initWithContentsOfURL:url
                                                            encoding:NSUTF8StringEncoding
                                                               error:nil];
        
        if(checkStr.length>50){
            NSDictionary* dic = [self convertJSONToDict:checkStr];
            if(dic[@"build"]){
                NSString *build = [self getStringFromDicItem:dic[@"build"]];
                
                NSString* oldBuild = [infoDic objectForKey:@"CFBundleVersion"];
                
                if(![oldBuild isEqualToString:build]){
                    callback(YES);
                }else{
                    callback(NO);
                }
            }
        }
    });
}

/**
 *  json解析
 *
 */
+ (NSDictionary *)convertJSONToDict:(NSString *)string
{
    NSError *error = nil;
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    if (!data || data == nil) {
        return nil;
    }
    NSDictionary *respDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
    if (nil == error){
        return respDict;
    }else{
        return nil;
    }
}

+ (NSString*)getStringFromDicItem:(id)obj//从字典取字符串
{
    if(!obj || [obj isKindOfClass:[NSNull class]]){
        return @"";
    }
    if([obj isKindOfClass:[NSDictionary class]]||[obj isKindOfClass:[NSArray class]]){return @"";}
    if([obj isKindOfClass:[NSString class]])return obj;
    if([obj isKindOfClass:[NSNumber class]])return [NSString stringWithFormat:@"%@",obj];
    return [NSString stringWithFormat:@"%@",obj];
}




//忘记密码
+(void)cfqServerQYAPIchangePwdByQuesWithInput:(NSDictionary *)input Callback:(void(^)(id response, BOOL success, NSString *message, NSString *code))callback{
    
    NSString *mobile = input[@"mobile"];
    NSString *newPwd = input[@"newPwd"];
    NSString *newTradePwd = input[@"newTradePwd"];
    NSString *quesTion = input[@"quesTion"];
    NSString *answer = input[@"answer"];

    
    SKBaseRequest *request = [SKBaseRequest sk_request];
    request.sk_url = QYAPI_changePwdByQues_Url;
    //请求类型
    request.sk_methodType = SKRequestMethodTypeGET;
    //接收类型
    request.sk_resultType = SKResultResponTypeDictionary;
    //    [MBProgressHUD showMessage:@"正在加载中"];
    [SVProgressHUD show];
    
    NSMutableDictionary *dicc = [NSMutableDictionary dictionary];
    [dicc setValue:mobile forKey:@"mobile"];
    [dicc setValue:newPwd forKey:@"newPwd"];
    [dicc setValue:newTradePwd forKey:@"newTradePwd"];
    [dicc setValue:quesTion forKey:@"quesTion"];
    [dicc setValue:answer forKey:@"answer"];

    request.data = dicc;
    [request sk_sendRequestWithCompletion:^(id response, BOOL success, NSString *message, NSString *code) {
        
        if (success) {
            callback(response,success,message,code);
        }else {
            
            callback(response,success,message,code);
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                //                [MBProgressHUD showError:message toView:nil];
                [MBProgressHUD showMessage:message];
                
            });
        }
        
    }];
}

@end

