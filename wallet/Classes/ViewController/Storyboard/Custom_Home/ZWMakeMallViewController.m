//
//  ZWMakeMallViewController.m
//  wallet
//
//  Created by 张威威 on 2019/9/17.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "ZWMakeMallViewController.h"

@interface ZWMakeMallViewController ()

@property (weak, nonatomic) IBOutlet UITextField *MallNameTF;
@property (weak, nonatomic) IBOutlet UIButton *SubMitBtn;



@end

@implementation ZWMakeMallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.barStyle = UIStatusBarStyleLightContent;
    self.SubMitBtn.layer.cornerRadius = 6;
    self.SubMitBtn.layer.masksToBounds = YES;
    self.SubMitBtn.enabled = NO;
    //使用rac相关技术
    RACSignal * signal =[self.MallNameTF rac_textSignal];
    [signal subscribeNext:^(NSString * x) {
        if (x.length) {
            self.SubMitBtn.enabled = YES;
            self.SubMitBtn.backgroundColor = [UIColor colorWithHexString:@"#0d8aca"];
        }else{
            self.SubMitBtn.enabled = NO;
            self.SubMitBtn.backgroundColor = [UIColor colorWithHexString:@"#999999"];
        }

    }];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
- (IBAction)BackBtnClick:(UIButton *)sender {
    [self back];
}
- (IBAction)SubmitBtnClick:(UIButton *)sender {
   CFQtestSwift *a = [[CFQtestSwift alloc]init];
    //创建 BTC 以太坊钱包  钱包成功,保存 助记词,秘钥 公钥   等等  ,
    //再次登录   使用助记词   私钥  获取我的钱包
    //首次进来,创建钱包.根据钱包名字创建钱包
    //CreatBTCMnemonicWordWithBTCImPrKey:self.WallType password:self.MallNameTF.text]
    //[a creatgenerateMnemonicWord];
    //创建空钱包
    @weakify(self);
    [[CustomUserManager customSharedManager] showWalletPassWordViewFinish:^(NSString * _Nonnull password) {
        @strongify(self);
        NSString *user_password = [CustomUserManager customSharedManager].userModel.passwrod;

        if (![password isEqualToString:user_password]) {
            [MBProgressHUD showMessage:@"password error"];
            return ;
        }
        if ([a creatgenerateMnemonicWordBTCandETHWithWallNameWithBTCImPrKey:@"" mobileA:self.MallNameTF.text Mnemonicstr:@"" WallType:self.WallType]) {
            NSLog(@"创建钱包成功");//创建成功之后.需要将当前钱包存进数据库
            [[NSNotificationCenter defaultCenter] postNotificationName:self.WallType object:nil];
            [SVProgressHUD showSuccessWithStatus:@"create wallet success"];
        }else{
            NSLog(@"创建钱包失败");
            [SVProgressHUD showErrorWithStatus:@"create wallet fail" ];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }];



}

@end
