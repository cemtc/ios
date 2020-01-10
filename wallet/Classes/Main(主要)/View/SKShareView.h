//
//  SKShareView.h
//  Business
//
//  Created by talking　 on 2018/8/14.
//  Copyright © 2018年 talking　. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SKShareView : UIView

- (void)show;

- (void)hideShare;

// 设置分享的内容 （文字和图片）
- (void)setShareContentWithText:(NSString *)text shareImage:(UIImage *)shareImage shareUrl:(NSString *)url;

@end
