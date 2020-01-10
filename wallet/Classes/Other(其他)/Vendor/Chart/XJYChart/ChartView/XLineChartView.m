//
//  XLineChartView.m
//  RecordLife
//
//  Created by 谢俊逸 on 17/03/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//

#import "XLineChartView.h"
#import "XAbscissaView.h"
#import "XLineContainerView.h"
#import "XAreaLineContainerView.h"
#import "XStackAreaLineContainerView.h"
#import "UIGestureRecognizer+XGesHelper.h"
#import "XColor.h"
#import "XLineChartConfiguration.h"
#define PartWidth 40

NSString* KVOKeyLineGraphMode = @"lineMode";

@interface XLineChartView ()
//x坐标轴
@property(nonatomic, strong) XAbscissaView* XAbscissaView;

@property(nonatomic, strong) UIView* contanierView;
@property(nonatomic, strong) XLineContainerView* lineContainerView;
@property(nonatomic, strong) XAreaLineContainerView* areaLineContainerView;
@property(nonatomic, strong)
    XStackAreaLineContainerView* stackAreaLineContainerView;

@end

@implementation XLineChartView

- (instancetype)initWithFrame:(CGRect)frame
                dataItemArray:(NSMutableArray<XLineChartItem*>*)dataItemArray
            dataDescribeArray:(NSMutableArray<NSString*>*)dataDescribeArray
                    topNumber:(NSNumber*)topNumbser
                 bottomNumber:(NSNumber*)bottomNumber
                    graphMode:(XLineGraphMode)graphMode
                configuration:(XLineChartConfiguration*)configuration {
  if (self = [super initWithFrame:frame]) {
    self.configuration = (XNormalLineChartConfiguration *)configuration;

    self.top = topNumbser;
    self.bottom = bottomNumber;
    self.dataItemArray = dataItemArray;
      //因为这是UIScrollView  所以这个是UIScrollView的背景颜色
    self.backgroundColor = [UIColor whiteColor];
    self.dataDescribeArray = dataDescribeArray;
      
      //设置UIScrollView contentSize  也就是大小显示 是否滚动 不是重要
    self.contentSize =
        [self computeSrollViewCententSizeFromItemArray:self.dataItemArray];

    // default line graph mode
    self.lineGraphMode = graphMode;

      
      //下面的x坐标轴
    [self addSubview:self.XAbscissaView];
      
      
      //这个是最重要的 画折线的
    self.contanierView =
        [self getLineChartContainerViewWithGraphMode:self.lineGraphMode];
    [self addSubview:self.contanierView];

      
      //其他的类型处理 这个用不到
    if ([self.contanierView isKindOfClass:[XAreaLineContainerView class]]) {
      self.bounces = NO;
      self.backgroundColor = XJYBlue;
    }
  }
  return self;
}

//根据model 类型画折线
// Acorrding Line Graph Mode Choose Which LineContanier View
- (UIView*)getLineChartContainerViewWithGraphMode:
    (XLineGraphMode)lineGraphMode {
  if (lineGraphMode == AreaLineGraph) {
    return self.areaLineContainerView;
  } else if (lineGraphMode == Straight) {
      //是默认的这个先  走的这个
    return self.lineContainerView;
  } else if (lineGraphMode == StackAreaLineGraph) {
    return self.stackAreaLineContainerView;
  } else {
    return self.lineContainerView;
  }
}

//计算是否需要滚动
- (CGSize)computeSrollViewCententSizeFromItemArray:
    (NSMutableArray<XLineChartItem*>*)itemArray {
  XLineChartItem* item = itemArray[0];
  if (item.numberArray.count <= 8 || !self.configuration.isScrollable) {
    return CGSizeMake(self.frame.size.width, self.frame.size.height);
  } else {

    CGFloat width = PartWidth * item.numberArray.count;
    CGFloat height = self.frame.size.height;
    return CGSizeMake(width, height);
  }
}

#pragma mark Get
- (XAbscissaView*)XAbscissaView {
  if (!_XAbscissaView) {
      //AbscissaHeight x坐标轴向下移动的距离
    _XAbscissaView = [[XAbscissaView alloc]
        initWithFrame:CGRectMake(0, self.contentSize.height - AbscissaHeight,
                                 self.contentSize.width, AbscissaHeight)
        dataItemArray:self.dataDescribeArray];
  }
  return _XAbscissaView;
}

#pragma mark Containers
//他是画线的 才是最重要的额
- (XLineContainerView*)lineContainerView {
  if (!_lineContainerView) {
      //AbscissaHeight x坐标轴向下移动的距离
    _lineContainerView = [[XLineContainerView alloc]
        initWithFrame:CGRectMake(0, 0, self.contentSize.width,
                                 self.contentSize.height - AbscissaHeight)
        dataItemArray:self.dataItemArray
            topNumber:self.top
         bottomNumber:self.bottom
        configuration:self.configuration];
  }
  return _lineContainerView;
}

- (XAreaLineContainerView*)areaLineContainerView {
  if (!_areaLineContainerView) {
    _areaLineContainerView = [[XAreaLineContainerView alloc]
        initWithFrame:CGRectMake(0, 0, self.contentSize.width,
                                 self.contentSize.height - AbscissaHeight)
        dataItemArray:self.dataItemArray
            topNumber:self.top
         bottomNumber:self.bottom
        configuration:(XAreaLineChartConfiguration*)self.configuration];
  }
  return _areaLineContainerView;
}

- (XStackAreaLineContainerView*)stackAreaLineContainerView {
  if (!_stackAreaLineContainerView) {
    _stackAreaLineContainerView = [[XStackAreaLineContainerView alloc]
        initWithFrame:CGRectMake(0, 0, self.contentSize.width,
                                 self.contentSize.height - AbscissaHeight)
        dataItemArray:self.dataItemArray
            topNumber:self.top
         bottomNumber:self.bottom
        configuration:(XStackAreaLineChartConfiguration*)self.configuration];
  }
  return _stackAreaLineContainerView;
}

#pragma mark - Set


@end

