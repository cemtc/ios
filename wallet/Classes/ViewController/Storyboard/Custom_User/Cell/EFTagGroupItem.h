//
//  EFTagGroupItem.h
//  wallet
//
//  Created by 董文龙 on 2019/11/28.
//  Copyright © 2019 talking　. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EFGroupItem.h"

NS_ASSUME_NONNULL_BEGIN
@class EFGroupItem;
@interface EFTagGroupItem : EFGroupItem
+ (instancetype)tagGroupWithDict:(NSDictionary *)dict;

- (CGFloat)cellH;

@end


NS_ASSUME_NONNULL_END
