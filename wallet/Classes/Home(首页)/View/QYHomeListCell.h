//
//  QYHomeListCell.h
//  wallet
//
//  Created by talking　 on 2019/6/14.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "SKBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@class QYHomeListModel;
@interface QYHomeListCell : SKBaseTableViewCell

@property (nonatomic, strong) QYHomeListModel *model;

@end

NS_ASSUME_NONNULL_END
