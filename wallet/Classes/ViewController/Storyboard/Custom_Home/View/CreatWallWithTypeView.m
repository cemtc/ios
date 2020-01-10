//
//  CreatWallWithTypeView.m
//  wallet
//
//  Created by 张威威 on 2019/9/17.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "CreatWallWithTypeView.h"
@interface CreatWallWithTypeView ()
@property (weak, nonatomic) IBOutlet UIView *BGView;//背景白色cview
//
@property (weak, nonatomic) IBOutlet UIImageView *CreatWallImageView;//创建钱包
@property (weak, nonatomic) IBOutlet UILabel *CreatWallLB;

@property (weak, nonatomic) IBOutlet UIImageView *MoneWordImageView;//助记词
@property (weak, nonatomic) IBOutlet UILabel *MoneWordLB;


@property (weak, nonatomic) IBOutlet UIImageView *PrivateImageView;//私钥
@property (weak, nonatomic) IBOutlet UILabel *PrivateLB;




@end
@implementation CreatWallWithTypeView
- (void)awakeFromNib{
    [super awakeFromNib];
    //修改背景view 圆角  添加分割线
    self.BGView.layer.cornerRadius = 8;
    self.BGView.layer.masksToBounds = YES;

    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = [UIColor colorWithHexString:@"#979797"];
    [self.BGView addSubview:lineView];

    UIView *lineView1 = [[UIView alloc]init];
    lineView1.backgroundColor = [UIColor colorWithHexString:@"#979797"];
    [self.BGView addSubview:lineView1];

    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.CreatWallImageView.mas_top);
        make.left.mas_equalTo(self.mas_left).with.mas_offset(self.width/3);
        make.width.mas_equalTo(1);
        make.bottom.mas_equalTo(self.CreatWallLB.mas_bottom);
    }];

    [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.CreatWallImageView.mas_top);
        make.left.mas_equalTo(self.mas_left).with.mas_offset(self.width * 2/3);
        make.width.mas_equalTo(1);
        make.bottom.mas_equalTo(self.CreatWallLB.mas_bottom);
    }];

    ///绑定事件
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] init];
    [[tap1 rac_gestureSignal] subscribeNext:^(id x) {
        NSLog(@"创建钱包");
        if (self.clickBlock) {
            self.clickBlock(CustomImportWalletType_CraetWall);
        }
        [self dismisss];
    }];
    [self.CreatWallImageView addGestureRecognizer:tap1];

    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] init];
    [[tap2 rac_gestureSignal] subscribeNext:^(id x) {
        NSLog(@"导入助记词");
        if (self.clickBlock) {
            self.clickBlock(CustomImportWalletType_MnmonicWord);
        }
        [self dismisss];
    }];
    [self.MoneWordImageView addGestureRecognizer:tap2];


    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] init];
    [[tap3 rac_gestureSignal] subscribeNext:^(id x) {
        NSLog(@"导入私钥");
        if (self.clickBlock) {
            self.clickBlock(CustomImportWalletType_PrivateKey);
        }
        [self dismisss];
    }];
    [self.PrivateImageView addGestureRecognizer:tap3];

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
- (IBAction)CanCleBtnClick:(UIButton *)sender {
    [self dismisss];
}

@end
