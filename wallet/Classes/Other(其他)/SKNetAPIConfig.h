//
//  SKNetAPIConfig.h
//  Business
//
//  Created by talking　 on 2018/8/13.
//  Copyright © 2018年 talking　. All rights reserved.
//

#ifndef SKNetAPIConfig_h
#define SKNetAPIConfig_h


//服务器
//#define SKAPI_IP_ADDRESS @"192.168.1.182:8088"//开发服务器
//#define SKAPI_IP_ADDRESS @"192.168.1.195:8080"//开发服务器 传飞的
//#define SKAPI_IP_ADDRESS @"198.44.243.66:8080"//测试服务器
//#define SKAPI_IP_ADDRESS @"w-token.online"//测试服务器
#define SKAPI_IP_ADDRESS @"144.48.243.168:8080"//测试服务器
//#define SKAPI_IP_ADDRESS @"119.23.117.234:7204"//产线服务器

//用到的网络接口 BaseUrl
//#define SKAPI_BaseUrl [NSString stringWithFormat:@"https://%@",SKAPI_IP_ADDRESS]
#define SKAPI_BaseUrl [NSString stringWithFormat:@"http://%@",SKAPI_IP_ADDRESS]


#define UserAgreement @"http://ccmht.cc/userPro.txt"


//通知中心转账通知
#define QYAPI_getTokenNoticeTransRecord_Url [NSString stringWithFormat:@"%@/Web/mobile/common/getTokenNoticeTransRecord",SKAPI_BaseUrl]
#define QYAPI_getBTCNoticeTransRecord_Url [NSString stringWithFormat:@"%@/Web/mobile/common/getOthersTransRecord",SKAPI_BaseUrl]

//获取转账列表
//CCM
#define QYAPI_getCcmTransRecord_Url [NSString stringWithFormat:@"%@/Web/mobile/common/getCcmTransRecord",SKAPI_BaseUrl]
//其他
#define QYAPI_getTokenTransRecord_Url [NSString stringWithFormat:@"%@/Web/mobile/common/getTokenTransRecord",SKAPI_BaseUrl]

#define QYAPI_updateReadStatus_Url [NSString stringWithFormat:@"%@/Web/mobile/common/updateReadStatus",SKAPI_BaseUrl]
//通知中心系统通知
#define QYAPI_getNoticeListByPage_Url [NSString stringWithFormat:@"%@/Web/mobile/common/getNoticeListByPage",SKAPI_BaseUrl]


#define QYAPI_addFeedback_Url [NSString stringWithFormat:@"%@/Web/mobile/common/addFeedback",SKAPI_BaseUrl]









//1.登录POST
#define QYAPI_login_Url [NSString stringWithFormat:@"%@/Web/mobile/common/loginForMobile",SKAPI_BaseUrl]
//2.注册POST
#define QYAPI_register_Url [NSString stringWithFormat:@"%@/Web/mobile/common/register",SKAPI_BaseUrl]
//3.获取汇率GET
#define QYAPI_getCoinSystem_Url [NSString stringWithFormat:@"%@/Web/mobile/common/getCoinSystem",SKAPI_BaseUrl]
//4.获取总资产和平台币GET(我的界面)
#define QYAPI_getProperty_Url [NSString stringWithFormat:@"%@/Web/mobile/common/getProperty",SKAPI_BaseUrl]
//5.公告GET
#define QYAPI_getNoticeListByPage_Url [NSString stringWithFormat:@"%@/Web/mobile/common/getNoticeListByPage",SKAPI_BaseUrl]
//6.点击公告Get
#define QYAPI_insertNoticeHandle_Url [NSString stringWithFormat:@"%@/Web/mobile/common/insertNoticeHandle",SKAPI_BaseUrl]
//7.轮播图GET
#define QYAPI_getBannerByType_Url [NSString stringWithFormat:@"%@/Web/mobile/common/getBannerByType",SKAPI_BaseUrl]
//8.理财页面GET
#define QYAPI_getSystemHelpByType_Url [NSString stringWithFormat:@"%@/Web/mobile/common/getSystemHelpByType",SKAPI_BaseUrl]
//9.发现POST
#define QYAPI_getInformationList_Url [NSString stringWithFormat:@"%@/Web/mobile/common/getInformationList",SKAPI_BaseUrl]
//10.发现详情GET
#define QYAPI_getInformation_Url [NSString stringWithFormat:@"%@/Web/mobile/common/getInformation",SKAPI_BaseUrl]
//11.我的客服GET
#define QYAPI_getCustomList_Url [NSString stringWithFormat:@"%@/Web/mobile/common/getCustomList",SKAPI_BaseUrl]


//14.赎回GET
#define QYAPI_addRansomRecord_Url [NSString stringWithFormat:@"%@/Web/mobile/common/addRansomRecord",SKAPI_BaseUrl]


//15.赎回记录GET
#define QYAPI_getRansomRecordListByPage_Url [NSString stringWithFormat:@"%@/Web/mobile/common/getRansomRecordListByPage",SKAPI_BaseUrl]

//16.修改密码GET
#define QYAPI_changePwd_Url [NSString stringWithFormat:@"%@/Web/mobile/common/changePwd",SKAPI_BaseUrl]

//17.应用接口GET
#define QYAPI_getApplicationList_Url [NSString stringWithFormat:@"%@/Web/mobile/common/getApplicationList",SKAPI_BaseUrl]


//18.更新的接口GET
#define QYAPI_getVersionInfo_Url [NSString stringWithFormat:@"%@/Web/mobile/common/getVersionInfo",SKAPI_BaseUrl]
//19.根据币种查询信息GET
#define QYAPI_getUseBalanceByCoinAndCustomerId_Url [NSString stringWithFormat:@"%@/Web/mobile/common/getUseBalanceByCoinAndCustomerId",SKAPI_BaseUrl]
//20.退出登录POST
#define QYAPI_logout_Url [NSString stringWithFormat:@"%@/Web/mobile/common/logout",SKAPI_BaseUrl]





//1.添加理财记录POST
#define QYAPI_addManageRecord_Url [NSString stringWithFormat:@"%@/Web/mobile/common/addManageRecord",SKAPI_BaseUrl]

//2.查询理财列表GET
#define QYAPI_getManageRecordList_Url [NSString stringWithFormat:@"%@/Web/mobile/common/getManageRecordList",SKAPI_BaseUrl]

////3.查询系统币信息GET
//#define QYAPI_getCoinSysInfo_Url [NSString stringWithFormat:@"%@/Web/mobile/common/getCoinSysInfo",SKAPI_BaseUrl]

//4.验证交易密码GET
#define QYAPI_checkTradePwd_Url [NSString stringWithFormat:@"%@/Web/mobile/common/checkTradePwd",SKAPI_BaseUrl]

//5.理财收益记录GET
#define QYAPI_getManageIncordList_Url [NSString stringWithFormat:@"%@/Web/mobile/common/getManageIncordList",SKAPI_BaseUrl]
//5.1.理财收益记录总收益GET
#define QYAPI_getAllIncome_Url [NSString stringWithFormat:@"%@/Web/mobile/common/getAllIncome",SKAPI_BaseUrl]


//6.糖果GET
#define QYAPI_getCustomerAwardList_Url [NSString stringWithFormat:@"%@/Web/mobile/common/getCustomerAwardList",SKAPI_BaseUrl]


//7.众筹接口添加私募POST
#define QYAPI_addPlacementRecord_Url [NSString stringWithFormat:@"%@/Web/mobile/common/addPlacementRecord",SKAPI_BaseUrl]
//8.众筹接口查询私募列表GET
#define QYAPI_getPlacementRecordList_Url [NSString stringWithFormat:@"%@/Web/mobile/common/getPlacementRecordList",SKAPI_BaseUrl]




//end.行情GET
#define QYAPI_getHangqing_Url @"https://dncapi.bqiapp.com/api/coin/hotcoin_search"




//new 理财
//获得用户理财收益开关的状态
#define QYAPI_getManageStatus_Url [NSString stringWithFormat:@"%@/Web/mobile/common/getManageStatus",SKAPI_BaseUrl]

//更改开关状态 传给服务器
#define QYAPI_updateIncomeStatus_Url [NSString stringWithFormat:@"%@/Web/mobile/common/updateIncomeStatus",SKAPI_BaseUrl]

//理财金额价值必须大于500美金! GET 后台去判断验证
#define QYAPI_checkManageAmount_Url [NSString stringWithFormat:@"%@/Web/mobile/common/checkManageAmount",SKAPI_BaseUrl]

//获取理财本金接口
#define QYAPI_getUseBalanceById_Url [NSString stringWithFormat:@"%@/Web/mobile/common/getUseBalanceById",SKAPI_BaseUrl]


//更新接口
#define QYAPI_getVersionInfo_Url [NSString stringWithFormat:@"%@/Web/mobile/common/getVersionInfo",SKAPI_BaseUrl]



//忘记密码 GET
#define QYAPI_changePwdByQues_Url [NSString stringWithFormat:@"%@/Web/mobile/common/changePwdByQues",SKAPI_BaseUrl]


#define QYAPI_getStarmoney_Url [NSString stringWithFormat:@"%@/Web/resources/starmoney.html",SKAPI_BaseUrl]

//#define SKAPI_api_place_Url(placeCode) [NSString stringWithFormat:@"%@/api/place/%@",SKAPI_BaseUrl,placeCode]

#endif /* SKNetAPIConfig_h */
