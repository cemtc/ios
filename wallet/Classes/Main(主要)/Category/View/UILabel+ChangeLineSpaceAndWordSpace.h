//
//  UILabel+ChangeLineSpaceAndWordSpace.h
//  Business
//
//  Created by talking on 2017/10/1.
//  Copyright © 2017年 talking　. All rights reserved.
//改变文字间距

#import <UIKit/UIKit.h>

@interface UILabel (ChangeLineSpaceAndWordSpace)
/**
 *  改变行间距
 */
+ (void)changeLineSpaceForLabel:(UILabel *)label WithSpace:(float)space;

/**
 *  改变字间距
 */
+ (void)changeWordSpaceForLabel:(UILabel *)label WithSpace:(float)space;

/**
 *  改变行间距和字间距
 */
+ (void)changeSpaceForLabel:(UILabel *)label withLineSpace:(float)lineSpace WordSpace:(float)wordSpace;

//作者：Elephan_z
//链接：http://www.jianshu.com/p/b7a2314e780a
//來源：简书
//著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。


@end
