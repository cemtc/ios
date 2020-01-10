//
//  UIBaseStoryBoardTableViewCell.m
//  wallet
//
//  Created by 曾云 on 2019/8/17.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "UIBaseStoryBoardTableViewCell.h"

@implementation UIBaseStoryBoardTableViewCell


+ (instancetype)cellWithTableView:(UITableView *)tableView identifier:(NSString *)identifier {
    return [self cellWithTableView:tableView identifier:identifier index:0];
}

+ (instancetype)cellWithTableView:(UITableView *)tableView identifier:(NSString *)identifier index:(NSInteger) index {
    
    UIBaseStoryBoardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [cell storyBoardCellWithTableView:tableView identifier:identifier index:index];
    }
    return cell;
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
