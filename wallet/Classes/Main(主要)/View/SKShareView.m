//
//  SKShareView.m
//  Business
//
//  Created by talking　 on 2018/8/14.
//  Copyright © 2018年 talking　. All rights reserved.
//

#import "SKShareView.h"
//#import "HLShareButton.h"
//#import <TencentOpenAPI/QQApiInterface.h>
//#import "WXApi.h"
//#import "UMSocial.h"

@interface SKShareView ()
{
//@private
//    NSString * _shareText;  // 分享的文字
//    UIImage  * _shareImage; // 分享的图片
//    NSString * _shareUrl; // 分享的URL
//
}
//
//@property (nonatomic, strong) NSArray * dataArray;
//@property (nonatomic, assign) CGFloat   viewHeight;     // 分享View的高度
//@property (nonatomic, strong) UIImageView * backImage;  // 蒙版
//


@end

@implementation SKShareView


//- (instancetype)init
//{
//    if (self = [super init]) {
//
//        //        UIImageView * bgImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
//        //        bgImg.image = [UIImage imageNamed:@"折扣卡@3x"];
//        //        [self setBackImage:bgImg];
//        self.backgroundColor = HLColor(255, 255, 255);
//        self.layer.borderColor = HLColor(200, 200, 200).CGColor;
//        self.layer.borderWidth = .3f;
//
//
//        // 构造数据源 （根据是否安装了QQ 微信客户端来确定分享的平台和view的大小）
//        if ([QQApiInterface isQQInstalled]) {
//            // 安装了qq
//            if ([WXApi isWXAppInstalled]) {
//                // 安装了微信和QQ
//                _dataArray = @[@{@"title":@"朋友圈", @"imageName":@"share_timeline", @"share_type":[NSNumber numberWithInt:Share_SNSType_TimeLine]},
//                               @{@"title":@"微信好友", @"imageName":@"share_wechat", @"share_type":[NSNumber numberWithInt:Share_SNSType_WeChat]},
//                               @{@"title":@"新浪微博", @"imageName":@"share_sina", @"share_type":[NSNumber numberWithInt:Share_SNSType_Sina]},
//                               @{@"title":@"QQ好友", @"imageName":@"share_qq", @"share_type":[NSNumber numberWithInt:Share_SNSType_QQ]},
//                               @{@"title":@"QQ空间", @"imageName":@"share_qzone", @"share_type":[NSNumber numberWithInt:Share_SNSType_QZone]},
//                               @{@"title":@"复制链接", @"imageName":@"share_link", @"share_type":[NSNumber numberWithInt:Share_SNSType_CopyLink]}];
//            }else {
//                // 只安装了QQ 没有安装微信
//                _dataArray = @[@{@"title":@"新 浪微博", @"imageName":@"share_sina", @"share_type":[NSNumber numberWithInt:Share_SNSType_Sina]},
//                               @{@"title":@"QQ好友", @"imageName":@"share_qq", @"share_type":[NSNumber numberWithInt:Share_SNSType_QQ]},
//                               @{@"title":@"QQ空间", @"imageName":@"share_qzone", @"share_type":[NSNumber numberWithInt:Share_SNSType_QZone]},
//                               @{@"title":@"复制链接", @"imageName":@"share_link", @"share_type":[NSNumber numberWithInt:Share_SNSType_CopyLink]}];
//            }
//        }else {
//            if ([WXApi isWXAppInstalled]) {
//                // 只安装了微信 没有安装QQ
//                // 安装了微信和QQ
//                _dataArray = @[@{@"title":@"朋友圈", @"imageName":@"share_timeline", @"share_type":[NSNumber numberWithInt:Share_SNSType_TimeLine]},
//                               @{@"title":@"微信好友", @"imageName":@"share_wechat", @"share_type":[NSNumber numberWithInt:Share_SNSType_WeChat]},
//                               @{@"title":@"新 浪微博", @"imageName":@"share_sina", @"share_type":[NSNumber numberWithInt:Share_SNSType_Sina]},
//                               @{@"title":@"复制链接", @"imageName":@"share_link", @"share_type":[NSNumber numberWithInt:Share_SNSType_CopyLink]}];
//            }else {
//                // 没有安装微信和QQ
//                _dataArray = @[@{@"title":@"新 浪微博", @"imageName":@"share_sina", @"share_type":[NSNumber numberWithInt:Share_SNSType_Sina]},
//                               @{@"title":@"复制链接", @"imageName":@"share_link", @"share_type":[NSNumber numberWithInt:Share_SNSType_CopyLink]}];
//            }
//        }
//
//        CGFloat iconHeight  = 90.0f;
//        CGFloat iconWidth   = 80.0f;
//        // 计算每个item的间距
//        CGFloat itemBorder_W = (HLMainSize.width - iconWidth * 3.0f) / 4.0f; // 水平间距
//        CGFloat lastHeight = 0.0f;
//        CGFloat itemBorder_H = 30.0f; // 垂直间距
//
//        // 九宫格
//        for (int i = 0; i < _dataArray.count; i++) {
//            HLShareButton * shareBtn = [[HLShareButton alloc] initWithFrame:CGRectMake(itemBorder_W + (i % 3) *(iconWidth + itemBorder_W), (i / 3) * (itemBorder_H + iconHeight) + itemBorder_H, iconWidth, iconHeight) shareIcon:[_dataArray[i] objectForKey:@"imageName"] shareSNSName:[_dataArray[i] objectForKey:@"title"]];
//            shareBtn.snsType = (Share_SNSType)[[_dataArray[i] objectForKey:@"share_type"] intValue];
//            [shareBtn addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
//            [self addSubview:shareBtn];
//            if (i == _dataArray.count - 1) {
//                lastHeight = CGRectGetMaxY(shareBtn.frame);
//            }
//        }
//
//        // 取消按钮
//        CGFloat border = 15.0f;
//        UIButton * cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(border, lastHeight + itemBorder_H, HLMainSize.width - border * 2.0f, 44.0f)];
//        cancelBtn.backgroundColor = HLColor(235, 235, 235);
//        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
//        [cancelBtn setTitleColor:HLColor(154, 154, 154) forState:UIControlStateNormal];
//        cancelBtn.titleLabel.font = [UIFont fontWithName:@"Arial Unicode MS" size:15.0f];
//        cancelBtn.layer.masksToBounds = YES;
//        cancelBtn.layer.cornerRadius  = 3.0f;
//        [cancelBtn addTarget:self action:@selector(hideShare) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:cancelBtn];
//
//        // 计算view的高度
//        _viewHeight = lastHeight + itemBorder_H + cancelBtn.frame.size.height + 15.0f;
//
//        self.frame = CGRectMake(0, HLMainSize.height, HLMainSize.width, _viewHeight);
//    }
//
//    return self;
//}
//
///*!
// *  brief   设置分享的内容
// *
// *  param
// *  return
// */
//- (void)setShareContentWithText:(NSString *)text shareImage:(UIImage *)shareImage shareUrl:(NSString *)url{
//    _shareText = text;
//    _shareImage = shareImage;
//    _shareUrl = url;
//
//}
//
//
///*!
// *  brief   分享到相应的平台
// *
// *  param
// *  return
// */
//- (void)shareAction:(HLShareButton *)shareBtn
//{
//    // 勘错
//    if (_shareText == nil || _shareImage == nil || _shareUrl == nil) {
//        // NSLog(@"请设置您要分享的内容");
//        return;
//    }
//
//    // 添加点击效果
//    [UIView animateWithDuration:.3f delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
//        shareBtn.transform = CGAffineTransformMakeScale(.9, .9);
//    } completion:^(BOOL finished) {
//        shareBtn.transform = CGAffineTransformMakeScale(1.0, 1.0);
//
//        int  shareTo = shareBtn.snsType;
//        switch (shareBtn.snsType) {
//
//            case Share_SNSType_QQ:
//            {
//                // QQ好友
//                [UMSocialData defaultData].extConfig.qqData.url = _shareUrl;
//                [UMSocialData defaultData].extConfig.qqData.title = _shareText;
//                [[UMSocialDataService defaultDataService] postSNSWithTypes:@[UMShareToQQ] content:nil image:_shareImage location:nil urlResource:nil presentedController:nil completion:^(UMSocialResponseEntity *response) {
//                    if (response.responseCode == UMSResponseCodeSuccess) {
//                        // NSLog(@"分享成功");
//                    }
//                }];
//            }
//                break;
//            case Share_SNSType_QZone:
//            {
//                // QQ空间
//                [UMSocialData defaultData].extConfig.qzoneData.url = _shareUrl;
//                [UMSocialData defaultData].extConfig.qzoneData.title = _shareText;
//                [[UMSocialDataService defaultDataService] postSNSWithTypes:@[UMShareToQzone] content:nil image:_shareImage location:nil urlResource:nil presentedController:nil completion:^(UMSocialResponseEntity *response) {
//                    if (response.responseCode == UMSResponseCodeSuccess) {
//                        // NSLog(@"分享成功");
//                    }
//                }];
//            }
//                break;
//            case Share_SNSType_WeChat:
//            {
//                // 微信好友
//                [UMSocialData defaultData].extConfig.wechatSessionData.url = _shareUrl;
//                [UMSocialData defaultData].extConfig.wechatSessionData.title = _shareText;
//                [[UMSocialDataService defaultDataService] postSNSWithTypes:@[UMShareToWechatSession] content:nil image:_shareImage location:nil urlResource:nil presentedController:nil completion:^(UMSocialResponseEntity *response) {
//                    if (response.responseCode == UMSResponseCodeSuccess) {
//                        // NSLog(@"分享成功");
//
//                    }
//                }];
//            }
//                break;
//            case Share_SNSType_TimeLine:
//            {
//
//                [UMSocialData defaultData].extConfig.wechatTimelineData.url = _shareUrl;
//                [UMSocialData defaultData].extConfig.wechatTimelineData.title = _shareText;
//                // 朋友圈
//                [[UMSocialDataService defaultDataService] postSNSWithTypes:@[UMShareToWechatTimeline] content:nil image:_shareImage location:nil urlResource:nil presentedController:nil completion:^(UMSocialResponseEntity *response) {
//                    if (response.responseCode == UMSResponseCodeSuccess) {
//                        // NSLog(@"分享成功");
//                    }
//                }];
//            }
//                break;
//            case Share_SNSType_Sina:
//            {
//                ////                // 新浪微博
//                //                [UMSocialAccountManager isOauthAndTokenNotExpired:UMShareToSina];
//                ////                // 进入授权页面
//                //                [[UMSocialControllerService defaultControllerService] setShareText:_shareText shareImage:_shareImage socialUIDelegate:nil];
//                ////                // 设置分享内容和回调对象
//                //                [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina].snsClickHandler(self.window.rootViewController ,[UMSocialControllerService defaultControllerService],YES);
//
//
//                [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToSina] content:[NSString stringWithFormat:@"%@%@",_shareText,_shareUrl] image:_shareImage location:nil urlResource:nil presentedController:nil completion:^(UMSocialResponseEntity *response){
//                    if (response.responseCode == UMSResponseCodeSuccess) {
//
//                    }
//
//                }];
//
//            }
//                break;
//            case Share_SNSType_CopyLink:
//            {
//                // 复制链接
//                // 创建剪切板
//                UIPasteboard * pasteBoard = [UIPasteboard generalPasteboard];
//                pasteBoard.string = _shareUrl;
//
//            }
//                break;
//
//            default:
//                break;
//
//        }
//
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"ShareSucceed" object:self userInfo:@{@"share":[NSNumber numberWithInteger:shareTo]}];
//        [self hideShare];
//
//    }];
//}
//
//// 蒙版
//- (UIImageView *)backImage
//{
//    if (nil == _backImage) {
//        _backImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, HLMainSize.width, HLMainSize.height)];
//        _backImage.userInteractionEnabled = YES; // 接收点击事件 禁止用户操作
//        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
//        [_backImage addGestureRecognizer:tap];
//        _backImage.backgroundColor = HLColor(10, 10, 10);
//    }
//    return _backImage;
//}
//
//- (void)tapAction:(UITapGestureRecognizer *)tap
//{
//    [self hideShare]; // 隐藏
//}
//
//- (void)show
//{
//    // 得到window
//    UIWindow * mainWindow = [UIApplication sharedApplication].keyWindow;
//    [mainWindow addSubview:self.backImage];
//    [mainWindow addSubview:self];
//
//    // 从底部弹出
//    [UIView animateWithDuration:.2f delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
//        CGRect frame = self.frame;
//        frame.origin.y -= _viewHeight;
//        self.frame = frame;
//    } completion:^(BOOL finished) {
//
//    }];
//}
//
///*!
// *  brief   隐藏shareView
// *
// *  param
// *  return
// */
//- (void)hideShare
//{
//    // 先向下pop
//    [UIView animateWithDuration:.2f delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
//        CGRect frame = self.frame;
//        frame.origin.y += _viewHeight;
//        self.frame = frame;
//        // 渐变
//        self.backImage.alpha = 0.0f;
//    } completion:^(BOOL finished) {
//        // remove
//        [self removeFromSuperview];
//        [self.backImage removeFromSuperview];
//    }];
//}
//


@end
