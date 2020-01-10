//
//  QYFinaLeftContentView.h
//  wallet
//
//  Created by talking　 on 2019/6/19.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "QYFinaContentView.h"

NS_ASSUME_NONNULL_BEGIN

@interface QYFinaLeftContentView : QYFinaContentView
@property(nonatomic, strong)UILabel *rightLabel1;
@property(nonatomic, strong)UITextField *rightTextField;


//交给子类用 其他没啥用
@property(nonatomic, strong) UILabel *rightLabelBtn;



@property(nonatomic, copy) NSString *balanceNum;


@end

NS_ASSUME_NONNULL_END
