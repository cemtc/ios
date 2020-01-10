//
//  CreatWalletCell.h
//  wallet
//
//  Created by talking　 on 2019/6/25.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "SKBaseTableViewCell.h"
#import "CreatWalletModel.h"

NS_ASSUME_NONNULL_BEGIN
@class CreatWalletModel;
@interface CreatWalletCell : SKBaseTableViewCell

@property (nonatomic, strong) CreatWalletModel*model;

@end

NS_ASSUME_NONNULL_END
