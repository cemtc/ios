//
//  SKBaseTableViewController.h
//  Business
//
//  Created by talking　 on 2018/8/15.
//  Copyright © 2018年 talking　. All rights reserved.
//

#import "SKRootViewController.h"
#import "SKBaseTableViewCell.h"
#import "SKBaseTableView.h"

typedef void(^SKTableVcCellSelectedHandle)(SKBaseTableViewCell *cell, NSIndexPath *indexPath);

typedef NS_ENUM(NSUInteger, SKBaseTableVcRefreshType) {
    
    /** 无法刷新*/
    SKBaseTableVcRefreshTypeNone = 0,
    /** 只能刷新*/
    SKBaseTableVcRefreshTypeOnlyCanRefresh,
    /** 只能上拉加载*/
    SKBaseTableVcRefreshTypeOnlyCanLoadMore,
    /** 能刷新*/
    SKBaseTableVcRefreshTypeRefreshAndLoadMore
    
};



@interface SKBaseTableViewController : SKRootViewController<UITableViewDelegate, UITableViewDataSource> {
    NSMutableArray *_dataArray;
}


/** 刚才执行的是刷新*/
@property (nonatomic, assign) NSInteger isRefresh;

/** 刚才执行的是上拉加载*/
@property (nonatomic, assign) NSInteger isLoadMore;

/** 添加空界面文字*/
- (void)sk_addEmptyPageWithText:(NSString *)text;

/** 设置导航栏右边的item*/
- (void)sk_setUpNavRightItemTitle:(NSString *)itemTitle handle:(void(^)(NSString *rightItemTitle))handle;

/** 设置导航栏左边的item*/
- (void)sk_setUpNavLeftItemTitle:(NSString *)itemTitle handle:(void(^)(NSString *rightItemTitle))handle;

/** 监听通知*/
- (void)sk_observeNotiWithNotiName:(NSString *)notiName action:(SEL)action;

/** 隐藏statusBar*/
@property (nonatomic, assign) BOOL hiddenStatusBar;

/** statusBar风格*/
@property (nonatomic, assign) UIStatusBarStyle barStyle;

/** 导航右边Item*/
@property (nonatomic, strong) UIBarButtonItem *navRightItem;

/** 导航左边Item*/
@property (nonatomic, strong) UIBarButtonItem *navLeftItem;

/** 标题*/
@property (nonatomic, copy) NSString *navItemTitle;

/** 表视图*/
@property (nonatomic, weak) SKBaseTableView *tableView;

/** 表视图偏移*/
@property (nonatomic, assign) UIEdgeInsets tableEdgeInset;

/** 分割线颜色*/
@property (nonatomic, assign) UIColor *sepLineColor;

/** 数据源数量*/
@property (nonatomic, strong) NSMutableArray *dataArray;

/** 加载刷新类型*/
@property (nonatomic, assign) SKBaseTableVcRefreshType refreshType;

/** 是否需要系统的cell的分割线*/
@property (nonatomic, assign) BOOL needCellSepLine;

/** 刷新数据*/
- (void)sk_reloadData;

/** 开始下拉*/
- (void)sk_beginRefresh;

/** 停止刷新*/
- (void)sk_endRefresh;

/** 停止上拉加载*/
- (void)sk_endLoadMore;

/** 隐藏刷新*/
- (void)sk_hiddenRrefresh;

/** 隐藏上拉加载*/
- (void)sk_hiddenLoadMore;

/** 提示没有更多信息*/
- (void)sk_noticeNoMoreData;

/** 配置数据*/
- (void)sk_commonConfigResponseWithResponse:(id)response isRefresh:(BOOL)isRefresh modelClass:(__unsafe_unretained Class)modelClass;

/** 配置数据*/
- (void)sk_commonConfigResponseWithResponse:(id)response isRefresh:(BOOL)isRefresh modelClass:(__unsafe_unretained Class)modelClass emptyText:(NSString *)emptyText;

/** 是否在下拉刷新*/
@property (nonatomic, assign, readonly) BOOL isHeaderRefreshing;

/** 是否在上拉加载*/
@property (nonatomic, assign, readonly) BOOL isFooterRefreshing;

#pragma mark - 子类去重写
/** 分组数量*/
- (NSInteger)sk_numberOfSections;

/** 某个分组的cell数量*/
- (NSInteger)sk_numberOfRowsInSection:(NSInteger)section;

/** 某行的cell*/
- (SKBaseTableViewCell *)sk_cellAtIndexPath:(NSIndexPath *)indexPath;

/** 点击某行*/
- (void)sk_didSelectCellAtIndexPath:(NSIndexPath *)indexPath cell:(SKBaseTableViewCell *)cell;

/** 某行行高*/
- (CGFloat)sk_cellheightAtIndexPath:(NSIndexPath *)indexPath;

/** 某个组头*/
- (UIView *)sk_headerAtSection:(NSInteger)section;

/** 某个组尾*/
- (UIView *)sk_footerAtSection:(NSInteger)section;

/** 某个组头高度*/
- (CGFloat)sk_sectionHeaderHeightAtSection:(NSInteger)section;

/** 某个组尾高度*/
- (CGFloat)sk_sectionFooterHeightAtSection:(NSInteger)section;

/** 分割线偏移*/
- (UIEdgeInsets)sk_sepEdgeInsetsAtIndexPath:(NSIndexPath *)indexPath;

#pragma mark - 子类去继承
/** 刷新方法*/
- (void)sk_refresh;

/** 上拉加载方法*/
- (void)sk_loadMore;

@property (nonatomic, assign) BOOL showRefreshIcon;

- (void)endRefreshIconAnimation;

@property (nonatomic, weak, readonly) UIView *refreshHeader;

#pragma mark - loading & alert
- (void)sk_showLoading;

- (void)sk_hiddenLoading;

- (void)sk_showTitle:(NSString *)title after:(NSTimeInterval)after;

@end
