//
//  MSMineRecommendView.m
//  wallet
//
//  Created by talking　 on 2019/6/30.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "MSMineRecommendView.h"


@interface MSMineRecommendView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView * collectionView;


@property (nonatomic, strong) UILabel *leftImageLabel;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIView *topBgView;

/*
 UILabel *leftImageLabel = [UILabel new];

 [view addSubview:leftImageLabel];
 UILabel * label = [UILabel new];

 [view addSubview:label];
 

 */
@end

@implementation MSMineRecommendView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.leftImageLabel = [UILabel new];
        self.leftImageLabel.backgroundColor = [UIColor colorWithHexString:@"#1186CE"];
        self.leftImageLabel.layer.cornerRadius = 2;
        self.label = [UILabel new];
        self.label.font = SKFont(16);
        self.label.textColor = SKColor(51, 51, 51, 1);
        self.label.text = @"推荐";
        
        self.topBgView = [[UIView alloc]init];
        self.topBgView.backgroundColor = SKWhiteColor;
        [self addSubview:self.topBgView];
        
        [self addSubview:self.label];
        [self addSubview:self.leftImageLabel];

        [self addSubview:self.collectionView];
        [self setupLayout];
    }
    return self;
}
- (void)setupLayout{
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(90.f);
        make.left.mas_equalTo(0.f);
        make.right.mas_equalTo(0.f);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-5);
    }];
    [self.topBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top);
        make.left.right.mas_equalTo(self);
        make.bottom.mas_equalTo(self.collectionView.mas_top);
    }];
    
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(20);
        make.bottom.mas_equalTo(self.collectionView.mas_top).offset(-10);
    }];
    
    [self.leftImageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.label.mas_left).offset(-5);
        make.centerY.mas_equalTo(self.label.mas_centerY);
        make.height.mas_equalTo(15);
        make.width.mas_equalTo(4);
    }];

}
- (void)setGoodsArr:(NSArray *)goodsArr
{
    _goodsArr = goodsArr;
    [self.collectionView reloadData];
}
#pragma mark -- lazy
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        flowLayout.minimumLineSpacing = 10.f;//计算屏幕宽度,除去3个item 的宽度,之后.才是中间显示的
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.alwaysBounceHorizontal = YES;
        _collectionView.alwaysBounceVertical = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[MSMineRecommendListCell class] forCellWithReuseIdentifier:@"MSMineRecommendListCell"];
    }
    return _collectionView;
}
#pragma mark -- UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.goodsArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MSMineRecommendListCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MSMineRecommendListCell" forIndexPath:indexPath];
    cell.model = self.goodsArr[indexPath.row];
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return  CGSizeMake((SKScreenWidth - 20)/3, 90.f);
}
//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsZero;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.clickBlock) {
        self.clickBlock(self.goodsArr[indexPath.row]);
    }
}


@end
