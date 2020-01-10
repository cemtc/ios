//
//  QYExportPrivateListCell.m
//  wallet
//
//  Created by talking　 on 2019/6/26.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "QYExportPrivateListCell.h"
#import "QYExportPrivateListModel.h"
#import "UIView+Layer.h"
#import "UIView+Tap.h"
#import "CFQLabelBgView.h"


@interface QYExportPrivateListCell ()
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *lineLabel;

@property (nonatomic, strong) UIImageView *passwordIsTrueimageView;


@property (nonatomic, strong) UIImageView *qrImageView1;
@property (nonatomic, strong) UIImageView *qrImageView2;


@property (nonatomic, strong) UILabel *leftTitleLabel1;
@property (nonatomic, strong) UILabel *leftTitleLabel2;

@property (nonatomic, strong) UILabel *leftContentLabel1;
@property (nonatomic, strong) UILabel *leftContentLabel2;


//用于隐藏显示
@property (nonatomic, strong) UILabel *leftContentLabel3;


@property (nonatomic, strong) CFQLabelBgView * rightLabel1;
@property (nonatomic, strong) CFQLabelBgView * rightLabel2;

@end

@implementation QYExportPrivateListCell
- (UILabel *)leftContentLabel1 {
    if (!_leftContentLabel1) {
        _leftContentLabel1 = [[UILabel alloc]init];
        _leftContentLabel1.numberOfLines = 0;
        _leftContentLabel1.textColor = SKWhiteColor;
        _leftContentLabel1.font = SKFont(9);
        [self.bgView addSubview:_leftContentLabel1];
    }
    return _leftContentLabel1;
}
- (UILabel *)leftContentLabel2 {
    if (!_leftContentLabel2) {
        _leftContentLabel2 = [[UILabel alloc]init];
        _leftContentLabel2.numberOfLines = 0;
        _leftContentLabel2.textColor = SKWhiteColor;
        _leftContentLabel2.font = SKFont(9);
        [self.bgView addSubview:_leftContentLabel2];
    }
    return _leftContentLabel2;
}

- (UILabel *)leftContentLabel3 {
    if (!_leftContentLabel3) {
        _leftContentLabel3 = [[UILabel alloc]init];
        _leftContentLabel3.numberOfLines = 0;
        _leftContentLabel3.textColor = SKWhiteColor;
        _leftContentLabel3.font = SKFont(9);
        [self.bgView addSubview:_leftContentLabel3];
    }
    return _leftContentLabel3;
}


- (CFQLabelBgView *)rightLabel1 {
    if (!_rightLabel1) {
        _rightLabel1 = [[CFQLabelBgView alloc]init];
        _rightLabel1.layerCornerRadius = 3;
        _rightLabel1.titleColor = SKColor(46, 48, 59, 1.0);
        _rightLabel1.font = SKFont(11);
        _rightLabel1.bgColor = SKWhiteColor;
        _rightLabel1.textAlignment = NSTextAlignmentCenter;
        _rightLabel1.title = @"Copy";
        [self.bgView addSubview:_rightLabel1];
    }
    return _rightLabel1;
}
- (CFQLabelBgView *)rightLabel2 {
    if (!_rightLabel2) {
        _rightLabel2 = [[CFQLabelBgView alloc]init];
        _rightLabel2.layerCornerRadius = 3;
        _rightLabel2.titleColor = SKColor(46, 48, 59, 1.0);
        _rightLabel2.font = SKFont(11);
        _rightLabel2.bgColor = SKWhiteColor;
        _rightLabel2.textAlignment = NSTextAlignmentCenter;
        _rightLabel2.title = @"Copy";
        [self.bgView addSubview:_rightLabel2];
    }
    return _rightLabel2;
}

- (UILabel *)leftTitleLabel1 {
    if (!_leftTitleLabel1) {
        _leftTitleLabel1 = [[UILabel alloc]init];
        _leftTitleLabel1.font = SKFont(11);
        _leftTitleLabel1.textColor = SKWhiteColor;
        _leftTitleLabel1.text = @"address:";
        _leftTitleLabel1.textAlignment = NSTextAlignmentRight;
        [self.bgView addSubview:_leftTitleLabel1];
    }
    return _leftTitleLabel1;
}
- (UILabel *)leftTitleLabel2 {
    if (!_leftTitleLabel2) {
        _leftTitleLabel2 = [[UILabel alloc]init];
        _leftTitleLabel2.font = SKFont(11);
        _leftTitleLabel2.textColor = SKWhiteColor;
        _leftTitleLabel2.text = @"private key:";
        _leftTitleLabel2.textAlignment = NSTextAlignmentRight;

        [self.bgView addSubview:_leftTitleLabel2];
    }
    return _leftTitleLabel2;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(10);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-10);
        make.top.mas_equalTo(self.contentView.mas_top);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-15);
    }];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgView.mas_left).offset(10);
        make.top.mas_equalTo(self.bgView.mas_top).offset(10);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.iconImageView.mas_centerY);
        make.left.mas_equalTo(self.iconImageView.mas_right).offset(10);
    }];
    [self.lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgView.mas_left).offset(10);
        make.right.mas_equalTo(self.bgView.mas_right).offset(-10);
        make.height.mas_equalTo(1);
        make.top.mas_equalTo(self.iconImageView.mas_bottom).offset(10);
    }];
    
    [self.passwordIsTrueimageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.iconImageView.mas_centerY);
        make.right.mas_equalTo(self.bgView.mas_right).offset(-20);
    }];
    self.passwordIsTrueimageView.image = SKImageNamed(@"icon_close");
    SKDefineWeakSelf;
    [self.passwordIsTrueimageView setTapActionWithBlock:^{
        [weakSelf passWorldTrueAndFalseHandle];
    }];
    
    [self.qrImageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(45);
        make.left.mas_equalTo(self.bgView.mas_left).offset(10);
        make.top.mas_equalTo(self.lineLabel.mas_bottom).offset(10);
    }];

    [self.qrImageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(45);
        make.left.mas_equalTo(self.bgView.mas_left).offset(10);
        make.top.mas_equalTo(self.qrImageView1.mas_bottom).offset(15);
    }];
    
    [self.leftTitleLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.qrImageView1.mas_centerY);
        make.left.mas_equalTo(self.qrImageView1.mas_right).offset(5);
        make.width.mas_equalTo(30);
    }];
    [self.leftTitleLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.qrImageView2.mas_centerY);
        make.left.mas_equalTo(self.qrImageView2.mas_right).offset(5);
        make.width.mas_equalTo(30);
    }];
    
    
    [self.rightLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(20);
        make.centerY.mas_equalTo(self.qrImageView1.mas_centerY);
        make.right.mas_equalTo(self.bgView.mas_right).offset(-10);
    }];
    
    
    
    [self.rightLabel1 setTapActionWithBlock:^{
        [weakSelf copLabelCilck:1];
    }];

    [self.rightLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(20);
        make.centerY.mas_equalTo(self.qrImageView2.mas_centerY);
        make.right.mas_equalTo(self.bgView.mas_right).offset(-10);
    }];
    
    
    
    [self.rightLabel2 setTapActionWithBlock:^{
        [weakSelf copLabelCilck:2];
    }];

    
    
    //地址 和 私钥
    [self.leftContentLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.qrImageView1.mas_centerY);
        make.left.mas_equalTo(self.leftTitleLabel1.mas_right).offset(10);
        make.right.mas_equalTo(self.rightLabel1.mas_left).mas_equalTo(-15);
    }];
    [self.leftContentLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.qrImageView2.mas_centerY);
        make.left.mas_equalTo(self.leftTitleLabel2.mas_right).offset(10);
        make.right.mas_equalTo(self.rightLabel2.mas_left).mas_equalTo(-15);
    }];
    
    [self.leftContentLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.qrImageView2.mas_centerY);
        make.left.mas_equalTo(self.leftTitleLabel2.mas_right).offset(10);
        make.right.mas_equalTo(self.rightLabel2.mas_left).mas_equalTo(-15);
    }];
    
    //隐藏
    self.leftContentLabel2.hidden = YES;
}
- (void)copLabelCilck:(NSInteger)index{
    NSString *str = @"";
    if (index == 1) {
        str = self.leftContentLabel1.text;
    }else if (index == 2){
        str = self.leftContentLabel2.text;
    }
    [UIPasteboard generalPasteboard].string = str;
    [MBProgressHUD showMessage:@"Copy success"];
}
- (void)passWorldTrueAndFalseHandle {
    
    if (self.leftContentLabel2.isHidden) {
        //显示
        self.leftContentLabel2.hidden = NO;
        self.leftContentLabel3.hidden = YES;
        self.passwordIsTrueimageView.image = SKImageNamed(@"icon_open");

    }else{
        //隐藏
        self.leftContentLabel2.hidden = YES;
        self.leftContentLabel3.hidden = NO;
        self.passwordIsTrueimageView.image = SKImageNamed(@"icon_close");

    }
}


- (void)setModel:(QYExportPrivateListModel *)model{
    _model = model;
    self.iconImageView.image = [SKUtils scaleFromImage:SKImageNamed(model.imageName) toSize:CGSizeMake(35, 35)];
    self.titleLabel.text = model.title;
    
    
    
    CFQtestSwift *a = [[CFQtestSwift alloc]init];
    //内容 就是 aaa
    self.qrImageView1.image = [a erweimaWithAddress:model.addressString];
    self.qrImageView2.image = [a erweimaWithAddress:model.privateString];

    
    
    self.leftContentLabel1.text = model.addressString;
    self.leftContentLabel2.text = model.privateString;
    
    
    NSMutableString *str3 = [NSMutableString new];
    for (NSInteger i = 0; i < self.leftContentLabel2.text.length; i++) {
        [str3 appendString:@"*"];
    }
    self.leftContentLabel3.text = str3.copy;

}
- (UIImageView *)qrImageView1 {
    if (!_qrImageView1) {
        _qrImageView1 = [[UIImageView alloc]init];
        [self.bgView addSubview:_qrImageView1];
    }
    return _qrImageView1;
}
- (UIImageView *)qrImageView2 {
    if (!_qrImageView2) {
        _qrImageView2 = [[UIImageView alloc]init];
        [self.bgView addSubview:_qrImageView2];
    }
    return _qrImageView2;
}

//bgview
- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor = SKColor(66, 73, 88, 1.0);
        _bgView.layer.cornerRadius = 5;
        [self.contentView addSubview:_bgView];
    }
    return _bgView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = SKFont(17);
        _titleLabel.textColor = SKWhiteColor;
        [self.bgView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UILabel *)lineLabel {
    if (!_lineLabel) {
        _lineLabel = [[UILabel alloc]init];
        _lineLabel.backgroundColor = SKWhiteColor;
        _lineLabel.alpha = 0.3;
        [self.bgView addSubview:_lineLabel];
    }
    return _lineLabel;
}

- (UIImageView *)iconImageView{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc]initWithImage:SKImageNamed(@"icon_market")];
        [self.bgView addSubview:_iconImageView];
    }
    return _iconImageView;
}


- (UIImageView *)passwordIsTrueimageView {
    if (!_passwordIsTrueimageView) {
        _passwordIsTrueimageView = [[UIImageView alloc]initWithImage:SKImageNamed(@"icon_close")];
        [self.bgView addSubview:_passwordIsTrueimageView];
    }
    return _passwordIsTrueimageView;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
