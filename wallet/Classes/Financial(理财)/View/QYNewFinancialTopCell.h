//
//  QYNewFinancialTopCell.h
//  wallet
//
//  Created by talking　 on 2019/7/4.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "SKBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface QYNewFinancialTopCell : SKBaseTableViewCell
@property (nonatomic, assign) BOOL currentSelectLicaiOrShuihui;
@property (nonatomic, copy) NSString *leftCurrentInfo;
@property (nonatomic, copy) NSString *rightCurrentInfo;


@property (nonatomic, copy) void (^NextViewControllerBlock)(NSString *tfText, BOOL currentSHUHUI);

@end

NS_ASSUME_NONNULL_END
