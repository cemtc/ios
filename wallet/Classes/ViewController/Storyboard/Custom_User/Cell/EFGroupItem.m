//
//  EFGroupItem.m
//  wallet
//
//  Created by 董文龙 on 2019/11/28.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "EFGroupItem.h"
#import "EFTagGroupItem.h"

@implementation EFGroupItem

+ (instancetype)groupWithDict:(NSDictionary *)dict
{
    EFGroupItem *item = [[self alloc] init];
    [item setValuesForKeysWithDictionary:dict];
    return item;
}

- (void)setData:(NSMutableArray *)data
{
    NSMutableArray *datas = [NSMutableArray array];
    
    for (NSDictionary *dict in data) {
        EFTagGroupItem *tagGroup = [EFTagGroupItem tagGroupWithDict:dict];
        [datas addObject:tagGroup];
    }
    
    _data = datas;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
@end
