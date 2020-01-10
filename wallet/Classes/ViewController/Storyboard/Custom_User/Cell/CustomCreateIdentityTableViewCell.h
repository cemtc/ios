//
//  CustomCreateIdentityTableViewCell.h
//  wallet
//
//  Created by 曾云 on 2019/8/17.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "UIBaseStoryBoardTableViewCell.h"
#import "CustomCreateIdentityModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CustomCreateIdentityTableViewCell : UIBaseStoryBoardTableViewCell

@property (nonatomic,strong) CustomCreateIdentityItemModel *itemModel;

@property(nonatomic,strong)void(^textFieldBlock)(CreateIdentityItemType type,NSString *text);

@end

NS_ASSUME_NONNULL_END
