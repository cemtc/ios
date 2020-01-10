//
//  CustomVerifyMnmonicWordViewController.m
//  wallet
//
//  Created by 曾云 on 2019/8/21.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "CustomVerifyMnmonicWordViewController.h"
#import "CustomVerifyMnmonicWordCollectionViewCell.h"

@interface CustomVerifyMnmonicWordViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *mainConllectionView;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) NSMutableArray *seleArray;
@end

@implementation CustomVerifyMnmonicWordViewController
- (IBAction)finishButtonClick:(UIButton *)sender {
    if ([self.textView.text isEqualToString:[CustomUserManager customSharedManager].userModel.ethMnemonic]) {
        [UIPasteboard generalPasteboard].string = self.textView.text;
        [MBProgressHUD showMessage:@"Copy Success"];
    } else {
        [MBProgressHUD showMessage:@"Mnemonic verification failed"];
    }
}

- (void)back {
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Mnemonic verification";
//    self.textView.placeholder = @"Please fill in the mnemonic in order";
    self.dataArray = [NSMutableArray array];
    self.seleArray = [NSMutableArray array];
    [self leftBarButtomItemWithNormalName:@"icon_return_black" highName:@"icon_return_black" selector:@selector(back) target:self];
    NSString *mnmonic =[CustomUserManager customSharedManager].userModel.ethMnemonic;
    NSArray *mnmonics = [mnmonic componentsSeparatedByString:@" "];
    mnmonics = [mnmonics sortedArrayUsingComparator:^NSComparisonResult(NSString *str1, NSString *str2) {
            int seed = arc4random_uniform(2);
            if (seed) {
                return [str1 compare:str2];
            } else {
                return [str2 compare:str1];
            }
        }];
    
    [self.dataArray addObjectsFromArray:mnmonics];
    
    for (NSInteger i = 0; i <self.dataArray.count; i++) {
        [self.seleArray addObject:@(NO)];
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
    CustomVerifyMnmonicWordCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Identifier_ CustomVerifyMnmonicWord" forIndexPath:indexPath];
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
    
    BOOL isSelected = [self.seleArray[indexPath.row] boolValue];
    [self.seleArray replaceObjectAtIndex:indexPath.row withObject:@(!isSelected)];

    NSLog(@"didSelectItemAtIndexPath == %ld",indexPath.row);
    NSMutableArray *array = [NSMutableArray array];
    for (NSInteger i = 0; i<self.seleArray.count; i++) {
        BOOL selected  =[self.seleArray[i] boolValue];
        if (selected) {
            [array addObject:self.dataArray[i]];
        }
    }
    
    
    self.textView.text = [array componentsJoinedByString:@" "];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
