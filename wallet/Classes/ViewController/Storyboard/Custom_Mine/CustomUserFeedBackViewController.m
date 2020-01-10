//
//  CustomUserFeedBackViewController.m
//  wallet
//
//  Created by 曾云 on 2019/8/18.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "CustomUserFeedBackViewController.h"
#import "ZWWTextView.h"
@interface CustomUserFeedBackViewController ()
@property (weak, nonatomic) IBOutlet UITextField *choose;
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *mobile;
@property (weak, nonatomic) IBOutlet ZWWTextView *textView;

@end

@implementation CustomUserFeedBackViewController

- (IBAction)chooseItem:(UIButton *)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Please select a feedback type" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"How can I quickly check the status of a transfer transaction?" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.choose.text = action.title;
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"What is the reason for the transfer failure?" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.choose.text = action.title;
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Why does the transfer failure also deduct the miners’ fees?" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.choose.text = action.title;
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"What should I do if I fill in the wrong address when I transfer?" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.choose.text = action.title;
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"What happens when the transaction arrives but does not show it?" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.choose.text = action.title;
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}
- (IBAction)finishButtonClick:(UIButton *)sender {
    if (![SKUtils isValidateMobile:self.mobile.text]) {
        [MBProgressHUD showMessage:@"input phone"];
        return;
    }
    [CFQCommonServer cfqServerQYAPIAddFeedback_Name:self.name.text mobile:self.mobile.text type:self.choose.text text:self.textView.text complete:^(NSString * _Nonnull errMsg) {
        if (errMsg) {
            [MBProgressHUD showMessage:errMsg];
        } else {
            [MBProgressHUD showMessage:@"Submitted successfully"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [super back];
            });
        }
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"customer feedback";
    [self leftBarButtomItemWithNormalName:@"icon_return_black" highName:@"icon_return_black" selector:@selector(back) target:self];
    self.textView.placeholderStr = @"please enter text";
}

@end
