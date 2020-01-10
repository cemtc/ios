//
//  CustomImportWalletView.m
//  wallet
//
//  Created by 曾云 on 2019/8/17.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "CustomImportWalletView.h"


@interface CustomImportWalletView ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation CustomImportWalletView

- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = _title;
}

- (IBAction)privateKey:(UIButton *)sender {
    NSLog(@"私钥");
    if (self.clickBlock) {
        self.clickBlock(CustomImportWalletType_PrivateKey);
    }
    [self dismisss];
}

- (IBAction)mnemonicWord:(UIButton *)sender {
    NSLog(@"助记词");
    if (self.clickBlock) {
        self.clickBlock(CustomImportWalletType_MnmonicWord);
    }
    [self dismisss];
}


- (IBAction)cancel:(UIButton *)sender {
    NSLog(@"取消");
    if (self.clickBlock) {
        self.clickBlock(CustomImportWalletType_Cancel);
    }
    [self dismisss];
}

- (void)showClickButtonType:(void(^)(CustomImportWalletType type))clickBlock {
    _clickBlock = clickBlock;
    [KEY_WINDOW addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(KEY_WINDOW.mas_top).offset(0);
        make.left.mas_equalTo(KEY_WINDOW.mas_left).offset(0);
        make.right.mas_equalTo(KEY_WINDOW.mas_right).offset(0);
        make.bottom.mas_equalTo(KEY_WINDOW.mas_bottom).offset(0);
    }];
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
