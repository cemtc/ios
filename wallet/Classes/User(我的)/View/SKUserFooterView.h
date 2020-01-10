//
//  SKUserFooterView.h
//  wallet
//
//  Created by talking　 on 2019/6/23.
//  Copyright © 2019 talking　. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SKUserFooterView;
@protocol SKUserFooterViewDelegate <NSObject>
- (void)skUserFooterView:(SKUserFooterView *)topView didClickInfo:(NSString *)info;
@end
@interface SKUserFooterView : UIView
@property (nonatomic, weak) id <SKUserFooterViewDelegate> delegate;

@property (nonatomic, copy) NSString *titleText;

@end

NS_ASSUME_NONNULL_END
