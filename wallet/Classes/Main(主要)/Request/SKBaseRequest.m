//
//  SKBaseRequest.m
//  Business
//
//  Created by talking　 on 2018/8/15.
//  Copyright © 2018年 talking　. All rights reserved.
//

#import "SKBaseRequest.h"
#import "NSNotificationCenter+Addition.h"
#import "SKRequestManager.h"
#import "MJExtension.h"

@implementation SKBaseRequest

#pragma mark - 构造
+ (instancetype)sk_request {
    return [[self alloc] init];
}

+ (instancetype)sk_requestWithUrl:(NSString *)sk_url {
    return [self sk_requestWithUrl:sk_url methodType:SKRequestMethodTypeGET];
}

+ (instancetype)sk_requestWithUrl:(NSString *)sk_url methodType:(SKRequestMethodType)sk_methodType {
    return [self sk_requestWithUrl:sk_url methodType:sk_methodType delegate:nil];
}

+ (instancetype)sk_requestWithUrl:(NSString *)sk_url methodType:(SKRequestMethodType)sk_methodType delegate:(id <SKBaseRequestReponseDelegate>)sk_delegate {
    SKBaseRequest *request = [self sk_request];
    request.sk_url = sk_url;
    request.sk_methodType = sk_methodType;
    request.sk_delegate = sk_delegate;
    return request;
}



#pragma mark - 发送请求
- (void)sk_sendRequest {
    [self sk_sendRequestWithCompletion:nil];
}

- (void)sk_sendRequestWithCompletion:(SKAPIDicCompletion)completion {
    
    // 链接
    NSString *urlStr = self.sk_url;
    if (urlStr.length == 0) return ;
    
    // 参数
    NSDictionary *params = [self params];
    
    // 普通POST请求
    if (self.sk_methodType == SKRequestMethodTypePOST) {
        if (self.sk_imageArray.count == 0) {
            // 开始请求
            [SKRequestManager POST:[SKUtils noWhiteSpaceString:urlStr] parameters:params responseSeializerType:SKResponseSeializerTypeJSON success:^(id responseObject) {
                // 处理数据
                [self handleResponse:responseObject completion:completion];
            } failure:^(NSURLSessionDataTask *task,NSError *error) {
                // 数据请求失败，暂时不做处理
                [self handleErrorTask:task error:error completion:completion];
            }];
        }
        
    } else if(self.sk_methodType == SKRequestMethodTypeGET){ // 普通GET请求
        // 开始请求
        [SKRequestManager GET:[SKUtils noWhiteSpaceString:urlStr] parameters:params responseSeializerType:SKResponseSeializerTypeJSON success:^(id responseObject) {
            NSLog(@"%@ \n %@",self.sk_url,responseObject);
            // 处理数据
            [self handleResponse:responseObject completion:completion];
        } failure:^(NSURLSessionDataTask *task,NSError *error) {
            // 数据请求处理
            [self handleErrorTask:task error:error completion:completion];
            
        }];
    } else if (self.sk_methodType == SKRequestMethodTypePUT){
        
        [SKRequestManager PUT:[SKUtils noWhiteSpaceString:urlStr] parameters:params responseSeializerType:SKResponseSeializerTypeJSON success:^(id responseObject) {
            
            // 处理数据
            [self handleResponse:responseObject completion:completion];
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
            
            [self handleErrorTask:task error:error completion:completion];
            
            
        }];
        
        
    } else if (self.sk_methodType == SKRequestMethodTypeDELETE){
        
        
        [SKRequestManager DELETE:[SKUtils noWhiteSpaceString:urlStr] parameters:params responseSeializerType:SKResponseSeializerTypeJSON success:^(id responseObject) {
            
            // 处理数据
            [self handleResponse:responseObject completion:completion];
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
            
            [self handleErrorTask:task error:error completion:completion];
            
            
        }];
        
        
    }
    
    
    // 上传图片
    if (self.sk_imageArray.count) {
        [SKRequestManager POST:[SKUtils noWhiteSpaceString:urlStr] parameters:params responseSeializerType:SKResponseSeializerTypeJSON constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            NSInteger imgCount = 0;
            for (UIImage *image in self.sk_imageArray) {
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss:SSS";
                NSString *fileName = [NSString stringWithFormat:@"%@%@.png",[formatter stringFromDate:[NSDate date]],@(imgCount)];
                //                [NSString stringWithFormat:@"uploadFile%@",@(imgCount)]
                [formData appendPartWithFileData:UIImagePNGRepresentation(image) name:@"file" fileName:fileName mimeType:@"image/png"];
                imgCount++;
            }
        } success:^(id responseObject) {
            // 处理数据
            [self handleResponse:responseObject completion:completion];
        } failure:^(NSURLSessionDataTask *task,NSError *error) {
            // 数据请求失败，暂时不做处理
            
            [self handleErrorTask:task error:error completion:completion];
            
        }];
    }
}

- (void)handleResponse:(id)responseObject completion:(SKAPIDicCompletion)completion {
    [SVProgressHUD dismiss];
    
    BOOL success = NO;
    if ([self.sk_url isEqualToString:QYAPI_getHangqing_Url]) {
        success = ([[SKUtils getStringFromDicItem:responseObject[@"code"]] isEqualToString:@"200"]) ? YES:NO;
    }else{
        success = ([[SKUtils getStringFromDicItem:responseObject[@"success"]] isEqualToString:SKCODE_SUCCESS]) ? YES:NO;
    }
    
    if (completion) {
        
        NSString *resultRespon = @"data";
        if (self.sk_resultType == SKResultResponTypeDictionary) {
            
            resultRespon = @"data";
        }else if (self.sk_resultType == SKResultResponTypeArray){
            
            resultRespon = @"data";
        }
        
        if (success) {
            
            completion(responseObject[resultRespon], success, responseObject[@"info"], [SKUtils getStringFromDicItem:responseObject[@"code"]]);
            
        }else {

            //如果请求失败了也暂时退出账号去
            if ([responseObject[@"info"] isEqualToString:@"token不存在或已失效"]) {
                [SKGET_APP_DELEGATE exitSign];
            }else {
                completion(responseObject[resultRespon], success, responseObject[@"info"], [SKUtils getStringFromDicItem:responseObject[@"code"]]);
            }
            
        }
        
    } else if (self.sk_delegate) {
        if ([self.sk_delegate respondsToSelector:@selector(requestSuccessReponse:response:message:)]) {
            [self.sk_delegate requestSuccessReponse:success response:responseObject[@"result"] message:responseObject[@"msg"]];
        }
    }
    // 请求成功，发布通知
    [NSNotificationCenter postNotification:SKRequestSuccessNotification];
}

- (void)handleErrorTask:(NSURLSessionDataTask *)task error:(NSError *)error completion:(SKAPIDicCompletion)completion {
    
    [SVProgressHUD dismiss];

    //        NSLog(@"====失败====%@",error.code); // 401 重新登录
    
    NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
    NSInteger sta = [response statusCode];
    
    //在这里加上sta == 500  服务器错误!!!!!

    
    if (sta == 401) {
        
        //把请求错误的返回到前面去  code   也可以自定义code 以后看需求！！！！！！！！！！！！！！！
        completion(nil,NO,@"网络错误",[NSString stringWithFormat:@"%ld",error.code]);
        
        
        //    延时0.02秒 因为在set 里面   等待下
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.02 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^(void){
            NSLog(@"未受权请求请重新登录");
            //            [MBProgressHUD showMessage:@"您的账号已过期，请重新登录" toView:nil];
            
            [MBProgressHUD showSuccess:@"您的账号已过期，请重新登录" toView:nil];
        });
        
        
    }else if (sta == 404) {
        
        NSLog(@"未找到资源");
    }else if (sta == 500){
        
        NSLog(@"这个服务器错误 要进入首页,提示网络错误");
        completion(nil,NO,@"网络错误",[NSString stringWithFormat:@"%ld",error.code]);

        //这个应该是登录失败
//        [MBProgressHUD showError:@"服务器出小差" toView:nil];
        [MBProgressHUD showMessage:@"服务器出小差"];

    }
    else {
        
        
        NSLog(@"talking请求失败:%@",error);
        
        if (error.code == -1009) {
            
            //这个很重要！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！
            //把请求错误的返回到前面去  code   也可以自定义code 以后看需求！！！！！！！！！！！！！！！
            completion(nil,NO,@"您的网络似乎已断开",[NSString stringWithFormat:@"%ld",error.code]);
            
            
//            [MBProgressHUD showMessage:@"您的网络似乎已断开" toView:nil];
            
        } else if (error.code == -1001) {
            
            
            completion(nil,NO,@"网络请求超时，请稍后重试",[NSString stringWithFormat:@"%ld",error.code]);
//            [MBProgressHUD showMessage:@"网络请求超时，请稍后重试" toView:nil];
            
        }else {
            
            completion(nil,NO,@"网络请求错误",[NSString stringWithFormat:@"%ld",error.code]);
        }
        
        
        
    }
    
    
    
}

- (void)exitController {
    
    [UIAlertView alertWithTitle:@"提示" message:@"由于您长时间未使用或在其他设备上登录,如果这不是您的操作,请及时更换密码!" okHandler:^{
        [SKGET_APP_DELEGATE exitSign];
    } cancelHandler:^{
        
    }];
}


// 设置链接
- (void)setSK_url:(NSString *)sk_url {
    if (sk_url.length == 0 || [sk_url isKindOfClass:[NSNull class]]) {
        return ;
    }
    _sk_url = sk_url;
}

- (NSDictionary *)params {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params addEntriesFromDictionary:self.mj_keyValues];
    
    if ([params.allKeys containsObject:@"sk_delegate"]) {
        [params removeObjectForKey:@"sk_delegate"];
    }
    //    if ([params.allKeys containsObject:@"hl_isPost"]) {
    //        [params removeObjectForKey:@"hl_isPost"];
    //    }
    if ([params.allKeys containsObject:@"sk_methodType"]) {
        [params removeObjectForKey:@"sk_methodType"];
    }
    if ([params.allKeys containsObject:@"sk_resultType"]) {
        [params removeObjectForKey:@"sk_resultType"];
    }
    if ([params.allKeys containsObject:@"sk_url"]) {
        [params removeObjectForKey:@"sk_url"];
    }
    if (self.sk_imageArray.count == 0) {
        if ([params.allKeys containsObject:@"sk_imageArray"]) {
            [params removeObjectForKey:@"sk_imageArray"];
        }
    }
    
    NSMutableDictionary *dicccc = [[NSMutableDictionary alloc]init];
    [dicccc addEntriesFromDictionary:params[@"data"]];
    if ([[SKUserInfoManager sharedManager] isLogin]) {
        [dicccc setValue:[self xAccessToken] forKey:@"token"];
        [dicccc setValue:[self xCustomerId] forKey:@"customerId"];
    }
    return dicccc;
}

- (NSString *)xAccessToken {
    
    if ([[SKUserInfoManager sharedManager] isLogin]) {
        
        SKUserInfoModel *userInfoModel = [[SKUserInfoManager sharedManager] currentUserInfo];
        return userInfoModel.token;
    }
    return @"";
}
- (NSString *)xCustomerId {
    
    if ([[SKUserInfoManager sharedManager] isLogin]) {
        
        SKUserInfoModel *userInfoModel = [[SKUserInfoManager sharedManager] currentUserInfo];
        return userInfoModel.customerId;
    }
    return @"";
}



@end
