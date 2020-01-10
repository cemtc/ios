//
//  QYHomeTopView.h
//  wallet
//
//  Created by talking　 on 2019/6/14.
//  Copyright © 2019 talking　. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QYHomeTopView : UIView

//回到上一页 把TextView.text值 传给上个界面
@property (nonatomic, copy) void (^NextViewControllerBlock)(NSString *tfText);

@property (nonatomic, copy) NSArray *gonggaoArrayTop;

@end

NS_ASSUME_NONNULL_END
