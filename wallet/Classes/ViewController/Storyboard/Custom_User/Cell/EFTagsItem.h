//
//  EFTagsItem.h
//  wallet
//
//  Created by 董文龙 on 2019/11/28.
//  Copyright © 2019 talking　. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EFTagsItem : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) BOOL isSelected;
+ (instancetype)tagWithDict:(NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END
