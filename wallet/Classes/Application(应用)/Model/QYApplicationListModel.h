//
//  QYApplicationListModel.h
//  wallet
//
//  Created by talking　 on 2019/6/29.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "SKBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface QYApplicationListModel : SKBaseModel

@property (nonatomic, copy) NSString *androidHyperLink;
@property (nonatomic, copy) NSString *androidSize;
@property (nonatomic, copy) NSString *applicationDesc;
@property (nonatomic, copy) NSString *applicationId;
@property (nonatomic, copy) NSString *applicationIntro;
@property (nonatomic, copy) NSString *applicationName;
@property (nonatomic, copy) NSString *createId;
@property (nonatomic, copy) NSString *createName;
@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, copy) NSString *iconUrl;
@property (nonatomic, copy) NSString *iosHyperLink;
@property (nonatomic, copy) NSString *iosSize;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *typeName;
@property (nonatomic, copy) NSString *updateId;
@property (nonatomic, copy) NSString *updateTime;

@end

NS_ASSUME_NONNULL_END
/*
 androidHyperLink = "https://www.lernd9.cn/downloads/Dapps/bian/bian.apk";
 androidSize = "11.1";
 applicationDesc = sdgsdfjgkjsf;
 applicationId = 18;
 applicationIntro = asfsadgddf;
 applicationName = "\U5e01\U5b89";
 createId = 1;
 createName = admin;
 createTime = 1545649564000;
 iconUrl = "";
 iosHyperLink = "itms-services://?action=download-manifest&url=https://www.lernd9.cn/downloads/Dapps/bian/bian.plist";
 iosSize = "10.6";
 status = 1;
 type = 2;
 typeName = "\U5c0f\U7f16\U63a8\U8350";
 updateId = 1;
 updateTime = "<null>";
 */
