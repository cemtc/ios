//
//  SKLineTabBar.m
//  Business
//
//  Created by talking　 on 2018/8/14.
//  Copyright © 2018年 talking　. All rights reserved.
//

#import "SKLineTabBar.h"

@interface SKLineTabBar ()

@property (nonatomic, strong) CAShapeLayer *shapeLayer;

@end

@implementation SKLineTabBar

-(instancetype)initWithFrame:(CGRect)frame
{
    
    if (self = [super initWithFrame:frame]) {
        
        self.shapeLayer = [CAShapeLayer new];
        self.shapeLayer.frame = CGRectMake(0,  - 20, SKScreenWidth, 69.f);
        UIBezierPath * beziperPath = [UIBezierPath bezierPath];
        beziperPath.lineCapStyle = kCGLineCapRound;
        CGFloat b = sqrt(pow(30,2) - pow(10,2)) * 2.f;
        CGFloat h = 20.f;
        CGFloat θ = (pow(b, 2) + 4 * pow(h, 2))/(8 * h);
        CGFloat scale = θ / 360.f;
        CGFloat y = h;
        CGFloat left_x = SKScreenWidth/2.f - sqrt(pow(30,2) - pow(10,2));
        CGFloat right_x = SKScreenWidth/2.f + sqrt(pow(30,2) - pow(10,2));
        [beziperPath moveToPoint:CGPointMake(0, y)];
        [beziperPath addLineToPoint:CGPointMake(left_x, y)];
        [beziperPath addArcWithCenter:CGPointMake(SKScreenWidth/2.f, 35.f) radius:30.f startAngle:M_PI * (1.f + scale * 2.f) endAngle:(2.f - scale * 2.f) * M_PI clockwise:YES];
        [beziperPath addLineToPoint:CGPointMake(right_x, y)];
        [beziperPath addLineToPoint:CGPointMake(SKScreenWidth, y)];
        self.shapeLayer.path = beziperPath.CGPath;
        
        //        调整图片的颜色
        self.shapeLayer.fillColor = [UIColor whiteColor].CGColor;
        self.shapeLayer.lineWidth = 1.f;
        
        //        调整外围的颜色
        self.shapeLayer.strokeColor = [UIColor colorWithRed:0.63f green:0.63f blue:0.63f alpha:0.2f].CGColor;
        [self.layer addSublayer:self.shapeLayer];
        
    }
    
    return self;
}


@end
