//
//  QYFinaHeadBtnView.h
//  wallet
//
//  Created by talking　 on 2019/6/19.
//  Copyright © 2019 talking　. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class QYFinaHeadBtnView;
@protocol QYFinaHeadBtnViewDelegate <NSObject>
- (void)qyFinaHeadBtnView:(QYFinaHeadBtnView *)topView didClickInfo:(NSString *)info;
@end

@interface QYFinaHeadBtnView : UIView
@property (nonatomic, weak) id <QYFinaHeadBtnViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
