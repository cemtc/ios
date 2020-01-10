//
//  SKCustomEditTextViewController.h
//  Business
//
//  Created by talking　 on 2018/8/15.
//  Copyright © 2018年 talking　. All rights reserved.
//

#import "SKRootViewController.h"

@interface SKCustomEditTextViewController : SKRootViewController


@property (nonatomic, copy) NSString *placeHolderTextViewText;

@property (nonatomic, copy) NSString *placehoderText;

@property (nonatomic, assign) NSInteger placeHeight;

@property (nonatomic, assign) NSInteger placeFontSize;


//回到上一页 把TextView.text值 传给上个界面
@property (nonatomic, copy) void (^NextViewControllerBlock)(NSString *tfText);


@property (nonatomic, assign) NSInteger MaxInputLimitLength;

//        设置Y偏移量默认是10

@property (nonatomic, assign) NSInteger placeY;


@end
