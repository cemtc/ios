//
//  SKBaseTableViewController.m
//  Business
//
//  Created by talking　 on 2018/8/15.
//  Copyright © 2018年 talking　. All rights reserved.
//

#import "SKBaseTableViewController.h"
#import "SKBaseTableHeaderFooterView.h"
#import <objc/runtime.h>
#import "UIView+Layer.h"
#import "UIView+Tap.h"
#import "MJRefresh.h"

#import "MJExtension.h"


const char SKBaseTableVcNavRightItemHandleKey;
const char SKBaseTableVcNavLeftItemHandleKey;


@interface SKBaseTableViewController ()

@property (nonatomic, copy) SKTableVcCellSelectedHandle handle;
@property (nonatomic, weak) UIImageView *refreshImg;

@end

@implementation SKBaseTableViewController


@synthesize needCellSepLine = _needCellSepLine;
@synthesize sepLineColor = _sepLineColor;
@synthesize navItemTitle = _navItemTitle;
@synthesize navRightItem = _navRightItem;
@synthesize navLeftItem = _navLeftItem;
@synthesize hiddenStatusBar = _hiddenStatusBar;
@synthesize barStyle = _barStyle;
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}


/**
 *  加载tableview
 */
- (SKBaseTableView *)tableView {
    if(!_tableView){
        SKBaseTableView *tab = [[SKBaseTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        [self.view addSubview:tab];
        _tableView = tab;
        tab.dataSource = self;
        tab.delegate = self;
        //        tab.backgroundColor = [UIColor colorWithRed:0.94f green:0.94f blue:0.94f alpha:1.00f];
        tab.backgroundColor = SKClearColor;
        tab.separatorColor = SKSeperatorColor;
    }
    return _tableView;
}

////#warning =================================在这更改颜色问题  因为在HLBaseNavigationController 设置了统一颜色  在这可以重写


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    

    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    //    [self nh_hiddenLoadMore];
    
}


#pragma mark - loading & alert
- (void)sk_showLoading {
    //    [FMHUD showLoading];
}

- (void)sk_hiddenLoading {
    //    [FMHUD hideHUD];
}

- (void)sk_showTitle:(NSString *)title after:(NSTimeInterval)after {
    //    [FDHUD showTitle:title];
    //    [FDHUD hideHUDAfterTimeout:after];
}



/** 添加空界面文字*/
- (void)sk_addEmptyPageWithText:(NSString *)text {
    //    [[NHEmptyPageManager sharedManager] setDelegateForScrollView:self.tableView emptyText:text];
}

/** 设置导航栏右边的item*/
- (void)sk_setUpNavRightItemTitle:(NSString *)itemTitle handle:(void(^)(NSString *rightItemTitle))handle {
    [self sk_setUpNavItemTitle:itemTitle handle:handle leftFlag:NO];
}

/** 设置导航栏左边的item*/
- (void)sk_setUpNavLeftItemTitle:(NSString *)itemTitle handle:(void(^)(NSString *leftItemTitle))handle {
    [self sk_setUpNavItemTitle:itemTitle handle:handle leftFlag:YES];
}

- (void)sk_navItemHandle:(UIBarButtonItem *)item {
    void (^handle)(NSString *) = objc_getAssociatedObject(self, &SKBaseTableVcNavRightItemHandleKey);
    if (handle) {
        handle(item.title);
    }
}

- (void)sk_setUpNavItemTitle:(NSString *)itemTitle handle:(void(^)(NSString *itemTitle))handle leftFlag:(BOOL)leftFlag {
    if (itemTitle.length == 0 || !handle) {
        if (itemTitle == nil) {
            itemTitle = @"";
        } else if ([itemTitle isKindOfClass:[NSNull class]]) {
            itemTitle = @"";
        }
        if (leftFlag) {
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:itemTitle style:UIBarButtonItemStylePlain target:nil action:nil];
        } else {
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:itemTitle style:UIBarButtonItemStylePlain target:nil action:nil];
        }
    } else {
        if (leftFlag) {
            objc_setAssociatedObject(self, &SKBaseTableVcNavLeftItemHandleKey, handle, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:itemTitle style:UIBarButtonItemStylePlain target:self action:@selector(sk_navItemHandle:)];
        } else {
            objc_setAssociatedObject(self, &SKBaseTableVcNavRightItemHandleKey, handle, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:itemTitle style:UIBarButtonItemStylePlain target:self action:@selector(sk_navItemHandle:)];
        }
    }
    
}


/** 监听通知*/
- (void)sk_observeNotiWithNotiName:(NSString *)notiName action:(SEL)action {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:action name:notiName object:nil];
}

/** 设置刷新类型*/
- (void)setRefreshType:(SKBaseTableVcRefreshType)refreshType {
    _refreshType = refreshType;
    switch (refreshType) {
        case SKBaseTableVcRefreshTypeNone: // 没有刷新
            break ;
        case SKBaseTableVcRefreshTypeOnlyCanRefresh: { // 只有下拉刷新
            [self sk_addRefresh];
        } break ;
        case SKBaseTableVcRefreshTypeOnlyCanLoadMore: { // 只有上拉加载
            [self sk_addLoadMore];
        } break ;
        case SKBaseTableVcRefreshTypeRefreshAndLoadMore: { // 下拉和上拉都有
            [self sk_addRefresh];
            [self sk_addLoadMore];
        } break ;
        default:
            break ;
    }
}

/** 导航栏标题*/
- (void)setNavItemTitle:(NSString *)navItemTitle {
    if ([navItemTitle isKindOfClass:[NSString class]] == NO) return ;
    if ([navItemTitle isEqualToString:_navItemTitle]) return ;
    _navItemTitle = navItemTitle.copy;
    self.navigationItem.title = navItemTitle;
}

- (NSString *)navItemTitle {
    return self.navigationItem.title;
}


/** statusBar是否隐藏*/
- (void)setHiddenStatusBar:(BOOL)hiddenStatusBar {
    _hiddenStatusBar = hiddenStatusBar;
    [self setNeedsStatusBarAppearanceUpdate];
}

- (BOOL)hiddenStatusBar {
    return _hiddenStatusBar;
}

- (void)setBarStyle:(UIStatusBarStyle)barStyle {
    if (_barStyle == barStyle) return ;
    _barStyle = barStyle;
    [self setNeedsStatusBarAppearanceUpdate];
}

- (BOOL)prefersStatusBarHidden {
    return self.hiddenStatusBar;
}

- (void)setShowRefreshIcon:(BOOL)showRefreshIcon {
    _showRefreshIcon = showRefreshIcon;
    self.refreshImg.hidden = !showRefreshIcon;
}

- (UIImageView *)refreshImg {
    if (!_refreshImg) {
        UIImageView *refreshImg = [[UIImageView alloc] init];
        [self.view addSubview:refreshImg];
        _refreshImg = refreshImg;
        [self.view bringSubviewToFront:refreshImg];
        refreshImg.image = [UIImage imageNamed:@"refresh"];
        SKDefineWeakSelf;
        [refreshImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf.view).mas_offset(-15);
            make.size.mas_equalTo(CGSizeMake(44, 44));
            make.bottom.mas_equalTo(weakSelf.view).mas_offset(-20);
        }];
        refreshImg.layerCornerRadius = 22;
        refreshImg.backgroundColor = SKWhiteColor;
        
        [refreshImg setTapActionWithBlock:^{
            [self startAnimation];
            [weakSelf sk_beginRefresh];
        }];
    }
    return _refreshImg;
}

- (void)startAnimation {
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = 1.5;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = MAXFLOAT;
    [self.refreshImg.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

- (void)endRefreshIconAnimation {
    [self.refreshImg.layer removeAnimationForKey:@"rotationAnimation"];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return self.barStyle;
}

/** 右边item*/
- (void)setNavRightItem:(UIBarButtonItem *)navRightItem {
    
    _navRightItem = navRightItem;
    self.navigationItem.rightBarButtonItem = navRightItem;
}

- (UIBarButtonItem *)navRightItem {
    return self.navigationItem.rightBarButtonItem;
}
/** 左边item*/
- (void)setNavLeftItem:(UIBarButtonItem *)navLeftItem {
    
    _navLeftItem = navLeftItem;
    self.navigationItem.leftBarButtonItem = navLeftItem;
}

- (UIBarButtonItem *)navLeftItem {
    return self.navigationItem.leftBarButtonItem;
}

/** 需要系统分割线*/
- (void)setNeedCellSepLine:(BOOL)needCellSepLine {
    _needCellSepLine = needCellSepLine;
    self.tableView.separatorStyle = needCellSepLine ? UITableViewCellSeparatorStyleSingleLine : UITableViewCellSeparatorStyleNone;
}

- (BOOL)needCellSepLine {
    return self.tableView.separatorStyle == UITableViewCellSeparatorStyleSingleLine;
}

- (void)sk_addRefresh {
    [SKUtils addPullRefreshForScrollView:self.tableView pullRefreshCallBack:^{
        [self sk_refresh];
    }];
}

- (void)sk_addLoadMore {
    [SKUtils addLoadMoreForScrollView:self.tableView loadMoreCallBack:^{
        [self sk_loadMore];
    }];
}

/** 表视图偏移*/
- (void)setTableEdgeInset:(UIEdgeInsets)tableEdgeInset {
    _tableEdgeInset = tableEdgeInset;
    [self.view setNeedsUpdateConstraints];
    [self.view updateConstraintsIfNeeded];
    [self.view layoutIfNeeded];
    [self.view setNeedsLayout];
}

- (void)updateViewConstraints {
    [super updateViewConstraints];
    //    HLDefineWeakSelf;
    //        // update
    //        [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
    //            make.edges.equalTo(weakSelf.view).mas_offset(weakSelf.tableEdgeInset);
    //        }];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.tableView.frame = self.view.bounds;
    [self.view sendSubviewToBack:self.tableView];
}
/** 分割线颜色*/
- (void)setSepLineColor:(UIColor *)sepLineColor {
    if (!self.needCellSepLine) return;
    _sepLineColor = sepLineColor;
    
    if (sepLineColor) {
        self.tableView.separatorColor = sepLineColor;
    }
}

- (UIColor *)sepLineColor {
    return _sepLineColor ? _sepLineColor : [UIColor whiteColor];
}

/** 刷新数据*/
- (void)sk_reloadData {
    [self.tableView reloadData];
}

/** 开始下拉*/
- (void)sk_beginRefresh {
    if (self.refreshType == SKBaseTableVcRefreshTypeOnlyCanRefresh || self.refreshType == SKBaseTableVcRefreshTypeRefreshAndLoadMore) {
        [SKUtils beginPullRefreshForScrollView:self.tableView];
    }
}

/** 刷新*/
- (void)sk_refresh {
    if (self.refreshType == SKBaseTableVcRefreshTypeNone || self.refreshType == SKBaseTableVcRefreshTypeOnlyCanLoadMore) {
        return ;
    }
    self.isRefresh = YES; self.isLoadMore = NO;
}

/** 上拉加载*/
- (void)sk_loadMore {
    if (self.refreshType == SKBaseTableVcRefreshTypeNone || self.refreshType == SKBaseTableVcRefreshTypeOnlyCanRefresh) {
        return ;
    }
    if (self.dataArray.count == 0) {
        return ;
    }
    self.isRefresh = NO; self.isLoadMore = YES;
    
}


- (void)sk_commonConfigResponseWithResponse:(id)response isRefresh:(BOOL)isRefresh modelClass:(__unsafe_unretained Class)modelClass {
    [self sk_commonConfigResponseWithResponse:response isRefresh:isRefresh modelClass:modelClass emptyText:nil];
}

- (void)sk_commonConfigResponseWithResponse:(id)response isRefresh:(BOOL)isRefresh modelClass:(__unsafe_unretained Class)modelClass emptyText:(NSString *)emptyText {
    if ([response isKindOfClass:[NSArray class]] == NO) return ;
    if (self.isRefresh) { // 刷新
        
        // 停止刷新
        [self sk_endRefresh];
        
        // 设置模型数组
        [self.dataArray removeAllObjects];
        self.dataArray = [modelClass mj_objectArrayWithKeyValuesArray:response];
        
        // 设置空界面占位文字
        if (emptyText.length) {
            [self sk_addEmptyPageWithText:emptyText];
        }
        
        // 刷新界面
        [self sk_reloadData];
        
    } else { // 上拉加载
        
        // 停止上拉
        [self sk_endLoadMore];
        
        // 没有数据提示没有更多了
        if ([response count] == 0) {
            [self sk_noticeNoMoreData];
        } else {
            
            // 设置模型数组
            NSArray *newModels = [modelClass mj_objectArrayWithKeyValuesArray:response];
            if (newModels.count < 50) {
                [self sk_hiddenLoadMore];
            }
            [self.dataArray addObjectsFromArray:newModels];
            
            // 刷新界面
            [self sk_reloadData];
        }
    }
}



/** 停止刷新*/
- (void)sk_endRefresh {
    if (self.refreshType == SKBaseTableVcRefreshTypeOnlyCanRefresh || self.refreshType == SKBaseTableVcRefreshTypeRefreshAndLoadMore) {
        [SKUtils endRefreshForScrollView:self.tableView];
    }
}

/** 停止上拉加载*/
- (void)sk_endLoadMore {
    if (self.refreshType == SKBaseTableVcRefreshTypeOnlyCanLoadMore || self.refreshType == SKBaseTableVcRefreshTypeRefreshAndLoadMore) {
        [SKUtils endLoadMoreForScrollView:self.tableView];
    }
}

/** 隐藏刷新*/
- (void)sk_hiddenRrefresh {
    if (self.refreshType == SKBaseTableVcRefreshTypeOnlyCanRefresh || self.refreshType == SKBaseTableVcRefreshTypeRefreshAndLoadMore) {
        [SKUtils hiddenHeaderForScrollView:self.tableView];
    }
}

/** 隐藏上拉加载*/
- (void)sk_hiddenLoadMore {
    if (self.refreshType == SKBaseTableVcRefreshTypeOnlyCanLoadMore || self.refreshType == SKBaseTableVcRefreshTypeRefreshAndLoadMore) {
        [SKUtils hiddenFooterForScrollView:self.tableView];
    }
}

/** 提示没有更多信息*/
- (void)sk_noticeNoMoreData {
    if (self.refreshType == SKBaseTableVcRefreshTypeOnlyCanLoadMore || self.refreshType == SKBaseTableVcRefreshTypeRefreshAndLoadMore) {
        [SKUtils noticeNoMoreDataForScrollView:self.tableView];
    }
}

/** 头部正在刷新*/
- (BOOL)isHeaderRefreshing {
    return [SKUtils headerIsRefreshForScrollView:self.tableView];
}

//* 尾部正在刷新
- (BOOL)isFooterRefreshing {
    return [SKUtils footerIsLoadingForScrollView:self.tableView];
}

#pragma mark - <UITableViewDataSource, UITableViewDelegate>
// 分组数量
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([self respondsToSelector:@selector(sk_numberOfSections)]) {
        return self.sk_numberOfSections;
    }
    return 0;
}

// 指定组返回的cell数量
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([self respondsToSelector:@selector(sk_numberOfRowsInSection:)]) {
        return [self sk_numberOfRowsInSection:section];
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if ([self respondsToSelector:@selector(sk_headerAtSection:)]) {
        return [self sk_headerAtSection:section];
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if ([self respondsToSelector:@selector(sk_footerAtSection:)]) {
        return [self sk_footerAtSection:section];
    }
    return nil;
}

// 每一行返回指定的cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self respondsToSelector:@selector(sk_cellAtIndexPath:)]) {
        return [self sk_cellAtIndexPath:indexPath];
    }
    // 1. 创建cell
    SKBaseTableViewCell *cell = [SKBaseTableViewCell cellWithTableView:self.tableView];
    
    // 2. 返回cell
    return cell;
}

// 点击某一行 触发的事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SKBaseTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([self respondsToSelector:@selector(sk_didSelectCellAtIndexPath:cell:)]) {
        [self sk_didSelectCellAtIndexPath:indexPath cell:cell];
    }
}

- (UIView *)refreshHeader {
    return self.tableView.mj_header;
}

// 设置分割线偏移间距并适配
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!self.needCellSepLine) return ;
    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
    if ([self respondsToSelector:@selector(sk_sepEdgeInsetsAtIndexPath:)]) {
        edgeInsets = [self sk_sepEdgeInsetsAtIndexPath:indexPath];
    }
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) [tableView setSeparatorInset:edgeInsets];
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) [tableView setLayoutMargins:edgeInsets];
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) [cell setSeparatorInset:edgeInsets];
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) [cell setLayoutMargins:edgeInsets];
}

// 每一行的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self respondsToSelector:@selector(sk_cellheightAtIndexPath:)]) {
        return [self sk_cellheightAtIndexPath:indexPath];
    }
    return tableView.rowHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if ([self respondsToSelector:@selector(sk_sectionHeaderHeightAtSection:)]) {
        return [self sk_sectionHeaderHeightAtSection:section];
    }
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if ([self respondsToSelector:@selector(sk_sectionFooterHeightAtSection:)]) {
        return [self sk_sectionFooterHeightAtSection:section];
    }
    return 0.01;
}

- (NSInteger)sk_numberOfSections { return 0; }

- (NSInteger)sk_numberOfRowsInSection:(NSInteger)section { return 0; }

- (UITableViewCell *)sk_cellAtIndexPath:(NSIndexPath *)indexPath { return [SKBaseTableViewCell cellWithTableView:self.tableView]; }

- (CGFloat)sk_cellheightAtIndexPath:(NSIndexPath *)indexPath { return 0; }

- (void)sk_didSelectCellAtIndexPath:(NSIndexPath *)indexPath cell:(SKBaseTableViewCell *)cell { }

- (UIView *)sk_headerAtSection:(NSInteger)section {
    
    return [SKBaseTableHeaderFooterView headerFooterViewWithTableView:self.tableView];
    
}

- (UIView *)sk_footerAtSection:(NSInteger)section {
    
    return [SKBaseTableHeaderFooterView headerFooterViewWithTableView:self.tableView];
    
}


- (CGFloat)sk_sectionHeaderHeightAtSection:(NSInteger)section { return 0.01; }

- (CGFloat)sk_sectionFooterHeightAtSection:(NSInteger)section { return 0.01; }

- (UIEdgeInsets)sk_sepEdgeInsetsAtIndexPath:(NSIndexPath *)indexPath { return UIEdgeInsetsMake(0, 15, 0, 0); }

- (void)dealloc { [[NSNotificationCenter defaultCenter] removeObserver:self]; }


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
