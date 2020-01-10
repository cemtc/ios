//
//  QYApplicationController.m
//  wallet
//
//  Created by talking　 on 2019/6/14.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "QYApplicationController.h"
#import "QYApplicationListCell.h"
#import "QYApplicationListModel.h"
//========================================
#import "NewPagedFlowView.h"
#import "PGCustomBannerView.h"
#define Width [UIScreen mainScreen].bounds.size.width

#define bannerHight Width * 9 / 16 - 50
#define bannerImageHight (Width - 50) * 9 / 16 - 50



//=========================================

#import "MSMineRecommendView.h"

#import "UIView+Layer.h"
#import "UIView+Tap.h"

//众筹
#import "QYRaiseController.h"

#import <SafariServices/SafariServices.h>


@interface QYApplicationController ()<NewPagedFlowViewDelegate, NewPagedFlowViewDataSource>
/**
 *  图片数组
 */
@property (nonatomic, strong) NSMutableArray *imageArray;
/**
 *  轮播图
 */
@property (nonatomic, strong) NewPagedFlowView *pageFlowView;


@property (nonatomic, strong) MSMineRecommendView * recommendView;

@end

@implementation QYApplicationController


- (MSMineRecommendView *)recommendView {
    if (!_recommendView) {
        SKDefineWeakSelf;
        _recommendView = [[MSMineRecommendView alloc]init];
        _recommendView.clickBlock = ^(MSMineRecommendListModel * _Nonnull goodsModel) {
            [MBProgressHUD showMessage:@"此功能未开放"];
            /*
            NSLog(@"推荐title:%@",goodsModel.title);
            QYRaiseController *vc = [QYRaiseController new];
            vc.navigationItem.title = goodsModel.title;
            //caofuqing OLD理财
//            vc.isZiLei = YES;
            [weakSelf pushVc:vc];
             */
        };
    }
    return _recommendView;
}


//=================================================
#pragma mark - UITableViewDelegate
//只有一个Section
- (NSInteger)sk_numberOfSections {
    return self.dataArray.count;
}
//cell 的数据源个数
- (NSInteger)sk_numberOfRowsInSection:(NSInteger)section {
    return [self.dataArray[section] count];
}
//cell
- (SKBaseTableViewCell *)sk_cellAtIndexPath:(NSIndexPath *)indexPath {
    
    QYApplicationListCell *cell = [QYApplicationListCell cellWithTableView:self.tableView];
    QYApplicationListModel *model = self.dataArray[indexPath.section][indexPath.row];
    cell.model = model;
    cell.NextViewControllerBlock = ^(QYApplicationListModel * _Nonnull modelA) {
        
        /*
         !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
         测试下载成功!!!!!!!!   按照这个去写 后台 主要plist文件 对应的iPad 下载路径
        NSString * plistStr = @"itms-services://?action=download-manifest&url=https://sezoex.io/file/downloads/Sezoex.plist";
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:plistStr]];
        NSLog(@"安装plistStr======%@",plistStr);
         !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

*/

        
        
//        NSLog(@"%@",modelA.applicationName);
        if (modelA.iosHyperLink) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:modelA.iosHyperLink]];
        }
        
        
        // 跳转界面 push 展示网页
        /*
         1.Safari openURL：自带很多功能 （进度条，刷新，前进，倒退..）就是打开了一个浏览器，跳出自己的应用
         2.UIWebView：没有功能，在当前应用中打开网页，自己去实现某些功能，但不能实现进度条功能
         3.SFSafariViewController：iOS9+ 专门用来展示网页 需求：既想要在当前应用展示网页，又想要safari功能
         需要导入#import <SafariServices/SafariServices.h>框架
         4.WKWebView：iOS8+ （UIWebView升级版本）添加功能：1）监听进度条 2）缓存
         */
        /*
        if (@available(iOS 9.0, *)) {
            NSString *urlA = [modelA.iosHyperLink stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

            NSURL *url = [NSURL URLWithString:urlA];

            if (url == nil) {

                NSLog(@"不能下载");
                [MBProgressHUD showMessage:@"下载地址失效"];
                return ;
            }
            SFSafariViewController *safariVc = [[SFSafariViewController alloc] initWithURL:url];
            //    safariVc.delegate = self;
            //    self.navigationController.navigationBarHidden = YES;
            //    [self.navigationController pushViewController:safariVc animated:YES];
            [weakSelf presentViewController:safariVc animated:YES completion:nil]; // 推荐使用modal自动处理 而不是push
        }
*/
        
        
    };
    
    return cell;
}
//cell高度
- (CGFloat)sk_cellheightAtIndexPath:(NSIndexPath *)indexPath {
    return 72;
}
//section headview高度
- (CGFloat)sk_sectionHeaderHeightAtSection:(NSInteger)section {
    return 45;
}
- (CGFloat)sk_sectionFooterHeightAtSection:(NSInteger)section{
    return 5;
}
//-  (UIView *)sk_footerAtSection:(NSInteger)section {
//
//}
//headview背景颜色为clear
- (UIView *)sk_headerAtSection:(NSInteger)section {
    QYApplicationListModel *model = [self.dataArray[section] firstObject];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SKScreenWidth, 30)];
    UILabel *leftImageLabel = [UILabel new];
    leftImageLabel.backgroundColor = [UIColor colorWithHexString:@"#2E303B"];
    leftImageLabel.layer.cornerRadius = 2;
    [view addSubview:leftImageLabel];
    [leftImageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.centerY.equalTo(view);
        make.height.mas_equalTo(15);
        make.width.mas_equalTo(4);
    }];
    UILabel * label = [UILabel new];
    label.font = SKFont(16);
    label.textColor = SKColor(51, 51, 51, 1);
    label.text = model.typeName;
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(leftImageLabel.mas_right).offset(5);
        make.centerY.equalTo(view);
    }];

    UILabel *rightLabel = [[UILabel alloc]init];
    rightLabel.font = SKFont(12);
    rightLabel.textColor = SKColor(153, 153, 153, 1);
    rightLabel.text = @"查看全部";
    [view addSubview:rightLabel];
    [rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view);
        make.right.mas_equalTo(view.mas_right).offset(-10);
    }];
    
//    SKDefineWeakSelf;
    [rightLabel setTapActionWithBlock:^{
        NSLog(@"aaa");
    }];
    
    view.backgroundColor = SKWhiteColor;
    return view;
}
//cell点击事件
- (void)sk_didSelectCellAtIndexPath:(NSIndexPath *)indexPath cell:(SKBaseTableViewCell *)cell {
    
}
//下拉
- (void)sk_refresh {
    [super sk_refresh];
    //7.轮播图
    [self loadDataBanner];
    //网络请求
    [self loadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.refreshType = SKBaseTableVcRefreshTypeOnlyCanRefresh;

    // 设置导航栏
    [self setUpItems];
    
    // 设置子视图
    [self setUpViews];
    

    //7.轮播图
    [self loadDataBanner];
    //网络请求
    [self loadData];
}


- (void)loadDataBanner {
    
    SKDefineWeakSelf;
    //7.轮播图
    NSMutableDictionary *d = [NSMutableDictionary new];
    [d setValue:@"2" forKey:@"bannerType"];
    NSDictionary * input = d.copy;
    [CFQCommonServer cfqServerQYAPIGetBannerByTypeWithInput:input Callback:^(id  _Nonnull response, BOOL success, NSString * _Nonnull message, NSString * _Nonnull code) {
        if (success) {
            
            NSArray *array = (NSArray *)response;
            if (array.count > 0) {
                NSMutableArray *headArray = [NSMutableArray new];
                for (NSInteger i = 0; i < array.count; i++) {
                    NSString *urlString = [NSString stringWithFormat:@"%@%@",SKAPI_BaseUrl,array[i]];
                    headArray[i] = urlString;
                }
                //                weakSelf.headerView.imageArr = headArray.mutableCopy;
                weakSelf.imageArray = headArray.mutableCopy;
                //轮播图
                [weakSelf setupUI];
                
            }
            
        }else{
            
        }
        
    }];
}



- (void)loadData {
    
    SKDefineWeakSelf;
    NSMutableDictionary *d = [NSMutableDictionary new];
    [d setValue:@"" forKey:@""];
    NSDictionary * input = d.copy;
    [CFQCommonServer cfqServerQYAPIgetApplicationListWithInput:input Callback:^(id  _Nonnull response, BOOL success, NSString * _Nonnull message, NSString * _Nonnull code) {
        //结束刷新
        [weakSelf sk_endRefresh];

        if (success) {
            NSMutableArray *dArray = [QYApplicationListModel modelArrayWithDictArray:response];
            if (dArray.count) {
                NSMutableArray *array = [NSMutableArray arrayWithArray:dArray.copy];
                NSMutableArray *dateMutablearray = [@[] mutableCopy];
                for (int i = 0; i < array.count; i ++) {
                    QYApplicationListModel *model = array[i];
                    NSMutableArray *tempArray = [@[] mutableCopy];
                    [tempArray addObject:model];
                    for (int j = i+1; j < array.count; j ++) {
                        QYApplicationListModel *jsmodel = array[j];
                        if([model.typeName isEqualToString:jsmodel.typeName]){
                            [tempArray addObject:jsmodel];
                            [array removeObjectAtIndex:j];
                            j -= 1;
                        }
                    }
                    [dateMutablearray addObject:tempArray];
                }
                weakSelf.dataArray = dateMutablearray.mutableCopy;
                
                /*
                 for (NSInteger mm = 0; mm < dateMutablearray.count; mm++) {
                 NSArray *tempA = dateMutablearray[mm];
                 for (NSInteger nn = 0; nn < tempA.count; nn ++) {
                 QYApplicationListModel *nnmodel = tempA[nn];
                 
                 NSLog(@"%@:%@",nnmodel.typeName,nnmodel.applicationName);
                 
                 }
                 }
                 */
                //                SKLog(@"有数据");
                
            }else {
                //                SKLog(@"数据为空");
            }
            
            [weakSelf sk_reloadData];
            
        }else{
            
        }
        
    }];
    
    
}

// 设置导航栏
- (void)setUpItems {
    
    self.navigationItem.title = @"应用";
    
}

// 设置子视图
- (void)setUpViews {
}
//=========================================第三方轮播start
- (void)setupUI {
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    NewPagedFlowView *pageFlowView = [[NewPagedFlowView alloc] initWithFrame:CGRectMake(0, 0, Width, bannerHight)];
    pageFlowView.backgroundColor = [UIColor whiteColor];
    pageFlowView.delegate = self;
    pageFlowView.dataSource = self;
    pageFlowView.minimumPageAlpha = 0.4;
    
#warning 假设产品需求左右卡片间距30,底部对齐
    pageFlowView.leftRightMargin = 30;
    pageFlowView.topBottomMargin = 0;
    
    pageFlowView.orginPageCount = self.imageArray.count;
    pageFlowView.isOpenAutoScroll = YES;
    
    //初始化pageControl
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, pageFlowView.frame.size.height - 34, Width, 8)];
    pageFlowView.pageControl = pageControl;
    [pageFlowView addSubview:pageControl];
    [pageFlowView reloadData];
    //    [self.view addSubview:pageFlowView];
    
    
    
    UIView *bg = [[UIView alloc]init];
    bg.frame = CGRectMake(0, 0, Width, bannerHight + 140);
    [bg addSubview:pageFlowView];
    
    self.recommendView.frame = CGRectMake(0, bannerHight, Width, 140);
    [bg addSubview:self.recommendView];
    self.recommendView.backgroundColor = SKCommonBgColor;
    
    MSMineRecommendListModel *model = [[MSMineRecommendListModel alloc]init];
    model.title = @"众筹";
    model.iconImageString = @"";
    MSMineRecommendListModel *model02 = [[MSMineRecommendListModel alloc]init];
    model02.title = @"链向财经";
    model02.iconImageString = @"APP02";
    MSMineRecommendListModel *model03 = [[MSMineRecommendListModel alloc]init];
    model03.title = @"链人";
    model03.iconImageString = @"APP03";
    MSMineRecommendListModel *model04 = [[MSMineRecommendListModel alloc]init];
    model04.title = @"比特币";
    model04.iconImageString = @"APP04";
    MSMineRecommendListModel *model05 = [[MSMineRecommendListModel alloc]init];
    model05.title = @"快链星球";
    model05.iconImageString = @"APP05";

//    MSMineRecommendListModel *model1 = [[MSMineRecommendListModel alloc]init];
//    model1.title = @"yangtianyan";

//    self.recommendView.goodsArr=@[model,model1];
    self.recommendView.goodsArr=@[model,model02,model03,model04,model05];

    
    self.tableView.tableHeaderView = bg;
    
    
//    self.tableView.tableHeaderView = pageFlowView;

    
    self.pageFlowView = pageFlowView;
    
}

#pragma mark --NewPagedFlowView Delegate
- (void)didSelectCell:(UIView *)subView withSubViewIndex:(NSInteger)subIndex {
    
    NSLog(@"点击了第%ld张图",(long)subIndex + 1);
}

- (void)didScrollToPage:(NSInteger)pageNumber inFlowView:(NewPagedFlowView *)flowView {
    
//    NSLog(@"CustomViewController 滚动到了第%ld页",pageNumber);
}

- (CGSize)sizeForPageInFlowView:(NewPagedFlowView *)flowView {
    return CGSizeMake(Width - 50, bannerImageHight);
}

#pragma mark --NewPagedFlowView Datasource
- (NSInteger)numberOfPagesInFlowView:(NewPagedFlowView *)flowView {
    
    return self.imageArray.count;
}

- (PGIndexBannerSubiew *)flowView:(NewPagedFlowView *)flowView cellForPageAtIndex:(NSInteger)index{
    
    PGCustomBannerView *bannerView = (PGCustomBannerView *)[flowView dequeueReusableCell];
    if (!bannerView) {
        bannerView = [[PGCustomBannerView alloc] init];
        bannerView.layer.cornerRadius = 4;
        bannerView.layer.masksToBounds = YES;
    }
    
    //在这里下载网络图片
//    [bannerView.mainImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:SKAPI_BaseUrl,self.imageArray[index]]] placeholderImage:nil];
    
    [bannerView.mainImageView sd_setImageWithURL:[NSURL URLWithString:self.imageArray[index]] placeholderImage:SKImageNamed(@"Appbandmoren")];

    
    //    bannerView.mainImageView.image = self.imageArray[index];
    bannerView.indexLabel.text = [NSString stringWithFormat:@"第%ld张图",(long)index + 1];
    bannerView.indexLabel.hidden = YES;
    
    return bannerView;
}

#pragma mark --懒加载
- (NSMutableArray *)imageArray {
    if (_imageArray == nil) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}


//=========================================end

@end

