//
//  CustomImportMnmonicWordModel.h
//  wallet
//
//  Created by 曾云 on 2019/8/17.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "ObjcSectionModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM (NSUInteger, ImportMnmonicWordItemType) {
    ImportMnmonicWordItemType_Name,/**< 名字 */
    ImportMnmonicWordItemType_Password,/**< 密码 */
    ImportMnmonicWordItemType_NewPassword/**< 新密码 */
};

@interface CustomImportMnmonicWordItemModel : ObjcBaseModel

@property (nonatomic,strong) NSString *key;
@property (nonatomic,strong) NSString *value;
@property (nonatomic,strong) NSString *placeholder;
@property (nonatomic,assign) BOOL isEntry;
@property (nonatomic,assign) ImportMnmonicWordItemType type;

@end


@interface CustomImportMnmonicWordModel : ObjcSectionModel

@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *mnmonicWord;
@property (nonatomic,strong) NSString *password;
@property (nonatomic,strong) NSString *newpassword;
@property (nonatomic,strong) NSString *errMsg;

@property (nonatomic,strong) NSMutableArray *dataArray;

@end

NS_ASSUME_NONNULL_END
