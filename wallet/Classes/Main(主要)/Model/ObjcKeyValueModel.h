//
//  ObjcKeyValueModel.h
//  wallet
//
//  Created by 曾云 on 2019/8/22.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "ObjcBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ObjcKeyValueModel : ObjcBaseModel
@property (nonatomic,strong) NSString *key;
@property (nonatomic,strong) NSString *value;

- (instancetype)initWithKey:(NSString *)key value:(NSString *)value;
@end

NS_ASSUME_NONNULL_END
