//
//  QYHomeListModel.h
//  wallet
//
//  Created by talking　 on 2019/6/14.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "SKBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface QYHomeListModel : SKBaseModel

//talking自定义的
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *number;
@property (nonatomic, copy) NSString *price;

@property (nonatomic, copy) NSString *imageName;


@property (nonatomic, copy) NSString *pricePTB;

//是不是测试数据
@property (nonatomic, assign) BOOL isTest;
@end

NS_ASSUME_NONNULL_END
