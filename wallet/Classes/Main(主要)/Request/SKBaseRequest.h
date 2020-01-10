//
//  SKBaseRequest.h
//  Business
//
//  Created by talking　 on 2018/8/15.
//  Copyright © 2018年 talking　. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SKBaseRequestReponseDelegate <NSObject>
@required
/** 如果不用block返回数据的话，这个方法必须实现*/
- (void)requestSuccessReponse:(BOOL)success response:(id)response message:(NSString *)message;
@end

typedef void(^SKAPIDicCompletion)(id response, BOOL success, NSString *message, NSString *code);


@interface SKBaseRequest : NSObject


@property (nonatomic, weak) id <SKBaseRequestReponseDelegate> sk_delegate;
/** 链接*/
@property (nonatomic, copy) NSString *sk_url;
/** 默认GET*/
//@property (nonatomic, assign) BOOL hl_isPost;

@property (nonatomic, assign) SKRequestMethodType sk_methodType;

//请求数据result 的返回类型
@property (nonatomic, assign) SKResultResponType sk_resultType;

/** 图片数组*/
@property (nonatomic, strong) NSArray <UIImage *>*sk_imageArray;

/** 构造方法*/
+ (instancetype)sk_request;
+ (instancetype)sk_requestWithUrl:(NSString *)sk_url;
+ (instancetype)sk_requestWithUrl:(NSString *)sk_url methodType:(SKRequestMethodType)sk_methodType;
+ (instancetype)sk_requestWithUrl:(NSString *)sk_url methodType:(SKRequestMethodType)sk_methodType delegate:(id <SKBaseRequestReponseDelegate>)sk_delegate;

/** 开始请求，如果设置了代理，不需要block回调*/
- (void)sk_sendRequest;
/** 开始请求，没有设置代理，或者设置了代理，需要block回调，block回调优先级高于代理*/
- (void)sk_sendRequestWithCompletion:(SKAPIDicCompletion)completion;


@property (nonatomic, copy) NSDictionary *data;

@end
