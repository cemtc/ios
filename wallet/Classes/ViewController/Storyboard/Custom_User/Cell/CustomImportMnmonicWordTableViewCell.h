//
//  CustomImportMnmonicWordTableViewCell.h
//  wallet
//
//  Created by 曾云 on 2019/8/17.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "UIBaseStoryBoardTableViewCell.h"

#import "CustomImportMnmonicWordModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CustomImportMnmonicWordTableViewCell : UIBaseStoryBoardTableViewCell

@property (nonatomic,strong) CustomImportMnmonicWordItemModel *itemModel;

@property(nonatomic,strong)void(^textFieldBlock)(ImportMnmonicWordItemType type,NSString *text);


@end

NS_ASSUME_NONNULL_END
