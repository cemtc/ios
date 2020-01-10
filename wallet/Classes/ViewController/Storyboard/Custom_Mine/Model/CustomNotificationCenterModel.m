//
//  CustomNotificationCenterModel.m
//  wallet
//
//  Created by 曾云 on 2019/8/21.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "CustomNotificationCenterModel.h"

@implementation CustomNotificationCenterItemModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _type1 = CustomNotificationCenterItemType_Transfer;
        _blockHash = @"";
        _blockNumber = 0;
        _contract = 0;
        _cumulativeGasUsed = 0;
        _from = @"";
        _fromReadStatus = 0;
        _gas = 0;
        _gasPrice = 0;
        _gasUsed = 0;
        _hash_K = @"";
        _input = @"";
        _nonce = 0;
        _realAddress = @"";
        _realValue = 0;
        _removed = NO;
        _status = @"";
        _timestamp = 0;
        _to = @"";
        _toReadStatus = 0;
        _tokenName = @"";
        _topics = [NSArray array];
        _transactionIndex = 0;
        _v = 0;
        _value = 0;
        _btc_eth_value = @"0";
        
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [self init];
    if (self) {
        _blockHash = [self modelAttribute:dict[@"blockHash"] withNullString:kMNullStr];
        _blockNumber = [self modelAttributeInteger:dict[@"blockNumber"]];
        _contract = [self modelAttributeInteger:dict[@"contract"]];;
        _cumulativeGasUsed = [self modelAttributeInteger:dict[@"cumulativeGasUsed"]];;
        _from =  [self modelAttribute:dict[@"from"] withNullString:kMNullStr];;
        _fromReadStatus = [self modelAttributeInteger:dict[@"fromReadStatus"]];;
        _gas = [self modelAttributeInteger:dict[@"gas"]];;
        _gasPrice = [self modelAttributeInteger:dict[@"gasPrice"]];;
        _gasUsed = [self modelAttributeInteger:dict[@"gasUsed"]];;
        _hash_K = [self modelAttribute:dict[@"hash"] withNullString:kMNullStr];
        _input =  [self modelAttribute:dict[@"input"] withNullString:kMNullStr];;
        _nonce = [self modelAttributeInteger:dict[@"nonce"]];;
        _realAddress =  [self modelAttribute:dict[@"realAddress"] withNullString:kMNullStr];;
        _realValue = [self modelAttributeDouble:dict[@"realValue"]];;
        _removed = [self modelAttributeBool:dict[@"removed"]];
        _status =  [self modelAttribute:dict[@"status"] withNullString:kMNullStr];;
        _timestamp = [self modelAttributeInteger:dict[@"timestamp"]];;
        _to =  [self modelAttribute:dict[@"to"] withNullString:kMNullStr];;
        _toReadStatus = [self modelAttributeInteger:dict[@"toReadStatus"]];;
        _tokenName =  [self modelAttribute:dict[@"tokenName"] withNullString:kMNullStr];;
        _topics = [NSArray array];
        _transactionIndex = [self modelAttributeInteger:dict[@"transactionIndex"]];;
        _v = [self modelAttributeInteger:dict[@"v"]];;
        _value = [self modelAttributeInteger:dict[@"value"]];
        _btc_eth_value = [self modelAttribute:dict[@"btc_eth_value"] withNullString:kMNullStr];
    }
    return self;
}

@end

@implementation CustomNotificationCenterModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _type1 = CustomNotificationCenterItemType_Transfer;
        _transferArray = [NSMutableArray array];
        _systemArray = [NSMutableArray array];
    }
    return self;
}




@end
