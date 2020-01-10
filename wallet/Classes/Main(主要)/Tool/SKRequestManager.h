//
//  SKRequestManager.h
//  Business
//
//  Created by talking　 on 2018/8/15.
//  Copyright © 2018年 talking　. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"


/**
 数据解析器类型
 */
typedef NS_ENUM(NSUInteger, SKResponseSeializerType) {
    /**
     *  默认类型 JSON  如果使用这个响应解析器类型,那么请求返回的数据将会是JSON格式
     */
    SKResponseSeializerTypeDefault,
    /**
     *  JSON类型 如果使用这个响应解析器类型,那么请求返回的数据将会是JSON格式
     */
    SKResponseSeializerTypeJSON,
    /*
     *  XML类型 如果使用这个响应解析器类型,那么请求返回的数据将会是XML格式
     */
    SKResponseSeializerTypeXML,
    /**
     *  Plist类型 如果使用这个响应解析器类型,那么请求返回的数据将会是Plist格式
     */
    SKResponseSeializerTypePlist,
    /*
     *  Compound类型 如果使用这个响应解析器类型,那么请求返回的数据将会是Compound格式
     */
    SKResponseSeializerTypeCompound,
    /**
     *  Image类型 如果使用这个响应解析器类型,那么请求返回的数据将会是Image格式
     */
    SKResponseSeializerTypeImage,
    /**
     *  Data类型 如果使用这个响应解析器类型,那么请求返回的数据将会是二进制格式
     */
    SKResponseSeializerTypeData
};



@interface SKRequestManager : NSObject



+ (void)PUT:(NSString *)URLString parameters:(id)parameters responseSeializerType:(SKResponseSeializerType)type success:(void(^)(id responseObject))success failure:(void(^)(NSURLSessionDataTask * task,NSError *error))failure;


+ (void)DELETE:(NSString *)URLString parameters:(id)parameters responseSeializerType:(SKResponseSeializerType)type success:(void(^)(id responseObject))success failure:(void(^)(NSURLSessionDataTask * task,NSError *error))failure;



/**
 *  GET请求 By NSURLSession
 *
 
 *  @param URLString  URL
 *  @param parameters 参数
 *  @param type       数据解析器类型
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 */
+ (void)GET:(NSString *)URLString parameters:(id)parameters responseSeializerType:(SKResponseSeializerType)type success:(void(^)(id responseObject))success failure:(void(^)(NSURLSessionDataTask * task,NSError *error))failure;

/**
 *  POST请求 By NSURLSession
 *
 *  @param URLString  URL
 *  @param parameters 参数
 *  @param type       数据解析器类型
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 */
+ (void)POST:(NSString *)URLString parameters:(id)parameters responseSeializerType:(SKResponseSeializerType)type success:(void(^)(id responseObject))success failure:(void(^)(NSURLSessionDataTask * task,NSError *error))failure;

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
     failure:(void (^)(NSURLSessionDataTask * task,NSError *error))failure;

+ (void)cancelAllRequests;


@end
