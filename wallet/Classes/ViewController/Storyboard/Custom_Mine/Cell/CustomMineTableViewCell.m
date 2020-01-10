//
//  CustomMineTableViewCell.m
//  wallet
//
//  Created by 曾云 on 2019/8/17.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "CustomMineTableViewCell.h"

@interface CustomMineTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIButton *count;

@end

@implementation CustomMineTableViewCell

- (void)setItemModel:(CustomMineItemModel *)itemModel {
    _itemModel = itemModel;
    if (_itemModel) {
        self.title.text = _itemModel.title;
        self.count.hidden = YES;
        if (_itemModel.type == CustomMineItemType_NotificationCenter) {
            if (_itemModel.count) {
                self.count.hidden = NO;
                [self.count setTitle:[NSString stringWithFormat:@"%ld",_itemModel.count] forState:UIControlStateNormal];
            }
        }
    }
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
