//
//  QYFinaLeftContentView.m
//  wallet
//
//  Created by talking　 on 2019/6/19.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "QYFinaLeftContentView.h"

@interface QYFinaLeftContentView ()

//币种
@property(nonatomic, strong)UILabel *leftTitleLabel1;
@property(nonatomic, strong)UILabel *leftTitleLabel2;






@property(nonatomic, strong) UILabel *bottomTipLabel;


@property(nonatomic, strong) UIImageView *rightLabel1ImageViewBtn;

@end

@implementation QYFinaLeftContentView
//改变部分颜色
NSAttributedString * (^blockA)(NSString *p,NSString *str,NSString *str1) = ^ NSAttributedString *(NSString *p,NSString *str,NSString *str1){
    NSMutableAttributedString * price_att_strA = [[NSMutableAttributedString alloc] initWithString:p];
    //        [price_att_strA addAttribute:NSFontAttributeName  value:[UIFont systemFontOfSize:13] range:[p rangeOfString:str]];
    [price_att_strA addAttribute:NSForegroundColorAttributeName value:SKColor(166, 193, 255, 1.0) range:[p rangeOfString:str]];
    [price_att_strA addAttribute:NSForegroundColorAttributeName value:SKColor(166, 193, 255, 1.0) range:[p rangeOfString:str1]];
    return price_att_strA.copy;
};

- (UIImageView *)rightLabel1ImageViewBtn {
    if (!_rightLabel1ImageViewBtn) {
        _rightLabel1ImageViewBtn = [[UIImageView alloc]initWithImage:SKImageNamed(@"三角形")];
    }
    return _rightLabel1ImageViewBtn;
}

- (UILabel *)bottomTipLabel {
    if (!_bottomTipLabel) {
        _bottomTipLabel = [[UILabel alloc]init];
        _bottomTipLabel.font = SKFont(11);
        _bottomTipLabel.textColor = SKColor(198, 167, 113, 1.0);
    }
    return _bottomTipLabel;
}

- (UILabel *)rightLabelBtn {
    if (!_rightLabelBtn) {
        _rightLabelBtn = [[UILabel alloc]init];
        _rightLabelBtn.textColor = SKColor(166, 193, 255, 1.0);
        _rightLabelBtn.font = SKFont(12);
        _rightLabelBtn.adjustsFontSizeToFitWidth = YES;
    }
    return _rightLabelBtn;
}


- (UITextField *)rightTextField {
    if (!_rightTextField) {
        _rightTextField = [[UITextField alloc]init];
        _rightTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入数量" attributes:@{NSForegroundColorAttributeName: SKItemNormalColor,NSFontAttributeName:[UIFont systemFontOfSize:12.0]}];
        _rightTextField.borderStyle = UITextBorderStyleRoundedRect;
        _rightTextField.layer.masksToBounds = YES;
        _rightTextField.layer.cornerRadius = 1;
        _rightTextField.backgroundColor = SKColor(166, 193, 255, 0.5);
        _rightTextField.textColor = SKWhiteColor;
//        _rightTextField.keyboardType = UIKeyboardTypePhonePad;
        _rightTextField.keyboardType = UIKeyboardTypeDecimalPad;

    }
    return _rightTextField;
}

- (UILabel *)rightLabel1 {
    if (!_rightLabel1) {
        _rightLabel1 = [[UILabel alloc]init];
        _rightLabel1.textColor = SKColor(166, 193, 255, 1.0);
        _rightLabel1.font = SKFont(14);
    }
    return _rightLabel1;
}

- (UILabel *)leftTitleLabel1 {
    if (!_leftTitleLabel1) {
        _leftTitleLabel1 = [[UILabel alloc]init];
        _leftTitleLabel1.textColor = SKWhiteColor;
        _leftTitleLabel1.font = SKFont(14);
    }
    return _leftTitleLabel1;
}
- (UILabel *)leftTitleLabel2 {
    if (!_leftTitleLabel2) {
        _leftTitleLabel2 = [[UILabel alloc]init];
        _leftTitleLabel2.textColor = SKWhiteColor;
        _leftTitleLabel2.font = SKFont(14);
    }
    return _leftTitleLabel2;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self customUI];
    }
    return self;
}
- (void)customUI {
    
    [self addSubview:self.topTextLabel];
    [self.topTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(10);
        make.right.mas_equalTo(self.mas_right).offset(-10);
        make.top.mas_equalTo(self.mas_top).offset(10);
    }];
    
    [self addSubview:self.lineL];
    [self.lineL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.topTextLabel.mas_bottom).offset(10);
        make.left.right.mas_equalTo(self.topTextLabel);
        make.height.mas_equalTo(1);
    }];
    
    [self addSubview:self.leftTitleLabel1];
    [self.leftTitleLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.topTextLabel.mas_left);
        make.top.mas_equalTo(self.topTextLabel.mas_bottom).offset(35);
    }];
    self.leftTitleLabel1.text = @"币种：";
    [self addSubview:self.leftTitleLabel2];
    [self.leftTitleLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.topTextLabel.mas_left);
        make.top.mas_equalTo(self.leftTitleLabel1.mas_bottom).offset(25);
    }];
    self.leftTitleLabel2.text = @"数量：";
    
    
    //======
    //币种
    [self addSubview:self.rightLabel1];
    [self.rightLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.leftTitleLabel1.mas_centerY);
        make.left.mas_equalTo(self.topTextLabel.mas_left).offset(60);
    }];
    self.rightLabel1.text = @"BTC";
    
    
    //选择btn
    [self addSubview:self.rightLabel1ImageViewBtn];
    [self.rightLabel1ImageViewBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.leftTitleLabel1.mas_centerY).offset(-2);
        make.right.mas_equalTo(self.mas_right).offset(-10);
    }];
    SKDefineWeakSelf;
    [self.rightLabel1ImageViewBtn setTapActionWithBlock:^{
        
        [weakSelf rightLabel1ImageViewBtnClickHandle];
    }];
    
    
    
    [self addSubview:self.rightLabelBtn];
    [self.rightLabelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.leftTitleLabel2.mas_centerY);
        make.right.mas_equalTo(self.mas_right).offset(-10);
        make.width.mas_equalTo(50);
    }];
    self.rightLabelBtn.text = @"all";
    [self.rightLabelBtn setTapActionWithBlock:^{
        if ([weakSelf.delegate respondsToSelector:@selector(qyFinaContentView:didClickInfo:)]) {
            [weakSelf.delegate qyFinaContentView:weakSelf didClickInfo:@"left_RightBtn"];
        }
    }];
    
    //textfield
    [self addSubview:self.rightTextField];
    [self.rightTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.rightLabel1.mas_left);
        make.right.mas_equalTo(self.rightLabelBtn.mas_left).offset(-15);
        make.centerY.mas_equalTo(self.leftTitleLabel2.mas_centerY);
    }];


    //tip
    [self addSubview:self.bottomTipLabel];
    [self.bottomTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.rightLabel1.mas_left);
        make.top.mas_equalTo(self.rightTextField.mas_bottom).offset(6);
    }];
    NSString *s = [NSString stringWithFormat:@"余额：%@ BTC",@"0"];
    self.bottomTipLabel.attributedText = blockA(s,@"余额：",@"BTC");
    
    self.sureButton = [UIButton buttonWithTitle:@"确认搬砖" titleColor:SKWhiteColor bgColor:SKColor(198, 167, 113, 1.0) fontSize:20 target:self action:@selector(sureButtonClick:)];
    [self addSubview:self.sureButton];
    [self.sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomTipLabel.mas_bottom).offset(40);
        make.left.equalTo(self).offset(20);
        make.right.equalTo(self).offset(-20);
        make.height.mas_equalTo(45);
    }];
    self.sureButton.layer.cornerRadius = 5;
    
    
    UIView *bgView = [[UIView alloc]init];
    bgView.backgroundColor = QYThemeColor;
    [self addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top);
        make.left.mas_equalTo(self.mas_left);
        make.right.mas_equalTo(self.mas_right);
        make.bottom.mas_equalTo(self.sureButton.mas_bottom).offset(35);
    }];
    [self sendSubviewToBack:bgView];
    bgView.layer.masksToBounds = YES;
    bgView.layer.cornerRadius = 3;
}
- (void)sureButtonClick:(UIButton *)button {
    if ([self.delegate respondsToSelector:@selector(qyFinaContentView:didClickInfo:)]) {
        [self.delegate qyFinaContentView:self didClickInfo:@"left"];
    }
}


-(void)rightLabel1ImageViewBtnClickHandle{
    
    NSLog(@"选择币种");
    
    if ([self.delegate respondsToSelector:@selector(qyFinaContentView:didClickInfo:)]) {

        [self.delegate qyFinaContentView:self didClickInfo:@"选择币种L"];
    }
    

}


- (void)setBalanceNum:(NSString *)balanceNum {
    _balanceNum = balanceNum;
    
    NSLog(@"limiande:%@",self.rightLabel1.text);

    NSString *s = [NSString stringWithFormat:@"余额：%@ %@",balanceNum,self.rightLabel1.text];
    self.bottomTipLabel.attributedText = blockA(s,@"余额：",self.rightLabel1.text);

}

@end
