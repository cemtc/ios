//
//  ObjcSectionModel.h
//  wallet
//
//  Created by 曾云 on 2019/8/17.
//  Copyright © 2019 talking　. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ObjcSectionModel : NSObject

@property (nonatomic,assign) double header_Height;
@property (nonatomic,assign) double footer_Height;
@property (nonatomic,strong) NSMutableArray *itemArray;

- (NSString *)verifyPassWord:(NSString *)value;

@end

NS_ASSUME_NONNULL_END
