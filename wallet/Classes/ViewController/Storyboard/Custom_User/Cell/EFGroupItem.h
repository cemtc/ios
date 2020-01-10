//
//  EFGroupItem.h
//  wallet
//
//  Created by 董文龙 on 2019/11/28.
//  Copyright © 2019 talking　. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EFGroupItem : NSObject
{
@protected NSMutableArray *_data;
}
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSMutableArray *data;
+ (instancetype)groupWithDict:(NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END
