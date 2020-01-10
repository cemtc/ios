//
//  QYChangeLoginPwdView.h
//  wallet
//
//  Created by talking　 on 2019/6/26.
//  Copyright © 2019 talking　. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class QYChangeLoginPwdView;
@protocol QYChangeLoginPwdViewDelegate <NSObject>
- (void)qyChangeLoginPwdView:(QYChangeLoginPwdView *)topView didClickInfo:(NSDictionary *)infoDict;
@end
@interface QYChangeLoginPwdView : UIView

@property (nonatomic, weak) id <QYChangeLoginPwdViewDelegate> delegate;

@property (nonatomic, strong)UITextField *loginTextField;//登录TextField
@property (nonatomic, strong)UITextField *passwordTextField1;//密码1TextField
@property (nonatomic, strong)UITextField *passwordTextField2;//密码2TextField
@property (nonatomic, strong)UIButton *nextButton;//下一步button

@end

NS_ASSUME_NONNULL_END
