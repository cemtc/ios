//
//  QYNewFinancialCenterCell.m
//  wallet
//
//  Created by talking　 on 2019/7/4.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "QYNewFinancialCenterCell.h"
#import "UIButton+Addition.h"//快速创建一个button
#import "UIView+Tap.h"

@interface QYNewFinancialCenterCell ()
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *lineLabel;




@property (nonatomic, strong) UILabel *tipLabel;//余额
@property (nonatomic, strong) UILabel *tipLabel1;//汇率

@property (nonatomic, strong) UILabel *tipShuhuiLeftLabel;
@property (nonatomic, strong) UILabel *tipShuhuiRightLabel;



@property (nonatomic, strong) UIButton *sureButton;


@property(nonatomic, strong) UILabel *rightLabelBtn;

@end

@implementation QYNewFinancialCenterCell
- (UILabel *)rightLabelBtn {
    if (!_rightLabelBtn) {
        _rightLabelBtn = [[UILabel alloc]init];
        _rightLabelBtn.font = SKFont(12);
        _rightLabelBtn.textColor = SKColor(198, 167, 113, 1.0);
        _rightLabelBtn.textAlignment = NSTextAlignmentRight;
        _rightLabelBtn.text = @"all";
        [self.bgView addSubview:_rightLabelBtn];
    }
    return _rightLabelBtn;
}
- (UILabel *)tipLabel {
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc]init];
        _tipLabel.text = @"余额：0.45765345BTC";
        _tipLabel.font = SKFont(11);
        _tipLabel.textColor = SKColor(49, 57, 75, 1.0);
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        [self.bgView addSubview:_tipLabel];
    }
    return _tipLabel;
}
- (UILabel *)tipLabel1 {
    if (!_tipLabel1) {
        _tipLabel1 = [[UILabel alloc]init];
        _tipLabel1.text = @"≈$0.00";
        _tipLabel1.font = SKFont(11);
        _tipLabel1.textColor = SKItemNormalColor;
        _tipLabel1.textAlignment = NSTextAlignmentCenter;
        [self.bgView addSubview:_tipLabel1];
    }
    return _tipLabel1;
}

- (UILabel *)tipShuhuiLeftLabel {
    if (!_tipShuhuiLeftLabel) {
        _tipShuhuiLeftLabel = [[UILabel alloc]init];
        _tipShuhuiLeftLabel.text = @"可提现：0.45765345BTC";
        _tipShuhuiLeftLabel.font = SKFont(11);
        _tipShuhuiLeftLabel.textColor = SKBlackColor;
        _tipShuhuiLeftLabel.textAlignment = NSTextAlignmentLeft;
        [self.bgView addSubview:_tipShuhuiLeftLabel];
    }
    return _tipShuhuiLeftLabel;
}
- (UILabel *)tipShuhuiRightLabel {
    if (!_tipShuhuiRightLabel) {
        _tipShuhuiRightLabel = [[UILabel alloc]init];
        _tipShuhuiRightLabel.text = @"手续费5%，汇率1WINT≈0.002BTC";
        _tipShuhuiRightLabel.font = SKFont(11);
        _tipShuhuiRightLabel.textColor = SKItemNormalColor;
        _tipShuhuiRightLabel.textAlignment = NSTextAlignmentRight;
        _tipShuhuiRightLabel.numberOfLines = 0;
        [self.bgView addSubview:_tipShuhuiRightLabel];
    }
    return _tipShuhuiRightLabel;
}

- (UILabel *)lineLabel {
    if (!_lineLabel) {
        _lineLabel = [[UILabel alloc]init];
        _lineLabel.alpha = 0.4;
        _lineLabel.backgroundColor = [UIColor colorWithHexString:@"#2E303B"];
        [self.bgView addSubview:_lineLabel];
    }
    return _lineLabel;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = @"请输入搬砖数量";
        _titleLabel.font = SKFont(14);
        _titleLabel.textColor = SKBlackColor;
        [self.bgView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UIButton *)sureButton {
    if (!_sureButton) {
        _sureButton = [UIButton buttonWithTitle:@"确认搬砖" titleColor:SKWhiteColor bgColor:SKColor(198, 167, 113, 1.0) fontSize:20 target:self action:@selector(sureButtonClick:)];
        _sureButton.layer.cornerRadius = 3;
        [self.bgView addSubview:_sureButton];
    }
    return _sureButton;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left);
        make.right.mas_equalTo(self.contentView.mas_right);
        make.top.mas_equalTo(self.contentView.mas_top);
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgView.mas_left).offset(10);
        make.top.mas_equalTo(self.bgView.mas_top).offset(10);
    }];
    [self.lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(10);
        make.left.mas_equalTo(self.titleLabel.mas_left);
        make.right.mas_equalTo(self.bgView.mas_right).offset(-10);
        make.height.mas_equalTo(1);
    }];
    
    
    
    
    [self.inputTextfield1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.lineLabel.mas_top).offset(35);
        make.left.mas_equalTo(self.bgView.mas_left).offset(35);
        make.right.mas_equalTo(self.bgView.mas_right).offset(-35);
        make.height.mas_equalTo(34);
    }];
    [self.inputTextfield2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.lineLabel.mas_top).offset(35);
        make.left.mas_equalTo(self.bgView.mas_left).offset(35);
        make.right.mas_equalTo(self.bgView.mas_right).offset(-35);
        make.height.mas_equalTo(34);
    }];

    
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.mas_equalTo(self.bgView);
        make.top.mas_equalTo(self.lineLabel.mas_top).offset(35 + 34 + 5);
        make.left.mas_equalTo(self.inputTextfield1.mas_left);
    }];
    [self.tipLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.tipLabel.mas_top);
        make.right.mas_equalTo(self.inputTextfield1.mas_right);
    }];
    [self.tipShuhuiLeftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.tipLabel);
        make.left.mas_equalTo(self.bgView.mas_left).offset(35);
    }];
    [self.tipShuhuiRightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.tipLabel);
        make.right.mas_equalTo(self.bgView.mas_right).offset(-35);
        make.left.mas_equalTo(self.bgView.mas_centerX);
    }];

    
    [self.sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tipLabel.mas_bottom).offset(35);
        make.left.equalTo(self.bgView).offset(10);
        make.right.equalTo(self.bgView).offset(-10);
        make.height.mas_equalTo(45);
    }];

    [self.rightLabelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.titleLabel.mas_centerY);
        make.right.mas_equalTo(self.bgView.mas_right).offset(-10);
    }];
    
    SKDefineWeakSelf;
    [self.rightLabelBtn setTapActionWithBlock:^{
        [weakSelf quanbulicaiClick];
    }];
}
- (void)quanbulicaiClick{
    if (self.NextViewControllerBlock) {
        self.NextViewControllerBlock(@"RightBtn", self.currentSelectLicaiOrShuihui);
    }
}
-(BOOL)firstColor:(UIColor*)firstColor secondColor:(UIColor*)secondColor
{
    if (CGColorEqualToColor(firstColor.CGColor, secondColor.CGColor))
    {
        NSLog(@"颜色相同");
        return YES;
    }
    else
    {
        NSLog(@"颜色不同");
        return NO;
    }
}
- (void)sureButtonClick:(UIButton *)button {
    
    if ([self firstColor:button.backgroundColor secondColor:SKItemNormalColor]) {
        [MBProgressHUD showMessage:@"请关闭智能AI后再进行搬砖"];
        return;
    }

    
    if (self.NextViewControllerBlock) {
        self.NextViewControllerBlock(@"SureButton", self.currentSelectLicaiOrShuihui);
    }
}

//bgview
- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor = SKWhiteColor;
        [self.contentView addSubview:_bgView];
    }
    return _bgView;
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (UITextField *)inputTextfield1 {
    if (!_inputTextfield1) {
        _inputTextfield1 = [[UITextField alloc]init];
        _inputTextfield1.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入搬砖数量" attributes:@{NSForegroundColorAttributeName: SKItemNormalColor,NSFontAttributeName:[UIFont systemFontOfSize:14.0]}];
        _inputTextfield1.backgroundColor = SKColor(214, 217, 223, 1.0);
        _inputTextfield1.textColor = SKBlackColor;
        //        _rightTextField.keyboardType = UIKeyboardTypePhonePad;
        _inputTextfield1.keyboardType = UIKeyboardTypeDecimalPad;
        _inputTextfield1.textAlignment = NSTextAlignmentCenter;
        [self.bgView addSubview:_inputTextfield1];
        
        _inputTextfield1.tag = 1;
        [_inputTextfield1 addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        
    }
    return _inputTextfield1;
}
- (UITextField *)inputTextfield2 {
    if (!_inputTextfield2) {
        _inputTextfield2 = [[UITextField alloc]init];
        _inputTextfield2.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入提现数量" attributes:@{NSForegroundColorAttributeName: SKItemNormalColor,NSFontAttributeName:[UIFont systemFontOfSize:14.0]}];
        _inputTextfield2.backgroundColor = SKColor(214, 217, 223, 1.0);
        _inputTextfield2.textColor = SKBlackColor;
        //        _rightTextField.keyboardType = UIKeyboardTypePhonePad;
        _inputTextfield2.keyboardType = UIKeyboardTypeDecimalPad;
        _inputTextfield2.textAlignment = NSTextAlignmentCenter;
        [self.bgView addSubview:_inputTextfield2];
        
        _inputTextfield2.tag = 2;
        [_inputTextfield2 addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _inputTextfield2;
}
- (void)textFieldDidChange:(UITextField *)textField {
    if (textField.tag == 2) {
        
        if (self.inputTextfieldBlock) {
            self.inputTextfieldBlock(textField.text, YES);
        }
        
    }else if (textField.tag == 1){

        if (self.inputTextfieldBlock) {
            self.inputTextfieldBlock(textField.text, NO);
        }

    }
    
    
}


- (void)setCurrentSelectLicaiOrShuihui:(BOOL)currentSelectLicaiOrShuihui {
    _currentSelectLicaiOrShuihui = currentSelectLicaiOrShuihui;
    
    if (currentSelectLicaiOrShuihui) {
        NSLog(@"QYNewFinancialCenterCell赎回");
        self.titleLabel.text = @"请输入提现数量";
        self.rightLabelBtn.text = @"all";
        
        
        
        self.tipLabel.hidden = YES;
        self.tipLabel1.hidden = YES;
        self.tipShuhuiRightLabel.hidden = NO;
        self.tipShuhuiLeftLabel.hidden = NO;
        
        [self.sureButton setTitle:@"确认提现" forState:UIControlStateNormal];

        
        //可以点击
        self.sureButton.backgroundColor = SKColor(198, 167, 113, 1.0);
        self.sureButton.enabled = YES;
        
//
//        //赎回
//        @property (nonatomic, copy) NSString * ruseBalance1;//余额
//        @property (nonatomic, copy) NSString * rpoundage2;//手续费
//        @property (nonatomic, copy) NSString * rtokenExchageRate3;//汇率
//
//@"可赎：0.45765345BTC"
//        self.tipShuhuiRightLabel.text = @"手续费5%，汇率1PTB≈0.002BTC";

        self.tipShuhuiLeftLabel.text = [NSString stringWithFormat:@"可提现：%@%@",self.ruseBalance1,self.rightCurrentInfo];
        self.tipShuhuiRightLabel.text = [NSString stringWithFormat:@"手续费%@%@，汇率1WINT≈%@%@",self.rpoundage2,@"%",self.rtokenExchageRate3,self.rightCurrentInfo];


        self.inputTextfield2.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入提现数量" attributes:@{NSForegroundColorAttributeName: SKItemNormalColor,NSFontAttributeName:[UIFont systemFontOfSize:14.0]}];

        self.inputTextfield2.text = self.rightTextField;
        
        self.inputTextfield1.hidden = YES;
        self.inputTextfield2.hidden = NO;
        
//        self.sureButton.hidden = NO;
        
    }else{
        NSLog(@"QYNewFinancialCenterCell搬砖");
        self.titleLabel.text = @"请输入搬砖数量";
        self.rightLabelBtn.text = @"all";
        
        
        self.tipLabel.hidden = NO;
        self.tipLabel1.hidden = NO;

        self.tipShuhuiRightLabel.hidden = YES;
        self.tipShuhuiLeftLabel.hidden = YES;

        [self.sureButton setTitle:@"确认搬砖" forState:UIControlStateNormal];

        //确认理财按钮颜色
        if (self.lisOn) {
            //可以点击
            self.sureButton.backgroundColor = SKColor(198, 167, 113, 1.0);
            self.sureButton.enabled = YES;
        }else{
            self.sureButton.backgroundColor = SKItemNormalColor;
//            self.sureButton.enabled = NO;
            //如果他是灰色的时候也能点击
        }

        
        self.inputTextfield1.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入搬砖数量" attributes:@{NSForegroundColorAttributeName: SKItemNormalColor,NSFontAttributeName:[UIFont systemFontOfSize:14.0]}];
        
        self.inputTextfield1.text = self.leftTextField;
        
        
//        @"余额：0.45765345BTC";
        self.tipLabel.text = [NSString stringWithFormat:@"余额：%@%@",self.leftBalanceNum,self.leftCurrentInfo];
        
        
//        if (self.duihuanHuilu) {
//            self.tipLabel1.text = [NSString stringWithFormat:@"≈$%@",self.duihuanHuilu];
//        }else{
//            self.tipLabel1.text = [NSString stringWithFormat:@"≈$%@",@"0.00"];
//        }

        

        self.inputTextfield1.hidden = NO;
        self.inputTextfield2.hidden = YES;
        
//        self.sureButton.hidden = YES;

    }
    
}
- (void)setDuihuanHuilu:(NSString *)duihuanHuilu{
    _duihuanHuilu = duihuanHuilu;
    
    if (duihuanHuilu) {
        self.tipLabel1.text = [NSString stringWithFormat:@"≈$%@",duihuanHuilu];
    }else{
        self.tipLabel1.text = [NSString stringWithFormat:@"≈$%@",@"0.00"];
    }

    
}
@end
