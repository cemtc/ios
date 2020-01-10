//
//  QYGonggaoController.m
//  wallet
//
//  Created by talking　 on 2019/6/28.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "QYGonggaoController.h"
#import "QYGonggaoListCell.h"

@interface QYGonggaoController ()

@end

@implementation QYGonggaoController{
    NSInteger currentSize;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //刷新
    self.refreshType = SKBaseTableVcRefreshTypeRefreshAndLoadMore;
    currentSize = 20;
    // 设置导航栏
    [self setUpItems];
    // 设置子视图
    [self setUpViews];
    // 请求数据
    [self loadDataRefreshIndex:0];
}
//下拉
- (void)sk_refresh {
    [super sk_refresh];
    currentSize = 20;
    [self loadDataRefreshIndex:0];
}

//加载更多
- (void)sk_loadMore {
    [super sk_loadMore];
    currentSize += 20;
    [self loadDataRefreshIndex:1];
}

- (void)loadDataRefreshIndex:(NSInteger)index{
    //5.公告
    NSMutableDictionary *d = [NSMutableDictionary new];
    [d setValue:[NSString stringWithFormat:@"%d",1] forKey:@"pageNo"]; //分页
    [d setValue:[NSString stringWithFormat:@"%ld",currentSize] forKey:@"pageSize"];

    NSDictionary * input = d.copy;
    SKDefineWeakSelf;
    [CFQCommonServer cfqServerQYAPIGetNoticeListByPageWithInput:input Callback:^(id  _Nonnull response, BOOL success, NSString * _Nonnull message, NSString * _Nonnull code) {
        //1正在上拉刷新  默认是0
        if (index == 1) {
            
            // 停止上拉加载
            [self sk_endLoadMore];
            
        }else if (index == 0) {
            //结束刷新
            [self sk_endRefresh];
        }

        if (success) {
            weakSelf.dataArray = [CFQCommonModel modelArrayWithDictArray:response];
            if (weakSelf.dataArray.count) {
                
                //                SKLog(@"有数据");
                [SKUtils updateFooterTitle:weakSelf.tableView.mj_footer];

            }else {
                //                SKLog(@"数据为空");
            }
            
            [weakSelf sk_reloadData];

        }else {
            
        }
    }];
    
}

// 设置导航栏
- (void)setUpItems {
    
    self.navigationItem.title = @"公告";
}

// 设置子视图
- (void)setUpViews {
    
    //不需要分割线
    self.needCellSepLine = NO;
    
}
#pragma mark - UITableViewDelegate
//只有一个Section
- (NSInteger)sk_numberOfSections {
    return 1;
}
//cell 的数据源个数
- (NSInteger)sk_numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
//cell
- (SKBaseTableViewCell *)sk_cellAtIndexPath:(NSIndexPath *)indexPath {
    
    QYGonggaoListCell *cell = [QYGonggaoListCell cellWithTableView:self.tableView];
    cell.model = self.dataArray[indexPath.row];
    cell.backgroundColor = SKCommonBgColor;
    return cell;
}
//cell高度
- (CGFloat)sk_cellheightAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}
//section headview高度
- (CGFloat)sk_sectionHeaderHeightAtSection:(NSInteger)section {
    return 0;
}
//headview背景颜色为clear
- (UIView *)sk_headerAtSection:(NSInteger)section {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SKScreenWidth, 30)];
    view.backgroundColor = SKClearColor;
    return view;
}
//cell点击事件
- (void)sk_didSelectCellAtIndexPath:(NSIndexPath *)indexPath cell:(SKBaseTableViewCell *)cell {
    

    SKDefineWeakSelf;
    CFQCommonModel *model = self.dataArray[indexPath.row];
     //    6.点击公告
     NSMutableDictionary *d = [NSMutableDictionary new];
     [d setValue:model.noticeId forKey:@"noticeId"];
     NSDictionary * input = d.copy;
     [CFQCommonServer cfqServerQYAPIInsertNoticeHandleWithInput:input Callback:^(id  _Nonnull response, BOOL success, NSString * _Nonnull message, NSString * _Nonnull code) {
         if (success) {
         
             [weakSelf loadDataRefreshIndex:0];
         }else{
         
         }
     }];
}

@end
