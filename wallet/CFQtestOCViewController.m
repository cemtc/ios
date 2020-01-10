//
//  CFQtestOCViewController.m
//  wallet
//
//  Created by talking　 on 2019/6/16.
//  Copyright © 2019 talking　. All rights reserved.
//

/*
 CFQtestOCViewController *vc = [CFQtestOCViewController new];
 [self pushVc:vc];
 */

#import "CFQtestOCViewController.h"

@interface CFQtestOCViewController ()

@end

@implementation CFQtestOCViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"caofuqingOC";

}

//验证交易密码
- (void)verifyisPhoneNumberPwd:(NSString *)pwd Callback:(void(^)(BOOL isLogin))callback{
    //验证交易密码测试
    NSMutableDictionary *d = [NSMutableDictionary new];
    [d setValue:MD532(pwd) forKey:@"tradePwd"];
    NSDictionary * input = d.copy;
    [CFQCommonServer cfqServerQYAPIQYAPIcheckTradePwdWithInput:input Callback:^(id  _Nonnull response, BOOL success, NSString * _Nonnull message, NSString * _Nonnull code) {
        if (success) {
            callback(YES);
        }else {
            callback(NO);
        }
    }];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
