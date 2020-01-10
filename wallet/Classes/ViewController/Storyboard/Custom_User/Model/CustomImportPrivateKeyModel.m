//
//  CustomImportPrivateKeyModel.m
//  wallet
//
//  Created by 曾云 on 2019/8/17.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "CustomImportPrivateKeyModel.h"



@implementation CustomImportPrivateKeyItemModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _key = @"";
        _value = @"";
        _placeholder =@"";
        _isEntry = NO;
        _type = ImportPrivateKeyItemType_Name;
        self.objc_Height = 50.0f;
        self.objc_Identifier = @"Identifier_CustomImportPrivateKey";
    }
    return self;
}

- (instancetype)initWithType:(ImportPrivateKeyItemType )type
{
    self = [self init];
    if (self) {
        self.type = type;
        switch (self.type) {
            case ImportPrivateKeyItemType_Name:
            {
                self.placeholder = @"Wallet name (up to 12 characters)";
            }
                break;
                
            case ImportPrivateKeyItemType_Password:
            {
                self.placeholder = @"Password (8-32 characters, letters and numbers)";
                self.isEntry = YES;
            }
                break;
                
            case ImportPrivateKeyItemType_NewPassword:
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





@implementation CustomImportPrivateKeyModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.header_Height = 234.0f;
        self.footer_Height = 100.0f;
        _name = @"EMTCWallet";
        _password = @"Zy1234567890";
        _newpassword = @"Zy1234567890";
        _privateKey = @"561131440a3c8f4f9a5bc86a1be93e0f1b16fd5fa745af3d06135ff8cbc8e49a";
        
//        _name = @"";
        _password = @"";
        _newpassword = @"";
        _privateKey = @"";
        
        _dataArray = [[NSMutableArray alloc]initWithObjects:
                      [[CustomImportPrivateKeyItemModel alloc]initWithType:ImportPrivateKeyItemType_Name],
                      [[CustomImportPrivateKeyItemModel alloc]initWithType:ImportPrivateKeyItemType_Password],
                      [[CustomImportPrivateKeyItemModel alloc]initWithType:ImportPrivateKeyItemType_NewPassword], nil];
        
        
        
        _errMsg = @"";
        RAC(self,errMsg)=
        [RACSignal combineLatest:@[ [RACObserve(self,privateKey) distinctUntilChanged]
                                    ,[RACObserve(self,name) distinctUntilChanged],
                                   [RACObserve(self,password) distinctUntilChanged],
                                   [RACObserve(self,newpassword) distinctUntilChanged]]
                          reduce:^(NSString *privateKey,
                                   NSString *name,
                                   NSString *password,
                                   NSString *newpassword){
                              if (privateKey.length == 0) {
                                  return @"input Private key";
                              }
                              if (name.length == 0) {
                                  return @"input Wallet name";
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
