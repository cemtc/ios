//
//  CustomHomeModel.h
//  wallet
//
//  Created by 曾云 on 2019/8/18.
//  Copyright © 2019 talking　. All rights reserved.
//


#import "ObjcBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CustomHomeItemModel :ObjcBaseModel

@property (nonatomic,strong) NSString *adress;
@property (nonatomic,strong) NSString *changeAdress;
@property (nonatomic,assign) double balance;
@property (nonatomic,strong) NSString *priviteKey;
@property (nonatomic,strong) NSString *publiceKey;
@property (nonatomic,strong) NSString *mnemonic;
@property (nonatomic,strong) NSString *seedStr;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *imgUrl;
@property (nonatomic,assign) double exchange;


- (instancetype)initWith:(TokenModel *)model;
@end

@interface CustomHomeModel : NSObject

@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *adress;
@property (nonatomic,assign) double balance;

@property (nonatomic,strong) NSMutableArray *dataArray;

- (instancetype)initWith:(ETHWalletModel *)model complete:(void(^)(NSInteger index))completion;

@end

NS_ASSUME_NONNULL_END
