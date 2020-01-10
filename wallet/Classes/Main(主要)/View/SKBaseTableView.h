//
//  SKBaseTableView.h
//  Business
//
//  Created by talking　 on 2018/8/15.
//  Copyright © 2018年 talking　. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SKBaseTableViewRowAnimation) {
    
    Fade = UITableViewRowAnimationFade,
    Right = UITableViewRowAnimationRight,           // slide in from right (or out to right)
    Left = UITableViewRowAnimationLeft,
    Top = UITableViewRowAnimationTop,
    Bottom = UITableViewRowAnimationBottom,
    None = UITableViewRowAnimationNone,            // available in iOS 3.0
    Middle = UITableViewRowAnimationMiddle,          // available in iOS 3.2.  attempts to keep cell centered in the space it will/did occupy
    Automatic = 100  // available in iOS 5.0.  chooses an appropriate animation style for you
};

@class SKBaseTableViewCell;

@interface SKBaseTableView : UITableView


- (void)sk_updateWithUpdateBlock:(void(^)(SKBaseTableView *tableView ))updateBlock;

- (UITableViewCell *)sk_cellAtIndexPath:(NSIndexPath *)indexPath;

/** 注册普通的UITableViewCell*/
- (void)sk_registerCellClass:(Class)cellClass identifier:(NSString *)identifier;

/** 注册一个从xib中加载的UITableViewCell*/
- (void)sk_registerCellNib:(Class)cellNib nibIdentifier:(NSString *)nibIdentifier;

/** 注册一个普通的UITableViewHeaderFooterView*/
- (void)sk_registerHeaderFooterClass:(Class)headerFooterClass identifier:(NSString *)identifier;

/** 注册一个从xib中加载的UITableViewHeaderFooterView*/
- (void)sk_registerHeaderFooterNib:(Class)headerFooterNib nibIdentifier:(NSString *)nibIdentifier;

#pragma mark - 只对已经存在的cell进行刷新，没有类似于系统的 如果行不存在，默认insert操作
/** 刷新单行、动画默认*/
- (void)sk_reloadSingleRowAtIndexPath:(NSIndexPath *)indexPath;

/** 刷新单行、动画默认*/
- (void)sk_reloadSingleRowAtIndexPath:(NSIndexPath *)indexPath animation:(SKBaseTableViewRowAnimation)animation;

/** 刷新多行、动画默认*/
- (void)sk_reloadRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths;

/** 刷新多行、动画默认*/
- (void)sk_reloadRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths animation:(SKBaseTableViewRowAnimation)animation;

/** 刷新某个section、动画默认*/
- (void)sk_reloadSingleSection:(NSInteger)section;

/** 刷新某个section、动画自定义*/
- (void)sk_reloadSingleSection:(NSInteger)section animation:(SKBaseTableViewRowAnimation)animation;

/** 刷新多个section、动画默认*/
- (void)sk_reloadSections:(NSArray <NSNumber *>*)sections;

/** 刷新多个section、动画自定义*/
- (void)sk_reloadSections:(NSArray <NSNumber *>*)sections animation:(SKBaseTableViewRowAnimation)animation;

#pragma mark - 对cell进行删除操作
/** 删除单行、动画默认*/
- (void)sk_deleteSingleRowAtIndexPath:(NSIndexPath *)indexPath;

/** 删除单行、动画自定义*/
- (void)sk_deleteSingleRowAtIndexPath:(NSIndexPath *)indexPath animation:(SKBaseTableViewRowAnimation)animation;

/** 删除多行、动画默认*/
- (void)sk_deleteRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths;

/** 删除多行、动画自定义*/
- (void)sk_deleteRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths animation:(SKBaseTableViewRowAnimation)animation;

/** 删除某个section、动画默认*/
- (void)sk_deleteSingleSection:(NSInteger)section;

/** 删除某个section、动画自定义*/
- (void)sk_deleteSingleSection:(NSInteger)section animation:(SKBaseTableViewRowAnimation)animation;

/** 删除多个section*/
- (void)sk_deleteSections:(NSArray <NSNumber *>*)sections;

/** 删除多个section*/
- (void)sk_deleteSections:(NSArray <NSNumber *>*)sections animation:(SKBaseTableViewRowAnimation)animation;

#pragma mark - 对cell进行删除操作
/** 增加单行 动画无*/
- (void)sk_insertSingleRowAtIndexPath:(NSIndexPath *)indexPath;

/** 增加单行，动画自定义*/
- (void)sk_insertSingleRowAtIndexPath:(NSIndexPath *)indexPath animation:(SKBaseTableViewRowAnimation)animation;

/** 增加单section，动画无*/
- (void)sk_insertSingleSection:(NSInteger)section;

/** 增加单section，动画自定义*/
- (void)sk_insertSingleSection:(NSInteger)section animation:(SKBaseTableViewRowAnimation)animation;

/** 增加多行，动画无*/
- (void)sk_insertRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths;

/** 增加多行，动画自定义*/
- (void)sk_insertRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths animation:(SKBaseTableViewRowAnimation)animation;

/** 增加多section，动画无*/
- (void)sk_insertSections:(NSArray <NSNumber *>*)sections;

/** 增加多section，动画自定义*/
- (void)sk_insertSections:(NSArray <NSNumber *>*)sections animation:(SKBaseTableViewRowAnimation)animation;



@end
