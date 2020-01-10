//
//  CustomMineModel.m
//  wallet
//
//  Created by 曾云 on 2019/8/17.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "CustomMineModel.h"


@implementation CustomMineItemModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        _title = @"";
        _count = 0;
        self.objc_Height = 44.0f;
        self.objc_Identifier = @"Identifier_CustomMine";
        _type = CustomMineItemType_NotificationCenter;
        [[RACObserve(self, type)distinctUntilChanged]subscribeNext:^(id  _Nullable x) {
            switch ([x integerValue]) {
                case CustomMineItemType_NotificationCenter:
                {
                    self.title = @"Notification Center";
                    
                }
                    break;
                    
                case CustomMineItemType_UserFeedback:
                {
                    self.title = @"customer feedback";
                }
                    break;
                    
                    
                case CustomMineItemType_ModifyPassword:
                {
                    self.title = @"change Password";
                }
                    break;
                    
//                case CustomMineItemType_UserAgreement:
//                {
//                    self.title = @"User Agreement";
//                }
//                    break;
//                    
                case CustomMineItemType_AboutMe:
                {
                    self.title = @"about us";
                }
                    break;
                    
                case CustomMineItemType_Version:
                {
                    self.title = @"current version";
                }
                    break;
                case CustomMineItemType_LoginOut:
                {
                    self.title = @"sign out";
                }
                    break;
                    
                default:
                    break;
            }
        }];
        
    }
    return self;
}
- (instancetype)initWithType:(CustomMineItemType)type
{
    self = [self init];
    if (self) {
        self.type = type;
    }
    return self;
}

@end

@implementation CustomMineSectionModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.header_Height = 30.0f;
        _title = @"";
        _imgName = @"";
        _type = CustomMineSectionType_Setup;
        [[RACObserve(self, type)distinctUntilChanged]subscribeNext:^(id  _Nullable x) {
            [self.itemArray removeAllObjects];
            switch ([x integerValue]) {
                case CustomMineSectionType_Setup:
                {
                    self.title = @"basic settings";
                    self.imgName = @"user_icon_set";
                    [self.itemArray addObject:[[CustomMineItemModel alloc]initWithType:CustomMineItemType_NotificationCenter]];
                    [self.itemArray addObject:[[CustomMineItemModel alloc]initWithType:CustomMineItemType_UserFeedback]];
                    
                    
                }
                    break;
                    
                case CustomMineSectionType_Security:
                {
                    self.title = @"Security center";
                    self.imgName = @"user_icon_security";
                     [self.itemArray addObject:[[CustomMineItemModel alloc]initWithType:CustomMineItemType_ModifyPassword]];
                }
                    break;
                    
                    
                case CustomMineSectionType_FocusMe:
                {
                    self.title = @"Follow us";
                    self.imgName = @"user_icon_us";
//                     [self.itemArray addObject:[[CustomMineItemModel alloc]initWithType:CustomMineItemType_UserAgreement]];
                     [self.itemArray addObject:[[CustomMineItemModel alloc]initWithType:CustomMineItemType_AboutMe]];
                     [self.itemArray addObject:[[CustomMineItemModel alloc]initWithType:CustomMineItemType_Version]];
                    [self.itemArray addObject:[[CustomMineItemModel alloc]initWithType:CustomMineItemType_LoginOut]];
                }
                    break;
                    
                default:
                    break;
            }
        }];
        
    }
    return self;
}
- (instancetype)initWithType:(CustomMineSectionType)type
{
    self = [self init];
    if (self) {
        self.type = type;
    }
    return self;
}

@end

@implementation CustomMineModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        _walletName = @"wallet name";
        _header_ImgName = @"head_portrait";
        _dataArray = [NSMutableArray array];
        _setup = [[CustomMineSectionModel alloc]initWithType:CustomMineSectionType_Setup];
        [_dataArray addObject:_setup];
        
        _security = [[CustomMineSectionModel alloc]initWithType:CustomMineSectionType_Security];
        [_dataArray addObject:_security];
        
        _focusMe = [[CustomMineSectionModel alloc]initWithType:CustomMineSectionType_FocusMe];
        [_dataArray addObject:_focusMe];
    }
    return self;
}
@end
