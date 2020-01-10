//
//  SKPhotoPickerManager.h
//  Business
//
//  Created by talking　 on 2018/8/15.
//  Copyright © 2018年 talking　. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol PhotoPickerManagerDelegate <NSObject>

- (void) didPickPhotoCancel;
-(void)didPickPhotoWithImage:(UIImage *)pickImage;
@end



@interface SKPhotoPickerManager : NSObject<
UIImagePickerControllerDelegate,
UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic,assign) id delegate;
- (BOOL)choosePhotoWithSource:(UIViewController *)sourceObject;
+ (id)shareInstance;


@end
