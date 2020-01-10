//
//  SKDownloadImageManager.h
//  Business
//
//  Created by talking　 on 2018/8/15.
//  Copyright © 2018年 talking　. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SKDownloadImageManager : NSObject

+ (void)downLoadImageWithURL:(NSURL *)URL finishHandle:(void(^)(BOOL finished, UIImage *finishedImage))finishHandle;
+ (void)downLoadImageWithURL:(NSURL *)URL finishHandle:(void(^)(BOOL finished, UIImage *finishedImage))finishHandle
              progressHandle:(void(^)(CGFloat progres))progressHandle;

+ (void)downLoadImageWithUrl:(NSString *)url finishHandle:(void(^)(BOOL finished, UIImage *finishedImage))finishHandle;
+ (void)downLoadImageWithUrl:(NSString *)url finishHandle:(void(^)(BOOL finished, UIImage *finishedImage))finishHandle
              progressHandle:(void(^)(CGFloat progres))progressHandle;

+ (UIImage *)cacheImageWithUrl:(NSString *)url;
+ (UIImage *)cacheImageWithURL:(NSURL *)URL;

@end
