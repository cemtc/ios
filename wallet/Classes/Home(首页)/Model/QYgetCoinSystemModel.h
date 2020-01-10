//
//  QYgetCoinSystemModel.h
//  wallet
//
//  Created by talking　 on 2019/6/26.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "SKBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface QYgetCoinSystemModel : SKBaseModel
//3.获取汇率

@property (nonatomic, copy) NSString *coinName;
@property (nonatomic, copy) NSString *coinSystemId;
@property (nonatomic, copy) NSString *createId;
@property (nonatomic, copy) NSString *createName;
@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString *ransomPoundage;
@property (nonatomic, copy) NSString *rmgExchageRate;
@property (nonatomic, copy) NSString *systemAddress;
@property (nonatomic, copy) NSString *systemPrivarty;
@property (nonatomic, copy) NSString *tokenExchageRate;
@property (nonatomic, copy) NSString *updateId;
@property (nonatomic, copy) NSString *updateTime;

@end

NS_ASSUME_NONNULL_END
