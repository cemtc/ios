//
//  SKPhotoPickerManager.m
//  Business
//
//  Created by talking　 on 2018/8/15.
//  Copyright © 2018年 talking　. All rights reserved.
//

#import "SKPhotoPickerManager.h"
#import <objc/runtime.h>

@interface SKPhotoPickerManager () {
    
    UIViewController *sourceObject;
}
@end

static SKPhotoPickerManager *_singleton = nil;

@implementation SKPhotoPickerManager
@synthesize delegate;

+ (id)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _singleton = [[SKPhotoPickerManager alloc]init];
    });
    return _singleton;
}


- (BOOL)choosePhotoWithSource:(UIViewController *)object
{
    sourceObject = object;
    self.delegate = object;
    BOOL bSupportPhotoLib = NO;
    if (YES == [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        bSupportPhotoLib = YES;
    }
    
    BOOL bSupportCamera = NO;
    if (YES == [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        bSupportCamera = YES;
    }
    
    UIActionSheet *sheet = NULL;
    if(NO == bSupportPhotoLib && NO == bSupportCamera){
        return NO;
    }else{
        if(YES == bSupportPhotoLib && YES == bSupportCamera){
            sheet = [[UIActionSheet alloc] initWithTitle:NSLocalizedString(@"takePhotoTip", @"请选择照片获取方式")
                                                delegate:self
                                       cancelButtonTitle:NSLocalizedString(@"cancel",@"取消")
                                  destructiveButtonTitle:nil
                                       otherButtonTitles:NSLocalizedString(@"from_Album",@"来自相册"), NSLocalizedString(@"from_Camera",@"来自摄像头"), nil];
        }else{
            if(NO == bSupportPhotoLib){
                sheet = [[UIActionSheet alloc] initWithTitle:NSLocalizedString(@"takePhotoTip", @"请选择照片获取方式")
                                                    delegate:self
                                           cancelButtonTitle:NSLocalizedString(@"cancel",@"取消")
                                      destructiveButtonTitle:nil
                                           otherButtonTitles: NSLocalizedString(@"from_Camera",@"来自摄像头"), nil];
            }else{
                sheet = [[UIActionSheet alloc] initWithTitle:NSLocalizedString(@"takePhotoTip", @"请选择照片获取方式")
                                                    delegate:self
                                           cancelButtonTitle:NSLocalizedString(@"cancel",@"取消")
                                      destructiveButtonTitle:nil
                                           otherButtonTitles:NSLocalizedString(@"from_Album",@"来自相册"), nil];
            }
        }
    }
    
    [sheet showFromRect:sourceObject.view.bounds inView:sourceObject.view animated:YES];
    return YES;
}

#pragma mark -
#pragma mark UIActionSheet delegate methods
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == actionSheet.cancelButtonIndex) {
        [delegate didPickPhotoCancel];
        return;
    }
    //创建图像选取控制器
    UIImagePickerController* imagePickerController = [[UIImagePickerController alloc] init];
    //允许用户进行编辑
    imagePickerController.allowsEditing = YES;
    //设置委托对象
    imagePickerController.delegate = self;
    
    imagePickerController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    switch (buttonIndex) {
        case 0:
        {
            if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
                return;
            }
            imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            break;
        }
        case 1:
        {
            if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                return;
            }
            imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            break;
        }
            
            
        default:
            break;
    }
    
    [sourceObject presentViewController:imagePickerController animated:YES completion:nil];
}


////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark UIImagePickerControllerDelegate implementation
- (void)image: (UIImage *) image
didFinishSavingWithError: (NSError *) error
  contextInfo: (void *) contextInfo
{
    if ([delegate respondsToSelector:@selector(didPickPhotoWithImage:)]) {
        [delegate didPickPhotoWithImage:image];
    }
}
- (void) imagePickerController: (UIImagePickerController *) picker
 didFinishPickingMediaWithInfo: (NSDictionary *) info {
    
    UIImage *editedImage = [info objectForKey:UIImagePickerControllerEditedImage];
    [delegate didPickPhotoWithImage:editedImage];
    //UIImageWriteToSavedPhotosAlbum(editedImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    [picker dismissViewControllerAnimated:YES completion:nil];
    // for iOS7
    if ([sourceObject respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)])
    {
        [[UIApplication sharedApplication] setStatusBarHidden:YES];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    // for iOS7
    if ([sourceObject respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        
        [[UIApplication sharedApplication] setStatusBarHidden:YES];
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
    [delegate didPickPhotoCancel];
}

@end
