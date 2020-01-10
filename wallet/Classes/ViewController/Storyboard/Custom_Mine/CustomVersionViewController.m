//
//  CustomVersionViewController.m
//  wallet
//
//  Created by 曾云 on 2019/8/18.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "CustomVersionViewController.h"

@interface CustomVersionViewController ()
@property (weak, nonatomic) IBOutlet UIButton *button;/**< 立即升级 按钮 */
@property (weak, nonatomic) IBOutlet UILabel *currentVersion;/**< 当前版本 */
@property (weak, nonatomic) IBOutlet UILabel *version;/**< 最新版本 */


@end

@implementation CustomVersionViewController
- (IBAction)buttonClick:(UIButton *)sender {
    [self checkAppVersionInfo];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
     self.navigationItem.title = @"Version Update";
    [self leftBarButtomItemWithNormalName:@"icon_return_black" highName:@"icon_return_black" selector:@selector(back) target:self];
    self.currentVersion.text = [NSString stringWithFormat:@"V%@",APP_VERSION];
    self.version.text = [NSString stringWithFormat:@"V%@",[CustomUserManager customSharedManager].userModel.serverVerson];
//    self.button.hidden = [self.version.text isEqualToString:self.currentVersion.text];
//    if (![self.version.text isEqualToString:self.currentVersion.text]) {
        CAGradientLayer *gradient = [CAGradientLayer layer];
        //设置开始和结束位置(设置渐变的方向)
        gradient.startPoint = CGPointMake(0,0);
        gradient.endPoint = CGPointMake(1,0);
        gradient.frame = self.button.bounds;
        gradient.colors = [NSArray arrayWithObjects:(id)[UIColor colorWithHexString:@"#0692C2"].CGColor,(id)[UIColor colorWithHexString:@"#1186CE"].CGColor,nil];
        [self.button.layer insertSublayer:gradient atIndex:0];
//    }
}

- (void)checkAppVersionInfo
{
    
    NSString *versionString = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    
    NSMutableDictionary *d = [NSMutableDictionary new];
    [d setValue:versionString forKey:@"versionName"];
    [d setValue:@"2" forKey:@"type"];
    
    NSDictionary * input = d.copy;
    SKDefineWeakSelf;
    [CFQCommonServer cfqServerQYAPIgetVersionInfoWithInput:input Callback:^(id  _Nonnull response, BOOL success, NSString * _Nonnull message, NSString * _Nonnull code) {
        self.version.text = [NSString stringWithFormat:@"V%@",response];
        if (success) {
            NSLog(@"%@",response);
            [weakSelf downLoadIpaUrl:[NSString stringWithFormat:@"%@",message]];
        } else {
            NSLog(@"%@",response);
            NSLog(@"%@",message);
            NSLog(@"不需要升级");
             [MBProgressHUD showMessage:@"Currently the latest version"];
        }
    }];
    
}

-(void)downLoadIpaUrl:(NSString *)url{
    [UIAlertView alertWithTitle:@"Message" message:@"Update App" okHandler:^{
        
        NSString *iosHyperLink = [NSString stringWithFormat:@"itms-services://?action=download-manifest&url=%@",url];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:iosHyperLink]];
        
    } cancelHandler:^{
        
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
