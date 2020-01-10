//
//  ImportMnemonicAndPrivite.h
//  wallet
//
//  Created by talking　 on 2019/6/25.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "SKRootViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ImportMnemonicAndPrivite : SKRootViewController


@property (nonatomic, copy) NSString *titleString;
//回到上一页 把TextView.text值 传给上个界面
@property (nonatomic, copy) void (^NextViewControllerBlock)(NSString *tfText,NSString *type);

@end

NS_ASSUME_NONNULL_END
