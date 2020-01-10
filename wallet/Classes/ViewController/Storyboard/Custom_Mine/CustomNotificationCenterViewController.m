//
//  CustomNotificationCenterViewController.m
//  wallet
//
//  Created by 曾云 on 2019/8/18.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "CustomNotificationCenterViewController.h"
#import "CustomNotificationCenterTableViewCell.h"

#import "CustomNotificationCenterDetailsViewController.h"
#import "CustomNotificationCenterModel.h"

@interface CustomNotificationCenterViewController ()
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;
@property (weak, nonatomic) IBOutlet UIButton *transfer;
@property (weak, nonatomic) IBOutlet UIButton *system;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineView_Constraint_Left;

@property (nonatomic,assign) NSInteger page;

@property (nonatomic,strong) CustomNotificationCenterModel *model;

@end

@implementation CustomNotificationCenterViewController
- (IBAction)transferClick:(UIButton *)sender {
    if (!sender.selected) {
         sender.selected = !sender.selected;
    }
   
    self.system.selected = !sender.selected;
    self.lineView_Constraint_Left.constant = SKScreenWidth/8;
    if (sender.selected) {
        self.model.type1 = CustomNotificationCenterItemType_Transfer;
        [SKUtils beginPullRefreshForScrollView:self.mainTableView];
    }
    
}
- (IBAction)systemClick:(UIButton *)sender {
    if (!sender.selected) {
        sender.selected = !sender.selected;
    }
    self.transfer.selected = !sender.selected;
    self.lineView_Constraint_Left.constant = SKScreenWidth/8 + SKScreenWidth/2;
    if (sender.selected) {
        self.model.type1 = CustomNotificationCenterItemType_System;
        [SKUtils beginPullRefreshForScrollView:self.mainTableView];
    }
}

-(void)getAllTokenNoticeTransRecordPage{
    [CFQCommonServer getAllTokenNoticeTransRecordPage:self.page address:[CustomUserManager customSharedManager].userModel.ethAddress complete:^(NSMutableArray<CustomNotificationCenterItemModel *> * _Nonnull dataArray, NSString * _Nonnull errMsg) {
        [SKUtils endLoadMoreForScrollView:self.mainTableView];
        if (errMsg) {
            [MBProgressHUD showMessage:errMsg];
        } else {
            if (dataArray.count <20) {
                [SKUtils noticeNoMoreDataForScrollView:self.mainTableView];
            }
            [self.model.transferArray addObjectsFromArray:dataArray];
            [CFQCommonServer getAllETHNoticeTransRecordPage:self.page address:[CustomUserManager customSharedManager].userModel.ethAddress complete:^(NSMutableArray<CustomNotificationCenterItemModel *> * _Nonnull dataArray, NSString * _Nonnull errMsg) {
                [SKUtils endLoadMoreForScrollView:self.mainTableView];
                if (errMsg) {
                    [MBProgressHUD showMessage:errMsg];
                } else {
                    if (dataArray.count <20) {
                        [SKUtils noticeNoMoreDataForScrollView:self.mainTableView];
                    }
                    [self.model.transferArray addObjectsFromArray:dataArray];
                    [self.mainTableView reloadData];
                }
            }];
            [self.mainTableView reloadData];
        }
    }];
}
-(void)getAllBTCNoticeTransRecord{
    NSString *obj = [[NSUserDefaults standardUserDefaults] objectForKey:@"BTCethAddress"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [CFQCommonServer getAllETHNoticeTransRecordPage:self.page address:obj complete:^(NSMutableArray<CustomNotificationCenterItemModel *> * _Nonnull dataArray, NSString * _Nonnull errMsg) {
        [SKUtils endLoadMoreForScrollView:self.mainTableView];
        if (errMsg) {
            [MBProgressHUD showMessage:errMsg];
        } else {
            if (dataArray.count <20) {
                [SKUtils noticeNoMoreDataForScrollView:self.mainTableView];
            }
            [self.model.transferArray addObjectsFromArray:dataArray];
            [self.mainTableView reloadData];
        }
    }];
}
-(void)getETHNoticeTransRecord{
//    NSString *obj = [[NSUserDefaults standardUserDefaults] objectForKey:@"ETHethAddress"];
//    [[NSUserDefaults standardUserDefaults] synchronize];
    [CFQCommonServer getAllETHNoticeTransRecordPage:self.page address:[CustomUserManager customSharedManager].userModel.ethAddress complete:^(NSMutableArray<CustomNotificationCenterItemModel *> * _Nonnull dataArray, NSString * _Nonnull errMsg) {
        [SKUtils endLoadMoreForScrollView:self.mainTableView];
        if (errMsg) {
            [MBProgressHUD showMessage:errMsg];
        } else {
            if (dataArray.count <20) {
                [SKUtils noticeNoMoreDataForScrollView:self.mainTableView];
            }
            [self.model.transferArray addObjectsFromArray:dataArray];
            [self.mainTableView reloadData];
        }
    }];
}
-(void)getAllETHNoticeTransRecord{
    [CFQCommonServer getAllETHNoticeTransRecordPage:self.page address:[CustomUserManager customSharedManager].userModel.ethAddress complete:^(NSMutableArray<CustomNotificationCenterItemModel *> * _Nonnull dataArray, NSString * _Nonnull errMsg) {
        [SKUtils endLoadMoreForScrollView:self.mainTableView];
        if (errMsg) {
            [MBProgressHUD showMessage:errMsg];
        } else {
            if (dataArray.count <20) {
                [SKUtils noticeNoMoreDataForScrollView:self.mainTableView];
            }
            [self.model.transferArray addObjectsFromArray:dataArray];
            [self.mainTableView reloadData];
        }
    }];
}
-(void)getNoticeListByPage{
    [CFQCommonServer getNoticeListByPage:self.page complete:^(NSMutableArray<CustomNotificationCenterItemModel *> * _Nonnull dataArray, NSString * _Nonnull errMsg) {
        [SKUtils endLoadMoreForScrollView:self.mainTableView];
        if (errMsg) {
            [MBProgressHUD showMessage:errMsg];
        } else {
            if (dataArray.count <20) {
                [SKUtils noticeNoMoreDataForScrollView:self.mainTableView];
            }
            [self.model.systemArray addObjectsFromArray:dataArray];
            [self.mainTableView reloadData];
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Notification Center";
    self.lineView_Constraint_Left.constant = SKScreenWidth/8;
    self.page = 1;
    self.model = [[CustomNotificationCenterModel alloc]init];
    [self leftBarButtomItemWithNormalName:@"icon_return_black" highName:@"icon_return_black" selector:@selector(back) target:self];
//    [self rightBarButtomItemWithTitle:@"全部已读" selector:@selector(read) target:self];
//    [self getAllETHNoticeTransRecord];
    [self getETHNoticeTransRecord];
    [self getAllBTCNoticeTransRecord];
    [SKUtils addLoadMoreForScrollView:self.mainTableView loadMoreCallBack:^{
        self.page ++;
        switch (self.model.type1) {
            case CustomNotificationCenterItemType_Transfer:
            {
                [self getAllTokenNoticeTransRecordPage];
                [self getAllBTCNoticeTransRecord];
                [self getETHNoticeTransRecord];

              
            }
                break;
                
            case CustomNotificationCenterItemType_System:
            {
                [self getNoticeListByPage];
            }
                break;
                
            default:
                break;
        }
        
        
    }];
  
    [SKUtils addPullRefreshForScrollView:self.mainTableView pullRefreshCallBack:^{
        self.page = 1;
        [MBProgressHUD showMessage:@"消息获取中..."];
        switch (self.model.type1) {
            case CustomNotificationCenterItemType_Transfer:
                {
                    [CFQCommonServer getAllTokenNoticeTransRecordPage:self.page address:[CustomUserManager customSharedManager].userModel.ethAddress complete:^(NSMutableArray<CustomNotificationCenterItemModel *> * _Nonnull dataArray, NSString * _Nonnull errMsg) {
                        [SKUtils endRefreshForScrollView:self.mainTableView];
                        if (errMsg) {
                            [MBProgressHUD showMessage:errMsg];
                        } else {
                            [self.model.transferArray removeAllObjects];
                            [self.model.transferArray addObjectsFromArray:dataArray];
                            if (dataArray.count <20) {
                                [SKUtils noticeNoMoreDataForScrollView:self.mainTableView];
                            }
                            [self.mainTableView reloadData];
                            [MBProgressHUD showMessage:@"Transfer message succeeded"];
                        }
                    }];

                }
                break;
                
            case CustomNotificationCenterItemType_System:
                {
                    [CFQCommonServer getNoticeListByPage:self.page complete:^(NSMutableArray<CustomNotificationCenterItemModel *> * _Nonnull dataArray, NSString * _Nonnull errMsg) {
                        [SKUtils endRefreshForScrollView:self.mainTableView];
                        if (errMsg) {
                            [MBProgressHUD showMessage:errMsg];
                        } else {
                            [self.model.systemArray removeAllObjects];
                            [self.model.systemArray addObjectsFromArray:dataArray];
                            if (dataArray.count <20) {
                                [SKUtils noticeNoMoreDataForScrollView:self.mainTableView];
                            }
                            [self.mainTableView reloadData];
                            [MBProgressHUD showMessage:@"System message succeeded"];
                        }
                    }];
                }
                break;
                
            default:
                break;
        }

    }];
    
    [SKUtils beginPullRefreshForScrollView:self.mainTableView];
}

- (void)read {
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (self.model.type1) {
        case CustomNotificationCenterItemType_Transfer:
            return self.model.transferArray.count;
            break;
            
        case CustomNotificationCenterItemType_System:
            return self.model.systemArray.count;
            break;
            
        default:
            break;
    }
    return 0;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomNotificationCenterItemModel *itemModel;
    switch (self.model.type1) {
        case CustomNotificationCenterItemType_Transfer:
            itemModel = self.model.transferArray[indexPath.row];
            break;
            
        case CustomNotificationCenterItemType_System:
            itemModel = self.model.systemArray[indexPath.row];
            break;
            
        default:
            break;
    }
    
    CustomNotificationCenterTableViewCell *cell = [CustomNotificationCenterTableViewCell cellWithTableView:tableView identifier:itemModel.objc_Identifier];
    cell.itemModel = itemModel;

    return cell;
}


#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (self.model.type1) {
        case CustomNotificationCenterItemType_Transfer:
            return [self.model.transferArray[indexPath.row] objc_Height];
            break;
            
        case CustomNotificationCenterItemType_System:
            return [self.model.systemArray[indexPath.row] objc_Height];
            break;
            
        default:
            break;
    }
    return CGFLOAT_MIN;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc]initWithFrame:CGRectZero];;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    return [[UIView alloc]initWithFrame:CGRectZero];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CustomNotificationCenterItemModel *itemModel;
    switch (self.model.type1) {
        case CustomNotificationCenterItemType_Transfer:
     
            itemModel = self.model.transferArray[indexPath.row];
            break;
            
        case CustomNotificationCenterItemType_System:
            itemModel = self.model.systemArray[indexPath.row];
            break;
            
        default:
            break;
    }
    
    if ([itemModel.tokenName isEqualToString:@"EMTC"]) {
        NSString *type = @"from";
        NSString *adress = [[CustomUserManager customSharedManager].userModel.ethAddress lowercaseString];
        if (![adress isEqualToString:itemModel.from.lowercaseString]) {
            type = @"to";
        }
        
        
        [CFQCommonServer updateReadStatusType:type hash:itemModel.hash_K complete:^(NSString * _Nonnull errMsg) {
            
        }];
        
        CustomNotificationCenterDetailsModel *detailsModel = [[CustomNotificationCenterDetailsModel alloc]initWithItemModel:itemModel];
        CustomNotificationCenterDetailsViewController *viewController = [[UIStoryboard storyboardWithName:@"Mine" bundle:nil] instantiateViewControllerWithIdentifier:@"CustomNotificationCenterDetails"];
        
        viewController.detailsModel = detailsModel;
        [self pushVc:viewController];
    }
    if ([itemModel.type isEqualToString:@"btc"]) {
        NSString *type = @"from";
        NSString *obj = [[NSUserDefaults standardUserDefaults] objectForKey:@"BTCethAddress"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        NSString *adress = [obj lowercaseString];
        if (![adress isEqualToString:itemModel.from.lowercaseString]) {
            type = @"to";
        }
        
        
        [CFQCommonServer updateReadStatusType:type hash:itemModel.hashO complete:^(NSString * _Nonnull errMsg) {
            
        }];
        
        CustomNotificationCenterDetailsModel *detailsModel = [[CustomNotificationCenterDetailsModel alloc]initWithItemModel:itemModel];
        CustomNotificationCenterDetailsViewController *viewController = [[UIStoryboard storyboardWithName:@"Mine" bundle:nil] instantiateViewControllerWithIdentifier:@"CustomNotificationCenterDetails"];
        
        viewController.detailsModel = detailsModel;
        [self pushVc:viewController];
    }
    if ([itemModel.type isEqualToString:@"eth"]) {
        NSString *type = @"from";
        NSString *adress = [[CustomUserManager customSharedManager].userModel.ethAddress lowercaseString];
        if (![adress isEqualToString:itemModel.from.lowercaseString]) {
            type = @"to";
        }
        
        
        [CFQCommonServer updateReadStatusType:type hash:itemModel.hashO complete:^(NSString * _Nonnull errMsg) {
            
        }];
        
        CustomNotificationCenterDetailsModel *detailsModel = [[CustomNotificationCenterDetailsModel alloc]initWithItemModel:itemModel];
        CustomNotificationCenterDetailsViewController *viewController = [[UIStoryboard storyboardWithName:@"Mine" bundle:nil] instantiateViewControllerWithIdentifier:@"CustomNotificationCenterDetails"];
        
        viewController.detailsModel = detailsModel;
        [self pushVc:viewController];
    }

    
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
