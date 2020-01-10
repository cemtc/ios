//
//  QYRedemptionListCell.m
//  wallet
//
//  Created by talking　 on 2019/6/29.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "QYRedemptionListCell.h"
#import "CFQLabelBgView.h"
#import "UIView+Layer.h"

@interface QYRedemptionListCell ()
@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UIImageView *topImageView;
@property (nonatomic, strong) UILabel *topLabel1;
@property (nonatomic, strong) UIImageView *topImageView1;
@property (nonatomic, strong) UIImageView *topImageView2;
@property (nonatomic, strong) UILabel *topLabel2;

@property (nonatomic, strong) CFQLabelBgView * leftContentLabel;
@property (nonatomic, strong) CFQLabelBgView * rightContentLabel;
@property (nonatomic, strong) UILabel *centerLabel;

@property (nonatomic, strong) UILabel *lineLabel;

@property (nonatomic, strong) UILabel *bottomLeftLabel;
@property (nonatomic, strong) UILabel *bottomRightLabel;


@property (nonatomic, strong) UILabel *shouxufeiL;

@end

@implementation QYRedemptionListCell
- (UILabel *)bottomRightLabel {
    if (!_bottomRightLabel) {
        _bottomRightLabel = [[UILabel alloc]init];
        _bottomRightLabel.textColor = SKColor(222, 188, 19, 1.0);
        _bottomRightLabel.font = SKFont(14);
        [self.bgView addSubview:_bottomRightLabel];
    }
    return _bottomRightLabel;
}

- (UILabel *)bottomLeftLabel {
    if (!_bottomLeftLabel) {
        _bottomLeftLabel = [[UILabel alloc]init];
        _bottomLeftLabel.textColor = SKItemNormalColor;
        _bottomLeftLabel.font = SKFont(14);
        [self.bgView addSubview:_bottomLeftLabel];
    }
    return _bottomLeftLabel;
}
- (UILabel *)shouxufeiL{
    if (!_shouxufeiL) {
        _shouxufeiL = [[UILabel alloc]init];
        _shouxufeiL.textColor = SKColor(198, 167, 113, 1);
        _shouxufeiL.font = SKFont(11);
        [self.bgView addSubview:_shouxufeiL];
    }
    return _shouxufeiL;
}
- (UILabel *)lineLabel {
    if (!_lineLabel) {
        _lineLabel = [[UILabel alloc]init];
        _lineLabel.backgroundColor = SKItemNormalColor;
        _lineLabel.alpha = 0.2;
        [self.bgView addSubview:_lineLabel];
    }
    return _lineLabel;
}

- (CFQLabelBgView *)leftContentLabel {
    if (!_leftContentLabel) {
        _leftContentLabel = [[CFQLabelBgView alloc]init];
        _leftContentLabel.layerCornerRadius = 5;
        _leftContentLabel.titleColor = SKColor(46, 48, 59, 1.0);
        _leftContentLabel.font = SKFont(14);
        _leftContentLabel.bgColor = SKColor(241, 241, 241, 1.0);
        _leftContentLabel.textAlignment = NSTextAlignmentCenter;
        [self.bgView addSubview:_leftContentLabel];
    }
    return _leftContentLabel;
}
- (CFQLabelBgView *)rightContentLabel {
    if (!_rightContentLabel) {
        _rightContentLabel = [[CFQLabelBgView alloc]init];
        _rightContentLabel.layerCornerRadius = 5;
        _rightContentLabel.titleColor = SKColor(46, 48, 59, 1.0);
        _rightContentLabel.font = SKFont(14);
        _rightContentLabel.bgColor = SKColor(241, 241, 241, 1.0);
        _rightContentLabel.textAlignment = NSTextAlignmentCenter;
        [self.bgView addSubview:_rightContentLabel];
    }
    return _rightContentLabel;
}
- (UILabel *)centerLabel {
    if (!_centerLabel) {
        _centerLabel = [[UILabel alloc]init];
        _centerLabel.font = SKFont(16);
        _centerLabel.textColor = SKColor(153, 153, 153, 0.5);
        _centerLabel.text = @"=";
        [self.bgView addSubview:_centerLabel];
    }
    return _centerLabel;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left);
        make.right.mas_equalTo(self.contentView.mas_right);
        make.top.mas_equalTo(self.contentView.mas_top);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-5);
    }];
    
    [self.topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgView.mas_top).offset(10);
        make.left.mas_equalTo(self.bgView.mas_left).offset(15);
    }];

    [self.topLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.topImageView.mas_right).offset(5);
        make.top.mas_equalTo(self.topImageView.mas_top);
    }];
    
    [self.shouxufeiL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.topLabel1.mas_left);
        make.top.mas_equalTo(self.topLabel1.mas_bottom).offset(10);
    }];


    [self.lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.topImageView.mas_bottom).offset(15);
        make.left.mas_equalTo(self.topImageView.mas_left);
        make.right.mas_equalTo(self.bgView.mas_right).offset(-15);
        make.height.mas_equalTo(1);
    }];


    [self.bottomLeftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.lineLabel.mas_bottom).offset(15);
        make.left.mas_equalTo(self.lineLabel.mas_left);
//        make.bottom.mas_equalTo(self.bgView.mas_bottom).offset(-15);
    }];

    [self.bottomRightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.bottomLeftLabel.mas_centerY);
        make.right.mas_equalTo(self.lineLabel.mas_right);
    }];

    [self.leftContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.lineLabel.mas_right);
        make.centerY.mas_equalTo(self.topLabel1.mas_centerY);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(100);
    }];
}

- (void)setModel:(CFQCommonModel *)model{
    _model = model;
    
    
    NSString *imageString = [NSString stringWithFormat:@"qy_%@",model.coinTypeDesc];
    
    self.topImageView.image = [SKUtils scaleFromImage:SKImageNamed(imageString) toSize:CGSizeMake(40, 40)];
//    self.topImageView.image = SKImageNamed(@"qy_BTC");

    self.topLabel1.text = model.coinTypeDesc;
    
    self.shouxufeiL.text = [NSString stringWithFormat:@"手续费%@%@",model.ransomPoundage,@"%"];
    
    //    self.topImageView1.image = SKImageNamed(@"icon_next");
    //    self.topImageView2.image = SKImageNamed(@"wint_logo");
    
    
    //    self.topLabel2.text = @"WINT";
    
    self.leftContentLabel.title = [NSString stringWithFormat:@"%@ %@",model.ransomValue,model.coinTypeDesc];
    
    //    self.rightContentLabel.title = @"5354.64939 WINT";
    
    
    
    self.bottomLeftLabel.text = [SKUtils timeStampToTime:model.createTime];
    
    
    
    //1：发起转账；2：转账；3：失败；4：成功
    NSString *staString = @"提现中";
    if ([model.ransomStatus isEqualToString:@"1"]) {
        staString = @"提现中";
        self.bottomRightLabel.textColor = SKColor(222, 188, 19, 1.0);
        
    }else if ([model.ransomStatus isEqualToString:@"2"]){
        staString = @"提现中";
        self.bottomRightLabel.textColor = SKColor(222, 188, 19, 1.0);
        
    }else if ([model.ransomStatus isEqualToString:@"3"]){
        staString = @"提现失败";
        self.bottomRightLabel.textColor = SKColor(255, 73, 0, 1.0);
        
    }else if ([model.ransomStatus isEqualToString:@"4"]){
        staString = @"提现成功";
        self.bottomRightLabel.textColor = SKColor(0, 190, 62, 1.0);
        
    }
    self.bottomRightLabel.text = staString;
    
    
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
- (UIImageView *)topImageView {
    if (!_topImageView) {
        _topImageView = [[UIImageView alloc]init];
        [self.bgView addSubview:_topImageView];
    }
    return _topImageView;
}
- (UIImageView *)topImageView1 {
    if (!_topImageView1) {
        _topImageView1 = [[UIImageView alloc]init];
        [self.bgView addSubview:_topImageView1];
    }
    return _topImageView1;
}
- (UIImageView *)topImageView2 {
    if (!_topImageView2) {
        _topImageView2 = [[UIImageView alloc]init];
        [self.bgView addSubview:_topImageView2];
    }
    return _topImageView2;
}
- (UILabel *)topLabel1 {
    if (!_topLabel1) {
        _topLabel1 = [[UILabel alloc]init];
        _topLabel1.font = SKFont(16);
        _topLabel1.textColor = SKColor(51, 51, 51, 1.0);
        [self.bgView addSubview:_topLabel1];
    }
    return _topLabel1;
}
- (UILabel *)topLabel2 {
    if (!_topLabel2) {
        _topLabel2 = [[UILabel alloc]init];
        _topLabel2.font = SKFont(16);
        _topLabel2.textColor = SKColor(51, 51, 51, 1.0);
        [self.bgView addSubview:_topLabel2];
    }
    return _topLabel2;
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


