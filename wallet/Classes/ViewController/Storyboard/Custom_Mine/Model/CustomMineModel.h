//
//  CustomMineModel.h
//  wallet
//
//  Created by 曾云 on 2019/8/17.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "ObjcSectionModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM (NSUInteger, CustomMineSectionType) {
    CustomMineSectionType_Setup = 1,/**< 基本设置 */
    CustomMineSectionType_Security,/**< 安全中心 */
    CustomMineSectionType_FocusMe/**< 关注我们 */
};

typedef NS_ENUM (NSUInteger, CustomMineItemType) {
    CustomMineItemType_NotificationCenter = 1,/**< 通知中心 */
    CustomMineItemType_UserFeedback,/**< 用户反馈 */
    CustomMineItemType_ModifyPassword,/**< 修改密码 */
//    CustomMineItemType_UserAgreement,/**< 用户协议 */
    CustomMineItemType_AboutMe,/**< 关于我们 */
    CustomMineItemType_Version,/**< 当前版本 */
    CustomMineItemType_LoginOut/**< 退出登录 */
};

@interface CustomMineItemModel : ObjcBaseModel

@property (nonatomic,strong) NSString *title;
@property (nonatomic,assign) NSInteger count;/**<  CustomMineItemType_NotificationCenter 才会使用 */
@property (nonatomic,assign) CustomMineItemType type;

- (instancetype)initWithType:(CustomMineItemType)type;
@end




@interface CustomMineSectionModel : ObjcSectionModel
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *imgName;
@property (nonatomic,assign) CustomMineSectionType type;
- (instancetype)initWithType:(CustomMineSectionType)type;
@end

@interface CustomMineModel : NSObject

@property (nonatomic,strong) NSString *walletName;
@property (nonatomic,strong) NSString *header_ImgName;

@property (nonatomic,strong) CustomMineSectionModel *setup;
@property (nonatomic,strong) CustomMineSectionModel *security;
@property (nonatomic,strong) CustomMineSectionModel *focusMe;
@property (nonatomic,strong) NSMutableArray *dataArray;

@end

NS_ASSUME_NONNULL_END
