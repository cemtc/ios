//
//  QYMarketViewListCell.h
//  wallet
//
//  Created by talking　 on 2019/6/29.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "SKBaseTableViewCell.h"
#import "QYHangQingModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface QYMarketViewListCell : SKBaseTableViewCell
@property (nonatomic, strong) CFQCommonModel *model;
@property (nonatomic, strong) QYHangQingModel *modelA;
@end

NS_ASSUME_NONNULL_END
