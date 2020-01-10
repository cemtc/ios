//
//  SKUtils.h
//  Business
//
//  Created by talking　 on 2018/8/13.
//  Copyright © 2018年 talking　. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MJRefreshComponent.h"

typedef void(^XRRefreshAndLoadMoreHandle)(void);


@interface SKUtils : NSObject

/** 开始下拉刷新 */
+ (void)beginPullRefreshForScrollView:(UIScrollView *)scrollView;

/** 判断头部是否在刷新 */
+ (BOOL)headerIsRefreshForScrollView:(UIScrollView *)scrollView;

/** 判断是否尾部在刷新 */
+ (BOOL)footerIsLoadingForScrollView:(UIScrollView *)scrollView;

/** 提示没有更多数据的情况 */
+ (void)noticeNoMoreDataForScrollView:(UIScrollView *)scrollView;

/**   重置footer */
+ (void)resetNoMoreDataForScrollView:(UIScrollView *)scrollView;

/**  停止下拉刷新 */
+ (void)endRefreshForScrollView:(UIScrollView *)scrollView;

/**  停止上拉加载 */
+ (void)endLoadMoreForScrollView:(UIScrollView *)scrollView;

/**  隐藏footer */
+ (void)hiddenFooterForScrollView:(UIScrollView *)scrollView;

/** 隐藏header */
+ (void)hiddenHeaderForScrollView:(UIScrollView *)scrollView;

/** 下拉刷新 */
+ (void)addLoadMoreForScrollView:(UIScrollView *)scrollView
                loadMoreCallBack:(XRRefreshAndLoadMoreHandle)loadMoreCallBackBlock;

/** 上拉加载 */
+ (void)addPullRefreshForScrollView:(UIScrollView *)scrollView
                pullRefreshCallBack:(XRRefreshAndLoadMoreHandle)pullRefreshCallBackBlock;






//转换成有效的字符串  在判断的时候用到   就是没有也要赋值为“” 避免为nil导致崩溃
+ (NSString *)validString:(NSString *)string;

/**
 *  判断字符串是否为空
 */
+ (BOOL)isBlankString:(NSString *)string;




/** color生成image*/
+ (UIImage *)imageWithColor:(UIColor *)color;




/**
 *  转化时间 时间戳转时间
 */
+ (NSString *)datestrFromDate:(NSDate *)date
               withDateFormat:(NSString *)format;

+ (NSDate *)GetTomorrowDay:(int)n;
/**
 *  转化时间
 *  几天前，几分钟前
 */
+ (NSString *)updateTimeForTimeInterval:(NSInteger)timeInterval;



/**
 *  公共富文本
 */
+ (NSAttributedString *)attStringWithString:(NSString *)string keyWord:(NSString *)keyWord;

+ (NSAttributedString *)attStringWithString:(NSString *)string
                                    keyWord:(NSString *)keyWord
                                       font:(UIFont *)font
                           highlightedColor:(UIColor *)highlightedcolor
                                  textColor:(UIColor *)textColor;

+ (NSAttributedString *)attStringWithString:(NSString *)string
                                    keyWord:(NSString *)keyWord
                                       font:(UIFont *)font
                           highlightedColor:(UIColor *)highlightedcolor
                                  textColor:(UIColor *)textColor
                                  lineSpace:(CGFloat)lineSpace;










/**
 *  手机号码验
 *
 *
 */
+ (BOOL)isValidateMobile:(NSString *)mobile;

/**
 *  判断邮箱
 */
-(BOOL)isEmailWithString:(NSString *)str;


/**
 *  身份证上的姓名
 *
 *
 */
+ (BOOL)isValidateCHNameChar:(NSString *)realname;

/**
 *  纯数字
 *
 *
 */
+ (BOOL)isTypeNumber:(NSString *)num;



/**
 *  是否是否仅包含英文、中文、数字
 *
 *
 */
+ (BOOL)isContainNonEnglishAndChineseCharacter:(NSString*)str;

/**
 *  字母、数字或下划线
 *
 *
 */
+ (BOOL)isContainNonEnglishAndUnderscores:(NSString*)str;

/**
 *  字母、数字或下划线中文
 *
 *
 */
+ (BOOL)isContainNonEnglishAndUnderscoresAndChinese:(NSString*)str;

/**
 *  检测字符串是否只包含空格和换行
 *
 *
 */
+ (BOOL)isWhitespaceCharacterSet:(NSString *)str;

/**
 *  从文件解析json
 *
 *  @param fileName <#fileName description#>
 *
 *  @return <#return value description#>
 */
+ (NSDictionary *)connvertJSONFileToDict:(NSString *)fileName;


/**
 *  json解析
 *
 *
 */
+ (NSArray *)convertJSONToArr:(NSString *)string;
+ (NSDictionary *)convertJSONToDict:(NSString *)string;

/**
 *  转json
 *
 *
 */
+ (NSString *)convertObjectToJSON:(id)object;


//json格式字符串转字典：
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;


/**
 *  根据字符串返回颜色
 *
 *  @param hexColor 888888 六位颜色值
 *
 */
+ (UIColor *)getColor:(NSString *)hexColor;

/**
 *  获取上传的正方形图片
 *
 *  @param image 原始图片
 *
 */
+ (UIImage *)getUploadImage:(UIImage *)image;

/**
 *  缩放图片
 *
 *  @param image 原始图片
 *  @param size  需要缩放的大小
 *
 */
+ (UIImage *) scaleFromImage: (UIImage *) image toSize: (CGSize) size;

/**
 *  叠加图片
 *
 *  @param image1 图片1
 *  @param image2 图片2
 *  @param frame  所叠加的位置
 *
 */
+ (UIImage *)addImage:(UIImage *)image1 toImage:(UIImage *)image2 atPosition:(CGRect)frame;

/**
 *  返回中文月份
 *
 *
 */
+ (NSString *)getMonthStr:(NSInteger)month;


/**
 *  按照市区转换时间
 *
 *  @param timeInterval 时间戳
 *
 */
+ (NSDate*)zoneChange:(NSTimeInterval)timeInterval;


/**持续时间
 获取两个时间的间隔
 */
+ (long long)getDurationStartTime:(NSString *)startTime endTime:(NSString *)endTime;


/**
 *  检测一个字符串是否是空
 *
 *
 */
+ (BOOL)isEmptyOrNull:(NSString*) string;

/**
 *  去掉字符串前后空格
 *
 *  @param str 字符串
 *
 */
+ (NSString *)trimString:(NSString *) str;


/**
 *  无空格和换行的字符串
 */
+ (NSString *)noWhiteSpaceString:(NSString *) str;

/**
 *  计算缓存大小
 *
 *
 */
+(NSString *) caculateCacheSize;

/**
 *  清除缓存大小
 *
 *
 */
+(BOOL)cleanCache;


/**
 *  简单获取文字高度
 *
 *  @param str  文字
 *  @param font 字体
 *  @param size 大小
 *
 */
+ (CGSize)getStringSize:(NSString*)str font:(UIFont*)font size:(CGSize)size;

/**
 *  根据文字获取高度
 *
 *  @param str           文字
 *  @param font          字体
 *  @param lineBreakMode 对齐方式
 *  @param lineSpacing   行间距
 *  @param size          所在画布大小
 *
 */
+ (CGSize)getStringSize:(NSString*)str font:(UIFont*)font lineBreakMode:(NSLineBreakMode)lineBreakMode lineSpacing:(CGFloat)lineSpacing size:(CGSize)size;

/**
 *  获取屏幕尺寸
 *
 */
+ (CGSize)getScreenSize;


/**
 *  把字符串数组转成字符串
 *
 *
 */
+ (NSString*)parseArrayToStr:(NSArray*)array;

/**
 *  根据颜色转成图片
 *
 *  @param color 颜色
 *
 */
+ (UIImage*)createImageWithColor:(UIColor*) color;

/**
 *  把数字解析成亿万千的形式
 *
 *  @param str 需要转换的字符串
 *  @param dot 是否需要小数点
 *
 */
+ (NSString*)parseStringToValue:(NSString*)str needDot:(BOOL)dot;


/**
 *  判断是否含有中文
 *
 *  @param str 需要判断的字符串
 *
 */
+ (BOOL)IsChinese:(NSString *)str;

/**
 *  根据当前view获取当前view最上层的vc
 *
 *  @param currentView 当前view
 *
 */
+ (UIViewController*)getVCFromView:(UIView*)currentView;

/**
 *  获取当前设备的UUID
 *
 */
+ (NSString *)createUUID;


/**
 *  获取设备IDFV
 *
 */
+ (NSString*)createIDFV;

/**
 *  把dic， array转换成hash，来做cell height的唯一判断
 *
 *  @param obj 需要转换的对象
 *
 */
+ (NSString*)getObjectHash:(id)obj;

/**
 *  检测是否需要显示帮助界面
 *
 *  @param helpType 类型
 *
 */
+ (BOOL)checkHelpVerson:(NSString*)helpType;

/**
 *  设置view下所有子lebel的字体
 *
 *  @param v    对应的view
 *  @param font 设置的字体
 */
+ (void)setAllLabelFont:(UIView*)v withFont:(UIFont*)font;

/**
 *  把id类型转换成字符串
 *
 *
 */
+ (NSString*)getStringFromDicItem:(id)obj;


/**
 *  获取显示的用户名，如果没有昵称，手机号中间替换成**** 150****0345
 *
 *  @param userName 用户名（手机号）
 *  @param nickName 昵称
 *
 */
+ (NSString*)parseUserName:(NSString*)userName nickname:(NSString*)nickName;

/**
 *  检测目前系统是否是测试系统
 *
 */
+ (BOOL)isTesting;







//进制转换************************************************


+(NSString*)dataToHexString:(NSData*)data;// 十六进制转换成字符串
+(NSData*)convert:(NSString*)str;//字符串转换十六进制   比如 FF ->0XFF
+(int)intForData:(NSData *)data;//十六进制转换十进制  比如 0x37 -> 55

//日期格式转字符串
+(NSString *)dateToString:(NSDate *)date withDateFormat:(NSString *)format;

//字符串转日期格式
+ (NSDate *)stringToDate:(NSString *)dateString withDateFormat:(NSString *)format;


//获取当前语言 是否是中文
+(BOOL)currentLanguageChinese;

//获取当前语言 是否是英文
+(BOOL)currentLanguageEnglish;


//判断APP是否在前台
+(BOOL)runningInForeground;


// 跳转到设置界面
+(void)gotoSetterHandle;

//颜色渐变
+ (CAGradientLayer *)gradientLayerFrame:(CGRect)frme color1:(UIColor *)color1 color2:(UIColor *)color2 isHorizontal:(BOOL) isHorizontal;


/** 判断一个字符串是纯数字 */
+ (BOOL)isPureNum:(NSString *)text;

//根据日期获取星期几
+ (NSString*)getWeekDay:(NSString*)currentStr;

//取出数组里面最大的数 最大的数换成接近的整数 6909 --> 6000  79 --> 70
+ (int)maxArray:(NSArray *)array;

//6.9999 == 6.99   6.9 == 6.90  
+ (NSString *)stringFloatPointToTwoString:(NSString *)stringNum;

//日期数组排序
+ (NSMutableArray *)arraySorting:(NSMutableArray *)array orderedIndex:(NSInteger)index;

//根据座位类型返回实际图片
+ (UIImage *)getSeatImageWithState:(KyoCinameSeatStateType)state;

//View转Image 就可以把Image保存在相册里面了
+(UIImage*)convertViewToImage:(UIView*)v;
//时间戳变为格式时间
+ (NSString *)timeStampToTime:(NSString *)timeStr;
+(NSString *)filterHTML:(NSString *)html;


//更改footer title
+(void)updateFooterTitle:(MJRefreshFooter *)tableViewfooter;
+ (NSData *)convertHexStrToData:(NSString *)str;


+(UIImage *)createQrCodeSize:(CGSize)size dataString:(NSString *)dataString;

@end
