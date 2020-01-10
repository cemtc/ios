//
//  SKRequestManager.m
//  Business
//
//  Created by talking　 on 2018/8/15.
//  Copyright © 2018年 talking　. All rights reserved.
//

#import "SKRequestManager.h"
#import "NSString+MD5.h"

@interface AFHTTPSessionManager (Shared)

// 设置为单利
+ (instancetype)sharedManager;

@end
@implementation AFHTTPSessionManager (Shared)
+ (instancetype)sharedManager {
    static AFHTTPSessionManager *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [AFHTTPSessionManager manager];
        _instance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/plain", @"text/json", @"text/javascript", @"text/html", nil];
    });
    return _instance;
}
@end



@implementation SKRequestManager

//+ (NSString *)xAccessToken {
//
//    if ([[SKUserInfoManager sharedManager] isLogin]) {
//
//        SKUserInfoModel *userInfoModel = [[SKUserInfoManager sharedManager] currentUserInfo];
//        return userInfoModel.accessToken;
//    }
//    return @"";
//}

+ (void)PUT:(NSString *)URLString parameters:(id)parameters responseSeializerType:(SKResponseSeializerType)type success:(void(^)(id responseObject))success failure:(void(^)(NSURLSessionDataTask * task,NSError *error))failure {
 
    AFHTTPSessionManager *manager = [AFHTTPSessionManager sharedManager];
    
    //    对传入的json 格式 特殊处理！！！！！！！！！start
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
//    [manager.requestSerializer setValue:[self xAccessToken] forHTTPHeaderField:@"accessToken"];
    
    // 如果不是JSON 或者 不是Default 才设置解析器类型
    if (type != SKResponseSeializerTypeJSON && type != SKResponseSeializerTypeDefault) {
        manager.responseSerializer = [self responseSearalizerWithSerilizerType:type];
    }

    [manager PUT:URLString parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 成功
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 失败
        if (failure) {
            failure(task,error);
        }
    }];


}

+ (void)DELETE:(NSString *)URLString parameters:(id)parameters responseSeializerType:(SKResponseSeializerType)type success:(void(^)(id responseObject))success failure:(void(^)(NSURLSessionDataTask * task,NSError *error))failure {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager sharedManager];
    
    //    对传入的json 格式 特殊处理！！！！！！！！！start
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
//    [manager.requestSerializer setValue:[self xAccessToken] forHTTPHeaderField:@"accessToken"];
    
    // 如果不是JSON 或者 不是Default 才设置解析器类型
    if (type != SKResponseSeializerTypeJSON && type != SKResponseSeializerTypeDefault) {
        manager.responseSerializer = [self responseSearalizerWithSerilizerType:type];
    }
    [manager DELETE:URLString parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 成功
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 失败
        if (failure) {
            failure(task,error);
        }
    }];

}



/**
 *  GET请求 By NSURLSession
 *
 
 *  @param URLString  URL
 *  @param parameters 参数
 *  @param type       数据解析器类型
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 */
+ (void)GET:(NSString *)URLString parameters:(id)parameters responseSeializerType:(SKResponseSeializerType)type success:(void(^)(id responseObject))success failure:(void(^)(NSURLSessionDataTask * task,NSError *error))failure {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager sharedManager];
    
    //    对传入的json 格式 特殊处理！！！！！！！！！start
    manager.requestSerializer = [AFJSONRequestSerializer serializer];

    // 请求头的
//    [manager.requestSerializer setValue:[self xAccessToken] forHTTPHeaderField:@"accessToken"];

    // 如果不是JSON 或者 不是Default 才设置解析器类型
    if (type != SKResponseSeializerTypeJSON && type != SKResponseSeializerTypeDefault) {
        manager.responseSerializer = [self responseSearalizerWithSerilizerType:type];
    }
    [manager GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        SKLog(@"talkingGet请求成功：%@ %@",responseObject,task.currentRequest.URL);
        // 成功
        if (success) {
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        SKLog(@"talkingGet请求失败：%@",error);
        // 失败
        if (failure) {
            failure(task,error);
        }
        
    }];

}

/**
 *  POST请求 By NSURLSession
 *
 *  @param URLString  URL
 *  @param parameters 参数
 *  @param type       数据解析器类型
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 */
+ (void)POST:(NSString *)URLString parameters:(id)parameters responseSeializerType:(SKResponseSeializerType)type success:(void(^)(id responseObject))success failure:(void(^)(NSURLSessionDataTask * task,NSError *error))failure {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager sharedManager];
    
    //这里对登录做了特殊处理  如果登录好了之后就把登录判断删除
//    if ([URLString isEqualToString:SKAPI_business_login_Url]) {
//
//        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
//
//    }else{
        //    对传入的json 格式 特殊处理！！！！！！！！！start  raw 和 format区别
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    }
    
    
//    [manager.requestSerializer setValue:[self xAccessToken] forHTTPHeaderField:@"accessToken"];
    
//    if ([URLString isEqualToString:SKAPI_business_token_expire_Url]) {
        // 设置超时时间
//        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
//        manager.requestSerializer.timeoutInterval = 3.f;
//        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
//    }else {
        manager.requestSerializer.timeoutInterval = 12.f;
//    }

    
    // 如果不是JSON 或者 不是Default 才设置解析器类型
    if (type != SKResponseSeializerTypeJSON && type != SKResponseSeializerTypeDefault) {
        manager.responseSerializer = [self responseSearalizerWithSerilizerType:type];
    }
    [manager POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {

        NSData *d = error.userInfo[@"com.alamofire.serialization.response.error.data"];
        NSString *str = [[NSString alloc]initWithData:d encoding:NSUTF8StringEncoding];
        NSLog(@"服务器的错误原因:%@",str);
        // 失败
        if (failure) {
            failure(task,error);
        }
    }];

}

/**
 *  POST请求 上传数据 By NSURLSession
 *
 *  @param URLString  URL
 *  @param parameters 参数
 *  @param type       数据解析器类型
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 */
+ (void)POST:(NSString *)URLString
  parameters:(id)parameters
responseSeializerType:(SKResponseSeializerType)type
constructingBodyWithBlock:(void (^)(id<AFMultipartFormData> formData))block
     success:(void (^)(id responseObject))success
     failure:(void (^)(NSURLSessionDataTask * task,NSError *error))failure {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager sharedManager];
    
    //    对传入的json 格式 特殊处理！！！！！！！！！start
    manager.requestSerializer = [AFJSONRequestSerializer serializer];

//    [manager.requestSerializer setValue:[self xAccessToken] forHTTPHeaderField:@"accessToken"];
    // 如果不是JSON 或者 不是Default 才设置解析器类型
    if (type != SKResponseSeializerTypeJSON && type != SKResponseSeializerTypeDefault) {
        manager.responseSerializer = [self responseSearalizerWithSerilizerType:type];
    }
    [manager POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (block) {
            block(formData);
        }
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(task,error);
        }
    }];
    
}



/**
 *  设置数据解析器类型
 *         请求管理类
 *  数据解析器类型
 */
+ (AFHTTPResponseSerializer *)responseSearalizerWithSerilizerType:(SKResponseSeializerType)serilizerType {
    
    switch (serilizerType) {
            
        case SKResponseSeializerTypeDefault: // default is JSON
            return [AFJSONResponseSerializer serializer];
            break;
            
        case SKResponseSeializerTypeJSON: // JSON
            return [AFJSONResponseSerializer serializer];
            break;
            
        case SKResponseSeializerTypeXML: // XML
            return [AFXMLParserResponseSerializer serializer];
            break;
            
        case SKResponseSeializerTypePlist: // Plist
            return [AFPropertyListResponseSerializer serializer];
            break;
            
        case SKResponseSeializerTypeCompound: // Compound
            return [AFCompoundResponseSerializer serializer];
            break;
            
        case SKResponseSeializerTypeImage: // Image
            return [AFImageResponseSerializer serializer];
            break;
            
        case SKResponseSeializerTypeData: // Data
            return [AFHTTPResponseSerializer serializer];
            break;
            
        default:  // 默认解析器为 JSON解析
            return [AFJSONResponseSerializer serializer];
            break;
    }
}


+ (void)cancelAllRequests {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager sharedManager];
    [manager.operationQueue cancelAllOperations];
    
}


@end
