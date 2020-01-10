//
//  SKUserInfoModel.h
//  Business
//
//  Created by talking　 on 2018/8/15.
//  Copyright © 2018年 talking　. All rights reserved.
//

#import "SKBaseModel.h"

@class UserModel;
@interface SKUserInfoModel : SKBaseModel


@property (nonatomic, copy) NSString *customerId;//用户ID
@property (nonatomic, copy) NSString *mobile;//手机号
//用户当前手机号在本地数据库的位置  默认为0
@property (nonatomic, copy) NSString *indexString;


@property (nonatomic, copy) NSString *token;//token
@property (nonatomic, copy) NSString *customerName;//token

@property (nonatomic, copy) NSString *myCode;//我的邀请码

@end

