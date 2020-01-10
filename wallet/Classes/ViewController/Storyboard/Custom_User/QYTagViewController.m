//
//  QYTagViewController.m
//  wallet
//
//  Created by 董文龙 on 2019/11/28.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "QYTagViewController.h"
#import "EFTagList.h"
#import "EFTagCell.h"
#import "EFTagsItem.h"
#import "EFGroupItem.h"
#import "EFTagGroupItem.h"
#import "EFHobbyCell.h"
#import "EFTagGroupCell.h"

#define EFColor86  [UIColor colorWithHexString:@"#0693C2"]
#define EFColor85  [UIColor colorWithHexString:@"#858585"]
static NSString * const hobbyCell = @"hobbyCell";
static NSString * const tagGroupCell = @"tagGroupCell";
@interface QYTagViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate>
{
    NSArray *sortArray;
}
@property(strong,nonatomic)UILabel *lblNotice;
@property(nonatomic, strong) UILabel *lblMn;
@property(nonatomic, strong) UITextView *mnWordTF;
@property(nonatomic, strong) UIImageView *headerImageView;
@property (nonatomic, strong) NSMutableArray *selectTagArr;
@property (nonatomic,strong)NSMutableArray *moreTagsArr;
@property (nonatomic,strong)UITableView *tagsView;
@property (nonatomic, strong) EFTagList *tagList;
@property (nonatomic, strong) NSMutableArray *groups;
@property (nonatomic, strong) NSMutableDictionary *selectTagDict;
@end
@implementation QYTagViewController
- (NSMutableArray *)selectTagArr
{
    if (_selectTagArr == nil) {
        _selectTagArr = [NSMutableArray array];
    }
    return _selectTagArr;
}
- (NSMutableDictionary *)selectTagDict
{
    if (_selectTagDict == nil) {
        _selectTagDict = [NSMutableDictionary dictionary];
    }
    return _selectTagDict;
}
- (EFTagList *)tagList
{
    if (_tagList == nil) {
        _tagList = [[EFTagList alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0)];
        __weak __typeof__(self) weakSelf = self;
        _tagList.clickTagBlock = ^(NSString *tag){
            [weakSelf clickTag:tag];
        };
        _tagList.tagColor = [UIColor whiteColor];
    }
    return _tagList;
}
- (void)clickTag:(NSString *)tag
{
    [_tagList deleteTag:tag];
    NSIndexSet *indexSex = [NSIndexSet indexSetWithIndex:0];
    [self.tagsView reloadSections:indexSex withRowAnimation:UITableViewRowAnimationNone];
    EFTagCell *cell = self.selectTagDict[tag];
    EFTagsItem *item = cell.item;
    item.isSelected = !item.isSelected;
    cell.item = item;
    [self.selectTagDict removeObjectForKey:tag];
    for(int i =0;i<_selectTagArr.count;i++){
        if([_selectTagArr[i] isEqualToString:tag]){
            [_selectTagArr removeObjectAtIndex:i];
            i--;
        }
    }
}
- (NSArray *)groups
{
    if (_groups == nil) {
        _groups = [NSMutableArray array];
    }
    return _groups;
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationControllerShouldReceiveGestural = NO;
    self.automaticallyAdjustsScrollViewInsets = false;
    self.edgesForExtendedLayout = UIRectEdgeAll;
    [self configUIView];
}
- (instancetype)initWithPsw:(NSString *)mn {
    self = [super init];
    if (self) {
        self.mn = mn;
        self.lblMnText = [mn copy];
        NSLog(@"QYTagViewController======%@",self.mn);

    }
    return self;
}
+ (instancetype)controllerWithPsw:(NSString *)mn {
    return [[self alloc] initWithPsw:mn];
}

- (void)configUIView {
//    [self setNavigationbar_Color:[UIColor clearColor]];
    self.navigationItem.title = @"Mnemonic verification";
    self.headerImageView = [[UIImageView alloc] init];
    self.headerImageView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0);
//    self.headerImageView.image = [UIImage imageNamed:@"topBackground"];
    //提示文字
    UILabel *lblTitle = [[UILabel alloc] init];
    lblTitle.text = @"Please select your backup mnemonic word！";
    _tagsView.delegate =self;
    _tagsView.dataSource =self;
    lblTitle.font = [UIFont systemFontOfSize:13];
    lblTitle.textColor = [UIColor whiteColor];
    lblTitle.textAlignment = NSTextAlignmentCenter;
    UIImageView *avatarImageView = [[UIImageView alloc] init];
    [self.headerImageView addSubview:avatarImageView];
    [self.headerImageView addSubview:lblTitle];
    avatarImageView.layer.masksToBounds = YES;
    avatarImageView.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - 75) / 2, 0, 63, 75);
    avatarImageView.image = [UIImage imageNamed:@"backupIcon"];
    [self.view addSubview:self.headerImageView];
    [lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.headerImageView);
        make.top.equalTo(avatarImageView.mas_bottom).offset(0);
    }];
    _lblNotice = [[UILabel alloc] init];
    _lblNotice.text =@"Mnemonics can be imported into the wallet instead of entering the wallet's private key. Please copy it down and memorize it, and store it in a safe place only you know.";

    _lblNotice.font = [UIFont systemFontOfSize:13];
    _lblNotice.textColor = EFColor85;
    _lblNotice.numberOfLines = 0;
    [self.view addSubview:_lblNotice];
    [_lblNotice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(30);
        make.right.equalTo(self.view).offset(-30);
        make.top.equalTo(lblTitle.mas_bottom).offset(33);
    }];
    self.array = [[self.lblMnText componentsSeparatedByString:@" "] mutableCopy];
    sortArray = [self.array sortedArrayUsingComparator:^NSComparisonResult(NSString *str1, NSString *str2) {
        int seed = arc4random_uniform(2);
        if (seed) {
            return [str1 compare:str2];
        } else {
            return [str2 compare:str1];
        }
    }];
    [self.view addSubview:self.tagsView];
    [self tabData];
    [self bottomUI];
    UIButton *btnCreate = [UIButton new];
    self.view.userInteractionEnabled = YES;
    btnCreate.frame = CGRectMake(20, [UIScreen mainScreen].bounds.size.height-115, [UIScreen mainScreen].bounds.size.width-40, 36);
    [btnCreate setTitle:@"Copy" forState:UIControlStateNormal];
    [btnCreate setBackgroundColor:EFColor86];
    //    [btnCreate addTarget:self action:@selector0693C2(btnCreateControlEvents:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnCreate];
    @weakify(self);
    [[btnCreate rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        NSString *originalStr = [self.array componentsJoinedByString:@" "];
        NSString *selectStr = [self.selectTagArr componentsJoinedByString:@" "];
        NSLog(@"-----------originalStr----------%@\n-----------originalStr----------",originalStr);
        if ([selectStr isEqualToString:@""]||selectStr==nil||selectStr.length==0) {
            [MBProgressHUD showMessage:@"Please select mnemonic words"];
          
        }else if([originalStr isEqualToString:selectStr]){
             [MBProgressHUD showMessage:@"Copy Success"];
            UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
            pasteboard.string = originalStr;
            [self.navigationController popViewControllerAnimated:YES];
//            Web3AccountModel *accountModel = [[Web3AccountModel alloc] init];
//            accountModel.address = self.accModel.address;
//            accountModel.privateKey = self.accModel.privateKey;
//            EFCreateWalletSuccessViewController *createWalletSuccessViewController = [[EFCreateWalletSuccessViewController alloc] initWithWeb3CreateWalletResultModel:accountModel];
//            [self.navigationController pushViewController:createWalletSuccessViewController animated:YES];
        }else{
            [MBProgressHUD showMessage:@"Your mnemonic choice is incorrect"];
        }
    }];
    
}
-(void)tabData{
    EFGroupItem *group = [[EFGroupItem alloc] init];
    group.data = [[NSMutableArray alloc]init];
    [self.groups addObject:group];
    EFTagGroupItem *tagGroup = [[EFTagGroupItem alloc] init];
    tagGroup.data = [[NSMutableArray alloc]init];
    [group.data addObject:tagGroup];
    _moreTagsArr =[[NSMutableArray alloc]init];
    NSMutableArray *array = [[NSMutableArray alloc]init];
    for (int i=0; i<sortArray.count; i++) {
        NSDictionary *data = @{@"id":[NSString stringWithFormat:@"%d",arc4random() % 100],
                               @"name":[sortArray objectAtIndex:i]
                               };
        [array addObject:data];
    }
    NSMutableDictionary *dataInfo = [self arrToDict:array];
    [_moreTagsArr addObject:dataInfo];
    for (NSDictionary *dict in _moreTagsArr) {
        EFGroupItem *group = [EFGroupItem groupWithDict:dict];
        [self.groups addObject:group];
    }
}
-(void)bottomUI{
    [self.tagsView registerClass:[EFHobbyCell class] forCellReuseIdentifier:hobbyCell];
    [self.tagsView registerNib:[UINib nibWithNibName:@"EFTagGroupCell" bundle:nil] forCellReuseIdentifier:tagGroupCell];
    self.tagsView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}
-(UITableView *)tagsView{
    if (!_tagsView){
        _tagsView =[[UITableView alloc]initWithFrame:CGRectMake(0, 239, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height/2-60) style:UITableViewStylePlain];
        _tagsView.alwaysBounceVertical = YES;
        _tagsView.delegate = self;
        _tagsView.dataSource = self;
    }
    return _tagsView;
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.groups.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    EFTagGroupItem *group = self.groups[section];
    return group.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        EFHobbyCell *cell = [tableView dequeueReusableCellWithIdentifier:hobbyCell];
        cell.tagList = self.tagList;
        return cell;
    }
    EFGroupItem *group = self.groups[indexPath.section];
    EFTagGroupItem *tagGroup = group.data[indexPath.row];
    EFTagGroupCell *cell = [tableView dequeueReusableCellWithIdentifier:tagGroupCell forIndexPath:indexPath];
    cell.collectionView.delegate = self;
    cell.tagGroup = tagGroup;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return _tagList.tagListH;
    }
    EFGroupItem *group = self.groups[indexPath.section];
    EFTagGroupItem *tagGroup = group.data[indexPath.row];
    return tagGroup.cellH;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    EFTagCell *cell = (EFTagCell *)[collectionView cellForItemAtIndexPath:indexPath];
    EFTagsItem *item = cell.item;
    item.isSelected = !item.isSelected;
    cell.item = item;
    
    NSString *tagStr = cell.tagLabel.text;
    if (item.isSelected) {
        [self.tagList addTag:tagStr];
        [self.selectTagDict setObject:cell forKey:tagStr];
        [self.selectTagArr addObject:tagStr];
    } else {
        [self.tagList deleteTag:tagStr];
        for(int i =0;i<_selectTagArr.count;i++){
            if([_selectTagArr[i] isEqualToString:tagStr]){
                [_selectTagArr removeObjectAtIndex:i];
                i--;
            }
        }
    }
    [self.tagsView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
}

-(NSMutableDictionary *)arrToDict:(NSMutableArray *)infoArr{
    NSMutableArray *array = [NSMutableArray new];
    [array addObject:infoArr];
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    [dict setValue:infoArr forKey:@"data"];
    NSMutableArray *tempArr = [NSMutableArray array];
    [tempArr addObject:dict];
    NSMutableDictionary *dataInfo=[[NSMutableDictionary alloc]init];
    [dataInfo setValue:tempArr forKey:@"data"];
    return dataInfo;
}
@end
