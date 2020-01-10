//
//  EFTagCell.m
//  wallet
//
//  Created by 董文龙 on 2019/11/28.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "EFTagCell.h"
#import "EFTagsItem.h"

@implementation EFTagCell



- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    self.layer.borderColor = [UIColor colorWithRed:221 / 255.0 green:221 / 255.0 blue:221 / 255.0 alpha:1].CGColor;
    self.layer.borderWidth = 1;
}

- (void)setItem:(EFTagsItem *)item
{
    _item = item;
    
    self.tagLabel.text = item.name;
    
    _tagLabel.textColor = item.isSelected?[UIColor colorWithRed:0 / 255.0 green:148 / 255.0 blue:228 / 255.0 alpha:1] : [UIColor colorWithRed:136 / 255.0 green:136 / 255.0 blue:136 / 255.0 alpha:1];
}

@end
