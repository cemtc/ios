//
//  ZWFoundCell.h
//  wallet
//
//  Created by 张威威 on 2019/9/18.
//  Copyright © 2019 talking　. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SKBaseTableViewCell.h"
NS_ASSUME_NONNULL_BEGIN

@interface ZWFoundCell : SKBaseTableViewCell
-(void)UpdateCellWith:(NSString *)iconImageName Name:(NSString *)name Des:(NSString *)des;
@end

NS_ASSUME_NONNULL_END
