//
//  CustomUserModel.h
//  wallet
//
//  Created by 曾云 on 2019/8/18.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "SKBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CustomUserModel : SKBaseModel

@property (nonatomic,strong) NSString *projectName;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *passwrod;
@property (nonatomic,strong) NSString *privateKey;
@property (nonatomic,strong) NSString *serverVerson;

@property (nonatomic,strong) NSString *ethAddress;
@property (nonatomic,strong) NSString *ethMnemonic;


//以太坊
@property (nonatomic,strong) NSString *ZWprojectName;
@property (nonatomic,strong) NSString *ZWname;
@property (nonatomic,strong) NSString *ZWpasswrod;
@property (nonatomic,strong) NSString *ZWprivateKey;
@property (nonatomic,strong) NSString *ZWserverVerson;

@property (nonatomic,strong) NSString *ZWethAddress;
@property (nonatomic,strong) NSString *ZWethMnemonic;


//比特币
@property (nonatomic,strong) NSString *BTCprojectName;
@property (nonatomic,strong) NSString *BTCname;
@property (nonatomic,strong) NSString *BTCpasswrod;
@property (nonatomic,strong) NSString *BTCprivateKey;
@property (nonatomic,strong) NSString *BTCserverVerson;

@property (nonatomic,strong) NSString *BTCethAddress;
@property (nonatomic,strong) NSString *BTCethMnemonic;




@end

NS_ASSUME_NONNULL_END
