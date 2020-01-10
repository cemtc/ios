//
//  SKBaseTableView.m
//  Business
//
//  Created by talking　 on 2018/8/15.
//  Copyright © 2018年 talking　. All rights reserved.
//

#import "SKBaseTableView.h"

@implementation SKBaseTableView
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.tableFooterView = [UIView new];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
- (void)sk_updateWithUpdateBlock:(void(^)(SKBaseTableView *tableView ))updateBlock{
    if (updateBlock) {
        [self beginUpdates];
        updateBlock(self);
        [self endUpdates];
    }
}

- (UITableViewCell *)sk_cellAtIndexPath:(NSIndexPath *)indexPath{
    if (!indexPath) return nil;
    NSInteger sectionNumber = self.numberOfSections;
    NSInteger section = indexPath.section;
    NSInteger rowNumber = [self numberOfRowsInSection:section];
    if (indexPath.section + 1 > sectionNumber || indexPath.section < 0) { // section 越界
        NSLog(@"刷新section: %ld 已经越界, 总组数: %ld", indexPath.section, sectionNumber);
        return nil;
    } else if (indexPath.row + 1 > rowNumber || indexPath.row < 0) { // row 越界
        NSLog(@"刷新row: %ld 已经越界, 总行数: %ld 所在section: %ld", indexPath.row, rowNumber, section);
        return nil;
    }
    return [self cellForRowAtIndexPath:indexPath];
}

/** 注册普通的UITableViewCell*/
- (void)sk_registerCellClass:(Class)cellClass identifier:(NSString *)identifier{
    
    if (cellClass && identifier.length) {
        [self registerClass:cellClass forCellReuseIdentifier:identifier];
    }
    
}
/** 注册一个从xib中加载的UITableViewCell*/
- (void)sk_registerCellNib:(Class)cellNib nibIdentifier:(NSString *)nibIdentifier{
    if (cellNib && nibIdentifier.length) {
        UINib *nib = [UINib nibWithNibName:[cellNib description] bundle:nil];
        [self registerNib:nib forCellReuseIdentifier:nibIdentifier];
    }
}
/** 注册一个普通的UITableViewHeaderFooterView*/
- (void)sk_registerHeaderFooterClass:(Class)headerFooterClass identifier:(NSString *)identifier{
    if (headerFooterClass && identifier.length) {
        [self registerClass:headerFooterClass forHeaderFooterViewReuseIdentifier:identifier];
    }
}

/** 注册一个从xib中加载的UITableViewHeaderFooterView*/
- (void)sk_registerHeaderFooterNib:(Class)headerFooterNib nibIdentifier:(NSString *)nibIdentifier{
    if (headerFooterNib && nibIdentifier.length) {
        UINib *nib = [UINib nibWithNibName:[headerFooterNib description] bundle:nil];
        [self registerNib:nib forHeaderFooterViewReuseIdentifier:nibIdentifier];
    };
}
#pragma mark - 只对已经存在的cell进行刷新，没有类似于系统的 如果行不存在，默认insert操作
/** 刷新单行、动画默认*/
- (void)sk_reloadSingleRowAtIndexPath:(NSIndexPath *)indexPath{
    [self sk_reloadSingleRowAtIndexPath:indexPath animation:None];
}

/** 刷新单行、动画默认*/
- (void)sk_reloadSingleRowAtIndexPath:(NSIndexPath *)indexPath animation:(SKBaseTableViewRowAnimation)animation{
    if (!indexPath) return ;
    NSInteger sectionNumber = self.numberOfSections;
    NSInteger section = indexPath.section;
    NSInteger rowNumber = [self numberOfRowsInSection:section];
    if (indexPath.section + 1 > sectionNumber || indexPath.section < 0) { // section 越界
        NSLog(@"刷新section: %ld 已经越界, 总组数: %ld", indexPath.section, sectionNumber);
    } else if (indexPath.row + 1 > rowNumber || indexPath.row < 0) { // row 越界
        NSLog(@"刷新row: %ld 已经越界, 总行数: %ld 所在section: %ld", indexPath.row, rowNumber, section);
    } else {
        [self beginUpdates];
        [self reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimation)animation];
        [self endUpdates];
    }
}
/** 刷新多行、动画默认*/
- (void)sk_reloadRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths{
    [self sk_reloadRowsAtIndexPaths:indexPaths animation:None];
}
/** 刷新多行、动画默认*/
- (void)sk_reloadRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths animation:(SKBaseTableViewRowAnimation)animation{
    if (!indexPaths.count) return ;
    SKDefineWeakSelf;
    [indexPaths enumerateObjectsUsingBlock:^(NSIndexPath * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSIndexPath class]]) {
            [weakSelf sk_reloadSingleRowAtIndexPath:obj animation:animation];
        }
    }];
}

/** 刷新某个section、动画默认*/
- (void)sk_reloadSingleSection:(NSInteger)section{
    [self sk_reloadSingleSection:section animation:None];
}

/** 刷新某个section、动画自定义*/
- (void)sk_reloadSingleSection:(NSInteger)section animation:(SKBaseTableViewRowAnimation)animation{
    
    NSInteger sectionNumber = self.numberOfSections;
    if (section + 1 > sectionNumber || section < 0) { // section越界
        NSLog(@"刷新section: %ld 已经越界, 总组数: %ld", section, sectionNumber);
    } else {
        [self beginUpdates];
        [self reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:(UITableViewRowAnimation)animation];
        [self endUpdates];
    }
    
}
/** 刷新多个section、动画默认*/
- (void)sk_reloadSections:(NSArray <NSNumber *>*)sections {
    [self sk_reloadSections:sections animation:None];
}

/** 刷新多个section、动画自定义*/
- (void)sk_reloadSections:(NSArray <NSNumber *>*)sections animation:(SKBaseTableViewRowAnimation)animation{
    if (!sections.count) return ;
    SKDefineWeakSelf;
    [sections enumerateObjectsUsingBlock:^(NSNumber *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSNumber class]]) {
            [weakSelf sk_reloadSingleSection:obj.integerValue animation:animation];
        }
    }];
}

#pragma mark - 对cell进行删除操作
/** 删除单行、动画默认*/
- (void)sk_deleteSingleRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self sk_deleteSingleRowAtIndexPath:indexPath animation:Fade];
    
}

/** 删除单行、动画自定义*/
- (void)sk_deleteSingleRowAtIndexPath:(NSIndexPath *)indexPath animation:(SKBaseTableViewRowAnimation)animation{
    
    if (!indexPath) return ;
    NSInteger sectionNumber = self.numberOfSections;
    NSInteger section = indexPath.section;
    NSInteger rowNumber = [self numberOfRowsInSection:section];
    
    NSLog(@"sectionNumber %ld  section%ld rowNumber%ld",sectionNumber, section , rowNumber);
    if (indexPath.section + 1 > sectionNumber || indexPath.section < 0) { // section 越界
        NSLog(@"删除section: %ld 已经越界, 总组数: %ld", indexPath.section, sectionNumber);
    } else if (indexPath.row + 1 > rowNumber || indexPath.row < 0) { // row 越界
        NSLog(@"删除row: %ld 已经越界, 总行数: %ld 所在section: %ld", indexPath.row, rowNumber, section);
    } else {
        [self beginUpdates];
        [self deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimation)animation];
        [self endUpdates];
    }
    
}

/** 删除多行、动画默认*/
- (void)sk_deleteRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths{
    
    [self sk_deleteRowsAtIndexPaths:indexPaths animation:Fade];
    
}
/** 删除多行、动画自定义*/
- (void)sk_deleteRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths animation:(SKBaseTableViewRowAnimation)animation{
    
    if (!indexPaths.count) return ;
    SKDefineWeakSelf;
    [indexPaths enumerateObjectsUsingBlock:^(NSIndexPath * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSIndexPath class]]) {
            [weakSelf sk_deleteSingleRowAtIndexPath:obj animation:animation];
        }
    }];
    
}

/** 删除某个section、动画默认*/
- (void)sk_deleteSingleSection:(NSInteger)section{
    
    [self sk_deleteSingleSection:section animation:Fade];
    
}
/** 删除某个section、动画自定义*/
- (void)sk_deleteSingleSection:(NSInteger)section animation:(SKBaseTableViewRowAnimation)animation{
    NSInteger sectionNumber = self.numberOfSections;
    if (section + 1 > sectionNumber || section < 0) { // section 越界
        NSLog(@"刷新section: %ld 已经越界, 总组数: %ld", section, sectionNumber);
    } else {
        [self beginUpdates];
        [self deleteSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:(UITableViewRowAnimation)animation];
        [self endUpdates];
    }
}

/** 删除多个section*/
- (void)sk_deleteSections:(NSArray <NSNumber *>*)sections{
    [self sk_deleteSections:sections animation:Fade];
}
/** 删除多个section*/
- (void)sk_deleteSections:(NSArray <NSNumber *>*)sections animation:(SKBaseTableViewRowAnimation)animation{
    if (!sections.count) return ;
    SKDefineWeakSelf;
    [sections enumerateObjectsUsingBlock:^(NSNumber *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSNumber class]]) {
            [weakSelf sk_deleteSingleSection:obj.integerValue animation:animation];
        }
    }];
}

#pragma mark - 对cell进行删除操作
/** 增加单行 动画无*/
- (void)sk_insertSingleRowAtIndexPath:(NSIndexPath *)indexPath{
    [self sk_insertSingleRowAtIndexPath:indexPath animation:None];
}
/** 增加单行，动画自定义*/
- (void)sk_insertSingleRowAtIndexPath:(NSIndexPath *)indexPath animation:(SKBaseTableViewRowAnimation)animation{
    if (!indexPath) return ;
    NSInteger sectionNumber = self.numberOfSections;
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    NSInteger rowNumber = [self numberOfRowsInSection:section];
    if (section > sectionNumber || section < 0) {
        // section 越界
        NSLog(@"section 越界 : %ld", section);
    } else if (row > rowNumber || row < 0) {
        NSLog(@"row 越界 : %ld", row);
    } else {
        [self beginUpdates];
        [self insertRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimation)animation];
        [self endUpdates];
    }
    
}

/** 增加单section，动画无*/
- (void)sk_insertSingleSection:(NSInteger)section{
    [self sk_insertSingleSection:section animation:None];
}

/** 增加单section，动画自定义*/
- (void)sk_insertSingleSection:(NSInteger)section animation:(SKBaseTableViewRowAnimation)animation{
    NSInteger sectionNumber = self.numberOfSections;
    if (section + 1 > sectionNumber || section < 0) {
        // section越界
        NSLog(@" section 越界 : %ld", section);
    } else {
        [self beginUpdates];
        [self insertSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:(UITableViewRowAnimation)animation];
        [self endUpdates];
    }
}

/** 增加多行，动画无*/
- (void)sk_insertRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths{
    [self sk_insertRowsAtIndexPaths:indexPaths animation:None];
}

/** 增加多行，动画自定义*/
- (void)sk_insertRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths animation:(SKBaseTableViewRowAnimation)animation{
    if (indexPaths.count == 0) return ;
    SKDefineWeakSelf;
    [indexPaths enumerateObjectsUsingBlock:^(NSIndexPath * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSIndexPath class]]) {
            [weakSelf sk_insertSingleRowAtIndexPath:obj animation:animation];
        }
    }];
}

/** 增加多section，动画无*/
- (void)sk_insertSections:(NSArray <NSNumber *>*)sections{
    [self sk_insertSections:sections animation:None];
}

/** 增加多section，动画自定义*/
- (void)sk_insertSections:(NSArray <NSNumber *>*)sections animation:(SKBaseTableViewRowAnimation)animation{
    if (sections.count == 0) return ;
    SKDefineWeakSelf;
    [sections enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSNumber class]]) {
            [weakSelf sk_insertSingleSection:obj.integerValue animation:animation];
        }
    }];
}

/** 当有输入框的时候 点击tableview空白处，隐藏键盘*/
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    id view = [super hitTest:point withEvent:event];
    if (![view isKindOfClass:[UITextField class]]) {
        [self endEditing:YES];
    }
    return view;
}


@end
