//
//  ZWMnemoincAndPrivaceViewController.m
//  wallet
//
//  Created by 张威威 on 2019/9/17.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "ZWMnemoincAndPrivaceViewController.h"
#import "ZWWTextView.h"
@interface ZWMnemoincAndPrivaceViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *SubMitBtn;

@property (weak, nonatomic) IBOutlet UITextField *MallTF;
@property (weak, nonatomic) IBOutlet UIView *TextView;

@property (weak, nonatomic) IBOutlet UILabel *desLB;

@property (weak, nonatomic) IBOutlet UIImageView *IconImageView;


@property (strong, nonatomic) ZWWTextView *ZWTextView;
@end

@implementation ZWMnemoincAndPrivaceViewController
- (UIImage *)imageWithColor:(UIColor *)color {
    return [self imageWithColor:color size:CGSizeMake(1, 1)];
}
- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    if (!color || size.width <= 0 || size.height <= 0) return nil;
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.TextView addSubview:self.ZWTextView];
    self.MallTF.delegate = self;
    self.barStyle = UIStatusBarStyleLightContent;
    self.SubMitBtn.layer.cornerRadius = 6;
    self.SubMitBtn.layer.masksToBounds = YES;
    self.SubMitBtn.enabled = NO;
    [self.SubMitBtn setBackgroundImage:[self imageWithColor:[UIColor colorWithHexString:@"#aaaaaa"]] forState:UIControlStateDisabled];
    [self.SubMitBtn setBackgroundImage:[self imageWithColor:[UIColor colorWithHexString:@"#0d8ac5"]] forState:UIControlStateNormal];
    if ([self.Type isEqualToString:@"2"]) {
        self.desLB.text = @"导入助记词";
        self.ZWTextView.placeholderStr = @"输入助记词，用空格分隔";
        self.ZWTextView.textColor = [UIColor colorWithHexString:@"464646"];
    }else{
        //私钥导入
        self.desLB.text = @"导入私钥";
        self.ZWTextView.placeholderStr = @"请输入私钥";
        self.IconImageView.image = [UIImage imageNamed:@"siyao_add"];
        self.ZWTextView.textColor = [UIColor colorWithHexString:@"464646"];
    }
    SKDefineWeakSelf;
    self.ZWTextView.MessageTextTFChangeBlock = ^(NSString *TextStr) {
        if (self.MallTF.text.length && TextStr.length) {
            weakSelf.SubMitBtn.enabled = YES;
        }else{
            weakSelf.SubMitBtn.enabled = NO;
        }
    };
    [self.navigationController setNavigationBarHidden:YES];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
- (IBAction)BackBtnClick:(UIButton *)sender {
    [self back];
}
- (IBAction)SubmitBtnClick:(UIButton *)sender {
    //创建钱包 私钥或者助记词创建
    @weakify(self);
    [[CustomUserManager customSharedManager] showWalletPassWordViewFinish:^(NSString * _Nonnull password) {
        @strongify(self);
        NSString *user_password = [CustomUserManager customSharedManager].userModel.passwrod;

        if (![password isEqualToString:user_password]) {
            [MBProgressHUD showMessage:@"密码错误"];
            return ;
        }
        NSLog(@"创建钱包=私钥或者助记词");
        CFQtestSwift *a = [[CFQtestSwift alloc]init];
        if ([a creatgenerateMnemonicWordBTCandETHWithWallNameWithBTCImPrKey:self.ZWTextView.text mobileA:self.MallTF.text Mnemonicstr:@"" WallType:self.WallType]) {
            NSLog(@"创建钱包成功");//创建成功之后.需要将当前钱包存进数据库
            [[NSNotificationCenter defaultCenter] postNotificationName:self.WallType object:nil];
            [SVProgressHUD showSuccessWithStatus:@"创建钱包成功"];
        }else{
            NSLog(@"创建钱包失败");
            [SVProgressHUD showErrorWithStatus:@"创建钱包失败"];
        }
        [self.navigationController popViewControllerAnimated:YES];

    }];

}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if (textField.text.length && self.ZWTextView.text.length) {
        self.SubMitBtn.enabled = YES;
    }else{
        self.SubMitBtn.enabled = NO;
    }
    return YES;
}
-(ZWWTextView *)ZWTextView{
    if (_ZWTextView == nil) {
        _ZWTextView = [ZWWTextView textView];
        _ZWTextView.frame = CGRectMake(10, 10, SKScreenWidth - 20, 130);
    }
    return _ZWTextView;
}

@end
