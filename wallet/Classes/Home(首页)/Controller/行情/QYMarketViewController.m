//
//  QYMarketViewController.m
//  wallet
//
//  Created by talking　 on 2019/6/26.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "QYMarketViewController.h"
#import "QYMarketViewListCell.h"
#import "QYHangQingModel.h"
#import "ZWSoketRocketUtility.h"
#import "AFNetworking.h"
@interface QYMarketViewController ()
@property(nonatomic,strong) ZWSoketRocketUtility * socket;
@property(nonatomic,strong) NSArray *dataArray;
@property(nonatomic,strong) NSArray *itemARR;
@end
@implementation QYMarketViewController
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //关闭连接
    [self.socket SRWebSocketClose];

}
//////如果不要导航把这个打开
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.socket SRWebSocketOpen];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorColor = [UIColor colorWithHexString:@"#E6E8EB"];
    self.view.backgroundColor  = [UIColor colorWithHexString:@"#FDFDFD"];
    
    self.refreshType = SKBaseTableVcRefreshTypeOnlyCanRefresh;
   //开始连接
    self.socket = [ZWSoketRocketUtility instance];
    [self.socket SRWebSocketOpen];
    [self sk_beginRefresh];


    
    // 设置导航栏
    [self setUpItems];
    
    // 设置子视图
    [self setUpViews];
    
    

}
-(void)loadPrice{
    [[AFHTTPSessionManager manager] GET:[NSString stringWithFormat:@"https://mdncapi.bqiapp.com/api/coin/web-coinrank?webp=1&pagesize=100&page=1&type=-1"] parameters:nil progress:^(NSProgress *_Nonnull uploadProgress) {
    }                           success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
        NSDictionary *dataInfo = responseObject;
        self.dataArray = [dataInfo objectForKey:@"data"];
        self.itemARR = [QYHangQingModel modelArrayWithDictArray:self.dataArray];
        [self sk_reloadData];
        [self sk_endRefresh];

    }
                                failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
                                }];
    
}
- (void)sk_refresh {
    [super sk_refresh];
    [self loadPrice];
}
- (NSDictionary *)convertjsonStringToDict:(NSString *)jsonString{
    NSDictionary *retDict = nil;
    if ([jsonString isKindOfClass:[NSString class]]) {
        NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
        retDict = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:NULL];
        return  retDict;
    }else{
        return retDict;
    }
}
//- (void)loadData{
//    //发送数据
//    //[self.socket sendData:@{} withRequestURI:@"wss://www.ccm.one/wss2000/"];
//    //收到数据,进行解析,展示
//    SKDefineWeakSelf;
//    self.socket.didReceiveMessage = ^(id  _Nonnull message) {
//        NSLog(@"=========收到数据=%@",message);
//        //解析数据.保存到本地数据
//        NSDictionary *messageDict = [weakSelf convertjsonStringToDict:message];
//        NSArray *messageARR = messageDict[@"type_list"];
//        if (messageARR.count) {
//            NSMutableArray *Mutablearr = [[NSMutableArray alloc]init];
//            for (int i = 0; i < messageARR.count; i++) {
//                NSDictionary *dict = messageARR[i];
//                NSArray *arr = dict[@"data"];
//                if (arr.count) {
//                    NSArray *itemARR = [QYHangQingModel modelArrayWithDictArray:arr];
//                    [Mutablearr addObjectsFromArray:itemARR];
//                }
//            }
//            [self.dataArray removeAllObjects];
//            weakSelf.dataArray = Mutablearr;
//            [weakSelf sk_reloadData];
//        }
//        [weakSelf sk_endRefresh];
//    };
//}

// 设置导航栏
- (void)setUpItems {
    self.navigationItem.title = @"Market";
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
    return self.itemARR.count;
}
//cell
- (SKBaseTableViewCell *)sk_cellAtIndexPath:(NSIndexPath *)indexPath {
    QYMarketViewListCell *cell = [QYMarketViewListCell cellWithTableView:self.tableView];
    QYHangQingModel *modeA = self.itemARR[indexPath.row];
    cell.modelA = modeA;
    return cell;

}
//cell高度
- (CGFloat)sk_cellheightAtIndexPath:(NSIndexPath *)indexPath {
    return 62;
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
    
}

@end
