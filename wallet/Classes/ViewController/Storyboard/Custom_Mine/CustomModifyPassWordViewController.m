//
//  CustomModifyPassWordViewController.m
//  wallet
//
//  Created by 曾云 on 2019/8/18.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "CustomModifyPassWordViewController.h"

@interface CustomModifyPassWordViewController ()
@property (weak, nonatomic) IBOutlet UITextField *oldPassword;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *repeatPassword;
@property (weak, nonatomic) IBOutlet UIButton *finishButton;

@end

@implementation CustomModifyPassWordViewController

- (IBAction)entry:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.password.secureTextEntry = sender.selected;
}

- (IBAction)finishButtonClick:(UIButton *)sender {
    
    NSString *pad = [CustomUserManager customSharedManager].userModel.passwrod;
    if (![_oldPassword.text isEqualToString:pad]) {
        [MBProgressHUD showMessage:@"原密码不正确"];
        return;
    }
    NSString *errMsg = [self verifyPassWord:self.password.text];
    if (![errMsg isEqualToString:kMNullStr]) {
        [MBProgressHUD showMessage:errMsg];
        return;
    }
    
    if (![self.password.text isEqualToString:self.repeatPassword.text]) {
        [MBProgressHUD showMessage:@"新密码两次输入不相同"];
        return;
    }
    
    CustomUserModel *model = [CustomUserManager customSharedManager].userModel;
    model.passwrod = self.password.text;
    
    [[CustomUserManager customSharedManager]loginFinish:model];
    
    
    [MBProgressHUD showMessage:@"密码修改成功"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"run-----");
        [super back];
    });
    
//    NSDictionary *dict = @{@"oldPwd":_oldPassword.text,
//                           @"newPwd":self.password.text,
//                           @"type":@"1"};
////
//    [CFQCommonServer cfqServerQYAPIchangePwdWithInput:dict Callback:^(id  _Nonnull response, BOOL success, NSString * _Nonnull message, NSString * _Nonnull code) {
//        if (success) {
//            [MBProgressHUD showMessage:@"密码修改成功"];
//            [super back];
//        }
//  }];
    
}
- (NSString *)verifyPassWord:(NSString *)value {
    if ( value == nil || value.length == 0 ) {
        return @"密码不能为空";
    }
    
    if ( value.length < 8 || value.length > 32 ) {
        return @"密码长度为8-32位";
    }
    
    NSString *pattern = @"^\\d{8,32}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:value];
    if ( isMatch ) {
        return @"密码不能全为数字";
    }
    
    pattern = @"^[a-zA-Z]{8,32}";
    pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    isMatch = [pred evaluateWithObject:value];
    if ( isMatch ) {
        return @"密码不能全为字母";
    }
    
    pattern = @"^[-`=\\\[\\];',./~!@#$%^&*()_+|{}:\"<>?]{8,32}";
    pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    isMatch = [pred evaluateWithObject:value];
    if ( isMatch ) {
        return @"密码不能全为特殊符号";
    }
    
    // 特殊字符包含`、-、=、\、[、]、;、'、,、.、/、~、!、@、#、$、%、^、&、*、(、)、_、+、|、?、>、<、"、:、{、}
    // 必须包含数字和字母，可以包含上述特殊字符。
    // 依次为（如果包含特殊字符）
    // 数字 字母 特殊
    // 字母 数字 特殊
    // 数字 特殊 字母
    // 字母 特殊 数字
    // 特殊 数字 字母
    // 特殊 字母 数字
    pattern = @"(?=.*[0-9])(?=.*[a-zA-Z]).{8,32}";
    pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    isMatch = [pred evaluateWithObject:value];
    if ( isMatch ) {
        return kMNullStr;
    } else {
        return @"8-32位数字字母组合";
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"change Password";
    [self leftBarButtomItemWithNormalName:@"icon_return_black" highName:@"icon_return_black" selector:@selector(back) target:self];
    CAGradientLayer *gradient = [CAGradientLayer layer];
    //设置开始和结束位置(设置渐变的方向)
    gradient.startPoint = CGPointMake(0,0);
    gradient.endPoint = CGPointMake(1,0);
    gradient.frame = self.finishButton.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[UIColor colorWithHexString:@"#0692C2"].CGColor,(id)[UIColor colorWithHexString:@"#1186CE"].CGColor,nil];
    [self.finishButton.layer insertSublayer:gradient atIndex:0];
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
