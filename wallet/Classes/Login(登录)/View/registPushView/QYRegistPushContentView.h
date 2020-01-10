//
//  QYRegistPushContentView.h
//  wallet
//
//  Created by talking　 on 2019/6/18.
//  Copyright © 2019 talking　. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class QYRegistPushContentView;
@protocol QYRegistPushContentViewDelegate <NSObject>
- (void)qyRegistPushContentView:(QYRegistPushContentView *)topView didClickInfo:(NSDictionary *)infoDict;
@end
@interface QYRegistPushContentView : UIView
@property (nonatomic, weak) id <QYRegistPushContentViewDelegate> delegate;


@property (nonatomic, strong)UITextField *invitationTextField;//邀请TextField
@property (nonatomic, strong)UITextField *passwordTextField1;//密码1TextField
@property (nonatomic, strong)UITextField *passwordTextField2;//密码2TextField
@property (nonatomic, strong)UIButton *registButton;//注册button

@end

NS_ASSUME_NONNULL_END
