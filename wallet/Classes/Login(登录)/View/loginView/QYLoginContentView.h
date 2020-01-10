//
//  QYLoginContentView.h
//  wallet
//
//  Created by talking　 on 2019/6/18.
//  Copyright © 2019 talking　. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class QYLoginContentView;
@protocol QYLoginContentViewDelegate <NSObject>
- (void)qyLoginContentView:(QYLoginContentView *)topView didClickInfo:(NSDictionary *)infoDict;
@end

@interface QYLoginContentView : UIView
@property (nonatomic, weak) id <QYLoginContentViewDelegate> delegate;


@property (nonatomic, strong)UITextField *loginTextField;//登录TextField
@property (nonatomic, strong)UITextField *passwordTextField;//密码TextField
@property (nonatomic, strong)UIButton *loginButton;//登录button


@end

NS_ASSUME_NONNULL_END
