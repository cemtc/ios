//
//  kyoColumnIndexView.m
//  selectSeat
//
//  Created by talking　 on 2018/11/7.
//  Copyright © 2018 smnh. All rights reserved.
//

#import "kyoColumnIndexView.h"
#import <CoreText/CoreText.h>

#define kKyoRowIndexViewFontName    @"Helvetica"
#define kKyoRowIndexViewFontSize    10
#define kKyoRowIndexViewColor    [UIColor whiteColor]


@implementation kyoColumnIndexView

#pragma mark --------------------
#pragma mark - CycLife

- (void)drawRect:(CGRect)rect {
    [self setupView];
    
    if (self.column > 0) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextTranslateCTM(context, 0.0f,self.bounds.size.height);
        CGContextScaleCTM(context, 1, -1);
        
        //字体
        CTFontRef font = CTFontCreateWithName((__bridge CFStringRef)kKyoRowIndexViewFontName, kKyoRowIndexViewFontSize, NULL);
        //剧中对齐
        CTTextAlignment alignment = kCTCenterTextAlignment;
        CTParagraphStyleSetting alignmentStyle;
        alignmentStyle.spec=kCTParagraphStyleSpecifierAlignment;//指定为对齐属性
        alignmentStyle.valueSize=sizeof(alignment);
        alignmentStyle.value=&alignment;
        //样式设置
        CTParagraphStyleSetting settings[] = {alignmentStyle};
        CTParagraphStyleRef style = CTParagraphStyleCreate(settings, 2);
        NSMutableDictionary *attributes = [NSMutableDictionary dictionaryWithObject:(__bridge id)style forKey:(id)kCTParagraphStyleAttributeName];
        
        for (NSInteger i = 0; i < self.column ; i++) {
            NSString *string = [NSString stringWithFormat:@"%ld",(long)(i + 1)];
            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
            [attributedString addAttribute:(id)kCTFontAttributeName value:(__bridge id)font range:NSMakeRange(0, [attributedString length])];
            [attributedString addAttribute:(id)kCTForegroundColorAttributeName value:(id)kKyoRowIndexViewColor.CGColor range:NSMakeRange(0, attributedString.length)];
            [attributedString addAttributes:attributes range:NSMakeRange(0, [attributedString length])];
            
            CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attributedString);
            CGMutablePathRef path = CGPathCreateMutable();
            
            //修改了位置
            CGPathAddRect(path, NULL, CGRectMake(self.bounds.size.width / self.column * (i) - (self.bounds.size.width / self.column - kKyoRowIndexViewFontSize) / 4 + 4, 0,  self.bounds.size.width/ self.column, self.bounds.size.height ));
            
            CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), path, NULL);
            CTFrameDraw(frame, context);
            
            CFRelease(frame);
            CGPathRelease(path);
            CFRelease(framesetter);
        }
    }
}

#pragma mark --------------------
#pragma mark - Methods

- (void)setupView {
    self.clipsToBounds = YES;
    self.layer.cornerRadius = self.height / 2;
    self.layer.masksToBounds = YES;
}


@end
