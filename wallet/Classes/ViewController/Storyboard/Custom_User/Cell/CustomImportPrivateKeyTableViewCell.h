//
//  CustomImportPrivateKeyTableViewCell.h
//  wallet
//
//  Created by 曾云 on 2019/8/17.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "UIBaseStoryBoardTableViewCell.h"
#import "CustomImportPrivateKeyModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CustomImportPrivateKeyTableViewCell : UIBaseStoryBoardTableViewCell

@property (nonatomic,strong) CustomImportPrivateKeyItemModel *itemModel;

@property(nonatomic,strong)void(^textFieldBlock)(ImportPrivateKeyItemType type,NSString *text);

@end

NS_ASSUME_NONNULL_END
