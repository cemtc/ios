//
//  SKCustomGifImageView.m
//  Business
//
//  Created by talking　 on 2018/8/15.
//  Copyright © 2018年 talking　. All rights reserved.
//

#import "SKCustomGifImageView.h"

@interface SKCustomGifImageView ()
@property (nonatomic, weak) CAShapeLayer *shapeLayer;
@end

@implementation SKCustomGifImageView

- (void)setProgress:(CGFloat)progress {
    _progress = progress;
    
    if (progress == 1.0) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [_shapeLayer removeFromSuperlayer];
            _shapeLayer = nil;
            return ;
        });
    } else {
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, self.width * progress, 5)];
        self.shapeLayer.path = path.CGPath;
    }
}

- (CAShapeLayer *)shapeLayer {
    if (!_shapeLayer) {
        CAShapeLayer *layer = [CAShapeLayer layer];
        [self.layer addSublayer:layer];
        _shapeLayer = layer;
        layer.fillColor = SKOrangeColor.CGColor;
    }
    return _shapeLayer;
}

@end
