//
//  SKUserTopView.h
//  Business
//
//  Created by talking　 on 2018/8/31.
//  Copyright © 2018年 talking　. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SKUserTopView;
@protocol SKUserTopViewDelegate <NSObject>
- (void)skUserTopView:(SKUserTopView *)topView didClickInfo:(NSString *)info;
@end

@interface SKUserTopView : UIView
@property (nonatomic, weak) id <SKUserTopViewDelegate> delegate;


@property (nonatomic, strong)UILabel *bottomLeftMoney;
@property (nonatomic, strong)UILabel *bottomRightMoney;
@property (nonatomic, strong)UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *nickNameLabel;
@end
