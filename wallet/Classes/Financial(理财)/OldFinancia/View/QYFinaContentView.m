//
//  QYFinaContentView.m
//  wallet
//
//  Created by talking　 on 2019/6/19.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "QYFinaContentView.h"

@interface QYFinaContentView ()

@end

@implementation QYFinaContentView

- (UILabel *)topTextLabel {
    if (!_topTextLabel) {
        _topTextLabel = [[UILabel alloc]init];
        _topTextLabel.textColor = SKWhiteColor;
        _topTextLabel.font = SKFont(12);
        _topTextLabel.numberOfLines = 0;
        _topTextLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _topTextLabel;
}

- (UILabel *)lineL{
    if (!_lineL) {
        _lineL = [[UILabel alloc]init];
        _lineL.backgroundColor = SKWhiteColor;
        _lineL.alpha = 0.4;
    }
    return _lineL;
}

@end
