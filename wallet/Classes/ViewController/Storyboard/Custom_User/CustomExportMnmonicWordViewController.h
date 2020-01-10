//
//  CustomExportMnmonicWordViewController.h
//  wallet
//
//  Created by 曾云 on 2019/8/20.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "CustomBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CustomExportMnmonicWordViewController : CustomBaseViewController
@property(strong,nonatomic)NSString *mn;
- (IBAction)ExportMnDetailVc:(UIButton *)sender forEvent:(UIEvent *)event;
@property(nonatomic,copy)NSString *zhujici;
@end

NS_ASSUME_NONNULL_END
