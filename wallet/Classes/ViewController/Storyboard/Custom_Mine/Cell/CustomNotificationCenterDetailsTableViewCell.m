//
//  CustomNotificationCenterDetailsTableViewCell.m
//  wallet
//
//  Created by 曾云 on 2019/8/18.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "CustomNotificationCenterDetailsTableViewCell.h"

@interface CustomNotificationCenterDetailsTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *details;

@end

@implementation CustomNotificationCenterDetailsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setKeyValueModel:(ObjcKeyValueModel *)keyValueModel {
    _keyValueModel = keyValueModel;
    if (_keyValueModel) {
        self.title.text = _keyValueModel.key;
        self.details.text = _keyValueModel.value;
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
