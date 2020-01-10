//
//  CustomWalletPassWordView.m
//  wallet
//
//  Created by 曾云 on 2019/8/17.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "CustomWalletPassWordView.h"

@interface CustomWalletPassWordView ()
@property (weak, nonatomic) IBOutlet UIButton *finish;
@property (weak, nonatomic) IBOutlet UITextField *textField;


@end

@implementation CustomWalletPassWordView
- (IBAction)finishButtonClick:(UIButton *)sender {
    
    if (self.buttonClickBlock) {
        self.buttonClickBlock(self.textField.text);
    }
    [self dismisss];
}
- (IBAction)cancel:(UIButton *)sender {
    if (self.CanclebuttonClickBlock) {
        self.CanclebuttonClickBlock(@"1");
    }
    [self dismisss];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    CAGradientLayer *gradient = [CAGradientLayer layer];
    //设置开始和结束位置(设置渐变的方向)
    gradient.startPoint = CGPointMake(0,0);
    gradient.endPoint = CGPointMake(1,0);
    gradient.frame = self.finish.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[UIColor colorWithHexString:@"#0692C2"].CGColor,(id)[UIColor colorWithHexString:@"#1186CE"].CGColor,nil];
    [self.finish.layer insertSublayer:gradient atIndex:0];
}

- (void)showClickButton:(void(^)(NSString *text))buttonClickBlock {
    _buttonClickBlock = buttonClickBlock;
    [KEY_WINDOW addSubview:self];
    self.frame = CGRectMake(0, 0, SKScreenWidth, SKScreenHeight);
}
- (void)dismisss {
    [self removeFromSuperview];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
