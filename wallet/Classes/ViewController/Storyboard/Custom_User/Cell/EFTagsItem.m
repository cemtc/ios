//
//  EFTagsItem.m
//  wallet
//
//  Created by 董文龙 on 2019/11/28.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "EFTagsItem.h"

@implementation EFTagsItem
+ (instancetype)tagWithDict:(NSDictionary *)dict
{
    EFTagsItem *item = [[self alloc] init];
    [item setValuesForKeysWithDictionary:dict];
    return item;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
@end
