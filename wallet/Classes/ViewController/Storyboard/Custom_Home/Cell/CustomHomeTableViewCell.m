//
//  CustomHomeTableViewCell.m
//  wallet
//
//  Created by 曾云 on 2019/8/17.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "CustomHomeTableViewCell.h"


@interface CustomHomeTableViewCell ()

@end

@implementation CustomHomeTableViewCell
- (void)setItemModel:(CustomHomeItemModel *) itemModel{
    _itemModel = itemModel;
    if (_itemModel) {
        self.name.text = _itemModel.name;
        self.balance.text = [NSString stringWithFormat:@"%f",_itemModel.balance];
        self.price.text = [NSString stringWithFormat:@"≈￥ %f",self.itemModel.balance * self.itemModel.exchange];

//        if ([_itemModel.name isEqualToString:@"SAR"])
//        {
//            NSString *obj=[[NSUserDefaults standardUserDefaults] objectForKey:@"ccmFiatPrice"];
//            [[NSUserDefaults standardUserDefaults] synchronize];
//            NSDecimalNumber *num = [[NSDecimalNumber alloc]initWithString:[CSingleSample instance].ccmFiatPrice];
//             self.price.text = [NSString stringWithFormat:@"≈￥ %@",[self numberCalculate:self.itemModel.balance exchange:[num doubleValue]]];
//
//        }else{
//            self.price.text = [NSString stringWithFormat:@"≈￥ %f",self.itemModel.balance * self.itemModel.exchange];
//        }
//        NSLog(@"==%@",_itemModel.imgUrl);
        [self.image sd_setImageWithURL:[NSURL URLWithString:_itemModel.imgUrl] placeholderImage:[UIImage imageNamed:@"icon_export_logo"]];
//
    }
    
}
-(NSString *)numberCalculate:(double)balance exchange:(double)exchange{

    NSString *amBalance = [NSString stringWithFormat:@"%.6f",balance];
    NSString *exBalance = [NSString stringWithFormat:@"%.6f",exchange];
    if ([exBalance isEqualToString:@"nan"]) {
        exBalance = @"0";
    }
    NSDecimalNumber *amtDecimal = [NSDecimalNumber decimalNumberWithString:amBalance];
    NSDecimalNumber *exDecimal = [NSDecimalNumber decimalNumberWithString:exBalance];
    NSDecimalNumber *result = [amtDecimal decimalNumberByMultiplyingBy:exDecimal];
    return [result stringValue];
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
