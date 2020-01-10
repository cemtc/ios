//
//  QYFoundController.m
//  wallet
//
//  Created by talking　 on 2019/6/14.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "QYFoundController.h"
#import "ZWFoundCell.h"
#import "ZWFoundModel.h"
#import "SKCustomWebViewController.h"

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
@interface QYFoundController ()<NewPagedFlowViewDelegate, NewPagedFlowViewDataSource>
@property(nonatomic,strong)UITextField *TexFD;
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

@implementation QYFoundController

-(UITextField *)TexFD{
    if (_TexFD == nil) {
        _TexFD = [[UITextField alloc]init];
        _TexFD.layer.borderColor = [UIColor colorWithHexString:@"#CDD7DC"].CGColor;
        _TexFD.layer.cornerRadius = 20.0f;
        _TexFD.layer.borderWidth = 1.0f;
        _TexFD.placeholder = @"Search or enter a DApp URL";
        _TexFD.frame = CGRectMake(0, 3,SKScreenWidth - 20 , 40);
        _TexFD.layer.masksToBounds = YES;
        _TexFD.keyboardType = UIKeyboardTypeWebSearch;
        [_TexFD setValue:[UIColor colorWithHexString:@"#999999"] forKeyPath:@"_placeholderLabel.textColor"];
        _TexFD.font = [UIFont systemFontOfSize:14];
        [_TexFD setValue:[UIFont boldSystemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
        _TexFD.clearButtonMode = UITextFieldViewModeWhileEditing;
        UIView *rightview = [[UIView alloc]init];
        rightview.frame = CGRectMake(0, 0, 30, 40);
        _TexFD.rightView=rightview;
        UIImageView *rightimageViewPwd=[[UIImageView alloc]init];
        rightimageViewPwd.image=[UIImage imageNamed:@"icon_search"];
        [rightview addSubview:rightimageViewPwd];
        [rightimageViewPwd mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(rightview.mas_centerY);
            make.right.mas_equalTo(rightview.mas_right).with.mas_offset(-15);
            make.size.mas_equalTo(CGSizeMake(16, 16));
        }];
        _TexFD.rightViewMode=UITextFieldViewModeAlways;

        UIView *leftView = [[UIView alloc]init];
        leftView.frame = CGRectMake(0, 0, 15, 40);
        _TexFD.leftView=leftView;
        _TexFD.leftViewMode=UITextFieldViewModeAlways; //此处用来设置leftview现实时机
        _TexFD.leftView=leftView;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        [[tap rac_gestureSignal] subscribeNext:^(id x) {
            NSLog(@"tap");
            NSString *openURL = [NSString stringWithFormat:@"http://www.baidu.com/s?wd=%@",_TexFD.text];
            openURL =  [openURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            SKCustomWebViewController *webView = [[SKCustomWebViewController alloc]initWithUrl:openURL];
            webView.title = _TexFD.text;
            [self pushVc:webView];
        }];
        [rightview addGestureRecognizer:tap];



    }
    return _TexFD;
}
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]initWithObjects:@{@"icon":@"babite",@"name":@"Babbitt Forum",@"des":@"Babbitt was founded in 2011 and is the earliest block in China.链(blockchain)Consulting community portal"},@{@"icon":@"jinsecaijing",@"name":@"Golden finance",@"des":@"Golden Finance is a one-stop block industry service platform integrating industry news, information, market and data."},@{@"icon":@"LSK",@"name":@"LSK",@"des":@"Lsk is based on its own blockchain network and token LSK"}, nil];
    }
    return _dataArray;
}
- (MSMineRecommendView *)recommendView {
    if (!_recommendView) {
        SKDefineWeakSelf;
        _recommendView = [[MSMineRecommendView alloc]init];
        _recommendView.clickBlock = ^(MSMineRecommendListModel * _Nonnull goodsModel) {
            NSString *urlStr;
            if ([goodsModel.title isEqualToString:@"Etherscan"]) {
                //@"Etherscan"
                urlStr = @"https://cn.etherscan.com/";
            }else if ([goodsModel.title isEqualToString:@"Bitcoin"]){
                urlStr = @"https://www.blockchain.com/zh-cn/explorer";
            }else {
                urlStr = @"http://ccmisr.cc/#/index";
            }

            SKCustomWebViewController *webView = [[SKCustomWebViewController alloc]initWithUrl:urlStr];
            [weakSelf pushVc:webView];
        };
    }
    return _recommendView;
}
//cell点击事件
- (void)sk_didSelectCellAtIndexPath:(NSIndexPath *)indexPath cell:(SKBaseTableViewCell *)cell {
    NSLog(@"跳转网页");
    NSString *urlStr;
    NSString *title;
    switch (indexPath.row) {
        case 0:
        {
            urlStr = @"https://m.8btc.com/";
            title = @"Babbitt Forum";

        }
            break;
        case 1:
        {
            urlStr = @"https://m.jinse.com/";
            title = @"Golden finance";
        }
            break;
        case 2:
        {
           urlStr = @"https://lisk.io/";
            title = @"LSK";
        }
            break;
        case 3:
        {
            urlStr = @"https://www.ccm.one/dist/#/index/";
            title = @"SRA Digital Asset Exchange";
        }
            break;

        default:
            break;
    }
    SKCustomWebViewController *webView = [[SKCustomWebViewController alloc]initWithUrl:urlStr];
    webView.title = title;
    [self pushVc:webView];
}
//=================================================
#pragma mark - UITableViewDelegate
//只有一个Section
- (NSInteger)sk_numberOfSections {
    return 1;
}
//cell 的数据源个数
- (NSInteger)sk_numberOfRowsInSection:(NSInteger)section {
    return [self.dataArray count];
}
//cell
- (SKBaseTableViewCell *)sk_cellAtIndexPath:(NSIndexPath *)indexPath {

    ZWFoundCell *cell = [ZWFoundCell cellWithTableView:self.tableView];
    NSDictionary *Model = self.dataArray[indexPath.row];
    [cell UpdateCellWith:Model[@"icon"] Name:Model[@"name"] Des:Model[@"des"]];

    return cell;
}
//cell高度
- (CGFloat)sk_cellheightAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}
//section headview高度
- (CGFloat)sk_sectionHeaderHeightAtSection:(NSInteger)section {
    return 45;
}
- (CGFloat)sk_sectionFooterHeightAtSection:(NSInteger)section{
    return 0.01;
}

//headview背景颜色为clear
- (UIView *)sk_headerAtSection:(NSInteger)section {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SKScreenWidth, 30)];
    UILabel *leftImageLabel = [UILabel new];
    leftImageLabel.backgroundColor = [UIColor colorWithHexString:@"#1186CE"];
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
    label.text = @"application";
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(leftImageLabel.mas_right).offset(5);
        make.centerY.equalTo(view);
    }];
    view.backgroundColor = SKWhiteColor;
    return view;
}

//下拉
- (void)sk_refresh {
    [super sk_refresh];
    //7.轮播图
    [self loadDataBanner];
    //网络请求
    //[self loadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.refreshType = SKBaseTableVcRefreshTypeOnlyCanRefresh;
    self.view.backgroundColor = [UIColor whiteColor];

    // 设置导航栏
    [self setUpItems];

    // 设置子视图
    //[self setUpViews];

    //7.轮播图
    [self loadDataBanner];
    //网络请求
    //[self loadData];
}


- (void)loadDataBanner {

    SKDefineWeakSelf;
    //7.轮播图
    NSMutableDictionary *d = [NSMutableDictionary new];
    [d setValue:@"2" forKey:@"bannerType"];
    NSDictionary * input = d.copy;
    [CFQCommonServer cfqServerQYAPIGetBannerByTypeWithInput:input Callback:^(id  _Nonnull response, BOOL success, NSString * _Nonnull message, NSString * _Nonnull code) {
        if (success) {
            [weakSelf sk_endRefresh];

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
            [weakSelf sk_endRefresh];

        }

    }];
}




- (void)setUpItems {
    UIView*titleView = [[UIView alloc]initWithFrame:CGRectMake(0,0,SKScreenWidth,40)];
    [titleView setBackgroundColor:[UIColor clearColor]];
    [titleView addSubview:self.TexFD];
    self.navigationItem.titleView = titleView;
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



    UIView *bg = [[UIView alloc]init];
    bg.frame = CGRectMake(0, 0, Width, bannerHight + 140);
    bg.backgroundColor = [UIColor whiteColor];
    [bg addSubview:pageFlowView];

    self.recommendView.frame = CGRectMake(0, bannerHight, Width, 140);
    [bg addSubview:self.recommendView];
    self.recommendView.backgroundColor = SKCommonBgColor;

    MSMineRecommendListModel *model = [[MSMineRecommendListModel alloc]init];
    model.title = @"Etherscan";
    model.iconImageString = @"ether";
    MSMineRecommendListModel *model02 = [[MSMineRecommendListModel alloc]init];
    model02.title = @"Bitcoin";
    model02.iconImageString = @"btc-1";
    MSMineRecommendListModel *model03 = [[MSMineRecommendListModel alloc]init];
    model03.title = @"CCM";
    model03.iconImageString = @"ccm-1";
    self.recommendView.goodsArr=@[model,model02,model03];
    self.tableView.tableHeaderView = bg;
    self.pageFlowView = pageFlowView;

}

#pragma mark --NewPagedFlowView Delegate
- (void)didSelectCell:(UIView *)subView withSubViewIndex:(NSInteger)subIndex {

    NSLog(@"点击了第%ld张图",(long)subIndex + 1);
}

- (void)didScrollToPage:(NSInteger)pageNumber inFlowView:(NewPagedFlowView *)flowView {

    //    NSLog(@"CustomViewController 滚动到了第%ld页",pageNumber);
}

#warning 假设产品需求左右中间页显示大小为 Width - 50, (Width - 50) * 9 / 16
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



    [bannerView.mainImageView sd_setImageWithURL:[NSURL URLWithString:self.imageArray[index]] placeholderImage:SKImageNamed(@"Appbandmoren1")];

    bannerView.indexLabel.text = [NSString stringWithFormat:@"第%ld张图",(long)index + 1];
    bannerView.indexLabel.hidden = YES;

    return bannerView;
}

#pragma mark --懒加载
- (NSMutableArray *)imageArray {
    if (_imageArray == nil) {
        _imageArray = [[NSMutableArray alloc]init];
    }
    return _imageArray;
}


@end


