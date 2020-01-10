//
//  QYExportPrivateListCell.h
//  wallet
//
//  Created by talking　 on 2019/6/26.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "SKBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN
@class QYExportPrivateListModel;
@interface QYExportPrivateListCell : SKBaseTableViewCell

@property (nonatomic, strong) QYExportPrivateListModel *model;

@end

NS_ASSUME_NONNULL_END
