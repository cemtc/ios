//
//  EFTagGroupItem.m
//  wallet
//
//  Created by 董文龙 on 2019/11/28.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "EFTagGroupItem.h"
#import "EFTagsItem.h"
CGFloat const itemH = 30;
@implementation EFTagGroupItem
+ (instancetype)tagGroupWithDict:(NSDictionary *)dict
{
    EFTagGroupItem *item = [[self alloc] init];
    [item setValuesForKeysWithDictionary:dict];
    return item;
}
- (void)setData:(NSMutableArray *)data
{
    NSMutableArray *datas = [NSMutableArray array];
    for (NSDictionary *dict in data) {
        EFTagsItem *tagGroup = [EFTagsItem tagWithDict:dict];
        [datas addObject:tagGroup];
    }
    _data = datas;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}


- (CGFloat)cellH
{
    CGFloat originY = 27;
    CGFloat margin = 10;
    
    NSInteger cols = 4;
    NSInteger rows = (self.data.count - 1) / cols + 1;
    return rows * (itemH + margin) + originY;
}
@end
