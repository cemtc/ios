//
//  QYRegistContentView.h
//  wallet
//
//  Created by talking　 on 2019/6/18.
//  Copyright © 2019 talking　. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class QYRegistContentView;
@protocol QYRegistContentViewDelegate <NSObject>
- (void)qyRegistContentView:(QYRegistContentView *)topView didClickInfo:(NSDictionary *)infoDict;
@end

@interface QYRegistContentView : UIView
@property (nonatomic, weak) id <QYRegistContentViewDelegate> delegate;


@property (nonatomic, strong)UITextField *loginTextField;//登录TextField
@property (nonatomic, strong)UITextField *passwordTextField1;//密码1TextField
@property (nonatomic, strong)UITextField *passwordTextField2;//密码2TextField
@property (nonatomic, strong)UIButton *nextButton;//下一步button
@end

NS_ASSUME_NONNULL_END
