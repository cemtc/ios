//
//  ObjcBaseModel.h
//  wallet
//
//  Created by 曾云 on 2019/8/17.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "SKBaseModel.h"

#define kMNullStr @""
NS_ASSUME_NONNULL_BEGIN

@interface ObjcBaseModel : SKBaseModel

@property (nonatomic,assign) double objc_Height;
@property (nonatomic,strong) NSString *objc_Identifier;



- (NSString *)modelAttribute:(id)obj;
- (NSString *)modelAttribute:(id)obj withNullString:(NSString *)nullString;
- (NSString *)modelAttributeString:(id)obj;
- (NSInteger)modelAttributeInteger:(id)obj;
- (double)modelAttributeDouble:(id)obj;
- (BOOL)modelAttributeBool:(id)obj;
- (long long)modelAttributeLongLong:(id)obj;


- (instancetype)initWithDictionary:(NSDictionary *)dict;





@end

NS_ASSUME_NONNULL_END
