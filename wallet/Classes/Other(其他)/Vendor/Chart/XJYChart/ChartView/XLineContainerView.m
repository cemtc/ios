//
//  XLineContainerView.m
//  RecordLife
//
//  Created by 谢俊逸 on 17/03/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//
// macOS  和 iOS 的坐标系问题

#import "XLineContainerView.h"
#import "XAuxiliaryCalculationHelper.h"
#import "XColor.h"
#import "XAnimationLabel.h"
#import "XAnimation.h"
#import "XPointDetect.h"
#import "CALayer+XLayerSelectHelper.h"
#import "CAShapeLayer+XLayerHelper.h"
#pragma mark - Macro

#define LineWidth 2.0
#define PointDiameter 10.0

#define ReactTap 10.0

// Control Touch Area
CGFloat touchLineWidth = 20;

@interface XLineContainerView ()
//CABasicAnimation 动画效果 是否一开始显示动画 用到的
@property(nonatomic, strong) CABasicAnimation* pathAnimation;

@property(nonatomic, strong) CAShapeLayer* coverLayer;
/**
 All lines points
 */
@property(nonatomic, strong)
    NSMutableArray<NSMutableArray<NSValue*>*>* pointsArrays;
@property(nonatomic, strong) NSMutableArray<CAShapeLayer*>* shapeLayerArray;
@property(nonatomic, strong) NSMutableArray<XAnimationLabel*>* labelArray;
@property(nonatomic, strong) NSMutableArray<CAShapeLayer*>* pointLayerArray;

@end

@implementation XLineContainerView

- (instancetype)initWithFrame:(CGRect)frame
                dataItemArray:(NSMutableArray<XLineChartItem*>*)dataItemArray
                    topNumber:(NSNumber*)topNumber
                 bottomNumber:(NSNumber*)bottomNumber
                configuration:(XNormalLineChartConfiguration*)configuration {
  if (self = [super initWithFrame:frame]) {
      //配置
    self.configuration = configuration;
      //线的颜色
    self.backgroundColor = self.configuration.chartBackgroundColor;

      //把线应该放到这了
    self.coverLayer = [CAShapeLayer layer];
      //存放的数据 包括颜色
    self.shapeLayerArray = [NSMutableArray new];
      //获取拐点 self.pointsArrays 里面只有一个值 是数组linePointArray  linePointArray数组里面放着点
    self.pointsArrays = [NSMutableArray new];
    self.labelArray = [NSMutableArray new];
    self.pointLayerArray = [NSMutableArray new];

    self.dataItemArray = dataItemArray;
    self.top = topNumber;
    self.bottom = bottomNumber;
  }
  return self;
}

#pragma mark - Draw

// Draw Template
- (void)drawRect:(CGRect)rect {
  [super drawRect:rect];
  CGContextRef contextRef = UIGraphicsGetCurrentContext();
    //这个写的好, 如果有的话先清除下  再展示新的数据
  [self cleanPreDrawLayerAndData];
//    contextRef是一个画布 把画布传过去 开始画线 这个是坐标线!!!!!
  [self strokeAuxiliaryLineInContext:contextRef];
    
    //画折线 和 点击显示数字 这个很重要!!!!!!
  [self strokeLineChart];
    
    //圆点
  [self strokePointInContext];
    //汇智label
  [self strokeNumberLabels];
}

//画的坐标线
/// Stroke Auxiliary
- (void)strokeAuxiliaryLineInContext:(CGContextRef)context {
    //是否显示坐标线
  if (self.configuration.isShowAuxiliaryDashLine) {
    CGContextSetStrokeColorWithColor(context, self.configuration.auxiliaryDashLineColor.CGColor);
    CGContextSaveGState(context);
    CGFloat lengths[2] = {5.0, 5.0};
    CGContextSetLineDash(context, 0, lengths, 2);
    CGContextSetLineWidth(context, 0.2);
    for (int i = 0; i < 11; i++) {
      CGContextMoveToPoint(
                           context, 5, self.frame.size.height - (self.frame.size.height) / 11 * i);
      CGContextAddLineToPoint(
                              context, self.frame.size.width,
                              self.frame.size.height - ((self.frame.size.height) / 11) * i);
      CGContextStrokePath(context);
    }
    CGContextRestoreGState(context);
    CGContextSaveGState(context);
    CGContextSetStrokeColorWithColor(context, self.configuration.auxiliaryDashLineColor.CGColor);
  }

  
  if (self.configuration.isShowCoordinate) {
    // ordinate
    CGContextMoveToPoint(context, 5, 0);
    CGContextAddLineToPoint(context, 5, self.frame.size.height);
    CGContextStrokePath(context);
    
    // abscissa
    CGContextMoveToPoint(context, 5, self.frame.size.height);
    CGContextAddLineToPoint(context, self.frame.size.width,
                            self.frame.size.height);
    CGContextStrokePath(context);
    CGContextRestoreGState(context);
    
    // arrow
    UIBezierPath* arrow = [[UIBezierPath alloc] init];
    arrow.lineWidth = 0.7;
    [arrow moveToPoint:CGPointMake(0, 8)];
    [arrow addLineToPoint:CGPointMake(5, 0)];
    [arrow moveToPoint:CGPointMake(5, 0)];
    [arrow addLineToPoint:CGPointMake(10, 8)];
    [[UIColor black75PercentColor] setStroke];
    arrow.lineCapStyle = kCGLineCapRound;
    [arrow stroke];
  }
}
//这个写的好, 如果有的话先清除下  再展示新的数据
- (void)cleanPreDrawLayerAndData {
  [self.coverLayer removeFromSuperlayer];
  [self.shapeLayerArray
      enumerateObjectsUsingBlock:^(CAShapeLayer* _Nonnull obj, NSUInteger idx,
                                   BOOL* _Nonnull stop) {
        [obj removeFromSuperlayer];
      }];
  [self.labelArray
      enumerateObjectsUsingBlock:^(XAnimationLabel* _Nonnull obj,
                                   NSUInteger idx, BOOL* _Nonnull stop) {
        [obj removeFromSuperview];
      }];
  
  [self.pointLayerArray enumerateObjectsUsingBlock:^(CAShapeLayer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    [obj removeFromSuperlayer];
  }];

  [self.pointsArrays removeAllObjects];
  [self.shapeLayerArray removeAllObjects];
  [self.labelArray removeAllObjects];
  [self.pointLayerArray removeAllObjects];
}

/// Stroke Point
- (void)strokePointInContext {
  
    //如果显示拐点
  if (self.configuration.isShowPoint) {
      //获取拐点 self.pointsArrays 里面只有一个值 是数组linePointArray  linePointArray数组里面放着点
    self.pointsArrays = [self getPointsArrays];
    [self.pointsArrays enumerateObjectsUsingBlock:^(NSMutableArray* _Nonnull obj,
                                                    NSUInteger idx,
                                                    BOOL* _Nonnull stop) {
      
        //放着item数据
      UIColor *color = self.dataItemArray[idx].color;
      
      [obj enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx,
                                        BOOL* _Nonnull stop) {
        NSValue* pointValue = obj;
        CGPoint point = pointValue.CGPointValue;
        /// Change To CALayer
        CAShapeLayer* pointLayer = [CAShapeLayer pointLayerWithDiameter:PointDiameter color:color center:point];
        
        [self.pointLayerArray addObject:pointLayer];
        [self.layer addSublayer:pointLayer];
        
      }];
    }];
  }

}

//画折线 和 点击显示数字 这个很重要!!!!!!
/// Stroke Line
- (void)strokeLineChart {
    //获取拐点 self.pointsArrays 里面只有一个值 是数组linePointArray  linePointArray数组里面放着点
  self.pointsArrays = [self getPointsArrays];
  [self.pointsArrays enumerateObjectsUsingBlock:^(NSMutableArray* _Nonnull obj,
                                                  NSUInteger idx,
                                                  BOOL* _Nonnull stop) {
      
      //只执行一次 因为里面就一个数组 linePointArray
//    NSLog(@"**>%ld**%@",idx,obj);

      
      //重点!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
      //obj 是点存放的数组 把数组传过去 color颜色
    [self.shapeLayerArray
          addObject:[self lineShapeLayerWithPoints:obj
                                            colors:self.dataItemArray[idx].color
                                          lineMode:self.configuration.lineMode]];
  }];

    
    //把线段放到self.layer
  [self.shapeLayerArray
      enumerateObjectsUsingBlock:^(CAShapeLayer* _Nonnull obj, NSUInteger idx,
                                   BOOL* _Nonnull stop) {
        [self.layer addSublayer:obj];
      }];
}


// 绘制number label
- (void)strokeNumberLabels {
  if (!self.configuration.isEnableNumberLabel) {
    return;
  }
  for (int i = 0; i < self.pointsArrays.count; i++) {
      [self.pointsArrays[i]
       enumerateObjectsUsingBlock:^(
                                    NSValue* _Nonnull obj, NSUInteger idx, BOOL* _Nonnull stop) {
           CGPoint point = obj.CGPointValue;
           XAnimationLabel* label =
           [XAnimationLabel topLabelWithPoint:point
                                         text:@"0"
                                    textColor:XJYBlack
                                    fillColor:[UIColor clearColor]];
           CGFloat textNum = self.dataItemArray[i]
           .numberArray[idx]
           .doubleValue;
           [self.labelArray addObject:label];
           [self addSubview:label];
           [label countFromCurrentTo:textNum duration:0.5];
       }];
  }
}



// compute Points Arrays
- (NSMutableArray<NSMutableArray<NSValue*>*>*)getPointsArrays {
  // 避免重复计算
  if (self.pointsArrays.count > 0) {
    return self.pointsArrays;
  } else {
    NSMutableArray* pointsArrays = [NSMutableArray new];
    // Get Points
    [self.dataItemArray enumerateObjectsUsingBlock:^(
                            XLineChartItem* _Nonnull obj, NSUInteger idx,
                            BOOL* _Nonnull stop) {
        //obj.numberArray  获取所有的数据Array
        //只打印一次 因为里面只有一个数据
      NSMutableArray* numberArray = obj.numberArray;
        //把点都装数组里面
      NSMutableArray* linePointArray = [NSMutableArray new];
        
        //获取所有的数据Array 的值
      [obj.numberArray enumerateObjectsUsingBlock:^(NSNumber* _Nonnull obj,
                                                    NSUInteger idx,
                                                    BOOL* _Nonnull stop) {
          
          //遍历的所有数据 index object
//          NSLog(@"==>%ld,=%@",idx,obj);
          //接下来 把数组的每个值 传递 index object 计算点calculateDrawablePointWithNumber
          //这个方法很通用!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        CGPoint point = [self calculateDrawablePointWithNumber:obj
                                                           idx:idx
                                                         count:numberArray.count
                                                        bounds:self.bounds];
          
          //得到了每个点
//          NSLog(@"point.x:%f,idx:%ld,objc:%@>>>>>",point.x,idx,obj);
//          NSLog(@"point.y:%f,idx:%ld,objc:%@>>>>>",point.y,idx,obj);

        NSValue* pointValue = [NSValue valueWithCGPoint:point];
          //把点都装数组里面
        [linePointArray addObject:pointValue];
      }];
        
        //把点的数据数组 只有一个放到pointsArrays
      [pointsArrays addObject:linePointArray];
    }];
    return pointsArrays;
  }
}


//接下来 把数组的每个值 传递 index object 计算点calculateDrawablePointWithNumber
//这个方法很通用!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#pragma mark Helper
/**
 计算点通过 数值 和 idx

 @param number number
 @param idx like 0.1.2.3...
 @return CGPoint
 */
// Calculate -> Point
- (CGPoint)calculateDrawablePointWithNumber:(NSNumber*)number
                                        idx:(NSUInteger)idx
                                      count:(NSUInteger)count
                                     bounds:(CGRect)bounds {
    
    //计算percentageH  传递数组线值number  self.top240 Y轴最高的 self.bottom Y轴最低的0
  CGFloat percentageH = [[XAuxiliaryCalculationHelper shareCalculationHelper]
      calculateTheProportionOfHeightByTop:self.top.doubleValue
                                   bottom:self.bottom.doubleValue
                                   height:number.doubleValue];
    
    //计算percentageW 传递数组的index idx   count 数组的总数
  CGFloat percentageW = [[XAuxiliaryCalculationHelper shareCalculationHelper]
      calculateTheProportionOfWidthByIdx:(idx)
                                   count:count];
  CGFloat pointY = percentageH * bounds.size.height;
  CGFloat pointX = percentageW * bounds.size.width;
    //把point点得到了
  CGPoint point = CGPointMake(pointX, pointY);
    
    //point 进行处理changeCoordinateSystem  传递点 传递self.frame.size.height
    // 改变成容易绘制的坐标系
  CGPoint rightCoordinatePoint =
      [[XAuxiliaryCalculationHelper shareCalculationHelper]
          changeCoordinateSystem:point
                  withViewHeight:self.frame.size.height];
  return rightCoordinatePoint;
}

//重点
//obj 是点存放的数组 把数组传过去 color颜色
- (CAShapeLayer*)lineShapeLayerWithPoints:
                     (NSMutableArray<NSValue*>*)pointsValueArray
                                   colors:(UIColor*)color
                                 lineMode:(XLineMode)lineMode {
  UIBezierPath* line = [[UIBezierPath alloc] init];

//    用CAShapeLayer开始画线
  CAShapeLayer* chartLine = [CAShapeLayer layer];
  chartLine.lineCap = kCALineCapRound;//线条拐角
  chartLine.lineJoin = kCALineJoinRound;//终点处理
    //线的宽度
  chartLine.lineWidth = LineWidth;

    //遍历数组的点
  for (int i = 0; i < pointsValueArray.count - 1; i++) {
      
      //第一位点
    CGPoint point1 = pointsValueArray[i].CGPointValue;

      //第二位点
    CGPoint point2 = pointsValueArray[i + 1].CGPointValue;
      
      //贝塞尔起点开始
    [line moveToPoint:point1];

    if (lineMode == Straight) {
        //走的是这边 直接把第二个点设置 连接线段 很简单
        [line addLineToPoint:point2];
    } else if (lineMode == CurveLine) {
      CGPoint midPoint = [[XAuxiliaryCalculationHelper shareCalculationHelper]
          midPointBetweenPoint1:point1
                      andPoint2:point2];
      [line addQuadCurveToPoint:midPoint
                   controlPoint:[[XAuxiliaryCalculationHelper
                                    shareCalculationHelper]
                                    controlPointBetweenPoint1:midPoint
                                                    andPoint2:point1]];
      [line addQuadCurveToPoint:point2
                   controlPoint:[[XAuxiliaryCalculationHelper
                                    shareCalculationHelper]
                                    controlPointBetweenPoint1:midPoint
                                                    andPoint2:point2]];
    } else {
      [line addLineToPoint:point2];
    }

      
      
      
      
      
      
      
//      就是计算拐点的范围!!!!!!!!!很好
    //当前线段的四个点
    CGPoint rectPoint1 =
        CGPointMake(point1.x - LineWidth / 2, point1.y - LineWidth / 2);
    NSValue* value1 = [NSValue valueWithCGPoint:rectPoint1];
    CGPoint rectPoint2 =
        CGPointMake(point1.x - LineWidth / 2, point1.y + LineWidth / 2);
    NSValue* value2 = [NSValue valueWithCGPoint:rectPoint2];
    CGPoint rectPoint3 =
        CGPointMake(point2.x + LineWidth / 2, point2.y - LineWidth / 2);
    NSValue* value3 = [NSValue valueWithCGPoint:rectPoint3];
    CGPoint rectPoint4 =
        CGPointMake(point2.x + LineWidth / 2, point2.y + LineWidth / 2);
    NSValue* value4 = [NSValue valueWithCGPoint:rectPoint4];

    //当前线段的矩形组成点
    NSMutableArray<NSValue*>* segementPointsArray = [NSMutableArray new];
    [segementPointsArray addObject:value1];
    [segementPointsArray addObject:value2];
    [segementPointsArray addObject:value3];
    [segementPointsArray addObject:value4];

    //把当前线段的矩形组成点数组添加到 数组中
    if (chartLine.segementPointsArrays == nil) {
      chartLine.segementPointsArrays = [[NSMutableArray alloc] init];
      [chartLine.segementPointsArrays addObject:segementPointsArray];
    } else {
      [chartLine.segementPointsArrays addObject:segementPointsArray];
    }
  }
    

    //把贝塞尔的路径赋值给CAShapeLayer  有CAShapeLayer画线
  chartLine.path = line.CGPath;
  chartLine.strokeStart = 0.0;
  chartLine.strokeEnd = 1.0;
  chartLine.opacity = 0.6;//表示透明度
  chartLine.strokeColor = color.CGColor;//线条的颜色
  chartLine.fillColor = [UIColor clearColor].CGColor;//填充颜色
  
  
    //这个表示是否有动画效果pathAnimation 一开始的动画
  if (self.configuration.isShowShadow) {
    // shadow
    chartLine.shadowColor = [UIColor blackColor].CGColor;
    chartLine.shadowOpacity = 0.45f;
    chartLine.shadowOffset = CGSizeMake(0.0f, 6.0f);
    chartLine.shadowRadius = 5.0f;
    chartLine.masksToBounds = NO;
  } else {
      //走了这边的动画
    [chartLine addAnimation:self.pathAnimation forKey:@"strokeEndAnimation"];
  }
    
    
  //这个表示 一开始没有选中
  // selectedStatus
  chartLine.selectStatusNumber = [NSNumber numberWithBool:NO];

  return chartLine;
}

- (CAShapeLayer*)coverShapeLayerWithPath:(CGPathRef)path color:(UIColor*)color {
  CAShapeLayer* chartLine = [CAShapeLayer layer];
  chartLine.lineCap = kCALineCapRound;
  chartLine.lineJoin = kCALineJoinRound;
  chartLine.lineWidth = LineWidth * 1.5;
  chartLine.path = path;
  chartLine.strokeStart = 0.0;
  chartLine.strokeEnd = 1.0;
  chartLine.strokeColor = color.CGColor;
  chartLine.fillColor = [UIColor clearColor].CGColor;
  chartLine.opacity = 0.8;

  return chartLine;
}

- (CABasicAnimation*)pathAnimation {
  _pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
  _pathAnimation.duration = 3.0;
  _pathAnimation.timingFunction = [CAMediaTimingFunction
      functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
  _pathAnimation.fromValue = @0.0f;
  _pathAnimation.toValue = @1.0f;
  return _pathAnimation;
}

#pragma mark - Touch
//定义一个拐点
CGPoint GuandianPoint;

- (void)touchesBegan:(NSSet<UITouch*>*)touches withEvent:(UIEvent*)event {
  
    //是否显示数据  NO 不显示   YES直接显示出来 直接显示就没有点击事件了
  if (self.configuration.isEnableNumberLabel) {
    return;
  }
  //根据 点击的x坐标 只找在x 坐标区域内的 线段进行判断
  //坐标系转换
  CGPoint __block point = [[touches anyObject] locationInView:self];
    

  //找到小的区域
  int areaIdx = 0;
    //获取拐点 self.pointsArrays 里面只有一个值 是数组linePointArray  linePointArray数组里面放着点
  NSArray<NSValue*>* points = self.pointsArrays.lastObject;
    //遍历所有的值的点
    //如果x 在坐标区域内的 线段进行判断 areaIdx是代表第几个点 数组的index
  for (int i = 0; i < points.count; i++) {
    if (point.x >= points[i].CGPointValue.x - ReactTap &&
        point.x <= points[i].CGPointValue.x + ReactTap &&
        point.y >= points[i].CGPointValue.y - ReactTap &&
        point.y <= points[i].CGPointValue.y + ReactTap
        ) {
      areaIdx = i;
        GuandianPoint = CGPointMake(points[i].CGPointValue.x, points[i].CGPointValue.y);
        
        //先移除
        // remove pre layer and label
        [self.labelArray enumerateObjectsUsingBlock:^(
                                                      XAnimationLabel* _Nonnull obj, NSUInteger idx,
                                                      BOOL* _Nonnull stop) {
            [obj removeFromSuperview];
        }];
        [self.labelArray removeAllObjects];
        
        
        //再显示
        //显示label
        XAnimationLabel* label =
        [XAnimationLabel topLabelWithPoint:GuandianPoint
                                      text:@"0"
                                 textColor:XJYBlack
                                 fillColor:[UIColor clearColor]];
        CGFloat textNum = self.dataItemArray.lastObject
        .numberArray[areaIdx]
        .doubleValue;
        [self.labelArray addObject:label];
        [self addSubview:label];
        [label countFromCurrentTo:textNum duration:0.5];
    }
  }
    
}

- (XNormalLineChartConfiguration *)configuration {
  if (_configuration == nil) {
    _configuration = [[XNormalLineChartConfiguration alloc] init];
  }
  return _configuration;
}



@end
