//
//  EFHobbyCell.m
//  wallet
//
//  Created by 董文龙 on 2019/11/28.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "EFHobbyCell.h"
#import "EFTagList.h"

@implementation EFHobbyCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setTagList:(EFTagList *)tagList
{
    _tagList = tagList;
    
    [self.contentView addSubview:tagList];
}

@end
