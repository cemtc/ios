//
//  CSingleSample.m
//  wallet
//
//  Created by 董文龙 on 2019/10/31.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "CSingleSample.h"
static NSString *const walletData = @"walletData";

@interface CSingleSample ()
@end
@implementation CSingleSample
@synthesize ethFiatPrice,btcFiatPrice,walletSocketData;
+ (CSingleSample *)instance {
    static CSingleSample *_instance = nil;
    
    @synchronized (self) {
        if (_instance == nil) {
            _instance = [[self alloc] init];
        }
    }
    
    return _instance;
}
- (instancetype)init {
    self = [super init];
    if (self) {
      walletSocketData = [[NSUserDefaults standardUserDefaults] objectForKey:walletData];
        _sum = 0;
    }
    return self;
}
- (void)setCurrentWalletData:(NSString *)currentWalletData {
    [[NSUserDefaults standardUserDefaults] setObject:currentWalletData forKey:walletData];
    [[NSUserDefaults standardUserDefaults] synchronize];
    walletSocketData = currentWalletData;
}
@end
