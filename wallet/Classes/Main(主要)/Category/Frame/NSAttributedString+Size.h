//
//  NSAttributedString+Size.h
//  Business
//
//  Created by talking on 2017/10/1.
//  Copyright © 2017年 talking　. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface NSAttributedString (Size)


/**
 *  根据约束的宽度来求NSAttributedString的高度
 */
- (CGFloat)heightWithConstrainedWidth:(CGFloat)width ;


@end
