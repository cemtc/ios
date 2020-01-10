//
//  CustomExportMnmonicWordViewController.m
//  wallet
//
//  Created by 曾云 on 2019/8/20.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "CustomExportMnmonicWordViewController.h"
#import "CustomExportMnmonicWordCollectionViewCell.h"
#import "QYTagViewController.h"


@interface CustomExportMnmonicWordViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *mainCollectionView;

@property (nonatomic,strong) NSMutableArray *dataArray;

@end

@implementation CustomExportMnmonicWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Mnemonic export";
    self.dataArray = [NSMutableArray array];
    [self leftBarButtomItemWithNormalName:@"icon_return_black" highName:@"icon_return_black" selector:@selector(back) target:self];
    if (self.zhujici) {
        [self.dataArray addObjectsFromArray:[self.zhujici componentsSeparatedByString:@" "]];
    }else{
        NSString *mnmonic =[CustomUserManager customSharedManager].userModel.ethMnemonic;
        [self.dataArray addObjectsFromArray:[mnmonic componentsSeparatedByString:@" "]];
    }

}
#pragma mark - <UICollectionDataSourceDelegate>
//返回组数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//返回个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
//显示conllectionView的单元格
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //设置重用单元格
    CustomExportMnmonicWordCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Identifier_CustomExportMnmonicWord" forIndexPath:indexPath];
    cell.title.text = self.dataArray[indexPath.row];
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((SKScreenWidth-80)/3, 30.0f);
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        UICollectionReusableView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"Identifier_FooterView" forIndexPath:indexPath];
        return footer;
    } else {
        UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Identifier_HeaderView" forIndexPath:indexPath];
        return header;
    }
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:NO];
    NSLog(@"didSelectItemAtIndexPath == %ld",indexPath.row);
}

- (IBAction)ExportMnDetailVc:(UIButton *)sender forEvent:(UIEvent *)event {
    QYTagViewController *vc = [[QYTagViewController alloc]initWithPsw:self.mn];
    vc.mn = [CustomUserManager customSharedManager].userModel.ethMnemonic;
    NSLog(@"QYTagViewController======%@",[CustomUserManager customSharedManager].userModel.ethMnemonic);
    [self pushVc:vc];

}
@end
