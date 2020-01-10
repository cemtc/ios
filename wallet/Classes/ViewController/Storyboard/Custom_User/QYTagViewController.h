//
//  QYTagViewController.h
//  wallet
//
//  Created by 董文龙 on 2019/11/28.
//  Copyright © 2019 talking　. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QYTagViewController : CustomBaseViewController
@property(nonatomic,strong)NSString *lblMnText;
//@property(copy, nonatomic) NSString *psw;
@property(copy, nonatomic) NSString *mn;
@property(nonatomic,strong)NSMutableArray *array;
@property(nonatomic,strong)NSString *lblMnString;
- (instancetype)initWithPsw:(NSString *)mn ;
+ (instancetype)controllerWithPsw:(NSString *)mn;
@end

NS_ASSUME_NONNULL_END
