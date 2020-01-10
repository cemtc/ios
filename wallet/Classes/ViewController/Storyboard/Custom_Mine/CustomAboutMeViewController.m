//
//  CustomAboutMeViewController.m
//  wallet
//
//  Created by 曾云 on 2019/8/18.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "CustomAboutMeViewController.h"

@interface CustomAboutMeViewController ()
@property (weak, nonatomic) IBOutlet UILabel *version;
@property (weak, nonatomic) IBOutlet UILabel *name;

@end

@implementation CustomAboutMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"About Us";
    [self leftBarButtomItemWithNormalName:@"icon_return_black" highName:@"icon_return_black" selector:@selector(back) target:self];
    self.version.text = [NSString stringWithFormat:@"V%@",APP_VERSION];
    self.name.text = [CustomUserManager customSharedManager].userModel.name;
    self.name.text = @"EMTC Wallet";
}



@end
