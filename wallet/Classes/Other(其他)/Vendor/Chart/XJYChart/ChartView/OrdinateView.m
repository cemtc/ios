//
//  OrdinateView.m
//  RecordLife
//
//  Created by 谢俊逸 on 16/03/2017.
//  Copyright © 2017 谢俊逸. All rights reserved.
//

#import "OrdinateView.h"
#import "XColor.h"
#import "XAbscissaView.h"
#import "XBaseChartConfiguration.h"
@interface OrdinateView ()

@property(nonatomic, strong) NSMutableArray<UILabel*>* labelArray;
@property(nonatomic, assign) CGFloat top;
@property(nonatomic, assign) CGFloat bottom;
@property(nonatomic, strong) XBaseChartConfiguration *configuration;

@end

@implementation OrdinateView

- (instancetype)initWithFrame:(CGRect)frame
                    topNumber:(NSNumber*)topNumber
                 bottomNumber:(NSNumber*)bottomNumber {
  if (self = [self initWithFrame:frame]) {
    self.top = topNumber.floatValue;
    self.bottom = bottomNumber.floatValue;
    self.labelArray = [NSMutableArray new];
    for (int i = 0; i < 4; i++) {
      UILabel* label = [[UILabel alloc] init];
      [self.labelArray addObject:label];
    }
    [self setupUI];
  }
  return self;
}

//用的是这个
- (instancetype)initWithFrame:(CGRect)frame
                    topNumber:(NSNumber*)topNumber
                 bottomNumber:(NSNumber*)bottomNumber
                configuration:(XBaseChartConfiguration *)configuration {
  if (self = [self initWithFrame:frame]) {
    self.top = topNumber.floatValue;
    self.bottom = bottomNumber.floatValue;
    self.labelArray = [NSMutableArray new];
    self.configuration = configuration;
      //在这里设置用了几个
    for (int i = 0; i < self.configuration.ordinateDenominator + 1; i++) {
      UILabel* label = [[UILabel alloc] init];
      [self.labelArray addObject:label];
    }
    [self setupUI];
  }
  return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
  }
  return self;
}

- (void)setupUI {
    /*
     NSDictionary有一个方法叫enumerateKeysAndObjectsUsingBlock，它就一个参数就是block，这个block携带了三个参数，这将要把dictionary里面的key和value每次一组传递到block，enumerateKeysAndObjectsUsingBlock会遍历dictionary并把里面所有的key和value一组一组的展示给你，每组都会执行这个block。这其实就是传递一个block到另一个方法，在这个例子里它会带着特定参数被反复调用，直到找到一个key2的key，然后就会通过重新赋值那个BOOL *stop来停止运行，停止遍历同时停止调用block。
     
     作者：十指恋静
     链接：https://www.jianshu.com/p/c45f928b0519
     來源：简书
     简书著作权归作者所有，任何形式的转载都请联系作者获得授权并注明出处。
     */
  [self.labelArray
      enumerateObjectsUsingBlock:^(UILabel* _Nonnull obj, NSUInteger idx,
                                   BOOL* _Nonnull stop) {
          
//          NSLog(@">>>%ld<<<",idx);
          
        CGFloat width = self.frame.size.width;
        
        //
        CGFloat newH = ((self.frame.size.height - AbscissaHeight)/(self.labelArray.count - 1)) * (self.labelArray.count - idx - 1);
          
        obj.frame = CGRectMake(0, newH, width, 15);

        float largestFontSize = 12;
//        while ([obj.text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:largestFontSize]}].width > obj.frame.size.width)
//        {
//          largestFontSize--;
//        }
//        largestFontSize--;

        obj.font = [UIFont fontWithName:@"AppleSDGothicNeo-Bold" size:largestFontSize];
        obj.textColor = [UIColor black50PercentColor];
          
          if (idx != 0) {
              obj.text = [NSString
                          stringWithFormat:@"%.0f", (idx) * (self.top - self.bottom) / (self.labelArray.count - 1) +
                          self.bottom];
          }
        obj.textAlignment = NSTextAlignmentCenter;
        obj.backgroundColor = [UIColor whiteColor];

        [self addSubview:obj];
      }];
}

@end
