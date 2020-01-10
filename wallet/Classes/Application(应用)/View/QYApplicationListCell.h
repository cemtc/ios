//
//  QYApplicationListCell.h
//  wallet
//
//  Created by talking　 on 2019/6/29.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "SKBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN
@class QYApplicationListModel;
@interface QYApplicationListCell : SKBaseTableViewCell

@property (nonatomic, strong) QYApplicationListModel *model;

//回到上一页 把TextView.text值 传给上个界面
@property (nonatomic, copy) void (^NextViewControllerBlock)(QYApplicationListModel *modelA);
@end

NS_ASSUME_NONNULL_END
