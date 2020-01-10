//
//  CustomNotificationCenterDetailsSectionView.h
//  wallet
//
//  Created by 曾云 on 2019/8/22.
//  Copyright © 2019 talking　. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomNotificationCenterDetailsSectionView : UIView
@property (weak, nonatomic) IBOutlet UILabel *tokenName;
@property (weak, nonatomic) IBOutlet UILabel *value;
@property (weak, nonatomic) IBOutlet UILabel *balance;

@end

NS_ASSUME_NONNULL_END
