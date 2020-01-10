//
//  QYNewFinancialTopCell.m
//  wallet
//
//  Created by talking　 on 2019/7/4.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "QYNewFinancialTopCell.h"
#import "QYNewFinancialTopItemView.h"

#import "UIView+Tap.h"

@interface QYNewFinancialTopCell ()
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *lineLabel;

@property (nonatomic, strong) QYNewFinancialTopItemView *btcView;
@property (nonatomic, strong) QYNewFinancialTopItemView *ethView;
@property (nonatomic, strong) QYNewFinancialTopItemView *usdtView;



@end
@implementation QYNewFinancialTopCell

- (void)selectClickInfo:(NSString *)info{
    if (self.NextViewControllerBlock) {
        self.NextViewControllerBlock(info,self.currentSelectLicaiOrShuihui);
    }
}

- (QYNewFinancialTopItemView *)btcView {
    if (!_btcView) {
        SKDefineWeakSelf;
        _btcView = [[QYNewFinancialTopItemView alloc]init];
        _btcView.bgImageView.image = SKImageNamed(@"NFkuang");
        _btcView.iconimageView.image = [SKUtils scaleFromImage:SKImageNamed(@"qy_BTC") toSize:CGSizeMake(30, 30)];
        _btcView.title.text = @"BTC";
        [self.bgView addSubview:_btcView];
        
        [_btcView setTapActionWithBlock:^{
            [weakSelf selectClickInfo:@"BTC"];
        }];
    }
    return _btcView;
}
- (QYNewFinancialTopItemView *)ethView {
    if (!_ethView) {
        SKDefineWeakSelf;
        _ethView = [[QYNewFinancialTopItemView alloc]init];
        _ethView.bgImageView.image = SKImageNamed(@"NFkuang");
        _ethView.iconimageView.image = [SKUtils scaleFromImage:SKImageNamed(@"qy_ETH") toSize:CGSizeMake(30, 30)];
        _ethView.title.text = @"ETH";
        [self.bgView addSubview:_ethView];
        
        [_ethView setTapActionWithBlock:^{
            [weakSelf selectClickInfo:@"ETH"];
        }];
    }
    return _ethView;
}
- (QYNewFinancialTopItemView *)usdtView {
    if (!_usdtView) {
        SKDefineWeakSelf;
        _usdtView = [[QYNewFinancialTopItemView alloc]init];
        _usdtView.bgImageView.image = SKImageNamed(@"NFkuang");
        _usdtView.iconimageView.image = [SKUtils scaleFromImage:SKImageNamed(@"qy_USDT") toSize:CGSizeMake(30, 30)];
        _usdtView.title.text = @"USDT";
        [self.bgView addSubview:_usdtView];
        [_usdtView setTapActionWithBlock:^{
            [weakSelf selectClickInfo:@"USDT"];
        }];

    }
    return _usdtView;
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
        _titleLabel.text = @"请选择搬砖币种";
        _titleLabel.font = SKFont(14);
        _titleLabel.textColor = SKBlackColor;
        [self.bgView addSubview:_titleLabel];
    }
    return _titleLabel;
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
    
    
    [self.ethView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.bgView.mas_centerX);
        make.top.mas_equalTo(self.lineLabel.mas_bottom).offset(3);
    }];
    
    
    [self.btcView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.ethView.mas_centerY);
        make.left.mas_equalTo(self.bgView.mas_left).offset(10);
    }];
 
    [self.usdtView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.ethView.mas_centerY);
        make.right.mas_equalTo(self.bgView.mas_right).offset(-10);

    }];
}






//bgview
- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor = SKColor(240, 240, 240, 1.0);
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


- (void)setCurrentSelectLicaiOrShuihui:(BOOL)currentSelectLicaiOrShuihui {
    _currentSelectLicaiOrShuihui = currentSelectLicaiOrShuihui;
    
    if (currentSelectLicaiOrShuihui) {
        NSLog(@"QYNewFinancialTopCell赎回");
        self.titleLabel.text = @"请选择提现币种";
        
        if ([self.rightCurrentInfo isEqualToString:@"BTC"]) {
            self.btcView.bgImageView.image = SKImageNamed(@"NFkuangSelect");
            self.ethView.bgImageView.image = SKImageNamed(@"NFkuang");
            self.usdtView.bgImageView.image = SKImageNamed(@"NFkuang");
        }else if([self.rightCurrentInfo isEqualToString:@"ETH"]){
            self.ethView.bgImageView.image = SKImageNamed(@"NFkuangSelect");
            self.usdtView.bgImageView.image = SKImageNamed(@"NFkuang");
            self.btcView.bgImageView.image = SKImageNamed(@"NFkuang");
        }else if([self.rightCurrentInfo isEqualToString:@"USDT"]){
            self.usdtView.bgImageView.image = SKImageNamed(@"NFkuangSelect");
            self.btcView.bgImageView.image = SKImageNamed(@"NFkuang");
            self.ethView.bgImageView.image = SKImageNamed(@"NFkuang");
        }

    }else{
        self.titleLabel.text = @"请选择搬砖币种";
        NSLog(@"QYNewFinancialTopCell搬砖");
        if ([self.leftCurrentInfo isEqualToString:@"BTC"]) {
            self.btcView.bgImageView.image = SKImageNamed(@"NFkuangSelect");
            self.ethView.bgImageView.image = SKImageNamed(@"NFkuang");
            self.usdtView.bgImageView.image = SKImageNamed(@"NFkuang");
        }else if([self.leftCurrentInfo isEqualToString:@"ETH"]){
            self.ethView.bgImageView.image = SKImageNamed(@"NFkuangSelect");
            self.usdtView.bgImageView.image = SKImageNamed(@"NFkuang");
            self.btcView.bgImageView.image = SKImageNamed(@"NFkuang");
        }else if([self.leftCurrentInfo isEqualToString:@"USDT"]){
            self.usdtView.bgImageView.image = SKImageNamed(@"NFkuangSelect");
            self.btcView.bgImageView.image = SKImageNamed(@"NFkuang");
            self.ethView.bgImageView.image = SKImageNamed(@"NFkuang");
        }
        
    }
    
}

@end
