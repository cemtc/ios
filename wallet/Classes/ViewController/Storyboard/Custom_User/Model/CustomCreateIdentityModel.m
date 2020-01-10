//
//  CustomCreateIdentityModel.m
//  wallet
//
//  Created by 曾云 on 2019/8/17.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "CustomCreateIdentityModel.h"


@implementation CustomCreateIdentityItemModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _key = @"";
        _value = @"";
        _placeholder =@"";
        _isEntry = NO;
        _type = CreateIdentityItemType_Name;
        self.objc_Height = 50.0f;
        self.objc_Identifier = @"Identifier_CustomCreateIdentity";
    }
    return self;
}

- (instancetype)initWithType:(CreateIdentityItemType )type
{
    self = [self init];
    if (self) {
        self.type = type;
        switch (self.type) {
            case CreateIdentityItemType_Name:
            {
                self.placeholder = @"Wallet Name（up to 12 characters）";
            }
                break;
                
            case CreateIdentityItemType_Password:
            {
                self.placeholder = @"Password (8-32 characters, letters and numbers)";
                self.isEntry = YES;
            }
                break;
                
            case CreateIdentityItemType_NewPassword:
            {
                self.placeholder = @"Repeat password (8-32 characters, letters and numbers)";
            }
                break;
                
            default:
                break;
        }
    }
    return self;
}

@end

@implementation CustomCreateIdentityModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.header_Height =40.0f;
        self.footer_Height = 100.0f;
        _name = @"EMTCWallet";
        _password = @"Zy1234567890";
        _newpassword = @"Zy1234567890";
        _name = @"";
        _password = @"";
        _newpassword = @"";
        _dataArray = [[NSMutableArray alloc]initWithObjects:
                      [[CustomCreateIdentityItemModel alloc]initWithType:CreateIdentityItemType_Name],
                      [[CustomCreateIdentityItemModel alloc]initWithType:CreateIdentityItemType_Password],
                      [[CustomCreateIdentityItemModel alloc]initWithType:CreateIdentityItemType_NewPassword], nil];
        
        
        
        _errMsg = @"";
        RAC(self,errMsg)=
        [RACSignal combineLatest:@[[RACObserve(self,name) distinctUntilChanged],
                                   [RACObserve(self,password) distinctUntilChanged],
                                   [RACObserve(self,newpassword) distinctUntilChanged]]
                          reduce:^(NSString *name,
                                   NSString *password,
                                   NSString *newpassword){
                              if (name.length == 0) {
                                  return @"input wallet name";
                              }
                              
                              if (name.length >12) {
                                  return @"Wallet name up to 12 digits";
                              }
                              
                              NSString *pad = [self verifyPassWord:password];
                              if (pad.length != 0) {
                                  return pad;
                              }
                              
                              if (![password isEqualToString:newpassword]) {
                                  return @"Not the same twice";
                              }
                              return @"";
                          }];
    }
    return self;
}



@end
