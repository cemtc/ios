//
//  MSMineRecommendView.h
//  wallet
//
//  Created by talking　 on 2019/6/30.
//  Copyright © 2019 talking　. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSMineRecommendListCell.h"
#import "MSMineRecommendListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MSMineRecommendView : UIView

@property (nonatomic, strong) NSArray * goodsArr;

@property (nonatomic, copy)   void(^clickBlock)(MSMineRecommendListModel * goodsModel);

@end

NS_ASSUME_NONNULL_END
