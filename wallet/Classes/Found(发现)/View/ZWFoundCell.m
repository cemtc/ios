//
//  ZWFoundCell.m
//  wallet
//
//  Created by 张威威 on 2019/9/18.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "ZWFoundCell.h"
@interface ZWFoundCell()
@property(nonatomic,strong)UIImageView *IconImageView;
@property(nonatomic,strong)UILabel *nameLB;
@property(nonatomic,strong)UILabel *DesLB;
@end
@implementation ZWFoundCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self.contentView addSubview:self.IconImageView];
        [self.contentView addSubview:self.nameLB];
        [self.contentView addSubview:self.DesLB];
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        UIView *line = [[UIView alloc]init];
        line.backgroundColor = [UIColor colorWithHexString:@"#CDD7DC"];
        [self.contentView addSubview:line];
        //70
        [self.IconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.left.mas_equalTo(self.contentView.mas_left).with.mas_offset(7);
            make.size.mas_equalTo(CGSizeMake(50, 50));
        }];

        [self.nameLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.IconImageView.mas_right).with.mas_offset(9);
            make.top.mas_equalTo(self.IconImageView.mas_top).with.mas_offset(3);
            make.size.mas_equalTo(CGSizeMake(200, 20));
        }];

        [self.DesLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.IconImageView.mas_right).with.mas_offset(9);
            make.top.mas_equalTo(self.nameLB.mas_bottom).with.mas_offset(3);
            make.width.mas_equalTo(SKScreenWidth - 80);
        }];

        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.DesLB.mas_left);
            make.bottom.mas_equalTo(self.contentView.mas_bottom);
            make.height.mas_equalTo(1);
            make.right.mas_equalTo(self.contentView.mas_right).with.mas_offset(-10);
        }];



    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)UpdateCellWith:(NSString *)iconImageName Name:(NSString *)name Des:(NSString *)des{
    self.IconImageView.image = [UIImage imageNamed:iconImageName];
    self.nameLB.text = name;
    self.DesLB.text = des;
}

-(UIImageView *)IconImageView{
    if (_IconImageView == nil) {
        _IconImageView = [[UIImageView alloc]init];
    }
    return _IconImageView;
}
-(UILabel *)nameLB{
    if (_nameLB == nil) {
        _nameLB = [[UILabel alloc]init];
        _nameLB.font = [UIFont systemFontOfSize:13];
        _nameLB.textColor = [UIColor colorWithHexString:@"#37416B"];
    }
    return _nameLB;
}
-(UILabel *)DesLB{
    if (_DesLB == nil) {
        _DesLB = [[UILabel alloc]init];
        _DesLB.font = [UIFont systemFontOfSize:13];
        _DesLB.textColor = [UIColor colorWithHexString:@"#9ba0b5"];
        _DesLB.numberOfLines = 0;
    }
    return _DesLB;
}
@end
