//
//  QYLoginHeadView.h
//  wallet
//
//  Created by talking　 on 2019/6/18.
//  Copyright © 2019 talking　. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@class QYLoginHeadView;
@protocol QYLoginHeadViewDelegate <NSObject>
- (void)qyLoginHeadView:(QYLoginHeadView *)topView didClickInfo:(NSString *)info;
@end

@interface QYLoginHeadView : UIView

@property (nonatomic, weak) id <QYLoginHeadViewDelegate> delegate;


@property (nonatomic, strong) UIImageView *bottomLeftImageView;
@property (nonatomic, strong) UIImageView *bottomRightImageView;

@end

NS_ASSUME_NONNULL_END
