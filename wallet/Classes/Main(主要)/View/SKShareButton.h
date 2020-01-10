//
//  SKShareButton.h
//  Business
//
//  Created by talking　 on 2018/8/14.
//  Copyright © 2018年 talking　. All rights reserved.
//

#import <UIKit/UIKit.h>
// 平台枚举
typedef enum sns_Type {
    Share_SNSType_QQ,      // QQ
    Share_SNSType_WeChat,  // 微信
    Share_SNSType_Sina,   // 微博
    Share_SNSType_TimeLine,// 朋友圈
    Share_SNSType_QZone,   // QQ空间
    Share_SNSType_CopyLink // 复制链接
}Share_SNSType;



@interface SKShareButton : UIButton
// initial
- (instancetype)initWithFrame:(CGRect)frame
                    shareIcon:(NSString *)imageName
                 shareSNSName:(NSString *)snsName;

// snsName
@property (nonatomic, assign) Share_SNSType snsType; // 平台名称


@end
