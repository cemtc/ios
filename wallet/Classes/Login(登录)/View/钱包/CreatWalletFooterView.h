//
//  CreatWalletFooterView.h
//  wallet
//
//  Created by talking　 on 2019/6/25.
//  Copyright © 2019 talking　. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class CreatWalletFooterView;
@protocol CreatWalletFooterViewDelegate <NSObject>
- (void)qycreatWalletFooterView:(CreatWalletFooterView *)footerView didClickInfo:(NSString *)info;
@end
@interface CreatWalletFooterView : UIView
@property (nonatomic, weak) id <CreatWalletFooterViewDelegate> delegate;

@property (nonatomic, copy) NSString *titleText;
@end

NS_ASSUME_NONNULL_END
