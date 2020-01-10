//
//  CFQCommonModel.h
//  wallet
//
//  Created by talking　 on 2019/6/27.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "SKBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CFQCommonModel : SKBaseModel

//common
@property (nonatomic, copy) NSString *createTime;


//8.cfqServerGetSystemHelpByType start
@property (nonatomic, copy) NSString *content;//文字内容
@property (nonatomic, copy) NSString *createId;
@property (nonatomic, copy) NSString *systemHelpId;
@property (nonatomic, copy) NSString *systemType;
@property (nonatomic, copy) NSString *systemTypeDesc;
@property (nonatomic, copy) NSString *updateId;
@property (nonatomic, copy) NSString *updateTime;
//cfqServerGetSystemHelpByType end

//5.start 公告
@property (nonatomic, copy) NSString *noticeTitle;
@property (nonatomic, copy) NSString *noticeId;
@property (nonatomic, copy) NSString *isRead;
@property (nonatomic, copy) NSString *noticeDesc;
//5.end



//11.客服
@property (nonatomic, copy) NSString *tencentNo;
@property (nonatomic, copy) NSString *wechatNo;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *phoneNo;
//11.客服end

//我的总资产start
@property (nonatomic, copy) NSString *property;
//@property (nonatomic, copy) NSString *sumPTB;
@property (nonatomic, copy) NSString *totalBalance;

//我的总资产end

//3.查询系统币信息start(和汇率变成了一个)
@property (nonatomic, copy) NSString *coinName;
//@property (nonatomic, copy) NSString *systemAddress;
@property (nonatomic, copy) NSString *rechargeAddress;

//end

//理财记录
//@property (nonatomic, copy) NSString *createTime;
//1：发起转账；2：转账；3：失败；4：成功

@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *ransomStatus;
@property (nonatomic, copy) NSString *coinTypeDesc;
@property (nonatomic, copy) NSString *manageMoney;
//end


//理财收益记录
@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString *income;
@property (nonatomic, copy) NSString *recommend;
@property (nonatomic, copy) NSString *allIncome;



//赎回记录
@property (nonatomic, copy) NSString *ransomValue;
@property (nonatomic, copy) NSString *ransomPoundage ;//手续费



//行情测试 假数据
@property (nonatomic, copy) NSString *hqIconImageString;
@property (nonatomic, copy) NSString *hqTitleString;
@property (nonatomic, copy) NSString *hqCenterTopString;
@property (nonatomic, copy) NSString *hqCenterBottomString;
@property (nonatomic, copy) NSString *hqRightString;
//行情end 假数据


//糖果记录
@property (nonatomic, copy) NSString *awardDesc;
@property (nonatomic, copy) NSString *awardValue;//糖果记录金额

//end

//众筹记录
@property (nonatomic, copy) NSString *placementValue;
@property (nonatomic, copy) NSString *placementStatus;
//@property (nonatomic, copy) NSString *currentRage;




//new理财
@property (nonatomic, copy) NSString *isDis;
@property (nonatomic, copy) NSString *isOn;

@property (nonatomic, copy) NSString *useBalance;
@property (nonatomic, copy) NSString *poundage;
@property (nonatomic, copy) NSString *tokenExchageRate;


//汇率  输入的*rmgExchageRate / 6.8
@property (nonatomic, copy) NSString *rmgExchageRate;



@end

NS_ASSUME_NONNULL_END
