//
//  InputModel.h
//  wallet
//
//  Created by 董文龙 on 2019/11/11.
//  Copyright © 2019 talking　. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface InputModel : NSObject
@property (nonatomic,strong) NSString *addr;
@property (nonatomic,assign) BOOL spent;
@property (nonatomic,strong) NSString *value;
@end

NS_ASSUME_NONNULL_END
