//
//  EFTagGroupCell.h
//  wallet
//
//  Created by 董文龙 on 2019/11/28.
//  Copyright © 2019 talking　. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class EFTagGroupItem;
@interface EFTagGroupCell : UITableViewCell
@property (nonatomic, strong) EFTagGroupItem *tagGroup;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

NS_ASSUME_NONNULL_END
