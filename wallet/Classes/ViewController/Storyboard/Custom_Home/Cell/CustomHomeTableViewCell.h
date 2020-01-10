//
//  CustomHomeTableViewCell.h
//  wallet
//
//  Created by 曾云 on 2019/8/17.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "UIBaseStoryBoardTableViewCell.h"
#import "CustomHomeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CustomHomeTableViewCell : UIBaseStoryBoardTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *balance;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (nonatomic,strong) CustomHomeItemModel *itemModel;

@end

NS_ASSUME_NONNULL_END
