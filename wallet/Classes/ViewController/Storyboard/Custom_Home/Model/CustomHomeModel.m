//
//  CustomHomeModel.m
//  wallet
//
//  Created by 曾云 on 2019/8/18.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "CustomHomeModel.h"

@implementation CustomHomeItemModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.objc_Height = 60.0;
        self.objc_Identifier = @"Identifier_CustomHome";
    }
    return self;
}

- (instancetype)initWith:(TokenModel *)model {
    self = [self init];
    if (self) {
        self.name = model.name;
        self.adress = model.adress;
        self.changeAdress = model.changeAdress;
        self.priviteKey = model.priviteKey;
        self.publiceKey = model.publiceKey;
        self.mnemonic = model.mnemonic;
        self.seedStr = model.seedStr;
        self.exchange = model.exchange;
        self.balance = model.balance;
        self.imgUrl = model.imgUrl;
    }
    return self;
}

@end

@implementation CustomHomeModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        _name = @"";
        _adress = @"";
        _balance = 0;
        _dataArray = [NSMutableArray array];
    }
    return self;
}

- (instancetype)initWith:(ETHWalletModel *)model complete:(void(^)(NSInteger index))completion
{
    self = [self init];
    if (self) {
        [self.dataArray removeAllObjects];
        self.name = model.name;
        self.adress = model.adress;
        self.balance = model.balance;
        NSInteger count = 0;
        
        CustomHomeItemModel *ccm = [[CustomHomeItemModel alloc]init];
        ccm.name = model.name;
        ccm.adress = model.adress;
        ccm.priviteKey = model.priviteKey;
        ccm.publiceKey = model.publiceKey;
        ccm.mnemonic = model.mnemonic;
        ccm.seedStr = model.seedStr;
        ccm.exchange = model.exchange;
        ccm.balance = model.balance;
        ccm.imgUrl = model.imgurl;
        [[RLMRealm defaultRealm] beginWriteTransaction];
        //ccm  还是eth   修改这里  就可以啦
        //ccm.balance = [CustomWallet getETHRequestWalletBalanceWithType:@"ETH"];
        ccm.balance = [CustomWallet getETHRequestWalletBalanceWithType:@"EMTC"];
        [[RLMRealm defaultRealm] commitWriteTransaction];
        
       
        NSLog(@"CustomHomeItemModel == %f",ccm.balance);
        [self.dataArray addObject:ccm];
        for (TokenModel *token in [model getToken]) {
            count ++;
            CustomHomeItemModel *item = [[CustomHomeItemModel alloc]initWith:token];
            [[RLMRealm defaultRealm] beginWriteTransaction];
            item.balance= [CustomWallet getRequestWalletBalabceWithContract:token.seedStr];
            NSLog(@"TokenModel == %f",item.balance);
            [[RLMRealm defaultRealm] commitWriteTransaction];
            [self.dataArray addObject:item];
        }
        if (completion) {
            completion (0);
        }
        
    }
    return self;
}
@end
