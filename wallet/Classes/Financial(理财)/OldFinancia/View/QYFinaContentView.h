//
//  QYFinaContentView.h
//  wallet
//
//  Created by talking　 on 2019/6/19.
//  Copyright © 2019 talking　. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIButton+Addition.h"//快速创建一个button

#import "UIView+Tap.h"

NS_ASSUME_NONNULL_BEGIN

@class QYFinaContentView;
@protocol QYFinaContentViewDelegate <NSObject>
- (void)qyFinaContentView:(QYFinaContentView *)topView didClickInfo:(NSString *)info;
@end
@interface QYFinaContentView : UIView
@property (nonatomic, weak) id <QYFinaContentViewDelegate> delegate;

@property (nonatomic, strong) UIButton *sureButton;


@property (nonatomic, strong) UILabel *topTextLabel;

//线
@property (nonatomic, strong) UILabel *lineL;


@end

NS_ASSUME_NONNULL_END
