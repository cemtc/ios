//
//  CustomNotificationCenterDetailsViewController.m
//  wallet
//
//  Created by 曾云 on 2019/8/18.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "CustomNotificationCenterDetailsViewController.h"
#import "CustomNotificationCenterDetailsTableViewCell.h"
#import "CustomNotificationCenterDetailsSectionView.h"



@interface CustomNotificationCenterDetailsViewController ()
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;

@end

@implementation CustomNotificationCenterDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Transfer details";
    [self leftBarButtomItemWithNormalName:@"icon_return_black" highName:@"icon_return_black" selector:@selector(back) target:self];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.detailsModel.sectionModel.itemArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ObjcKeyValueModel *model = self.detailsModel.sectionModel.itemArray[indexPath.row];
    CustomNotificationCenterDetailsTableViewCell *cell = [CustomNotificationCenterDetailsTableViewCell cellWithTableView:tableView identifier:@"Identifier_CustomNotificationCenterDetails"];
    cell.keyValueModel = model;
    return cell;
}


#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 126.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc]initWithFrame:CGRectZero];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    CustomNotificationCenterDetailsSectionView *header = [CustomNotificationCenterDetailsSectionView initViewWithXibIndex:0];
//    header.value.text = self.detailsModel.btc_eth_value;
    if ([self.detailsModel.tokenName isEqualToString:@"btc"]) {
        header.tokenName.text = self.detailsModel.tokenName;
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        header.value.text = [defaults objectForKey:@"btc"];
    }else if ([self.detailsModel.tokenName isEqualToString:@"eth"]) {
        header.tokenName.text = self.detailsModel.tokenName;
        header.value.text = [NSString stringWithFormat:@"%f",self.detailsModel.gas];
    }else{
        header.tokenName.text = self.detailsModel.tokenName;
        header.value.text = [NSString stringWithFormat:@"%f",self.detailsModel.gas];
    }

    return header;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
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
