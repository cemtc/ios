//
//  QYNewFinancialCenterCell.h
//  wallet
//
//  Created by talking　 on 2019/7/4.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "SKBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface QYNewFinancialCenterCell : SKBaseTableViewCell
@property (nonatomic, assign) BOOL currentSelectLicaiOrShuihui;
@property (nonatomic, copy) NSString *rightCurrentInfo;
@property (nonatomic, copy) NSString *leftCurrentInfo;


@property (nonatomic, assign) BOOL lisOn;



//赎回
@property (nonatomic, copy) NSString * ruseBalance1;//余额
@property (nonatomic, copy) NSString * rpoundage2;//手续费
@property (nonatomic, copy) NSString * rtokenExchageRate3;//汇率


@property (nonatomic, copy) void (^NextViewControllerBlock)(NSString *tfText, BOOL currentSHUHUI);


@property (nonatomic, strong) UITextField *inputTextfield1;
@property (nonatomic, strong) UITextField *inputTextfield2;




@property (nonatomic, copy) NSString *rightTextField;
@property (nonatomic, copy) NSString *leftTextField;


@property(nonatomic, copy) NSString *leftBalanceNum;


//实时输出到controller
@property (nonatomic, copy) void (^inputTextfieldBlock)(NSString *tfText, BOOL currentSHUHUI);


@property (nonatomic, copy) NSString *duihuanHuilu;

@end

NS_ASSUME_NONNULL_END
