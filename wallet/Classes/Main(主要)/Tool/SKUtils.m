//
//  SKUtils.m
//  Business
//
//  Created by talking　 on 2018/8/13.
//  Copyright © 2018年 talking　. All rights reserved.
//

#import "SKUtils.h"
#include <sys/socket.h>
// Per msqr
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
#import <zlib.h>
#import "sys/utsname.h"
#import "SDImageCache.h"


#import "MJRefresh.h"
#import "SKTalkingRefreshAutoNormalFooter.h"

@implementation SKUtils


/** 开始下拉刷新*/
+ (void)beginPullRefreshForScrollView:(UIScrollView *)scrollView {
    [scrollView.mj_header beginRefreshing];
}

/**判断头部是否在刷新*/
+ (BOOL)headerIsRefreshForScrollView:(UIScrollView *)scrollView {
    
    BOOL flag =  scrollView.mj_header.isRefreshing;
    return flag;
}

/**判断是否尾部在刷新*/
+ (BOOL)footerIsLoadingForScrollView:(UIScrollView *)scrollView {
    return  scrollView.mj_footer.isRefreshing;
}

/**提示没有更多数据的情况*/
+ (void)noticeNoMoreDataForScrollView:(UIScrollView *)scrollView {
    [scrollView.mj_footer endRefreshingWithNoMoreData];
}

/**重置footer*/
+ (void)resetNoMoreDataForScrollView:(UIScrollView *)scrollView {
    [scrollView.mj_footer resetNoMoreData];
}

/**停止下拉刷新*/
+ (void)endRefreshForScrollView:(UIScrollView *)scrollView {
    [scrollView.mj_header endRefreshing];
}

/**停止上拉加载*/
+ (void)endLoadMoreForScrollView:(UIScrollView *)scrollView {
    [scrollView.mj_footer endRefreshing];
}

/** 隐藏footer*/
+ (void)hiddenFooterForScrollView:(UIScrollView *)scrollView {
    // 不确定是哪个类型的footer
    scrollView.mj_footer.hidden = YES;
}

/**隐藏header*/
+ (void)hiddenHeaderForScrollView:(UIScrollView *)scrollView {
    scrollView.mj_header.hidden = YES;
}

/**上拉*/
+ (void)addLoadMoreForScrollView:(UIScrollView *)scrollView
                loadMoreCallBack:(XRRefreshAndLoadMoreHandle)loadMoreCallBackBlock {
    
    if (scrollView == nil || loadMoreCallBackBlock == nil) {
        return ;
    }
    SKTalkingRefreshAutoNormalFooter *footer = [SKTalkingRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        if (loadMoreCallBackBlock) {
            loadMoreCallBackBlock();
        }
    }];
    //    [footer setTitle:NSLocalizedString(@"hl_show_fresh_reached_bottom", nil) forState:MJRefreshStateIdle];
    [footer setTitle:@"" forState:MJRefreshStateIdle];
    
    [footer setTitle:@"loading data..." forState:MJRefreshStateRefreshing];
    //这个不能用
//    [footer setTitle:@"没有更多了~" forState:MJRefreshStateNoMoreData];
    footer.stateLabel.textColor = SKColor(90, 90, 90, 1.0);

    footer.stateLabel.font = SKFont(13.0);
    //    footer.automaticallyHidden = YES;
    scrollView.mj_footer = footer;
    footer.backgroundColor = SKClearColor;
    
    
}

//更改footer title
+(void)updateFooterTitle:(MJRefreshFooter *)tableViewfooter{
    SKTalkingRefreshAutoNormalFooter *footer = (SKTalkingRefreshAutoNormalFooter *)tableViewfooter;
    [footer setTitle:@"no data" forState:MJRefreshStateIdle];
}

/**下拉*/
+ (void)addPullRefreshForScrollView:(UIScrollView *)scrollView
                pullRefreshCallBack:(XRRefreshAndLoadMoreHandle)pullRefreshCallBackBlock {
    __weak typeof(UIScrollView *)weakScrollView = scrollView;
    if (scrollView == nil || pullRefreshCallBackBlock == nil) {
        return ;
    }
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (pullRefreshCallBackBlock) {
            pullRefreshCallBackBlock();
        }
        if (weakScrollView.mj_footer.hidden == NO) {
            [weakScrollView.mj_footer resetNoMoreData];
        }
        
    }];
    
    [header setTitle:@"Release refresh" forState:MJRefreshStatePulling];
    [header setTitle:@"Updating" forState:MJRefreshStateRefreshing];
    [header setTitle:@"Pull down to refresh" forState:MJRefreshStateIdle];
    header.stateLabel.font = [UIFont systemFontOfSize:13];
    header.stateLabel.textColor = SKCommonBlackColor;
    header.lastUpdatedTimeLabel.hidden = YES;
    
    scrollView.mj_header = header;
}




//特殊字符正则
#define REGEX_SPECIALCHARACTER                  @"[`~!@#$^&*()=|{}':;'\\\\,\\[\\].<>/?~！@#￥……&*（）——|{}【】‘；;”“'。，、？%]"
#define kAlphaNum           @"0123456789"
#define _IM_FormatStr(fmt, ...) [NSString stringWithFormat:fmt, ##__VA_ARGS__]
#define kUploadImageHeight 300



//转换成有效的字符串  在判断的时候用到   就是没有也要赋值为“” 避免为nil导致崩溃
+ (NSString *)validString:(NSString *)string {
    
    if ([self isBlankString:string]) {
        return  SKEmptyStr;
    } else {
        return string;
    }
}
/**
 *  判断字符串是否为空
 */
+ (BOOL)isBlankString:(NSString *)string {
    
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([string isKindOfClass:[NSDictionary class]]) {
        return YES;
    }
    if ([string isKindOfClass:[NSString class]] == NO) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0) {
        return YES;
    }
    if ([string isEqualToString:@""]) {
        return YES;
    }
    return NO;
}

/** color生成image*/
+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}








// 公共富文本
+ (NSAttributedString *)attStringWithString:(NSString *)string keyWord:(NSString *)keyWord {
    return [self attStringWithString:string keyWord:keyWord font:SKFont(16) highlightedColor:SKCommonHighLightRedColor textColor:SKCommonBlackColor];
}

+ (NSAttributedString *)attStringWithString:(NSString *)string
                                    keyWord:(NSString *)keyWord
                                       font:(UIFont *)font
                           highlightedColor:(UIColor *)highlightedcolor
                                  textColor:(UIColor *)textColor {
    return [self attStringWithString:string keyWord:keyWord font:font highlightedColor:highlightedcolor textColor:textColor lineSpace:2.0];
}

+ (NSAttributedString *)attStringWithString:(NSString *)string
                                    keyWord:(NSString *)keyWord
                                       font:(UIFont *)font
                           highlightedColor:(UIColor *)highlightedcolor
                                  textColor:(UIColor *)textColor
                                  lineSpace:(CGFloat)lineSpace {
    if (string.length) {
        
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:string];
        if (!keyWord || keyWord.length == 0) {
            NSRange allRange = NSMakeRange(0, string.length);
            [attStr addAttribute:NSFontAttributeName value:font range:allRange];
            [attStr addAttribute:NSForegroundColorAttributeName value:textColor range:allRange];
            
            NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
            style.lineSpacing = lineSpace;
            [attStr addAttribute:NSParagraphStyleAttributeName value:style range:allRange];
            return attStr;
        }
        NSRange range = [string rangeOfString:keyWord options:NSCaseInsensitiveSearch];
        // 找到了关键字
        if (range.location != NSNotFound) {
            NSRange allRange = NSMakeRange(0, string.length);
            [attStr addAttribute:NSFontAttributeName value:font range:allRange];
            [attStr addAttribute:NSForegroundColorAttributeName value:textColor range:allRange];
            [attStr addAttribute:NSForegroundColorAttributeName value:highlightedcolor range:range];
            
            NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
            style.lineSpacing = lineSpace;
            [attStr addAttribute:NSParagraphStyleAttributeName value:style range:allRange];
        } else {
            NSRange allRange = NSMakeRange(0, string.length);
            [attStr addAttribute:NSFontAttributeName value:font range:allRange];
            [attStr addAttribute:NSForegroundColorAttributeName value:textColor range:allRange];
            
            NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
            style.lineSpacing = lineSpace;
            [attStr addAttribute:NSParagraphStyleAttributeName value:style range:allRange];
            return attStr;
        }
        return attStr.copy;
    }
    return [[NSAttributedString alloc] init];
}



// 时间戳转时间
+ (NSString *)datestrFromDate:(NSDate *)date
               withDateFormat:(NSString *)format {
    
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:format];
    return [dateFormat stringFromDate:date];
}

//传入1，返回明天的时间
+ (NSDate *)GetTomorrowDay:(int)n {
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components:NSCalendarUnitWeekday | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:[NSDate date]];
    [components setDay:([components day]+n)];
    
    NSDate *beginningOfWeek = [gregorian dateFromComponents:components];
//    NSDateFormatter *dateday = [[NSDateFormatter alloc] init];
//    [dateday setDateFormat:@"yyyy-MM-dd"];
//    return [dateday stringFromDate:beginningOfWeek];
    return beginningOfWeek;
}


//+ (NSData *)getWitchDay:(int)n {
//
//    NSDate *datenow = [NSDate date];
//
//    return datenow;
//}

// 几天前 几分钟前..
+ (NSString *)updateTimeForTimeInterval:(NSInteger)timeInterval {
    
    // 获取当前时时间戳 1466386762.345715 十位整数 6位小数
    NSTimeInterval currentTime = [[NSDate date] timeIntervalSince1970];
    // 创建歌曲时间戳(后台返回的时间 一般是13位数字)
    NSTimeInterval createTime = timeInterval;
    // 时间差
    NSTimeInterval time = currentTime - createTime;
    if (time < 60) {
        return @"刚刚";
    }
    NSInteger minutes = time / 60;
    if (minutes < 60) {
        
        return [NSString stringWithFormat:@"%ld minute before", minutes];
    }
    // 秒转小时
    NSInteger hours = time / 3600;
    if (hours < 24) {
        return [NSString stringWithFormat:@"%ld hour before",hours];
    }
    // 秒转天数
    NSInteger days = time / 3600 / 24;
    if (days < 30) {
        return [NSString stringWithFormat:@"%ld day before",days];
    }
    // 秒转月
    NSInteger months = time / 3600 / 24 / 30;
    if (months < 12) {
        return [NSString stringWithFormat:@"%ld Month ago",months];
    }
    // 秒转年
    NSInteger years = time / 3600 / 24 / 30 / 12;
    return [NSString stringWithFormat:@"%ld year ago",years];
}


/**持续时间
 获取两个时间的间隔
 */
+ (long long)getDurationStartTime:(NSString *)startTime endTime:(NSString *)endTime {
    if (startTime && endTime) {
        NSDateFormatter *strDateStr = [[NSDateFormatter alloc]init];
        [strDateStr setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *startdate = [strDateStr dateFromString:startTime];
        NSDate *enddate = [strDateStr dateFromString:endTime];
        //时间转时间戳的方法:
        NSTimeInterval aTime = [enddate timeIntervalSinceDate:startdate];
        return (long long)aTime;
    } else {
        return -1;
    }
}









#pragma mark - 正则

/**
 *  手机号码验
 *
 *
 */
+ (BOOL)isValidateMobile:(NSString *)mobile
{
    NSString *phoneRegex = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|70)\\d{8}$";//@"^1\\d{10}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}


/**
 *  邮箱地址是否合法
 */
-(BOOL)isEmailWithString:(NSString *)str{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:str];
}


/**
 *  身份证上的姓名
 *
 *
 */
+ (BOOL)isValidateCHNameChar:(NSString *)realname
{
    NSString *regexStr = @"^[\u4e00-\u9fa5]{1,}[·|.|•|•|•]?[\u4e00-\u9fa5]{1,}$";//@"^[\u4e00-\u9fa5]{2,24}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regexStr];
    return [predicate evaluateWithObject:realname];
}

/**
 *  纯数字
 *
 *
 */
+ (BOOL)isTypeNumber:(NSString *)num
{
    NSString *regexStr = @"^\\d+$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regexStr];
    return [predicate evaluateWithObject:num];
}



/**
 *  是否是否仅包含英文、中文、数字
 *
 *
 */
+ (BOOL)isContainNonEnglishAndChineseCharacter:(NSString*)str
{
    NSString *regTags = @"^[0-9a-zA-Z\u4e00-\u9fa5]+$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regTags];
    return ![predicate evaluateWithObject:str];
}

/**
 *  字母、数字或下划线
 *
 *
 */
+ (BOOL)isContainNonEnglishAndUnderscores:(NSString*)str
{
    NSString *regTags = @"^[0-9a-zA-Z_]+$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regTags];
    return ![predicate evaluateWithObject:str];
}

/**
 *  字母、数字或下划线中文
 *
 *
 */
+ (BOOL)isContainNonEnglishAndUnderscoresAndChinese:(NSString*)str
{
    NSString *regTags = @"^[0-9a-zA-Z\u4e00-\u9fa5_]+$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regTags];
    return ![predicate evaluateWithObject:str];
}

/**
 *  检测字符串是否只包含空格和换行
 *
 *
 */
+ (BOOL)isWhitespaceCharacterSet:(NSString *)str
{
    NSString *character  = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return [character length] == 0 ;
}
/**
 *  从文件解析json
 *
 *
 */
+ (NSDictionary *)connvertJSONFileToDict:(NSString *)fileName
{
    NSString *Json_path = [[NSBundle mainBundle]  pathForResource:fileName ofType:@"json"];
    NSData *data= [NSData dataWithContentsOfFile:Json_path];
    NSError *error;
    NSDictionary *JsonObject = [NSJSONSerialization JSONObjectWithData:data
                                                               options:NSJSONReadingAllowFragments
                                                                 error:&error];
    return JsonObject;
}
/**
 *  json解析
 *
 *
 */
+ (NSDictionary *)convertJSONToDict:(NSString *)string
{
    NSError *error = nil;
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    if (!data || data == nil) {
        return nil;
    }
    NSDictionary *respDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
    if (nil == error){
        return respDict;
    }else{
        return nil;
    }
}
+ (NSArray *)convertJSONToArr:(NSString *)string
{
    NSError *error = nil;
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    if (!data || data == nil) {
        return nil;
    }
   NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    if (nil == error){
        return array;
    }else{
        return nil;
    }
}

/**
 *  转json
 *
 
 */
+ (NSString *)convertObjectToJSON:(id)object
{
    NSError *error = nil;
    NSData  *data = nil;
    if (object) {
        data = [NSJSONSerialization dataWithJSONObject:object options:NSJSONWritingPrettyPrinted error:&error];
    }
    
    if (data == nil) {
        return nil;
    }
    
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}


//json格式字符串转字典：

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    
    if (jsonString == nil) {
        
        return nil;
        
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *err;
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                         
                                                        options:NSJSONReadingMutableContainers
                         
                                                          error:&err];
    
    if(err) {
        
        NSLog(@"json解析失败：%@",err);
        
        return nil;
        
    }
    
    return dic;
    
}


/**
 *  根据字符串返回颜色
 *
 *   hexColor 888888 六位颜色值
 *
 */
+ (UIColor *)getColor:(NSString *)hexColor
{
    unsigned int redInt_, greenInt_, blueInt_;
    NSRange rangeNSRange_;
    rangeNSRange_.length = 2;  // 范围长度为2
    
    // 取红色的值
    rangeNSRange_.location = 0;
    [[NSScanner scannerWithString:[hexColor substringWithRange:rangeNSRange_]] scanHexInt:&redInt_];
    
    // 取绿色的值
    rangeNSRange_.location = 2;
    [[NSScanner scannerWithString:[hexColor substringWithRange:rangeNSRange_]] scanHexInt:&greenInt_];
    
    // 取蓝色的值
    rangeNSRange_.location = 4;
    [[NSScanner scannerWithString:[hexColor substringWithRange:rangeNSRange_]] scanHexInt:&blueInt_];
    
    return [UIColor colorWithRed:(float)(redInt_/255.0f) green:(float)(greenInt_/255.0f) blue:(float)(blueInt_/255.0f) alpha:1.0f];
}

/**
 *  获取上传的正方形图片
 *
 *   image 原始图片
 *
 */
+ (UIImage *)getUploadImage:(UIImage *)image
{
    CGFloat fw = image.size.width;
    CGFloat fh = image.size.height;
    CGFloat wh = (fw>fh?fh:fw);
    CGFloat fx = 0,fy = 0;
    if(fw>fh){
        fy = 0;
        fx = -(fw-fh)*0.5;
    }
    else{
        fx = 0;
        fy = -(fh - fw)*0.5;
    }
    
    UIGraphicsBeginImageContext(CGSizeMake(wh, wh));
    [image drawInRect:CGRectMake(fx, fy, fw, fh)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    if(wh>kUploadImageHeight){
        scaledImage = [[self class] scaleFromImage:scaledImage toSize:CGSizeMake(kUploadImageHeight, kUploadImageHeight)];
    }
    return scaledImage;
}

/**
 *  缩放图片
 *
 *   image 原始图片
 *   size  需要缩放的大小
 *
 */
+ (UIImage *) scaleFromImage: (UIImage *) image toSize: (CGSize) size
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

/**
 *  叠加图片
 *
 *   image1 图片1
 *   image2 图片2
 *   frame  所叠加的位置
 *
 */
+ (UIImage *)addImage:(UIImage *)image1 toImage:(UIImage *)image2 atPosition:(CGRect)frame
{
    UIGraphicsBeginImageContext(image2.size);
    
    // Draw image1
    [image2 drawInRect:CGRectMake(0, 0, image2.size.width, image2.size.height)];
    
    // Draw image2
    [image1 drawInRect:frame];
    
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return resultingImage;
}

/**
 *  返回中文月份
 *
 *   month
 *
 */
+ (NSString *)getMonthStr:(NSInteger)month
{
    switch (month) {
        case 1:
            return @"一月";
            break;
        case 2:
            return @"二月";
            break;
        case 3:
            return @"三月";
            break;
        case 4:
            return @"四月";
            break;
        case 5:
            return @"五月";
            break;
        case 6:
            return @"六月";
            break;
        case 7:
            return @"七月";
            break;
        case 8:
            return @"八月";
            break;
        case 9:
            return @"九月";
            break;
        case 10:
            return @"十月";
            break;
        case 11:
            return @"十一月";
            break;
        case 12:
            return @"十二月";
            break;
        default:
            break;
    }
    return @"";
}



/**
 *  按照市区转换时间
 *
 *   timeInterval 时间戳
 *
 */
+ (NSDate*)zoneChange:(NSTimeInterval)timeInterval{
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSTimeZone *zone = [NSTimeZone timeZoneWithName:@"GMT"];
    NSInteger interval = [zone secondsFromGMTForDate:confromTimesp];
    NSDate *localeDate = [confromTimesp  dateByAddingTimeInterval: interval];
    
    return localeDate;
}


/**
 *  检测一个字符串是否是空
 *
 *   string
 *
 */
+ (BOOL)isEmptyOrNull:(NSString*) string
{
    if([string isKindOfClass:[NSNull class]])
        return NO;
    if ([string isKindOfClass:[NSNumber class]])
    {
        if (string != nil)
        {
            return  YES;
        }
        return NO;
    } else
    {
        string=[[self class] trimString:string];
        if (string != nil && string.length > 0 && ![string isEqualToString:@"null"]&&![string isEqualToString:@"(null)"]&&![string isEqualToString:@" "])
        {
            return  YES;
        }
        return NO;
    }
}

/**
 *  去掉字符串前后空格
 *
 *   str 字符串
 *
 */
+ (NSString *)trimString:(NSString *) str {
    return [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}


+ (NSString *)noWhiteSpaceString:(NSString *)str {
    NSString *newString = str;
    //    newString = [newString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
    newString = [newString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    newString = [newString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    newString = [newString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符使用
    newString = [newString stringByReplacingOccurrencesOfString:@" " withString:@""];
    //    可以去掉空格，注意此时生成的strUrl是autorelease属性的，所以不必对strUrl进行release操作！
    //    newString = [newString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return newString;
}


/**
 *  计算缓存大小
 *
 *   folders 路径
 *
 */
+(NSString *) caculateCacheSize
{
    float imageCacheSize = [[SDImageCache sharedImageCache] getSize] / 1024 /1024;
    
    NSString *clearCacheSizeStr = imageCacheSize >= 1 ? [NSString stringWithFormat:@"%.2fM",imageCacheSize] : [NSString stringWithFormat:@"%.2fK",imageCacheSize * 1024];
    
    
    return clearCacheSizeStr;
}

/**
 *  清除缓存大小
 *
 *   folders 对应的路径
 *
 */
+(BOOL)cleanCache
{
    [[SDImageCache sharedImageCache] clearMemory];
    
    //其他缓冲清空
    
    return YES;
}


/**
 *  简单获取文字高度
 *
 *   str  文字
 *   font 字体
 *   size 大小
 *
 */
+ (CGSize)getStringSize:(NSString*)str font:(UIFont*)font size:(CGSize)size{
    if([str isKindOfClass:[NSNull class]]){
        str = @"";
    }
    CGRect textFrame = CGRectZero;
    NSDictionary *attributes = @{NSFontAttributeName:font};
    textFrame = [str boundingRectWithSize:size
                                  options:NSStringDrawingUsesLineFragmentOrigin
                               attributes:attributes
                                  context:nil];
    return textFrame.size;
}

/**
 *  根据文字获取高度
 *
 *   str           文字
 *   font          字体
 *   lineBreakMode 对齐方式
 *   lineSpacing   行间距
 *   size          所在画布大小
 *
 */
+ (CGSize)getStringSize:(NSString*)str font:(UIFont*)font lineBreakMode:(NSLineBreakMode)lineBreakMode lineSpacing:(CGFloat)lineSpacing size:(CGSize)size{
    if([str isKindOfClass:[NSNull class]]){
        str = @"";
    }
    CGRect textFrame = CGRectZero;
    NSMutableParagraphStyle *ps = [[NSMutableParagraphStyle alloc] init];
    [ps setLineBreakMode:lineBreakMode];
    if(lineSpacing>0){
        [ps setLineSpacing:lineSpacing];
    }
    
    NSDictionary *attributes = @{NSFontAttributeName:font,NSParagraphStyleAttributeName:ps};
    textFrame = [str boundingRectWithSize:size
                                  options:NSStringDrawingUsesLineFragmentOrigin
                               attributes:attributes
                                  context:nil];
    return textFrame.size;
}

/**
 *  获取屏幕尺寸
 *
 */
+ (CGSize)getScreenSize{
    return [UIScreen mainScreen].bounds.size;
}

/**
 *  把字符串数组转成字符串
 *
 *   array
 *
 */
+ (NSString*)parseArrayToStr:(NSArray*)array{
    if(![array isKindOfClass:[NSArray class]] || array.count == 0)return @"";
    NSMutableString* mustr = [NSMutableString stringWithString:@""];
    if(array.count>0){
        [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSString* str = (NSString*)obj;
            str = [str capitalizedString];
            [mustr appendString:str];
            [mustr appendString:@" "];
        }];
    }
    if(mustr.length>1) return [mustr.copy substringToIndex:mustr.length-1];
    return mustr.copy;
}

/**
 *  根据颜色转成图片
 *
 *   color 颜色
 *
 */
+ (UIImage*)createImageWithColor:(UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

/**
 *  把数字解析成亿万千的形式
 *
 *   str 需要转换的字符串
 *   dot 是否需要小数点
 *
 */
+ (NSString*)parseStringToValue:(NSString*)str needDot:(BOOL)dot
{
    NSString* lastChat = @"";
    NSString* subStr = str;
    if(str.length>0){
        lastChat = [str substringFromIndex:str.length-1];
        if(![lastChat isEqualToString:@"0"] && lastChat.integerValue == 0){
            subStr = [str substringToIndex:str.length-1];
        }
        else{
            lastChat = @"";
        }
    }
    subStr = [subStr stringByReplacingOccurrencesOfString:@"," withString:@""];
    double d = subStr.doubleValue;
    if(d>100000000){
        double tmp = d/100000000.0;
        if(dot)
            return [NSString stringWithFormat:@"%.2f亿%@",tmp,lastChat];
        else{
            return [NSString stringWithFormat:@"%.0f亿%@",tmp,lastChat];
        }
    }
    if(d>10000){
        double tmp = d/10000.0;
        if(dot){
            return [NSString stringWithFormat:@"%.2f万%@",tmp,lastChat];
        }
        else{
            return [NSString stringWithFormat:@"%.0f万%@",tmp,lastChat];
        }
    }
    return str;
}


/**
 *  判断是否含有中文
 *
 *   str 需要判断的字符串
 *
 */
+ (BOOL)IsChinese:(NSString *)str {
    for(int i=0; i< [str length];i++){
        int a = [str characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff)
        {
            return YES;
        }
        
    }
    return NO;
}

/**
 *  根据当前view获取当前view最上层的vc
 *
 *  currentView 当前view
 *
 */
+ (UIViewController*)getVCFromView:(UIView*)currentView{
    for (UIView* next = [currentView superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

/**
 *  获取当前设备的UUID
 *
 */
+ (NSString *)createUUID
{
    CFUUIDRef uuidObject = CFUUIDCreate(kCFAllocatorDefault);
    
    NSString *uuidStr = (NSString *)CFBridgingRelease(CFUUIDCreateString(kCFAllocatorDefault, uuidObject));
    
    CFRelease(uuidObject);
    
    return uuidStr;
}

/**
 *  获取设备IDFV
 *
 */
+ (NSString*)createIDFV{
    NSString *idfv = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    return idfv;
}

/**
 *  把dic， array转换成hash，来做cell height的唯一判断
 *
 *   obj 需要转换的对象
 *
 */
+ (NSString*)getObjectHash:(id)obj{
    if([obj isKindOfClass:[NSObject class]]){
        NSObject* _obj = (NSObject*)obj;
        NSString* hashKey = [NSString stringWithFormat:@"%lu",(unsigned long)_obj.description.hash];
        return hashKey;
    }
    return [self createUUID];
}

/**
 *  检测是否需要显示帮助界面
 *
 *   helpType 类型
 *
 */
+ (BOOL)checkHelpVerson:(NSString*)helpType{
    //每次需要修改help界面的时候修改下面的版本号，就回显示，防止每次更新版本都显示
    NSString* currentVersion = @"2.0";
    NSString* key = helpType;
    NSString* showHelpVersion = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    if(!showHelpVersion){
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
        return YES;
    }
    else{
        if([showHelpVersion isEqualToString:currentVersion]){
            return NO;
        }
        else{
            [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    }
    return YES;
}

/**
 *  设置view下所有子lebel的字体
 *
 *  v    对应的view
 *   font 设置的字体
 */
+ (void)setAllLabelFont:(UIView*)v withFont:(UIFont*)font{
    NSArray* subViews = v.subviews;
    [subViews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if([obj isKindOfClass:[UILabel class]]){
            UILabel* lab = (UILabel*)obj;
            lab.font = font;
        }
        else if([obj isKindOfClass:[UIView class]])
        {
            UIView* tmpV = (UIView*)obj;
            [self setAllLabelFont:tmpV withFont:font];
        }
    }];
}

/**
 *  把id类型转换成字符串
 *
 *
 */
+ (NSString*)getStringFromDicItem:(id)obj//从字典取字符串
{
    if(!obj || [obj isKindOfClass:[NSNull class]]){
        return @"";
    }
    if([obj isKindOfClass:[NSDictionary class]]||[obj isKindOfClass:[NSArray class]]){return @"";}
    if([obj isKindOfClass:[NSString class]])return obj;
    if([obj isKindOfClass:[NSNumber class]])return [NSString stringWithFormat:@"%@",obj];
    return [NSString stringWithFormat:@"%@",obj];
}


/**
 *  获取显示的用户名，如果没有昵称，手机号中间替换成**** 150****0345
 *
 *   userName 用户名（手机号）
 *   nickName 昵称
 *
 */
+ (NSString*)parseUserName:(NSString*)userName nickname:(NSString*)nickName{
    if(PUGetString(nickName).length>0)return PUGetString(nickName);
    if(userName.length<11)return userName;
    return [NSString stringWithFormat:@"%@****%@",[userName substringToIndex:3],[userName substringFromIndex:7]];
}

/**
 *  检测目前系统是否是测试系统
 *
 */
+ (BOOL)isTesting{
    NSDictionary* bundleInfo = [[NSBundle mainBundle] infoDictionary];
    NSString* BundleIdentifier = PUGetString(bundleInfo[@"CFBundleIdentifier"]);
    if([BundleIdentifier isEqualToString:@"com.magikare.MagikareDoctor"]){
        return NO;
    }
    return YES;
}


/**
 *  解析英文用户名
 *
 *   firstName        firstName
 *   lastName         lastName
 *   userName         返回的用户名
 *
 */
+ (NSString*)parsePersonName:(NSString*)firstName lastName:(NSString*)lastName userName:(NSString*)userName{
    if(firstName && lastName){
        NSString* firstChar = [firstName substringToIndex:1];
        return [NSString stringWithFormat:@"%@.%@",firstChar.uppercaseString,lastName.capitalizedString];
    }
    if(userName){
        NSArray* tmp = [userName componentsSeparatedByString:@"|"];
        if(tmp.count>0){
            for(NSInteger i=0;i<tmp.count;i++){//判断是否有中文，有则直接返回
                NSString* strUserName = (NSString*)tmp[i];
                if([self IsChinese:strUserName]){
                    return strUserName;
                }
            }
            NSString* tmpUserName = tmp.firstObject;
            NSArray* tmpFirstName = [tmpUserName componentsSeparatedByString:@" "];//拆分组合firstname，lastname
            if(tmpFirstName.count>1){
                NSMutableString* mustr = [NSMutableString stringWithString:@""];
                NSString* tmpFirst = tmpFirstName.firstObject;
                NSString* firstChar = [tmpFirst substringToIndex:1];
                [mustr appendString:firstChar.uppercaseString];
                [mustr appendString:@"."];
                for(NSInteger i=1;i<tmpFirstName.count;i++){
                    NSString* strName = tmpFirstName[i];
                    [mustr appendString:strName.capitalizedString];
                }
                return mustr.copy;
            }
            else{
                return userName.capitalizedString;
            }
        }
    }
    
    return @"";
}













#define C2I(c) ((c >= '0' && c<='9') ? (c-'0') : ((c >= 'a' && c <= 'z') ? (c - 'a' + 10): ((c >= 'A' && c <= 'Z')?(c - 'A' + 10):(-1))))



//进制转换************************************************

// 十六进制转换成字符串 0x55->55
+(NSString*)dataToHexString:(NSData*)data {
    if (data == nil) {
        return @"";
    }
    Byte *dateByte = (Byte *)[data bytes];
    
    NSString *hexStr=@"";
    for(int i=0;i<[data length];i++) {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",dateByte[i]&0xff]; ///16进制数
        if([newHexStr length]==1)
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        else
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
    }
    return hexStr;
}

//字符串转换十六进制   比如 FF ->0XFF
+ (NSData*)convert:(NSString*)str{
    const char* cs = str.UTF8String;
    int count = (int)strlen(cs);
    int8_t  bytes[count / 2];
    for(int i = 0; i<count; i+=2){
        char c1 = *(cs + i);
        char c2 = *(cs + i + 1);
        if(C2I(c1) >= 0 && C2I(c2) >= 0){
            bytes[i / 2] = C2I(c1) * 16 + C2I(c2);
            
        }else{
            return nil;
        }
    }
    return [NSData dataWithBytes:bytes length:count /2];
}

//十六进制转换十进制  比如 0x37 -> 55
+(int)intForData:(NSData *)data{
    uint8_t* a = (uint8_t*) [data bytes];
    NSString *str=[NSString stringWithFormat:@"%d",*a];
    return [str intValue];
}



//日期格式转字符串
+(NSString *)dateToString:(NSDate *)date withDateFormat:(NSString *)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    NSString *strDate = [dateFormatter stringFromDate:date];
    return strDate;
}

//字符串转日期格式
+ (NSDate *)stringToDate:(NSString *)dateString withDateFormat:(NSString *)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    
    NSDate *date = [dateFormatter dateFromString:dateString];
    
    return [self worldTimeToChinaTime:date];
    
}

//将世界时间转化为中国区时间
+ (NSDate *)worldTimeToChinaTime:(NSDate *)date
{
    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
    NSInteger interval = [timeZone secondsFromGMTForDate:date];
    NSDate *localeDate = [date  dateByAddingTimeInterval:interval];
    return localeDate;
}







//获取当前语言 是否是中文
+(BOOL)currentLanguageChinese
{
    if([[self currentLanguage] hasPrefix:@"zh"]){
        return YES;
    }
    
    return NO;
}

//获取当前语言 是否是英文
+(BOOL)currentLanguageEnglish
{
    if([[self currentLanguage] hasPrefix:@"en"]){
        return YES;
    }
    
    return NO;
}

+(NSString*)currentLanguage
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *languages = [defaults objectForKey:@"AppleLanguages"];
    NSString *currentLang = [languages objectAtIndex:0];
    return currentLang;
}



//判断APP是否在前台
+(BOOL)runningInForeground
{
    UIApplicationState state = [UIApplication sharedApplication].applicationState;
    BOOL result = (state == UIApplicationStateActive);
    
    return result;
}




// 跳转到设置界面
+(void)gotoSetterHandle {
    
}

//颜色渐变
+ (CAGradientLayer *)gradientLayerFrame:(CGRect)frme color1:(UIColor *)color1 color2:(UIColor *)color2 isHorizontal:(BOOL) isHorizontal{
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)color1.CGColor,
                             (__bridge id)color2.CGColor
                             ];
    gradientLayer.startPoint = CGPointMake(0, 0);
    
    if (isHorizontal) {
        gradientLayer.endPoint = CGPointMake(1, 0);
    }else {
        gradientLayer.endPoint = CGPointMake(0, 1);
    }
    gradientLayer.frame = frme;
    
    return gradientLayer;
}


/** 判断一个字符串是纯数字 */
+ (BOOL)isPureNum:(NSString *)text {
    if (!text) {
        return NO;
    }
    NSScanner *scan = [NSScanner scannerWithString:text];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

//根据日期获取星期几
+ (NSString*)getWeekDay:(NSString*)currentStr

{
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc]init];//实例化一个NSDateFormatter对象
    
    [dateFormat setDateFormat:@"yyyy-MM-dd"];//设定时间格式,要注意跟下面的dateString匹配，否则日起将无效
    
    NSDate*date =[dateFormat dateFromString:currentStr];
    
    NSArray*weekdays = [NSArray arrayWithObjects: [NSNull null],@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",nil];
    
    NSCalendar*calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSTimeZone*timeZone = [[NSTimeZone alloc]initWithName:@"Asia/Shanghai"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit =NSCalendarUnitWeekday;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:date];
    
    return [weekdays objectAtIndex:theComponents.weekday];
}

//取出数组里面最大的数 最大的数换成接近的整数 6909 --> 6000  79 --> 70
+ (int)maxArray:(NSArray *)array{
    
//    array = [array sortedArrayUsingSelector:@selector(compare:)];
    
    NSMutableArray * arr = array.mutableCopy;
    

    for (int i = 0; i < arr.count - 1; i++) {
        //比较的躺数
        for (int j = 0; j < array.count - 1 - i; j++) {
            //比较的次数
            if ([arr[j] intValue] > [arr[j + 1] intValue]) {
                //这里为升序排序
                
                int temp = [arr[j] intValue];
                arr[j] = arr[j + 1];
                //OC中的数组只能存储对象，所以这里转换成string对象
                arr[j + 1] = [NSString stringWithFormat:@"%d",temp];
            }
        }
    }
    
    
    
    int num = [[arr lastObject] floatValue];
    
    NSString *len = [NSString stringWithFormat:@"%d",num];
    int powNum = (int)pow(10, len.length - 1);
    int number = num - num%powNum + powNum;
    return number;
}

+ (NSString *)stringFloatPointToTwoString:(NSString *)stringNum {
    
    if ([stringNum rangeOfString:@"."].location != NSNotFound) {
        
        NSArray *array = [stringNum componentsSeparatedByString:@"."];
        if (array.count == 2) {
            NSString *st1 = array[0];
            NSString *st2 = array[1];
            if (st2.length >= 2) {
                
                return [NSString stringWithFormat:@"%@.%@",st1,[st2 substringToIndex:2]];
            }else if (st2.length == 1) {
                return [NSString stringWithFormat:@"%@.%@0",st1,[st2 substringToIndex:1]];
            }else {
                return [NSString stringWithFormat:@"%@.00",st1];
            }
        }
        
    }
    return stringNum;
}


//日期数组排序
+ (NSMutableArray *)arraySorting:(NSMutableArray *)array orderedIndex:(NSInteger)index {
    
    return (NSMutableArray *)[array sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];        [formatter setDateFormat:@"yyyy-MM-dd"];        if (obj1 == [NSNull null]) {            obj1 = @"0000-00-00";        }
        if (obj2 == [NSNull null]) {            obj2 = @"0000-00-00";        }
        NSDate *date1 = [formatter dateFromString:obj1];
        NSDate *date2 = [formatter dateFromString:obj2];        NSComparisonResult result = [date1 compare:date2];
        //倒叙和正序
        if (index == 1) { //当等于1的时候才走
            return result == NSOrderedAscending;
        }else {
            //这个是默认
            return result == NSOrderedDescending;
        }
    }];
}

//根据座位类型返回实际图片
+ (UIImage *)getSeatImageWithState:(KyoCinameSeatStateType)state {
    if (state == KyoCinameSeatStateTypeEmpty) {
        return [UIImage imageNamed:@"com_icon_seat_empty"];
    } else if (state == KyoCinameSeatStateTypeOffline) {
        return [UIImage imageNamed:@"com_icon_seat_offline"];
    } else if (state == KyoCinameSeatStateTypeOnline) {
        return [UIImage imageNamed:@"com_icon_seat_online"];
    }
    //极差
    else if (state == KyoCinameSeatStateTypeVeryPoor) {
        return [UIImage imageNamed:@"com_icon_seat_offline"];
    }
    //较差
    else if (state == KyoCinameSeatStateTypePoor) {
        return [UIImage imageNamed:@"com_icon_seat_poor"];
    }
    //中等
    else if (state == KyoCinameSeatStateTypeMedium) {
        return [UIImage imageNamed:@"com_icon_seat_medium"];
    }
    //良好
    else if (state == KyoCinameSeatStateTypeGeneral) {
        return [UIImage imageNamed:@"com_icon_seat_online"];
    }
    //优秀
    else if (state == KyoCinameSeatStateTypeGood) {
        return [UIImage imageNamed:@"com_icon_seat_good"];
    }
    //选中button
    else if (state == KyoCinameSeatStateTypeSelect) {
        return [UIImage imageNamed:@"com_icon_seat_selected"];
    }
    else {
        return [UIImage imageNamed:@"com_icon_seat_empty"];
    }
}


//View转Image 就可以把Image保存在相册里面了
+(UIImage*)convertViewToImage:(UIView*)v{
    CGSize s = v.bounds.size;
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了
    UIGraphicsBeginImageContextWithOptions(s, NO, [UIScreen mainScreen].scale);
    [v.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage*image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

//时间戳变为格式时间
+ (NSString *)timeStampToTime:(NSString *)timeStr {
    if (timeStr.length <= 0) {
        return @"";
    }
    //    如果服务器返回的是13位字符串，需要除以1000，否则显示不正确(13位其实代表的是毫秒，需要除以1000)
    long long time = [timeStr longLongValue] / 1000;
    NSDate *date = [[NSDate alloc]initWithTimeIntervalSince1970:time];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *timeString=[formatter stringFromDate:date];
    return timeString;
}
+(NSString *)filterHTML:(NSString *)html
{
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        //找到标签的起始位置
        [scanner scanUpToString:@"<" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        //替换字符
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    //    NSString * regEx = @"<([^>]*)>";
    //    html = [html stringByReplacingOccurrencesOfString:regEx withString:@""];
    return html;
}
+ (NSData *)convertHexStrToData:(NSString *)str {
    if (!str || [str length] == 0) {
        return nil;
    }
    
    NSMutableData *hexData = [[NSMutableData alloc] initWithCapacity:8];
    NSRange range;
    if ([str length] % 2 == 0) {
        range = NSMakeRange(0, 2);
    } else {
        range = NSMakeRange(0, 1);
    }
    for (NSInteger i = range.location; i < [str length]; i += 2) {
        unsigned int anInt;
        NSString *hexCharStr = [str substringWithRange:range];
        NSScanner *scanner = [[NSScanner alloc] initWithString:hexCharStr];
        
        [scanner scanHexInt:&anInt];
        NSData *entity = [[NSData alloc] initWithBytes:&anInt length:1];
        [hexData appendData:entity];
        
        range.location += range.length;
        range.length = 2;
    }
    
    NSLog(@"hexdata: %@", hexData);
    return hexData;
}


+(UIImage *)createQrCodeSize:(CGSize)size  dataString:(NSString *)dataString {
    /**
     *  2.生成CIFilter(滤镜)对象
     */
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    /**
     *  3.恢复滤镜默认设置
     */
    [filter setDefaults];
    
    /**
     *  4.设置数据(通过滤镜对象的KVC)
     */
    //存放的信息
//    NSString *info = @"hahahahhahahaha";
    //把信息转化为NSData
    NSData *infoData = [dataString dataUsingEncoding:NSUTF8StringEncoding];
    //滤镜对象kvc存值
    [filter setValue:infoData forKeyPath:@"inputMessage"];
    [filter setValue:@"L" forKeyPath:@"inputCorrectionLevel"];
    
//    "": "L"
    
    /**
     *  5.生成二维码
     */
    CIImage *outImage = [filter outputImage];
    
    //imageView.image = [UIImage imageWithCIImage:outImage];//不处理图片模糊,故而调用下面的信息
    
    //    self.img.image =  [UIImage imageWithCIImage:outImage];
    
    
    
    CGRect extent = CGRectIntegral(outImage.extent);
    CGFloat scale = MIN(size.width/CGRectGetWidth(extent), size.height/CGRectGetHeight(extent));
    
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:outImage fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    

    return  [UIImage imageWithCGImage:scaledImage];

}

@end
