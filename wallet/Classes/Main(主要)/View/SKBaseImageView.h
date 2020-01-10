//
//  SKBaseImageView.h
//  Business
//
//  Created by talking　 on 2018/8/13.
//  Copyright © 2018年 talking　. All rights reserved.
//

#import "YYAnimatedImageView.h"

@interface SKBaseImageView : YYAnimatedImageView


/** 设置图片*/
- (void)setImageWithUrl:(NSString *)url;
- (void)setImageWithURL:(NSURL *)URL;

/** 设置图片*/
- (void)setImageWithUrl:(NSString *)url placeHolder:(UIImage *)image;
- (void)setImageWithURL:(NSURL *)URL placeHolder:(UIImage *)image;

/** 设置图片*/
- (void)setImageWithUrl:(NSString *)url placeHolder:(UIImage *)image finishHandle:(void(^)(BOOL finished, UIImage *image))finishHandle;
- (void)setImageWithURL:(NSURL *)URL placeHolder:(UIImage *)image finishHandle:(void(^)(BOOL finished, UIImage *image))finishHandle;

/** 设置图片*/
- (void)setImageWithUrl:(NSString *)url placeHolder:(UIImage *)image progressHandle:(void(^)(CGFloat progress))progressHandle finishHandle:(void(^)(BOOL finished, UIImage *image))finishHandle;
- (void)setImageWithURL:(NSURL *)URL placeHolder:(UIImage *)image progressHandle:(void(^)(CGFloat progress))progressHandle finishHandle:(void(^)(BOOL finished, UIImage *image))finishHandle;


@end
