//
//  SKCommenDefines.h
//  Business
//
//  Created by talking　 on 2018/8/13.
//  Copyright © 2018年 talking　. All rights reserved.
//

#ifndef SKCommenDefines_h
#define SKCommenDefines_h


#pragma mark -获取整个app delegate
#define SKGET_APP_DELEGATE   ((AppDelegate *)[UIApplication sharedApplication].delegate)
#define ENDEDITING                      [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
#define KEY_WINDOW                      [[UIApplication sharedApplication] keyWindow]

#define APP_VERSION                 [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"]

#define CustomWallet  [[CustomWalletSwift alloc]init]

#pragma mark - 图片，返回UIImage
#define SKImageNamed(name) [UIImage imageNamed:name]

#define SKStr(num) [NSString stringWithFormat:@"%d",num]


//在DEBUG模式下
#pragma mark - 打印
#ifdef DEBUG
#define SKLog(...) NSLog(@"%s 第%d行 \n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else
#define SKLog(...)
#endif

#pragma mark - 弱引用
#define SKDefineWeakSelf       __weak typeof(self) weakSelf = self

#pragma mark - 通知 归档标识
/** 网络请求成功*/
#define SKRequestSuccessNotification @"SKRequestSuccessNotification"

/** 是否登陆*/
#define SKHasLoginFlag @"SKHasLoginFlag"


#pragma mark - 颜色

#define QYThemeColor [UIColor colorWithRed:46.0/255.0 green:48.0/255.0 blue:59.0/255.0 alpha:1.0]//主色

#define SKThemeColor [UIColor colorWithHexString:@"#2268ef"]//主色

//#define SKCommonBgColor [UIColor colorWithHexString:@"#f0f0f0"]//controll 背景颜色
#define SKCommonBgColor [UIColor colorWithRed:247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:1.0]//controll 背景颜色


#define SKDirectionTextColor [UIColor colorWithRed:144.0/255.0 green:108.0/255.0 blue:106.0/255.0 alpha:1.0]//使用说明颜色

#define SKItemNormalColor [UIColor colorWithRed:0.62f green:0.62f blue:0.63f alpha:1.00f]//tabbar item 普遍颜色


#define SKWhiteColor [UIColor whiteColor]//白色
#define SKBlackColor [UIColor blackColor]//黑色
#define SKRedColor [UIColor redColor]//红色
#define SKLightGrayColor [UIColor lightGrayColor] //高亮灰
#define SKClearColor [UIColor clearColor]//clear色
#define SKBlueColor [UIColor blueColor]//蓝色
#define SKGreenColor [UIColor greenColor]//绿色
#define SKOrangeColor [UIColor orangeColor]

#define SKSeperatorColor SKColor(234,237,240,1.0)//HLCustomAlertView Line颜色
#define SKCommonBlackColor [UIColor colorWithRed:0.17f green:0.23f blue:0.28f alpha:1.00f]//HLCustomAlertView 背景颜色
#define SKCommonGrayTextColor [UIColor colorWithRed:0.63f green:0.63f blue:0.63f alpha:1.00f]
////在HLUtils用到
#define SKCommonHighLightRedColor [UIColor colorWithRed:1.00f green:0.49f blue:0.65f alpha:1.00f]
////自定义颜色
#define SKColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]


#define SKTextColor [UIColor colorWithRed:0.32f green:0.36f blue:0.40f alpha:1.00f]


#pragma mark - frame
#define SKIsIphoneX [UIScreen mainScreen].bounds.size.height > 811

#define SKAdapterScale (SKScreenWidth/375.0) // UI按照iPhone6 标准尺寸设计效果图 每个控件的要成他做不同机型适配
#define SKScreenWidth [UIScreen mainScreen].bounds.size.width
#define SKScreenHeight [UIScreen mainScreen].bounds.size.height
#define SKLineHeight (1 / [UIScreen mainScreen].scale)

//对所有的数进行屏幕适配 talking171024
#define SKAppAdapter(num) num*SKAdapterScale

#pragma mark - font
#define SKFont(size) [UIFont systemFontOfSize:size*SKAdapterScale]//字体自适应屏幕尺寸
#define SKFontBig(F) [UIFont fontWithName:@"Helvetica-Bold" size:F]

#pragma mark - 字符串转化
#define SKEmptyStr @""
#define SKValidStr(str) [SKUtils validString:str] //转换成有效的字符串  在判断的时候用到   就是没有也要赋值为“” 避免为nil导致崩溃
//转换字符串 在Until里用到的！！！！！
#define PUGetString(__Obj__) [SKUtils getStringFromDicItem:__Obj__]
//成功
#define SKCODE_SUCCESS @"1" //正确


#define SKKEY_HAS_LAUNCHED_ONCE   @"HasLaunchedOnce"  //判断是否第一次安装APP 如果是 登录新特性  如果不是 去检测之前有没有登录

//钱包项目
#define QYLICAIZHUANZHANG @"QYLICAIZHUANZHANG" //转账操作

#define QYLICAIYUE @"QYLICAIYUE" //网络请求余额操作


//eth 固定手续费
#define QYETHGASPRICE 0.00021

#define QYUSDTANDBTCGASPRICE 0.0001


#endif /* SKCommenDefines_h */
