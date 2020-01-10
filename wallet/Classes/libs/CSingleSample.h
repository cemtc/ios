//
//  CSingleSample.h
//  wallet
//
//  Created by 董文龙 on 2019/10/31.
//  Copyright © 2019 talking　. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CustomHomeModel.h"
#import "QYHangQingModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CSingleSample : NSObject
+ (CSingleSample *)instance;
@property (nonatomic, copy) id  _Nonnull walletSocketData;
@property (nonatomic, assign) double sum;
@property (nonatomic, strong) NSString *ccmFiatPrice;
@property (nonatomic, assign) double ethFiatPrice;
@property (nonatomic, assign) double btcFiatPrice;
@property (nonatomic, assign) double fiatPrice;
@property (nonatomic, strong) NSMutableArray *listArr;
//@property (nonatomic, strong) QYHangQingModel * exchangeModel;
@property (nonatomic, strong) CustomHomeItemModel *itemModel;
@property (nonatomic, strong) NSString *latest_price_xs;
- (void)setCurrentWalletData:(NSString *)currentWalletData;
@end

NS_ASSUME_NONNULL_END
