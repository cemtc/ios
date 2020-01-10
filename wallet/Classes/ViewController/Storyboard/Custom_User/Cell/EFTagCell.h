//
//  EFTagCell.h
//  wallet
//
//  Created by 董文龙 on 2019/11/28.
//  Copyright © 2019 talking　. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class EFTagsItem;
@interface EFTagCell : UICollectionViewCell
@property (nonatomic, strong) EFTagsItem *item;
@property (weak, nonatomic) IBOutlet UILabel *tagLabel;
@end

NS_ASSUME_NONNULL_END
