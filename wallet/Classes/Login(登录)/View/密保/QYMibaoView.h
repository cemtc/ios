//
//  QYMibaoView.h
//  wallet
//
//  Created by talking　 on 2019/7/19.
//  Copyright © 2019 talking　. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class QYMibaoView;
@protocol QYMibaoViewDelegate <NSObject>
- (void)qyMibaoView:(QYMibaoView *)topView didClickInfo:(NSDictionary *)infoDict;
@end

@interface QYMibaoView : UIView

@property (nonatomic, weak) id <QYMibaoViewDelegate> delegate;

@property (nonatomic, strong) UILabel *q1;
@property (nonatomic, strong) UITextField *q1TextField;
@property (nonatomic, strong)UIButton *nextButton;//下一步button

@end

NS_ASSUME_NONNULL_END
