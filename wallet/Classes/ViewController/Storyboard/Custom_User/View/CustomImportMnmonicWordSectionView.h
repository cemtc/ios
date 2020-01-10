//
//  CustomImportMnmonicWordSectionView.h
//  wallet
//
//  Created by 曾云 on 2019/8/17.
//  Copyright © 2019 talking　. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomImportMnmonicWordSectionView : UIView

@property (nonatomic,strong) void(^buttonClickBlock)(void);
@property (nonatomic,strong) void(^textViewBlock)(NSString *text);


@end

NS_ASSUME_NONNULL_END
