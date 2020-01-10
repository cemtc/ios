//
//  EFTagGroupCell.m
//  wallet
//
//  Created by 董文龙 on 2019/11/28.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "EFTagGroupCell.h"
#import "EFTagCell.h"
#import "EFTagGroupItem.h"
#import "EFTagsItem.h"
extern CGFloat const itemH;
static NSString * const tagCell = @"tagCell";
@interface EFTagGroupCell ()<UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *tagGroupLabel;


@end
@implementation EFTagGroupCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    CGFloat margin = 10;
    CGFloat cols = 4;
    CGFloat itemW = ([UIScreen mainScreen].bounds.size.width - (cols + 1) * margin) / cols;
    layout.itemSize = CGSizeMake(itemW, itemH);
    layout.minimumInteritemSpacing = margin;
    layout.minimumLineSpacing = margin;
    
    // 设置collectionView
    self.collectionView.dataSource = self;
    self.collectionView.scrollEnabled = NO;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerNib:[UINib nibWithNibName:@"EFTagCell" bundle:nil] forCellWithReuseIdentifier:tagCell];
}



- (void)setTagGroup:(EFTagGroupItem *)tagGroup
{
    _tagGroup = tagGroup;
    _tagGroupLabel.text = tagGroup.name;
    [self.collectionView reloadData];
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _tagGroup.data.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    EFTagCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:tagCell forIndexPath:indexPath];
    
    EFTagsItem *item = _tagGroup.data[indexPath.row];
    cell.item = item;
    
    
    return cell;
}

@end
