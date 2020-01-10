//
//  SKUserListCell.h
//  Business
//
//  Created by talking　 on 2018/8/31.
//  Copyright © 2018年 talking　. All rights reserved.
//

#import "SKBaseTableViewCell.h"

@class SKUserListModel;
@interface SKUserListCell : SKBaseTableViewCell

@property (nonatomic, strong) SKUserListModel *model;
//自定义分割线
@property (nonatomic, strong) UILabel *bottomLineLabel;


@end
