//
//  CustomImportWalletView.h
//  wallet
//
//  Created by 曾云 on 2019/8/17.
//  Copyright © 2019 talking　. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM (NSUInteger, CustomImportWalletType) {
    CustomImportWalletType_PrivateKey,/**< 私钥 */
    CustomImportWalletType_MnmonicWord,/**< 助记词 */
    CustomImportWalletType_Cancel/**< 取消 */
};

@interface CustomImportWalletView : UIView

@property (nonatomic,strong) NSString *title;

@property (nonatomic,strong) void(^clickBlock)(CustomImportWalletType type);

- (void)showClickButtonType:(void(^)(CustomImportWalletType type))clickBlock;
- (void)dismisss;

@end

NS_ASSUME_NONNULL_END
