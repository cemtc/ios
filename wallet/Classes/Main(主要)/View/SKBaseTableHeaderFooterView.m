//
//  SKBaseTableHeaderFooterView.m
//  Business
//
//  Created by talking　 on 2018/8/15.
//  Copyright © 2018年 talking　. All rights reserved.
//

#import "SKBaseTableHeaderFooterView.h"

@implementation SKBaseTableHeaderFooterView


+ (instancetype)headerFooterViewWithTableView:(UITableView *)tableView {
    if (tableView == nil) {
        return [[self alloc] init];
    }
    NSString *classname = NSStringFromClass([self class]);
    NSString *identifer = [classname stringByAppendingString:@"HeaderFooterID"];
    [tableView registerClass:[self class] forHeaderFooterViewReuseIdentifier:identifer];
    return [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifer];
}

+ (instancetype)nibHeaderFooterViewWithTableView:(UITableView *)tableView {
    if (tableView == nil) {
        return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].firstObject;
    }
    NSString *classname = NSStringFromClass([self class]);
    NSString *identifer = [classname stringByAppendingString:@"nibHeaderFooterID"];
    UINib *nib = [UINib nibWithNibName:classname bundle:nil];
    [tableView registerNib:nib forHeaderFooterViewReuseIdentifier:identifer];
    return [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifer];
}


@end
