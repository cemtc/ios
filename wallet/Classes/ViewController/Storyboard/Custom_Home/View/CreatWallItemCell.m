//
//  CreatWallItemCell.m
//  wallet
//
//  Created by 张威威 on 2019/9/8.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "CreatWallItemCell.h"

@interface CreatWallItemCell()
@property(nonatomic,strong)UIImageView *BGImageView;
@property(nonatomic,strong)UIView *BGView;
@property(nonatomic,strong)UIImageView *IconImageView;
@property(nonatomic,strong)UILabel *TextLB;

@end
@implementation CreatWallItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)UpdateWithBgImageName:(NSString *)imagename iconImage:(NSString *)iconimage Title:(NSString *)title{
    self.BGImageView.image = [UIImage imageNamed:imagename];
    self.IconImageView.image = [UIImage imageNamed:iconimage];
    self.TextLB.text = title;
    if ([title isEqualToString:@"EMTC-Wallet"]) {
        self.BGView.backgroundColor = [UIColor colorWithHexString:@"#0793c2"];
    }else if ([title isEqualToString:@"BTC-Wallet"]){
        self.BGView.backgroundColor = [UIColor colorWithHexString:@"#fe9e00"];
    }else if ([title isEqualToString:@"USDT-Wallet"]){
        self.BGView.backgroundColor = [UIColor colorWithHexString:@"#1EB284"];
    }else if ([title isEqualToString:@"ETH-Wallet"]){
        self.BGView.backgroundColor = [UIColor colorWithHexString:@"#343434"];
    }
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUpUI];
    }
    return self;
}
-(void)setUpUI{
    CGFloat screenwidth = [UIScreen mainScreen].bounds.size.width;
    //CGFloat screenheight = [UIScreen mainScreen].bounds.size.height;
    self.contentView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.BGView];
    [self.BGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).with.mas_offset(10);
        make.top.mas_equalTo(self.contentView.mas_top);
        make.size.mas_equalTo(CGSizeMake(screenwidth - 20, 85));
    }];


    [self.BGView addSubview:self.BGImageView];
    [self.BGImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.BGView.mas_right).with.mas_offset(0);
        make.bottom.mas_equalTo(self.BGView.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(150, 50));
    }];
    [self.BGView addSubview:self.IconImageView];
    [self.IconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.BGView.mas_left).with.mas_offset(15);
        make.centerY.mas_equalTo(self.BGView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(28, 28));
    }];

    [self.BGView addSubview:self.TextLB];
    [self.TextLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.IconImageView.mas_right).with.mas_offset(10);
        make.centerY.mas_equalTo(self.IconImageView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(200, 25));
    }];

    
}
-(UIView *)BGView{
    if (_BGView == nil) {
        _BGView = [[UIView alloc]init];
        _BGView.layer.cornerRadius = 6;
        _BGView.layer.masksToBounds = YES;
    }
    return _BGView;
}
-(UIImageView *)BGImageView{
    if (_BGImageView == nil) {
        _BGImageView = [[UIImageView alloc]init];
    }
    return _BGImageView;
}
-(UIImageView *)IconImageView{
    if (_IconImageView == nil) {
        _IconImageView = [[UIImageView alloc]init];
    }
    return _IconImageView;
}
-(UILabel *)TextLB{
    if (_TextLB == nil) {
        _TextLB = [[UILabel alloc]init];
        _TextLB.font = [UIFont systemFontOfSize:18];
        _TextLB.textColor = [UIColor whiteColor];
    }
    return _TextLB;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
