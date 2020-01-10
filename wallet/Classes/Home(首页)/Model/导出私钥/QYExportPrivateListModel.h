//
//  QYExportPrivateListModel.h
//  wallet
//
//  Created by talking　 on 2019/6/26.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "SKBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface QYExportPrivateListModel : SKBaseModel
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *imageName;


@property (nonatomic, copy) NSString *addressString;
@property (nonatomic, copy) NSString *privateString;

@end

NS_ASSUME_NONNULL_END
