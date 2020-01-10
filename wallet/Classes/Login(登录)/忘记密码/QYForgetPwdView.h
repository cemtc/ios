//
//  QYForgetPwdView.h
//  wallet
//
//  Created by talking　 on 2019/7/19.
//  Copyright © 2019 talking　. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class QYForgetPwdView;
@protocol QYForgetPwdViewDelegate <NSObject>
- (void)qyForgetPwdView:(QYForgetPwdView *)topView didClickInfo:(NSDictionary *)infoDict;
@end

@interface QYForgetPwdView : UIView
@property (nonatomic, weak) id <QYForgetPwdViewDelegate> delegate;


@property (nonatomic, strong)UITextField *loginTextField;//登录TextField
@property (nonatomic, strong)UITextField *passwordTextField1;//密码1TextField
@property (nonatomic, strong)UITextField *passwordTextField2;//密码2TextField
@property (nonatomic, strong)UIButton *nextButton;//下一步button



@property (nonatomic, strong) UILabel *q1;
@property (nonatomic, strong) UITextField *q1TextField;

@end

NS_ASSUME_NONNULL_END
